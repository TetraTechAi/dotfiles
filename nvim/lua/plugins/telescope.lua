------------------------------------------------------------------------------
-- Telescope: ファジーファインダー
------------------------------------------------------------------------------

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        -- 表示設定
        prompt_prefix = '🔍 ',
        selection_caret = '➤ ',
        path_display = { 'truncate' },

        -- ソート設定
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },

        -- マッピング
        mappings = {
          i = {
            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,
            ['<C-c>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,
            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,
          },
          n = {
            ['q'] = actions.close,
            ['<C-c>'] = actions.close,
          },
        },

        -- ファイル無視設定
        file_ignore_patterns = {
          'node_modules',
          '.git/',
          'dist/',
          'build/',
          'target/',
          '%.lock',
        },
      },

      -- Picker固有設定
      pickers = {
        find_files = {
          hidden = true,  -- 隠しファイルも表示
          find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },
        },
        live_grep = {
          additional_args = function()
            return { '--hidden', '--glob', '!.git/*' }
          end,
        },
        buffers = {
          sort_mru = true,
          mappings = {
            i = {
              ['<C-d>'] = actions.delete_buffer,
            },
          },
        },
      },

      -- 拡張機能
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    })

    -- fzf拡張の読み込み
    pcall(telescope.load_extension, 'fzf')
  end,
}
