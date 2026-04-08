-- ~/.config/nvim/lua/statusline.lua
local lualine = require('lualine')

lualine.setup {
  options = {
    theme = 'auto',
    component_separators = { left = '\u{e0b1}', right = '\u{e0b3}' },
    section_separators = { left = '\u{e0b0}', right = '\u{e0b2}' },
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  winbar = {
    lualine_c = {{'filename', path = 1}},
  },
  inactive_winbar = {
    lualine_c = {{'filename', path = 1}},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
