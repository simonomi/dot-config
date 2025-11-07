return {
	{ -- lsp
		"neoclide/coc.nvim",
		branch = "release"
	},
	{ -- fancy status bar!
		"nvim-lualine/lualine.nvim",
		opts = {
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
	},
	{ -- automatically adds closing deliminators
		"windwp/nvim-autopairs",
		config = {
			map_cr = false
		}
	},
	{ -- tab bar
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = function()
			return {
				options = {
					-- style_preset = require("bufferline").style_preset.minimal,
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
		opts = {
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
		branch = "master",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			ensure_installed = { "swift", "rust", "json", "markdown", "nu", "lua", "typst", "comment", "vim", "html", "css", "javascript" },
			highlight = {
				enable = true,
				disable = { "swift", "typst" }
			}
		}
	},
	{ -- treesitter text objects
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		main = "nvim-treesitter.configs",
		opts = {
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
				},
				swap = {
					enable = true,
					swap_next = {
						["ml"] = "@parameter.inner",
					},
					swap_previous = {
						["mj"] = "@parameter.inner",
					},
				}
			}
		}
	},
	{ -- file tree view
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
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
				symlink_destination = false,
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
	},
	{ -- lsp
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config {
				signs = false,
				severity_sort = true,
				virtual_text = {
					spacing = 0
				}
			}
			
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("my.lsp", {}),
				callback = function(args)
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
					
					if client:supports_method("textDocument/completion") then
						vim.lsp.completion.enable(true, client.id, args.buf, {
							autotrigger = false
						})
					end
				end
			})
			
			-- -- TODO: not necessarily lsp related
			-- local triggers = {"."}
			-- vim.api.nvim_create_autocmd("InsertCharPre", {
			-- 	buffer = vim.api.nvim_get_current_buf(),
			-- 	callback = function()
			-- 		if vim.fn.pumvisible() == 1 or vim.fn.state("m") == "m" then
			-- 			return
			-- 		end
			-- 		local char = vim.v.char
			-- 		if vim.list_contains(triggers, char) then
			-- 			local key = vim.keycode("<C-x><C-o>")
			-- 			vim.api.nvim_feedkeys(key, "m", false)
			-- 		end
			-- 	end
			-- })
			
			vim.lsp.enable {
				"sourcekit",
				"tinymist",
				"rust_analyzer",
				"lua_ls",
				"html",
				"cssls",
				"eslint",
				"jsonls",
				"nushell"
			}
		end
	},
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	init = function()
	-- 		vim.g.coq_settings = {
	-- 			auto_start = "shut-up",
	-- 			keymap = {
	-- 				pre_select = true
	-- 			},
	-- 			display = {
	-- 				pum = {
	-- 					x_max_len = 30,
	-- 					kind_context = {" ", ""},
	-- 					source_context = {" ", ""}
	-- 				},
	-- 				icons = {
	-- 					mode = "short"
	-- 				},
	-- 				statusline = {
	-- 					helo = false
	-- 				}
	-- 			}
	-- 		}
	-- 	end
	-- },
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	config = function()
	-- 		local cmp = require("cmp")
	-- 		return {
	-- 			snippet = {
	-- 				expand = function(args)
	-- 					vim.snippet.expand(args.body)
	-- 					-- insert({ body = args.body }) -- Insert at cursor
	-- 					-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
	-- 					-- require("cmp.config").set_onetime({ sources = {} })
	-- 				end,
	-- 			},
	-- 			window = {
	-- 				-- completion = cmp.config.window.bordered(),
	-- 				-- documentation = cmp.config.window.bordered(),
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert {
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-Space>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				["<CR>"] = cmp.mapping.confirm { select = true },
	-- 			},
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				-- { name = 'vsnip' }, -- For vsnip users.
	-- 				-- { name = 'luasnip' }, -- For luasnip users.
	-- 				-- { name = 'ultisnips' }, -- For ultisnips users.
	-- 				-- { name = 'snippy' }, -- For snippy users.
	-- 			}, {
	-- 				{ name = "buffer" }
	-- 			})
	-- 		}
	-- 	end
	-- }
	-- TODO: coqtail and idris2 should be lazy-loaded
	-- { "whonore/Coqtail" },
	-- {
	-- 	"ShinKage/idris2-nvim",
	-- 	dependencies = { "neovim/nvim-lspconfig", "MunifTanjim/nui.nvim" }
	-- },
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- 	opts = {
	-- 		multiwindow = true,
	-- 		max_lines = 5,
	-- 		multiline_threshold = 1,
	-- 		trim_scope = "inner",
	-- 		mode = "topline"
	-- 	}
	-- }
}

