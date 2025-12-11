------------------------------------------------------------------------------
-- alpha-nvim: スタートアップ画面
------------------------------------------------------------------------------
-- Neovim起動時にダッシュボード画面を表示

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ASCIIアートヘッダー
    dashboard.section.header.val = {
      [[                                                    ]],
      [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
      [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
      [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                    ]],
    }

    -- ボタン設定
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("o", "  Obsidian Vault", ":cd ~/obsidian/main_vault | Yazi<CR>"),
      dashboard.button("g", "  Git status", ":Telescope git_status<CR>"),
      dashboard.button("p", "  Plugins", ":Lazy<CR>"),
      dashboard.button("m", "  Mason", ":Mason<CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- フッター（初期値）
    dashboard.section.footer.val = function()
      local stats = require("lazy").stats()
      return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded"
    end

    -- レイアウト
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)

    -- Lazy起動完了後にフッターを更新（起動時間を表示）
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = function()
          local stats = require("lazy").stats()
          return "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins loaded in " .. string.format("%.2f", stats.startuptime) .. "ms"
        end
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
