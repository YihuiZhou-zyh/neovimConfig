vim.cmd "packadd packer.nvim"

local plugins = {

  ["nvim-lua/plenary.nvim"] = { module = "plenary" },
  ["wbthomason/packer.nvim"] = {
    cmd = require("core.lazy_load").packer_cmds,
    config = function()
      require "plugins"
    end,
  },
  -- markdowm
  ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },
  ["preservim/vim-markdown"] = {
    config = function()
      local ok, markdown = pcall(require, "vim-markdown")

      if ok then
        markdown.setup()
      end
    end,
  },
  ["iamcco/markdown-preview.nvim"] = {
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }
  },

  -- ["ellisonleao/glow.nvim"] = {
  --   config = function()
  --     local ok, glow = pcall(require, "glow")
  --     if ok then
  --       glow.setup({
  --         glow_path = "", -- filled automatically with your glow bin in $PATH,
  --         glow_install_path = "~/.local/bin", -- default path for installing glow binary
  --         border = "shadow", -- floating window border config
  --         -- style = "dark|light", -- filled automatically with your current editor background, you can override using glow json style
  --         pager = false,
  --         width = 80,
  --       })
  --     end
  --   end,
  --
  -- },
  ["NvChad/base46"] = {
    config = function()
      local ok, base46 = pcall(require, "base46")

      if ok then
        base46.load_theme()
      end
    end,
  },

  ["NvChad/ui"] = {
    after = "base46",
    config = function()
      require("plugins.configs.others").nvchad_ui()
    end,
  },

  ["NvChad/nvterm"] = {
    module = "nvterm",
    config = function()
      require "plugins.configs.nvterm"
    end,
    setup = function()
      require("core.utils").load_mappings "nvterm"
    end,
  },

  ["kyazdani42/nvim-web-devicons"] = {
    after = "ui",
    module = "nvim-web-devicons",
    config = function()
      require("plugins.configs.others").devicons()
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-blankline.nvim"
      require("core.utils").load_mappings "blankline"
    end,
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-colorizer.lua"
    end,
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    module = "nvim-treesitter",
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter"
    end,
    cmd = require("core.lazy_load").treesitter_cmds,
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },

  -- git stuff
  ["lewis6991/gitsigns.nvim"] = {
    ft = "gitcommit",
    setup = function()
      require("core.lazy_load").gitsigns()
    end,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
  },

  -- lsp stuff

  ["williamboman/mason.nvim"] = {
    cmd = require("core.lazy_load").mason_cmds,
    config = function()
      require "plugins.configs.mason"
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only

  ["rafamadriz/friendly-snippets"] = {
    module = { "cmp", "cmp_nvim_lsp" },
    event = "InsertEnter",
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },

  ["hrsh7th/cmp-nvim-lua"] = {
    after = "cmp_luasnip",
  },

  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "cmp-nvim-lua",
  },

  ["hrsh7th/cmp-buffer"] = {
    after = "cmp-nvim-lsp",
  },

  ["hrsh7th/cmp-path"] = {
    after = "cmp-buffer",
  },

  -- misc plugins
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },

  ["goolord/alpha-nvim"] = {
    after = "base46",
    disable = false,
    config = function()
      require "plugins.configs.alpha"
    end,
  },

  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("plugins.configs.others").comment()
    end,
    setup = function()
      require("core.utils").load_mappings "comment"
    end,
  },

  -- file managing , picker etc
  ["kyazdani42/nvim-tree.lua"] = {
    ft = "alpha",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
    setup = function()
      require("core.utils").load_mappings "nvimtree"
    end,
  },

  ["nvim-telescope/telescope.nvim"] = {
    cmd = "Telescope",
    config = function()
      require "plugins.configs.telescope"
    end,
    setup = function()
      require("core.utils").load_mappings "telescope"
    end,
  },

  -- dap
  ["mfussenegger/nvim-dap"] = {
    disable = false,
    -- config = function()
    --   require "plugins.dap"
    -- end,
    requires = {
      "Pocco81/DAPInstall.nvim",
      -- "mfussenegger/nvim-dap-python",
    },
  },
  ["rcarriga/nvim-dap-ui"] = {
    after = "nvim-dap",
    config = function()
      require("dapui").setup()
    end,
  },
  ["mfussenegger/nvim-dap-python"] = {
    after = "nvim-dap",
    config = function()
      require("dap-python").setup('/Users/zhouyihui/opt/anaconda3/bin/python')
    end
  },
  -- ["puremourning/vimspector"] = {
  --   -- config = function ()
  --   --   require("vimspector")
  --   -- end
  --   cmd = { "VimspectorInstall", "VimspectorUpdate" },
  --   fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
  --   config = function()
  --     require("plugins.configs.vimspector").setup()
  --   end,
  --   run = "./install_gadget.py --enable-python --enable-c --enable-cpp"
  -- },
  --
  -- Only load whichkey after all the gui
  ["folke/which-key.nvim"] = {
    disable = false,
    module = "which-key",
    keys = "<leader>",
    config = function()
      require "plugins.configs.whichkey"
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },

  -- Speed up deffered plugins
  ["lewis6991/impatient.nvim"] = {},
}
pcall(
  vim.cmd,
  [[
      augroup packer_user_config
      autocmd!
      autocmd BufWritePost init.lua source <afile> | PackerSync
      augroup end
    ]]
)
require("core.packer").run(plugins)
