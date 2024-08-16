return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-H>", "<cmd>TmuxNavigateLeft<CR>" },
      { "<C-J>", "<cmd>TmuxNavigateDown<CR>" },
      { "<C-K>", "<cmd>TmuxNavigateUp<CR>" },
      { "<C-L>", "<cmd>TmuxNavigateRight<CR>" },
      { "<C-P>", "<cmd>TmuxNavigatePrevious<CR>" },
    },
  },
  {
    "knubie/vim-kitty-navigator",
  },
  -- {
  --   "alexghergh/nvim-tmux-navigation",
  -- },
  -- {
  --   "MunsMan/kitty-navigator.nvim",
  --   -- stylua: ignore
  --   keys = {
  --     {"<C-h>", function()require("kitty-navigator").navigateLeft()end, desc = "Move left a Split", mode = {"n"}},
  --     {"<C-j>", function()require("kitty-navigator").navigateDown()end, desc = "Move down a Split", mode = {"n"}},
  --     {"<C-k>", function()require("kitty-navigator").navigateUp()end, desc = "Move up a Split", mode = {"n"}},
  --     {"<C-l>", function()require("kitty-navigator").navigateRight()end, desc = "Move right a Split", mode = {"n"}},
  --   },
  --   build = {
  --     "cp navigate_kitty.py ~/.config/kitty",
  --     "cp pass_keys.py ~/.config/kitty",
  --   },
  -- },
}
