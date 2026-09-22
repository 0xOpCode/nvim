-- ==============================================================================
-- ⚙️ C BUFFER-LOCAL SETTINGS (VS CODE / ALLMAN STYLE)
-- ==============================================================================

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true
vim.opt_local.smartindent = false
vim.opt_local.cindent = true

-- cinoptions:
-- :0: case labels at switch column
-- (0: align unclosed parentheses
-- W4: indent inside parentheses
-- m1: align closing parenthesis with line of matching parenthesis
-- {0: place opening brace at column 0 in Allman style
-- f0: place function opening brace at column 0
-- t0: do not indent function return type
-- p0: do not indent after function declarations / parentheses (K&R parameter indent off)
vim.opt_local.cinoptions = ":0,(0,W4,m1,{0,f0,t0,p0"
vim.opt_local.commentstring = "// %s"
