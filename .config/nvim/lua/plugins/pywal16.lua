return {
  "uZer/pywal16.nvim",
  --priority = 1000,
  --lazy = false,
  config = function()
    require("pywal16").setup()
    vim.cmd("colorscheme blue")
    vim.cmd("colorscheme pywal16")
  end,
}
