transparent_mode = true -- Set this to false if you don't want a transparent background

return {
  { "ellisonleao/gruvbox.nvim" },
  { "neanias/everforest-nvim" },
  { "xero/miasma.nvim" },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim" },
  { "iagorrr/noctishc.nvim" },
  { "Tsuzat/NeoSolarized.nvim" },

  -- Configure LazyVim to load peachpuff
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "catppuccin/nvim",
    config = function()
      require("catppuccin").setup({
        flavour = transparent_mode and "mocha" or "macchiato",
        transparent_background = transparent_mode,
        styles = {
          keywords = { "bold" },
          functions = { "italic" },
        },
        integrations = {
          alpha = false,
          neogit = false,
          nvimtree = true,
          treesitter_context = false,
          rainbow_delimiters = false,
          mini = { enabled = false },
          dropbar = { enabled = false },
          illuminate = { enabled = false },
          mason = true,
          noice = true,
          notify = true,
          neotest = true,
          which_key = true,
          nvim_surround = true,
          telescope = { style = transparent_mode and nil or "nvchad" },
        },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      style = "moon",
    },
  },
}
