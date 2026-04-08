return {
  cmd = { 'vscode-eslint-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.json', 'eslint.config.js', 'eslint.config.mjs', 'package.json', '.git' },
  settings = {
    validate = 'on',
    codeAction = {
      disableRuleComment = { enable = true, location = 'separateLine' },
      showDocumentation = { enable = true },
    },
    workingDirectory = { mode = 'auto' },
  },
}
