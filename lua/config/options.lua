local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.wrap = false
opt.cursorline = true
opt.showmatch = true
opt.nrformats = ""
opt.swapfile = false

-- smartcase only has an effect when ignorecase is on
opt.ignorecase = true
opt.smartcase = true

opt.mouse = "a"
opt.complete:append("kspell")

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

opt.splitbelow = true
opt.splitright = true

-- System clipboard integration (replaces pbcopy/pbpaste mappings)
opt.clipboard = "unnamedplus"

opt.list = true
opt.listchars = { tab = "»·", trail = "·", nbsp = "·" }

opt.colorcolumn = "101"

opt.wildmode = "list:longest,list:full"

opt.diffopt:append("vertical")

opt.laststatus = 3 -- single global statusline
