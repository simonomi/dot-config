return {
	{ -- lsp
		"neoclide/coc.nvim",
		branch = "release"
	},
	{ -- fancy status bar!
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup {
				options = {
					theme = "dracula",
					component_separators = { left = "", right = ""},
					section_separators = { left = "", right = ""}
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = { "progress" },
					lualine_z = { "location" }
				}
			}
		end
	},
	{ -- automatically adds closing deliminators
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup { map_cr = false }
		end
	},
	{ -- tab bar
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			local bufferline = require("bufferline")
			bufferline.setup {
				options = {
					style_preset = bufferline.style_preset.minimal,
					numbers = "buffer_id",
					indicator = { style = "underline" },
					modified_icon = "●",
					left_trunc_marker = "◀",
					right_trunc_marker = "▶",
					max_name_length = 0,
					max_prefix_length = 0,
					truncate_names = false,
					tab_size = 0,
					custom_filter = function(buf_number)
						return vim.bo[buf_number].buftype ~= "terminal"
					end,
					offsets = {
						{
							filetype = "NvimTree",
							text = function()
								return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							end,
							highlight = "Directory",
							text_align = "left",
							separator = true
						}
					},
					show_buffer_close_icons = false,
					separator_style = { "", "" },
					always_show_bufferline = false,
					auto_toggle_bufferline = true,
				}
			}
		end
	},
	{ -- adding, changing, removing () {} <> [] etc
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup {
				surrounds = {
					["("] = { add = { "(" , ")" }  },
					[")"] = { add = { "( ", " )" } },
					["<"] = { add = { "<" , ">" }  },
					[">"] = { add = { "< ", " >" } },
					["["] = { add = { "[" , "]" }  },
					["]"] = { add = { "[ ", " ]" } },
					["/"] = {
						add = { "/* ", " */" },
						find = "(/%* )().-( %*/)()",
						delete = "(/%* )().-( %*/)()"
					},
					["?"] = {
						add = { "/*", "*/" },
						find = "(/%*)().-(%*/)()",
						delete = "(/%*)().-(%*/)()"
					}
				}
			}
		end
	},
	{ -- changes how w e b work
		"chrisgrieser/nvim-spider",
		config = function()
			vim.keymap.set(
				{ "n", "o", "x" },
				"w",
				"<Cmd>lua require'spider'.motion('w')<CR>",
				{ desc = "Spider-w" }
			)
			vim.keymap.set(
				{ "n", "o", "x" },
				"e",
				"<Cmd>lua require'spider'.motion('e')<CR>",
				{ desc = "Spider-e" }
			)
			vim.keymap.set(
				{ "n", "o", "x" },
				"b",
				"<Cmd>lua require'spider'.motion('b')<CR>",
				{ desc = "Spider-b" }
			)
		end
	},
	{ "mbbill/undotree" },
	{ -- treesitter
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "swift", "rust", "json", "markdown", "nu", "lua", "typst" },
				highlight = {
					enable = true,
					disable = { "swift", "typst" }
				}
			}
		end
	},
	{ -- treesitter text objects
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup {
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["a="] = "@assignment.outer",
							["h="] = "@assignment.inner",
							["l="] = "@assignment.lhs",
							["r="] = "@assignment.rhs",
							["ac"] = "@call.outer",
							["hc"] = "@call.inner",
							["a/"] = "@comment.outer",
							["h/"] = "@comment.inner",
							["af"] = "@function.outer",
							["hf"] = "@function.inner",
							["aa"] = "@parameter.outer",
							["ha"] = "@parameter.inner",
							["ar"] = "@regex.outer",
							["hr"] = "@regex.inner",
						},
						include_surrounding_whitespace = function(textobject)
							(textobject.query_string):find("outer")
						end
					}
				}
			}
		end
	},
	{ -- file tree view
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup {
				hijack_cursor = true,
				sync_root_with_cwd = true,
				view = {
					width = {
						min = 1
					}
				},
				renderer = {
					group_empty = true,
					root_folder_label = false,
					highlight_opened_files = "all",
					decorators = {},
					indent_markers = {
						enable = true,
						inline_arrows = false,
						icons = {
							corner = "╰",
							edge = "│",
							item = "├",
							bottom = "─",
							none = " "
						}
					},
					icons = {
						web_devicons = {
							folder = {
								enable = true
							}
						},
						show = {
							git = false,
							modified = false,
							bookmarks = false
						}
					}
				},
				git = {
					enable = false
				},
				diagnostics = {
					enable = true,
					show_on_dirs = false,
					show_on_open_dirs = true,
					debounce_delay = 50,
					severity = {
						min = vim.diagnostic.severity.HINT,
						max = vim.diagnostic.severity.ERROR,
					},
					icons = {
						error = "",
						warning = "",
						info = "󰰅",
						hint = "",
					}
				},
				filters = {
					dotfiles = true
				}
			}
		end
	},
	-- TODO: switch to built-in lsp over coc (?)
	{ -- lsp
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable("sourcekit")
		end
	}
	-- TODO: coqtail and idris2 should be lazy-loaded
	-- { "whonore/Coqtail" },
	-- {
	-- 	"ShinKage/idris2-nvim",
	-- 	dependencies = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" },
	-- 	config = function()
	-- 		require("idris2").setup {}
	-- 	end
	-- },
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	config = function()
	-- 		require("treesitter-context").setup {
	-- 			multiwindow = true,
	-- 			max_lines = 5,
	-- 			multiline_threshold = 1,
	-- 			trim_scope = "inner",
	-- 			mode = "topline"
	-- 		}
	-- 	end
	-- }
}

