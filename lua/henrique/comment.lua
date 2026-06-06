-- ── Helpers ────────────────────────────────────────────────────────────────

local function is_jsx_commented_line(line)
  -- Matches lines where the non-whitespace content is wrapped in {/* ... */}
  return line:match("^%s*{/%*.*%*/}%s*$") ~= nil
end

local function unwrap_jsx_comment(line)
  -- Remove {/* and */} from a line, preserving indent and inner content
  local indent, content = line:match("^(%s*){/%*%s?(.-)%s?%*/}%s*$")
  if indent ~= nil then
    return indent .. content
  end
  return line
end

local function strip_jsx_delimiters(text)
  -- Strip {/* prefix and */} suffix (with optional surrounding spaces)
  local inner = text:match("^{/%*%s?(.-)%s?%*/}$")
  return inner or text
end

-- ── Normal mode ────────────────────────────────────────────────────────────

local function jsx_comment_normal()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  if is_jsx_commented_line(line) then
    -- Toggle OFF: unwrap
    local new_line = unwrap_jsx_comment(line)
    vim.api.nvim_set_current_line(new_line)
    -- Land cursor at the start of the recovered content
    local indent = new_line:match("^(%s*)") or ""
    vim.api.nvim_win_set_cursor(0, { row, #indent })
  else
    -- Toggle ON: wrap
    local indent, content = line:match("^(%s*)(.*)")
    local new_line = indent .. "{/* " .. content .. " */}"
    vim.api.nvim_set_current_line(new_line)
    vim.api.nvim_win_set_cursor(0, { row, #indent + 4 })
  end
end

-- ── Visual mode ────────────────────────────────────────────────────────────

local function jsx_comment_visual()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)

  local start_pos = vim.fn.getpos("'<")
  local end_pos   = vim.fn.getpos("'>")
  local mode      = vim.fn.visualmode()

  local s_row = start_pos[2]
  local s_col = start_pos[3]
  local e_row = end_pos[2]
  local e_col = end_pos[3]

  local lines = vim.api.nvim_buf_get_lines(0, s_row - 1, e_row, false)

  if mode == "V" then
    -- ── Linewise ─────────────────────────────────────────────────────────

    -- Detect toggle state: all selected lines are jsx-commented
    local all_commented = true
    for _, l in ipairs(lines) do
      if not is_jsx_commented_line(l) then
        all_commented = false
        break
      end
    end

    if all_commented then
      -- Toggle OFF: unwrap every line
      local unwrapped = {}
      for _, l in ipairs(lines) do
        table.insert(unwrapped, unwrap_jsx_comment(l))
      end
      vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, unwrapped)
      local indent = unwrapped[1]:match("^(%s*)") or ""
      vim.api.nvim_win_set_cursor(0, { s_row, #indent })
    else
      -- Toggle ON: add block delimiters above and below
      local indent = lines[1]:match("^(%s*)") or ""
      table.insert(lines, 1, indent .. "{/*")
      table.insert(lines, indent .. "*/}")
      vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, lines)
      vim.api.nvim_win_set_cursor(0, { s_row, #indent })
    end

  else
    -- ── Characterwise ────────────────────────────────────────────────────

    if s_row == e_row then
      -- Single line: check if selection is exactly {/* ... */}
      local line = lines[1] e_col = math.min(e_col, #line)
      local selected = line:sub(s_col, e_col)

      if selected:match("^{/%*%s?(.-)%s?%*/}$") then
        -- Toggle OFF: replace selection with inner content
        local inner = strip_jsx_delimiters(selected)
        local new_line = line:sub(1, s_col - 1) .. inner .. line:sub(e_col + 1)
        vim.api.nvim_buf_set_lines(0, s_row - 1, s_row, false, { new_line })
        vim.api.nvim_win_set_cursor(0, { s_row, s_col - 1 })
      else
        -- Toggle ON: wrap selection
        local before   = line:sub(1, s_col - 1)
        local after    = line:sub(e_col + 1)
        local new_line = before .. "{/* " .. selected .. " */}" .. after
        vim.api.nvim_buf_set_lines(0, s_row - 1, s_row, false, { new_line })
        vim.api.nvim_win_set_cursor(0, { s_row, s_col - 1 + 4 })
      end

    else
      -- Multi-line characterwise: detect by checking first/last line delimiters
      local first = lines[1]
      local last  = lines[#lines]
      e_col = math.min(e_col, #last)

      local first_chunk = first:sub(s_col)
      local last_chunk  = last:sub(1, e_col)
      local is_commented = first_chunk:match("^{/%*%s?") ~= nil
                        and last_chunk:match("%s?%*/}$") ~= nil

      if is_commented then
        -- Toggle OFF: strip delimiters from first and last lines
        lines[1]      = first:sub(1, s_col - 1) .. first_chunk:gsub("^{/%*%s?", "", 1)
        lines[#lines] = last_chunk:gsub("%s?%*/}$", "", 1) .. last:sub(e_col + 1)
        vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, lines)
        vim.api.nvim_win_set_cursor(0, { s_row, s_col - 1 })
      else
        -- Toggle ON: inject delimiters into first and last lines
        lines[1]      = first:sub(1, s_col - 1) .. "{/* " .. first:sub(s_col)
        lines[#lines] = last:sub(1, e_col) .. " */}" .. last:sub(e_col + 1)
        vim.api.nvim_buf_set_lines(0, s_row - 1, e_row, false, lines)
        vim.api.nvim_win_set_cursor(0, { s_row, s_col - 1 + 4 })
      end
    end
  end
end

-- ── Keymaps ────────────────────────────────────────────────────────────────

-- Swap these for buffer-local (recommended, see below)
local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>/", jsx_comment_normal, vim.tbl_extend("force", opts, { desc = "JSX: toggle {/* */} (normal)" }))
map("v", "<leader>/", jsx_comment_visual, vim.tbl_extend("force", opts, { desc = "JSX: toggle {/* */} (visual)" }))
