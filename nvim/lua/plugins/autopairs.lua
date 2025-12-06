------------------------------------------------------------------------------
-- nvim-autopairs: 括弧・クォート自動補完
------------------------------------------------------------------------------

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,  -- Treesitterを使用してペア判定
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        typescript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",  -- Alt+e で括弧を追加
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- nvim-cmpとの統合
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Tabで閉じ括弧を抜ける
    vim.keymap.set("i", "<Tab>", function()
      local col = vim.fn.col(".") - 1
      local char = vim.fn.getline("."):sub(col + 1, col + 1)
      if char:match('[%)%]%}\'"`]') then
        return "<Right>"
      elseif vim.fn.pumvisible() == 1 then
        return "<C-n>"  -- 補完メニューが開いている場合は次の候補
      else
        return "<Tab>"
      end
    end, { expr = true, noremap = true, desc = "Tab: 閉じ括弧を抜ける/補完選択" })
  end,
}
