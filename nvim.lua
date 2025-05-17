vim.cmd.packadd("packer.nvim")
	
require("packer").startup(function()
	-- plugin manager
	use { "wbthomason/packer.nvim" }
	
	-- lsp integration
	use { "neoclide/coc.nvim", branch = "release" }
	-- html, sourcekit, rust-analyzer, python, json, css
	
	-- file tree view
	use {
		"nvim-tree/nvim-tree.lua",
		requires = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup {
				disable_netrw = true,
				hijack_cursor = true,
				sync_root_with_cwd = true,
				renderer = {
					group_empty = true,
					root_folder_label = false,
					highlight_opened_files = "all", -- TODO:
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
							file = { enable = true },
							folder = { enable = true }
						},
						show = {
							file = true,
							folder = true,
							folder_arrow = false,
							git = false,
							modified = false,
							diagnostics = true,
							bookmarks = false
						}
					}
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
	}
	
	-- fancy status bar!
	use {
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
	}
	
	-- tab bar
	use {
		"akinsho/bufferline.nvim",
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
	}
	
	-- <Leader>f
	use {
		"nvim-telescope/telescope.nvim", tag = "0.1.5",
		requires = {{ "nvim-lua/plenary.nvim" }},
		config = function()
			require("telescope").setup {
				defaults = {
					mappings = {
						i = {
							["<Esc>"] = "close",
							["<Left>"] = { "<Cmd>Telescope<CR>", type = "command" },
							["<Right>"] = "select_default"
						}
					}
				}
			}
		end
	}
	
	-- coq ide
	use { "whonore/Coqtail" }
	
	-- adding, changing, removing () {} <> [] etc
	use {
		"kylechui/nvim-surround",
		tag = "*",
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
	}
	
	-- changes how w e b work
	use {
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
	}
	
	-- automatically adds closing deliminators
	use {
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup { map_cr = false }
		end
	}
	
	-- toggle line comments
	use {
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end
	}
	
	-- LaTeX
	use "lervag/vimtex"
	
	-- undo tree
	use "mbbill/undotree"
	
	-- leap
	use {
		"ggandor/leap.nvim",
		config = function()
			vim.keymap.set("n", "s", "<Plug>(leap)")
			
			require("leap").opts.case_sensitive = true
			
			require("leap").opts.special_keys.prev_target = "<Backspace>"
			require("leap").opts.special_keys.prev_group = "<Backspace>"
			
			require("leap.user").set_repeat_keys("<Enter>", "<Backspace>")
		end
	}
	
	-- idris2-nvim
-- 	use {
-- 		"ShinKage/idris2-nvim",
-- 		requires = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" },
-- 		config = function()
-- 			require("idris2").setup {}
-- 		end
-- 	}
	
	-- auto close html tags
	-- note: needs `:TSInstall html` to work
	use {
		"windwp/nvim-ts-autotag",
		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup {}
		end
	}
	
	-- sticky headers
	use {
		"nvim-treesitter/nvim-treesitter-context",
-- 		requires = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup {
				multiwindow = true,
				max_lines = 5,
				multiline_threshold = 1,
				trim_scope = "inner",
				mode = "topline"
			}
		end
	}
	
	-- custom treesitter config
	require("nvim-treesitter.configs").setup {
		ensure_installed = { "swift", "rust", "json", "markdown", "nu" },
		highlight = {
			enable = true,
			disable = { "swift" }
		}
	}
end)
