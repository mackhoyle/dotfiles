-- C# via the Roslyn language server (the same engine the devcontainer's
-- ms-dotnettools.csdevkit uses — the devcontainer explicitly sets
-- "dotnet.server.useOmnisharp": false, so we use Roslyn, not OmniSharp).
--
-- roslyn.nvim auto-detects the Roslyn LS binary installed by Mason ("roslyn")
-- and locates the solution (URMS.sln at the repo root).
return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module "roslyn.config"
    ---@type RoslynNvimConfig
    opts = {
      -- Format on save + organize imports, matching the devcontainer's
      -- "editor.formatOnSave": true behavior for C#.
      config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|background_analysis"] = {
            -- Mirror the devcontainer: analyze open files only (large solution).
            dotnet_analyzer_diagnostics_scope = "openFiles",
            dotnet_compiler_diagnostics_scope = "openFiles",
          },
        },
      },
    },
  },

  -- Make sure the Roslyn LS and C# debugger are installed via Mason.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "roslyn", "netcoredbg" } },
  },

  -- C# treesitter parser (no LazyVim lang.csharp extra is enabled).
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c_sharp" } },
  },
}
