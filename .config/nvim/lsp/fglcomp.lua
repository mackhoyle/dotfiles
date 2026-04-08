return {
  -- Command and arguments to start the server.
  cmd = { 'fglcomp', '--language-server', 'dummy' },
  -- Filetypes to automatically attach to.
  filetypes = { 'fgl' },
  -- Sets the "workspace" to the directory where any of these files is found.
  -- Files that share a root directory will reuse the LSP server connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { '.git' },
}

