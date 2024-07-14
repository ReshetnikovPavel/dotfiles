local function separate()
	return "        "
end


local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format("%%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function git()
	vim.cmd("!git rev-parse --is-inside-work-tree")
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError#E " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning#W " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint#H " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation#I " .. count["info"]
  end

  return errors .. warnings .. hints .. info
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return "%l,%c" .. separate() .. "%P"
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    filepath(),
	filename(),
    "%=%#StatusLineExtra#",
    lsp(),
	separate(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return "%F"
end

vim.cmd([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
