local HintDirection = { BEFORE_CURSOR = 1, AFTER_CURSOR = 2 }

local function get_line_starts(winid, direction)
    local wininfo = vim.fn.getwininfo(winid)[1]
    local cur_line = vim.fn.line(".")

    -- Get targets.
    local targets = {}
    local from_line, to_line
    if direction == HintDirection.BEFORE_CURSOR then
        from_line = wininfo.topline
        to_line = cur_line
    elseif direction == HintDirection.AFTER_CURSOR then
        from_line = cur_line
        to_line = wininfo.botline
    else
        from_line = wininfo.topline
        to_line = wininfo.botline
    end
    local lnum = from_line
    while lnum <= to_line do
        local fold_end = vim.fn.foldclosedend(lnum)
        -- Skip folded ranges.
        if fold_end ~= -1 then
            lnum = fold_end + 1
        else
            if lnum ~= cur_line then
                table.insert(targets, { pos = { lnum, 1 } })
            end
            lnum = lnum + 1
        end
    end
    -- Sort them by vertical screen distance from cursor.
    local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
    local function screen_rows_from_cur(t)
        local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
        return math.abs(cur_screen_row - t_screen_row)
    end
    table.sort(targets, function(t1, t2)
        return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
    end)

    if #targets >= 1 then
        return targets
    end
end

-- Usage:
local function leap_to_line(direction)
    local winid = vim.api.nvim_get_current_win()
    require("leap").leap({
        target_windows = { winid },
        targets = get_line_starts(winid, direction),
    })
end

return {
    leap_to_line = leap_to_line,
    HintDirection = HintDirection,
}
