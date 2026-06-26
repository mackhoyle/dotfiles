-- Treesitter parser builds need the `tree-sitter` CLI, whose prebuilt binary
-- requires glibc >= 2.29. The RHEL 8 dev host (usapp81dev) ships glibc 2.28,
-- so parser compilation fails and spams errors on startup. LSPs and formatters
-- do NOT depend on treesitter, so we simply skip parser auto-install when the
-- CLI can't run. Inside the devcontainer (newer glibc) the CLI works and
-- parsers build normally. Where the CLI works you can also run :TSInstall <lang>.
local function ts_cli_works()
  local candidates = { "tree-sitter", vim.fn.stdpath("data") .. "/mason/bin/tree-sitter" }
  for _, exe in ipairs(candidates) do
    if vim.fn.executable(exe) == 1 then
      vim.fn.system({ exe, "--version" })
      if vim.v.shell_error == 0 then
        return true
      end
    end
  end
  return false
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if not ts_cli_works() then
        -- runs after LazyVim/extras merge their ensure_installed tables
        opts.ensure_installed = {}
      end
    end,
  },
}
