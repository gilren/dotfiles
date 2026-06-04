return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      picker = {
        win = {
          preview = {
            wo = {
              wrap = true,
              linebreak = true,
              breakindent = true,
              showbreak = "",
            },
          },
        },
      },
    },
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e",  false },

    },
  },
}
