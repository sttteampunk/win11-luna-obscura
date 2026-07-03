-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.g.neovide then
  vim.o.cmdheight = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_floating_corner_radius = 0.3
  vim.g.neovide_floating_blur_amount_x = 1.0
  vim.g.neovide_floating_blur_amount_y = 1.0
  vim.o.winblend = 20
  vim.o.pumblend = 20
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_corner_preference = "round"
  vim.o.guifont = "JetBrainsMono_NFP:h11"
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_window_blurred = true
end
-- Dynamically toggles the statusline row out of existence to allow edge-to-edge screens
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "FileType" }, {
  pattern = "*",
  callback = function()
    if
      vim.bo.filetype == "neo-tree"
      or vim.bo.filetype == "snacks_picker_input"
      or vim.bo.filetype == "snacks_picker_list"
      or vim.bo.filetype == "snacks_dashboard"
    then
      vim.o.laststatus = 0 -- Destroys the row; windows expand down to fill it
    else
      vim.o.laststatus = 3 -- Restores your global statusline for code files
    end
  end,
})
