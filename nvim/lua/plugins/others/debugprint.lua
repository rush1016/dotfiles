return {
    "andrewferrier/debugprint.nvim",

    -- opts = { … },

    dependencies = {
        "echasnovski/mini.nvim" -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
    },

    version = "*", -- Remove if you DON'T want to use the stable version
    config = function()
        require("debugprint").setup()
    end,
}
