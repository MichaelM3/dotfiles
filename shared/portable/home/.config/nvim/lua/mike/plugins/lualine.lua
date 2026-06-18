return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local neocodeium_symbols = {
			status = {
				[0] = "󰚩",
				[1] = "󱚧",
				[2] = "󱙻",
				[3] = "󱙺",
				[4] = "󱙺",
				[5] = "󱚠",
				[6] = "󱚠",
			},
			server_status = {
				[0] = "󰣺",
				[1] = "󰣻",
				[2] = "󰣽",
			},
		}

		local function neocodeium_status()
			local ok, neocodeium = pcall(require, "neocodeium")
			if not ok then
				return ""
			end
			local status, server_status = neocodeium.get_status()
			return neocodeium_symbols.status[status]
				.. neocodeium_symbols.server_status[server_status]
		end

		local colors = {
			blue = "#8ba4b0",
			green = "#8a9a7b",
			violet = "#a292a3",
			yellow = "#c4b28a",
			red = "#c4746e",
			fg = "#c8c093",
			bg = "#181616",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						neocodeium_status,
						color = { fg = "#c4b28a" },
					},
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
				lualine_z = {
					{
						require("opencode").statusline,
					},
				},
			},
		})
	end,
}
