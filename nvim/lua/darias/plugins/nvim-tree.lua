-- load eagerly only when neovim is opened on a directory (e.g. `nvim .`),
-- since netrw is disabled and nvim-tree needs to take over that buffer
local opened_on_dir = vim.fn.argc(-1) == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = not opened_on_dir,
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeCollapse", "NvimTreeRefresh" },
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" }, -- toggle file explorer
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file" }, -- toggle file explorer on current file
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer" }, -- collapse file explorer
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" }, -- refresh file explorer
  },
  config = function()
    local nvimtree = require("nvim-tree")

    -- change color for arrows in tree to light blue
    -- (re-applied on colorscheme change, which would otherwise reset them)
    local function set_arrow_highlights()
      vim.api.nvim_set_hl(0, "NvimTreeFolderArrowClosed", { fg = "#3FC5FF" })
      vim.api.nvim_set_hl(0, "NvimTreeFolderArrowOpen", { fg = "#3FC5FF" })
    end
    set_arrow_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("NvimTreeArrowHighlights", { clear = true }),
      callback = set_arrow_highlights,
    })

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
  end,
}
