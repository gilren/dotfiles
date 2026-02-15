vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map_lsp_keybinds = require("gilren.keymaps").map_lsp_keybinds
    local bufnr = event.buf
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    -- Detach from non-file buffers (diffview, fugitive, etc.)
    if bufname == "" or bufname:match("^diffview://") or bufname:match("^fugitive://") then
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, event.data.client_id)
      end)
      return
    end

    map_lsp_keybinds(bufnr)
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})
