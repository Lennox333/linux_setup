return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
  config = function()
    require("lualine").setup({
      options = {
        theme = "pywal16-nvim", -- matches pywal16
      },
    })
  end,
}
