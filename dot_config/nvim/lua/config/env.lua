local M = {}

M.is_wezterm = os.getenv("WEZTERM_EXECUTABLE") ~= nil
M.is_tmux = os.getenv("TMUX") ~= nil

return M
