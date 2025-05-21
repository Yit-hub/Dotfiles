return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Esto asegura que se cargue antes que otros
    config = function()
      require("gruvbox").setup({
        -- Aquí puedes poner opciones personalizadas
        contrast = "hard", -- o 'soft' | 'medium'
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox") -- Activa el tema
    end,
  },
}
