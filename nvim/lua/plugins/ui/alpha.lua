return  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local time = os.date("%H:%M")
		local date = os.date("%a %d %b")

		dashboard.section.buttons.val = {
			dashboard.button("SPACE p", "󰮗   Find file", ":Fzf files<CR>"),
			dashboard.button("SPACE n", "   File Explorer", ":Neotree position=current<CR>"),
			dashboard.button("SPACE r", "   Recent", ":Fzf oldfiles<CR>"),
			dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}

		local function centerText(text, width)
			local totalPadding = width - #text
			local leftPadding = math.floor(totalPadding / 2)
			local rightPadding = totalPadding - leftPadding
			return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
		end

        dashboard.section.footer.val = {
            centerText(date, 50),
            centerText(time, 50),
        }

        alpha.setup(dashboard.opts)

        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
