return {
  cmd = { 'omnisharp', '--languageserver' },
  filetypes = { 'cs' },
  root_markers = { '*.sln', '*.csproj', '.git' },
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
      OrganizeImports = true,
    },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
}
