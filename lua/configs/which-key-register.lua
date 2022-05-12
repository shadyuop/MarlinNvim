local M = {}

local utils = require "core.utils"
local normal_opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      }


local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local mappings = {
    n = {
      ["<leader>"] = {
        p = { name = "Packer" },
        l = { name = "LSP" },
      },
    },
  }

  local extra_sections = {
    g = "Git",
    s = "Search",
    S = "Session",
    t = "Terminal",
  }

  local function init_table(mode, prefix, idx)
    if not mappings[mode][prefix][idx] then
      mappings[mode][prefix][idx] = { name = extra_sections[idx] }
    end
  end

  if utils.is_available "neovim-session-manager" then
    init_table("n", "<leader>", "S")
  end

  if utils.is_available "gitsigns.nvim" then
    init_table("n", "<leader>", "g")
  end

  if utils.is_available "nvim-toggleterm.lua" then
    init_table("n", "<leader>", "g")
    init_table("n", "<leader>", "t")
  end

  if utils.is_available "telescope.nvim" then
    init_table("n", "<leader>", "s")
    init_table("n", "<leader>", "g")
  end

which_key.register({
["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
["n"] = { "<cmd>enew<cr>", "New File" },
["."] = { "<cmd>cd %:p:h<cr>", "Set CWD" },

a = {
  name = "Annotate",
  ["<cr>"] = {
    function()
      require("neogen").generate()
    end,
    "Current",
  },
  c = {
    function()
      require("neogen").generate { type = "class" }
    end,
    "Class",
  },
  f = {
    function()
      require("neogen").generate { type = "func" }
    end,
    "Function",
  },
  t = {
    function()
      require("neogen").generate { type = "type" }
    end,
    "Type",
  },
  F = {
    function()
      require("neogen").generate { type = "file" }
    end,
    "File",
  },
},

f = {
  name = "Telescope",
  ["?"] = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  ["'"] = { "<cmd>Telescope marks<cr>", "Marks" },
  B = { "<cmd>Telescope bibtex<cr>", "BibTeX" },
  c = { "<cmd>Telescope commands<cr>", "Commands" },
  e = { "<cmd>Telescope file_browser<cr>", "Explorer" },
  F = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "All Files" },
  h = { "<cmd>Telescope oldfiles<cr>", "History" },
  k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  m = { "<cmd>Telescope marks<cr>", "Bookmarks" },
  M = { "<cmd>Telescope media_files<cr>", "Media" },
  n = { "<cmd>Telescope notify<cr>", "Notifications" },
  p = { "<cmd>Telescope project<cr>", "Projects" },
  r = { "<cmd>Telescope registers<cr>", "Registers" },
  t = { "<cmd>Telescope colorscheme<cr>", "Themes" },
  u = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
},

},normal_opts)

  -- mappings = require("configs.which-key-bkup").register_mappings
  -- -- support previous legacy notation, deprecate at some point
  -- -- mappings.n["<leader>"] = require("configs.which-key-bkup").register_mappings.n["<leader>"]
  -- for mode, prefixes in pairs(mappings) do
  --   for prefix, mapping_table in pairs(prefixes) do
  --     which_key.register(mapping_table, normal_opts)
  --   end
  -- end

  mappings = require("core.utils").user_plugin_opts("which-key.register_mappings", mappings)
  -- support previous legacy notation, deprecate at some point
  mappings.n["<leader>"] = require("core.utils").user_plugin_opts("which-key.register_n_leader", mappings.n["<leader>"])
  for mode, prefixes in pairs(mappings) do
    for prefix, mapping_table in pairs(prefixes) do
      which_key.register(mapping_table, {
        mode = mode,
        prefix = prefix,
        buffer = nil,
        silent = true,
        noremap = true,
        nowait = true,
      })
    end
  end
end

return M
