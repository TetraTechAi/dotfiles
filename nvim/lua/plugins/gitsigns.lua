------------------------------------------------------------------------------
-- Gitsigns: Git統合
------------------------------------------------------------------------------

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },

      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,

      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '次のGit変更箇所' })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = '前のGit変更箇所' })

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk, { desc = 'Gitステージhunk' })
        map('n', '<leader>gr', gs.reset_hunk, { desc = 'Gitリセットhunk' })
        map('v', '<leader>gs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Gitステージ選択範囲' })
        map('v', '<leader>gr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, { desc = 'Gitリセット選択範囲' })

        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Gitステージバッファ全体' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Gitステージ取り消し' })
        map('n', '<leader>gR', gs.reset_buffer, { desc= 'Gitリセットバッファ全体' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Gitプレビューhunk' })
        map('n', '<leader>gb', function()
          gs.blame_line({ full = true })
        end, { desc = 'Git blame行' })
        map('n', '<leader>gB', gs.toggle_current_line_blame, { desc = 'Git blame表示切替' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'Git diff表示' })
        map('n', '<leader>gD', function()
          gs.diffthis('~')
        end, { desc = 'Git diff表示(~)' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Gitsigns hunk選択' })
      end,
    })
  end,
}
