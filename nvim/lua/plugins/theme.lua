return {
  -- 1. Base Setup & The Assassination of Tokyonight
  { "LazyVim/LazyVim", opts = { colorscheme = "habamax" } },

  -- 2. THE VANTABLACK ENFORCER + TRANSPARENCY
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NeoTreeNormal",
          "NeoTreeNormalNC",
          "SnacksNormal",
          "SnacksNormalNC",
          "SnacksDashboardNormal",
          "SnacksPicker",
          "SnacksPickerBorder",
          "SnacksPickerInput",
          "SnacksPickerInputBorder",
          "SnacksPickerList",
          "SnacksPickerListBorder",
          "SnacksPickerPreview",
          "SnacksPickerPreviewBorder",
          "TabLine",
          "TabLineFill",
          "TabLineSel",
          "BufferLinePanel",
          "BufferLineFill",
          "BufferLineBackground",
          "BufferLineSeparator",
          "BufferLineSeparatorVisible",
          "BufferLineSeparatorSelected",
          "BufferLineBuffer",
          "BufferLineBufferVisible",
          "BufferLineBufferSelected",
          "BufferLineTab",
          "BufferLineTabSelected",
          "BufferLineIndicatorSelected",
        },
        exclude_groups = {},
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          local hl = function(group, opts)
            vim.api.nvim_set_hl(0, group, opts)
          end

          -- CORE UI
          hl("Normal", { fg = "#E5E7EB", bg = vim.g.neovide and "#000000" or "NONE" })
          hl("FloatBorder", { fg = "#555659" })
          hl("LineNr", { fg = "#47474A" })
          hl("CursorLineNr", { fg = "#E5E7EB", bold = true })
          hl("Directory", { fg = "#E5E7EB" })
          hl("Title", { fg = "#E5E7EB", bold = true })

          -- OPAQUE FLOATING LAYER DEEPLY DISTINGUISHED (Matches WezTerm Base Color)
          hl("NormalFloat", { bg = "NONE", fg = "#B2B2B2" })
          hl("FloatBorder", { bg = "NONE", fg = "#3F3F42" }) -- Crisp bounding frame outline
          hl("TelescopeNormal", { bg = "NONE", fg = "#B2B2B2" })
          hl("TelescopeBorder", { bg = "NONE", fg = "#3F3F42" })
          hl("WhichKeyNormal", { bg = "NONE", fg = "#B2B2B2" })
          hl("WhichKeyFloat", { bg = "NONE", fg = "#3F3F42" })
          -- COMPLETION DROP-DOWN MENU (Matches the documentation box background)
          hl("Pmenu", { bg = "NONE", fg = "#B2B2B2" })
          hl("BlinkCmpMenu", { bg = "NONE", fg = "#B2B2B2" })
          hl("BlinkCmpDoc", { bg = "NONE", fg = "#B2B2B2" })

          -- SELECTION BAR IN DROPDOWN (Matches your custom Visual Mode gray)
          hl("PmenuSel", { bg = "#3F3F42", fg = "#E5E7EB", bold = true })
          hl("BlinkCmpMenuSelection", { bg = "#3F3F42", fg = "#E5E7EB", bold = true })
          -- THE NEW HIGHLIGHTS
          hl("Visual", { bg = "#3F3F42" })
          hl("MatchParen", { fg = "#FFFFFF", bg = "NONE", bold = true })
          hl("IncSearch", { bg = "#555659", fg = "#E5E7EB", bold = true })

          -- KILL YELLOW FOR WARNINGS: Swapped out neon yellow for a clean monochrome look
          hl("DiagnosticWarn", { fg = "#87888C" })
          hl("DiagnosticSignWarn", { fg = "#87888C" })
          hl("DiagnosticFloatingWarn", { fg = "#87888C" })
          hl("WarningMsg", { fg = "#87888C", bold = true })

          -- PERFECTED MONOCHROME SYNTAX MATRIX (Muted to match YASB spacing)
          hl("Comment", { fg = "#6C6D70", italic = true }) -- Soft, readable comment gray
          hl("Function", { fg = "#E5E7EB", bold = true }) -- Crisp silver-white for methods
          hl("Keyword", { fg = "#BDBFC3" }) -- Clean slate gray for syntax keys
          hl("Statement", { fg = "#BDBFC3" })
          hl("PreProc", { fg = "#BDBFC3" })
          hl("String", { fg = "#A7A9AC" }) -- Deep gray for strings (Kills contrast bleed)
          hl("Number", { fg = "#B0B1B5" })
          hl("Boolean", { fg = "#B0B1B5" })
          hl("Constant", { fg = "#B0B1B5" })
          hl("Type", { fg = "#A9AAAE" })
          hl("Special", { fg = "#A9AAAE" })
          hl("Identifier", { fg = "#87888C" }) -- Subdued tokening for raw variables
          hl("Operator", { fg = "#6C6D70" }) -- Darkened symbols/punctuation
          hl("Error", { fg = "#E5E7EB", bold = true })
          hl("MoreMsg", { fg = "#E5E7EB" })

          -- SNACKS DASHBOARD OVERRIDES
          hl("SnacksDashboardHeader", { fg = "#E5E7EB" })
          hl("SnacksDashboardDesc", { fg = "#87888C" })
          hl("SnacksDashboardIcon", { fg = "#6C6D70" })
          hl("SnacksDashboardKey", { fg = "#BDBFC3", bold = true })
          hl("SnacksDashboardFooter", { fg = "#47474A" })
          hl("SnacksDashboardDir", { fg = "#47474A" })
          hl("SnacksDashboardStats", { fg = "#87888C" })
          hl("SnacksDashboardSpecial", { fg = "#6C6D70" })

          -- WHICH-KEY OVERRIDES
          hl("WhichKey", { fg = "#E5E7EB" })
          hl("WhichKeyGroup", { fg = "#BDBFC3" })
          hl("WhichKeyDesc", { fg = "#87888C" })
          hl("WhichKeySeparator", { fg = "#47474A" })
          hl("WhichKeyIcon", { fg = "#555659" })

          -- NEO-TREE OVERRIDES
          hl("NeoTreeFileName", { fg = "#B2B2B2" })
          hl("NeoTreeRootName", { fg = "#E5E7EB", bold = true })
          hl("NeoTreeDirName", { fg = "#87888C" })
          hl("NeoTreeGitAdded", { fg = "#A7A9AC" })
          hl("NeoTreeGitModified", { fg = "#6C6D70" })
          hl("NeoTreeGitDeleted", { fg = "#47474A" })

          -- ISOLATED EXPLORER & PICKER TRANSPARENCY SHAPING (Forces transparency)
          hl("SnacksNormal", { bg = "NONE" })
          hl("SnacksNormalNC", { bg = "NONE" })
          hl("SnacksWinNormal", { bg = "NONE" })
          hl("SnacksWinNormalNC", { bg = "NONE" })
          hl("SnacksPicker", { bg = "NONE" })
          hl("SnacksPickerBorder", { bg = "NONE", fg = "#3F3F42" })
          hl("SnacksPickerInput", { bg = "NONE" })
          hl("SnacksPickerList", { bg = "NONE" })
          hl("SnacksPickerPreview", { bg = "NONE" })
          hl("NeoTreeNormal", { bg = "NONE" })
          hl("NeoTreeNormalNC", { bg = "NONE" })
          -- SAFE BACKGROUND CLEARING (Using foolproof Vimscript)
          vim.cmd([[
            hi CursorLine guibg=NONE ctermbg=NONE
            hi SignColumn guibg=NONE ctermbg=NONE
            hi StatusLine guibg=NONE ctermbg=NONE
            hi StatusLineNC guibg=NONE ctermbg=NONE
            hi WinSeparator guibg=NONE ctermbg=NONE guifg=#47474A
            hi VertSplit guibg=NONE ctermbg=NONE guifg=#47474A
            hi SnacksNormal guibg=NONE ctermbg=NONE
            hi SnacksNormalNC guibg=NONE ctermbg=NONE
            hi SnacksPicker guibg=NONE ctermbg=NONE
            hi SnacksPickerBorder guibg=NONE ctermbg=NONE
            hi SnacksPickerInput guibg=NONE ctermbg=NONE
            hi SnacksPickerInputBorder guibg=NONE ctermbg=NONE
            hi SnacksPickerList guibg=NONE ctermbg=NONE
            hi SnacksPickerListBorder guibg=NONE ctermbg=NONE
            hi SnacksPickerPreview guibg=NONE ctermbg=NONE
            hi SnacksPickerPreviewBorder guibg=NONE ctermbg=NONE
            hi NeoTreeNormal guibg=NONE ctermbg=NONE
            hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
            hi TabLine guibg=NONE ctermbg=NONE
            hi TabLineFill guibg=NONE ctermbg=NONE
            hi TabLineSel guibg=NONE ctermbg=NONE
            hi BufferLineFill guibg=NONE ctermbg=NONE
            hi BufferLineBackground guibg=NONE ctermbg=NONE
            hi BufferLinePanel guibg=NONE ctermbg=NONE
            hi BufferLineBuffer guibg=NONE ctermbg=NONE
            hi BufferLineBufferVisible guibg=NONE ctermbg=NONE
            hi BufferLineBufferSelected guibg=NONE ctermbg=NONE
            hi BufferLineSeparator guibg=NONE ctermbg=NONE
            hi BufferLineSeparatorVisible guibg=NONE ctermbg=NONE
            hi BufferLineSeparatorSelected guibg=NONE ctermbg=NONE
            hi BufferLineTab guibg=NONE ctermbg=NONE
            hi BufferLineTabSelected guibg=NONE ctermbg=NONE
            ]])
        end,
      })
      vim.cmd([[colorscheme habamax]])
    end,
  },

  -- 3. KILL ICON COLORS
  {
    "nvim-mini/mini.icons",
    opts = function(_, opts)
      return opts
    end,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.cmd([[
            hi! link MiniIconsAzure Normal
            hi! link MiniIconsBlue Normal
            hi! link MiniIconsCyan Normal
            hi! link MiniIconsGreen Normal
            hi! link MiniIconsGrey Normal
            hi! link MiniIconsOrange Normal
            hi! link MiniIconsPurple Normal
            hi! link MiniIconsRed Normal
            hi! link MiniIconsYellow Normal
            hi! link DevIconDefault Normal
          ]])
        end,
      })
    end,
  },

  -- 4. LUALINE (Unified YASB Minimalist Alignment)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.disabled_filetypes = {
        statusline = { "neo-free", "snacks_dashboard", "snacks_picker_input", "snacks_picker_list" },
        winbar = {},
      }

      local colors = {
        void = "NONE",
        text = "#B2B2B2",
        text2 = "#E5E7EB",
        muted = "#6C6D70",
        sep_color = "#47474A",
      }

      local function global_sep()
        return {
          function()
            return "│"
          end,
          color = { fg = colors.sep_color },
          padding = { left = 0, right = 0 },
        }
      end

      local moon_frames = {
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      }
      local moon_idx = 1

      -- Explicitly listen ONLY to user input/navigation actions
      vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "CursorMoved", "CursorMovedI" }, {
        pattern = "*",
        callback = function()
          moon_idx = (moon_idx % #moon_frames) + 1
        end,
      })
      local function moon_spinner()
        -- Automatically advances one frame whenever a keystroke triggers a statusline redraw
        return moon_frames[moon_idx] .. " LUNAR"
      end
      -- Completely wipe automated behaviors to prevent layout fracturing
      opts.options.section_separators = { left = "", right = "" }
      opts.options.component_separators = { left = "", right = "" }

      -- Explicitly build sections to eliminate default LazyVim bloat
      opts.sections.lualine_a = {
        { "mode", color = { fg = colors.text2, gui = "bold" }, padding = { left = 1, right = 1 } },
      }

      opts.sections.lualine_b = {
        global_sep(),
        -- Clean, shortened relative path tracker (e.g., "config/options.lua")
        {
          "filename",
          path = 1,
          symbols = { modified = "[+]", readonly = "[-]", unnamed = "[*]" },
          color = { fg = colors.text },
        },
      }
      opts.sections.lualine_c = {
        { "navic", color = { fg = colors.muted } }, -- Function context breadcrumbs
      }

      opts.sections.lualine_x = {
        { "diagnostics", color = { fg = colors.muted } },
      }

      opts.sections.lualine_y = {
        { "branch", icon = "", color = { fg = colors.muted } },
        global_sep(),
        { "progress", color = { fg = colors.text } },
        { "location", color = { fg = colors.text } },
      }

      opts.sections.lualine_z = {
        global_sep(),
        { moon_spinner, color = { fg = colors.text2, gui = "bold" }, padding = { left = 1, right = 1 } },
      }

      -- Global structural canvas clearing
      opts.options.theme = {
        normal = {
          a = { bg = colors.void },
          b = { bg = colors.void },
          c = { bg = colors.void },
          x = { bg = colors.void },
          y = { bg = colors.void },
          z = { bg = colors.void },
        },
        insert = {
          a = { bg = colors.void },
          b = { bg = colors.void },
          c = { bg = colors.void },
          x = { bg = colors.void },
          y = { bg = colors.void },
          z = { bg = colors.void },
        },
        visual = {
          a = { bg = colors.void },
          b = { bg = colors.void },
          c = { bg = colors.void },
          x = { bg = colors.void },
          y = { bg = colors.void },
          z = { bg = colors.void },
        },
        command = {
          a = { bg = colors.void },
          b = { bg = colors.void },
          c = { bg = colors.void },
          x = { bg = colors.void },
          y = { bg = colors.void },
          z = { bg = colors.void },
        },
        inactive = {
          a = { bg = colors.void },
          b = { bg = colors.void },
          c = { bg = colors.void },
          x = { bg = colors.void },
          y = { bg = colors.void },
          z = { bg = colors.void },
        },
      }
    end,
  },
}
