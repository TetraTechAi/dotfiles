return {
  -- colorscheme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight-moon]])
    end
  },

  -- Auto close parentheses
  {
    'cohama/lexima.vim',
    lazy = false,
  },


  -- Filer
  {
    'lambdalisue/fern.vim',
    lazy = false,
    keys = {
      {
        "<C-n>", ":Fern . -reveal=% -drawer -toggle -width=40<CR>",
        desc = "toggle fern"
      }
    },
    dependencies = {
      {
        'lambdalisue/nerdfont.vim',
      },
      {
        'lambdalisue/fern-renderer-nerdfont.vim',
        config = function()
          vim.g['fern#renderer'] = "nerdfont"
        end
      },
    },
  },

  -- VIM help Japanese
  {
    'vim-jp/vimdoc-ja',
    lazy = true,
    keys = {
      {
        "h",
        mode = "c",
      },
    },
  },

  -- push gcc comment
  {
    'tpope/vim-commentary',
    lazy = false,
    keys = {
      {
        "gcc",
        mode = "n",
        desc = "comment"
      },
    },
  },

  -- Indent Guides
  {
    'nathanaelkane/vim-indent-guides',
    lazy = false,
    init = function()
      vim.g['indent_guides_enable_on_vim_startup'] = 1
    end
  },

  -- github copilot
  {
    'github/copilot.vim',
    lazy=false,
    config = function()
      vim.g['copilot#enabled'] = 1
    end
  },

  -- Toggle Terminal
  {
    'akinsho/nvim-toggleterm.lua',
    lazy = false,
    keys = {
      {
        "<C-t>",
        mode = "n",
        desc = "toggle terminal"
      },
    },
    config = function()
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<c-t>]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 1,
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal',
      }
    end,
  },

  -- Git Decorations
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Air line
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = function()
      require('lualine').setup{
        -- options = {
        --   theme = 'tokyonight-moon'
      }
    end
  },

  -- Syntax
  {
    'sheerun/vim-polyglot'
  },

  -- -- Treesitter
  -- {
  --   'nvim-treesitter/nvim-treesitter',
  --   lazy = false,
  --   config = function()
  --     require('nvim-treesitter.configs').setup {
  --       ensure_installed = "maintained",
  --       highlight = {
  --         enable = true,
  --       },
  --       indent = {
  --         enable = true,
  --       },
  --     }
  --   end
  -- },










  ------------------------------
  -- LSP
  ------------------------------

  -- -- mason
  -- {
  --   'williamboman/mason.nvim',
  --   lazy = false,
  --   build = ":MasonUpdate",
  --   opts = {},
  -- },

  -- -- lspconfig
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   depends = {
  --     {
  --       'williamboman/mason.nvim'
  --     },
  --     {
  --       'neovim/nvim-lspconfig',
  --     },
  --     {
  --       'echasnovski/mini.completion',
  --       version = false,
  --     },
  --   },
  -- }


}

