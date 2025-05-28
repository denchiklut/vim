return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "literals",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeCompletionsForModuleExports = true,
        },
      },
    },
  },
  { import = "nvchad.blink.lazyspec" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-space>",
          node_incremental = "<M-space>",
          node_decremental = "<bs>",
        },
      },
    },
  },
  { "nvzone/volt", lazy = true },
  { "nvzone/menu", lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "nvzone/typr",
    dependencies = "nvzone/volt",
    opts = {},
    cmd = { "Typr", "TyprStats" },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = require "configs.gitsigns",
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/" },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = { "MunifTanjim/nui.nvim" },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
        ["<Esc>"] = require("telescope.actions").close,
      }
      conf.defaults.mappings.n = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
      }

      return conf
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = require("configs.trouble").keys,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          require "configs.statuscol"
        end,
      },
    },
    config = function()
      require "configs.ufo"
    end,
  },
  {
    "vim-test/vim-test",
    cmd = {
      "TestNearest",
      "TestFile",
      "TestSuite",
      "TestLast",
      "TestVisit",
    },
    dependencies = { "preservim/vimux" },
    config = function()
      vim.cmd [[let test#strategy = 'vimux']]
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require("configs.flash").keys,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = { "sindrets/diffview.nvim" },
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<M-m>",
        ["Find Subword Under"] = "<M-m>",
        ["Add Cursor Down"] = "<S-M-j>",
        ["Add Cursor Up"] = "<S-M-k>",
      }
    end,
  },
  {
    "lucidph3nx/nvim-sops",
    keys = {
      { "<leader>ef", vim.cmd.SopsEncrypt, desc = "Encrypt File" },
      { "<leader>df", vim.cmd.SopsDecrypt, desc = "Decrypt File" },
    },
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    version = "*",
    opts = {},
  },
  {
    "echasnovski/mini.move",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
      options = {
        reindent_linewise = true,
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    opts = {
      display = {
        chat = {
          start_in_insert_mode = true,
        },
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "openai",
        },
        cmd = {
          adapter = "openai",
        },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            picker = "telescope",
            enable_logging = false,
            dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
            auto_save = true,
            save_chat_keymap = "sc",
          },
        },
      },
    },
    dependencies = {
      "github/copilot.vim",
      "ravitemer/codecompanion-history.nvim",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {
      heading = { border = true },
      file_types = { "markdown", "codecompanion" },
    },
    ft = { "markdown", "codecompanion" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      require("configs.highlight").setup()
    end,
  },
}
