local function odin_context(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr or 0)
  local root = vim.fs.root(file, { "ols.json", ".git" }) or vim.fs.dirname(file)
  local rel = vim.fs.relpath(root, file) or vim.fs.basename(file)
  return root, rel, vim.fs.dirname(rel) or "."
end

local function parse_odin_check(output, bufnr)
  if output == "" then
    return {}
  end

  local ok, result = pcall(vim.json.decode, output)
  if not ok then
    return {}
  end

  local _, rel = odin_context(bufnr)
  local diagnostics = {}
  local severities = {
    error = vim.diagnostic.severity.ERROR,
    warning = vim.diagnostic.severity.WARN,
    info = vim.diagnostic.severity.INFO,
    hint = vim.diagnostic.severity.HINT,
  }

  for _, error in ipairs(result.errors or {}) do
    local pos = error.pos or {}
    local path = vim.fs.normalize(pos.file or "")
    if path:sub(-#rel) == rel then
      table.insert(diagnostics, {
        lnum = math.max(0, (pos.line or 1) - 1),
        col = math.max(0, (pos.column or 1) - 1),
        end_col = math.max(0, (pos.end_column or pos.column or 1) - 1),
        severity = severities[error.type] or vim.diagnostic.severity.ERROR,
        message = table.concat(error.msgs or { error.type or "Odin check failed" }, "\n"),
        source = "odin check",
      })
    end
  end

  return diagnostics
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.odin = { "odin_check" }

      opts.linters = opts.linters or {}
      opts.linters.odin_check = {
        cmd = "bash",
        stdin = true,
        append_fname = false,
        stream = "stdout",
        ignore_exitcode = true,
        args = {
          "-c",
          [[
root=$1
rel=$2
check_dir=$3
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/root/$(dirname "$rel")"
find "$root" -name '*.odin' -type f -not -path '*/.git/*' | while IFS= read -r file; do
  copy_rel=${file#"$root/"}
  mkdir -p "$tmp/root/$(dirname "$copy_rel")"
  cp "$file" "$tmp/root/$copy_rel"
done
cat > "$tmp/root/$rel"
odin check "$tmp/root/$check_dir" -json-errors 2>&1
exit 0
]],
          "odin-check",
          function()
            local root = odin_context(0)
            return root
          end,
          function()
            local _, rel = odin_context(0)
            return rel
          end,
          function()
            local _, _, check_dir = odin_context(0)
            return check_dir
          end,
        },
        parser = parse_odin_check,
      }
    end,
    init = function()
      local group = vim.api.nvim_create_augroup("odin-realtime-lint", { clear = true })
      local timers = {}

      vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = group,
        pattern = "*.odin",
        callback = function(event)
          local timer = timers[event.buf]
          if timer then
            timer:stop()
          else
            timer = vim.uv.new_timer()
            timers[event.buf] = timer
          end

          timer:start(700, 0, function()
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(event.buf) then
                vim.api.nvim_buf_call(event.buf, function()
                  require("lint").try_lint("odin_check", { ignore_errors = true })
                end)
              end
            end)
          end)
        end,
      })

      vim.api.nvim_create_autocmd("BufWipeout", {
        group = group,
        callback = function(event)
          local timer = timers[event.buf]
          if timer then
            timer:stop()
            timer:close()
            timers[event.buf] = nil
          end
        end,
      })
    end,
  },
}
