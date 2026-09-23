return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>hm", function()
      harpoon:list():add()
    end, { desc = "Mark file with harpoon" })
    keymap.set("n", "<leader>hh", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon menu" })
    keymap.set("n", "<leader>hn", function()
      harpoon:list():next()
    end, { desc = "Go to next harpoon mark" })
    keymap.set("n", "<leader>hp", function()
      harpoon:list():prev()
    end, { desc = "Go to previous harpoon mark" })
  end,
}
