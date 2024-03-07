local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = ' '
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true

vim.keymap.set('n', '<leader>k', function() vim.lsp.inlay_hint(0, nil) end,
    { desc = 'Toggle inlay hints' }
)
-- I had to map this because foot terminal outputs <D-Space> shit for some reason
vim.api.nvim_set_keymap('i', '<D-Space>', '<Nop>', { noremap = true })
vim.keymap.set('n', '<leader>#', ':b#<CR>', {})


function FixWrongLayout()
  local selected_text = vim.fn.getline("'<", "'>")
  local result = vim.fn.systemlist("python3 ~/scripts/fix_wrong_layout.py", selected_text)
  vim.fn.deletebufline('%', vim.fn.line("'<"), vim.fn.line("'>"))
  vim.fn.append(vim.fn.line("'<")-1, result)
end

vim.api.nvim_set_keymap('v', '<leader>t', ':lua FixWrongLayout()<CR>', {noremap = true, silent = true})



local plugins = {
    { 'rose-pine/neovim',                name = 'rose-pine' },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    -- {
    --     'ThePrimeagen/harpoon',
    --     dependencies = { 'nvim-lua/plenary.nvim' }
    -- },

    'natecraddock/workspaces.nvim',

    'stsewd/isort.nvim',

    'Slotos/telescope-lsp-handlers.nvim',

    'numToStr/Comment.nvim',
    'luckasRanarison/tree-sitter-hypr',
    'norcalli/nvim-colorizer.lua',
    'aveplen/ruscmd.nvim',
    { "folke/neodev.nvim", opts = {} },
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'lvimuser/lsp-inlayhints.nvim',
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
}

local opts = {}
require('lazy').setup(plugins, opts)

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { 'c', 'lua', 'vim', 'python', 'yaml' },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
}


local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp.default_keymaps({ buffer = bufnr })
end)
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()


local cmp = require('cmp')
require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
    }
})

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})

require('rose-pine').setup({ disable_italics = true })
vim.cmd('colorscheme rose-pine')
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.cmd(':highlight SignColumn guibg=NONE')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

local telescope = require('telescope')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

require('workspaces').setup()
telescope.load_extension('workspaces')
vim.keymap.set('n', '<leader>fw', ':Telescope workspaces<CR>', {})

-- telescope.load_extension('harpoon')
-- vim.keymap.set('n', '<leader>fh', ':Telescope harpoon marks<CR>', {})
-- local mark = require('harpoon.mark')
-- local ui = require('harpoon.ui')
-- vim.keymap.set('n', '<leader>a', mark.add_file)
-- vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu)
-- vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end)
-- vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end)
-- vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end)
-- vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end)

require 'telescope-lsp-handlers'.setup()

-- local smart_splits = require('smart-splits')
--
-- vim.keymap.set('n', '<A-C-h>', smart_splits.resize_left)
-- vim.keymap.set('n', '<A-C-j>', smart_splits.resize_down)
-- vim.keymap.set('n', '<A-C-k>', smart_splits.resize_up)
-- vim.keymap.set('n', '<A-C-l>', smart_splits.resize_right)
--
-- vim.keymap.set('n', '<A-h>', smart_splits.move_cursor_left)
-- vim.keymap.set('n', '<A-j>', smart_splits.move_cursor_down)
-- vim.keymap.set('n', '<A-k>', smart_splits.move_cursor_up)
-- vim.keymap.set('n', '<A-l>', smart_splits.move_cursor_right)
--
-- vim.keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left)
-- vim.keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down)
-- vim.keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up)
-- vim.keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right)
--
-- vim.keymap.set('n', '<leader>V','<CMD>split<CR>')
-- vim.keymap.set('n', '<leader>H','<CMD>vertical split<CR>')

require('Comment').setup()

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.hypr = {
    install_info = {
        url = "https://github.com/luckasRanarison/tree-sitter-hypr",
        files = { "src/parser.c" },
        branch = "master",
    },
    filetype = "hypr",
}

require('colorizer').setup()
require('ruscmd').setup {}

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            on_attach = on_attach,
        }
    end,
}

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


local dap = require('dap')
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
    name = 'lldb'
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
    -- ...
})
require("dapui").setup()
require("lsp-inlayhints").setup()
-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = "LspAttach_inlayhints",
--   callback = function(args)
--     if not (args.data and args.data.client_id) then
--       return
--     end
--
--     local bufnr = args.buf
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     require("lsp-inlayhints").on_attach(client, bufnr)
--   end,
-- })
