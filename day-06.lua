---@type string[]
local testInput = {
    "123 328  51 64 ",
    " 45 64  387 23 ",
    "  6 98  215 314",
    "*   +   *   +  ",
}

---@param input string[]
local function parseInput(input)
    ---@type {sign: string, start: number, end: number, total: number[]}[]
    local columns = {}
    for i = #input, 1, -1 do
        local row = input[i]

        if i == #input then
            for j = 1, #row do
                local char = row:sub(j, j)
                if (char == " ") then
                    columns[#columns][3] = columns[#columns][3] + 1
                else
                    table.insert(columns, { char, j, j, {} })
                end
            end
        else
            for icol, col in ipairs(columns) do
                local sub = row:sub(col[2], col[3])
                local num = math.tointeger(sub)
                -- local sign = col[1]
                -- print("col " .. icol .. "  ")
                --

                table.insert(col[4], num)

                -- print("row " .. i .. ", col " .. icol .. " <- " .. num)

                -- if icol == 1 then
                --     columns[icol][4] = num
                -- elseif sign == "+" then
                --     columns[icol][4] = columns[icol - 1][4] + num
                -- elseif sign == "*" then
                --     columns[icol][4] = columns[icol - 1][4] * num
                -- end
                -- print(num .. " -> " .. icol .. " = " .. columns[icol][4])
            end
        end


        -- print("columns", #columns)

        -- for j = 1, #row do
        --     local char = row:sub(j, j)

        --     if i == #input then
        --         if (char == " ") then
        --             columns[#columns][2] = columns[#columns][2] + 1
        --         else
        --             if columns[#columns] then
        --                 columns[#columns][2] = columns[#columns][2] - 1
        --             end
        --             table.insert(columns, { char, 1 })
        --         end
        --     end
        --
        -- print(columns[i][1], columns[i][2], columns[i][3])
    end

    local total = 0
    for _, col in ipairs(columns) do
        local sign = col[1]
        local colTotal = 0
        for i, num in ipairs(col[4]) do
            if i == 1 then
                colTotal = num
            else
                if sign == "*" then
                    colTotal = colTotal * num
                elseif sign == "+" then
                    colTotal = colTotal + num
                end
            end
        end
        total = total + colTotal
    end
    return total
end

print(parseInput(testInput))
