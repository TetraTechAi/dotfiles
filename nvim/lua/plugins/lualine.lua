------------------------------------------------------------------------------
-- Lualine: ステータスライン
------------------------------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- アイコン表示
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight",
        globalstatus = true,  -- グローバルステータスライン（Neovim 0.7+）
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "dashboard", "alpha" },
          winbar = {},
        },
      },

      sections = {
        -- 左側
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = "✘ ", warn = "▲ ", info = "» ", hint = "⚑ " },
          },
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 相対パス表示
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },

        -- 右側
        lualine_x = {
          {
            -- LSPサーバー表示
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if next(clients) == nil then
                return ""
              end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return " " .. table.concat(names, ", ")
            end,
          },
          "encoding",
          {
            "fileformat",
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
          },
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      -- 非アクティブウィンドウ
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      -- 拡張機能
      extensions = { "quickfix", "fugitive", "lazy" },
    })
  end,
}
