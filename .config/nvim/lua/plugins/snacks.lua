-- Disable LazyVim's animated smooth scrolling (feels very slow, especially in tmux).
return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false },
  },
}
