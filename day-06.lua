---@type string[]
local testInput = {
    "123 328  51 64 ",
    " 45 64  387 23 ",
    "  6 98  215 314",
    "*   +   *   +  ",
}

---@param input string[]
local function parseInput(input)
    ---@type {sign: string, start: number, end: number, total: number}[]
    local columns = {}
    for i = #input, 1, -1 do
        local row = input[i]

        if i == #input then
            for j = 1, #row do
                local char = row:sub(j, j)
                if (char == " ") then
                    columns[#columns][3] = columns[#columns][3] + 1
                else
                    table.insert(columns, { char, j, j, 0 })
                end
            end
        else
            for _, col in ipairs(columns) do
                local sub = row:sub(col[2], col[3])
                local num = math.tointeger(sub)
                print(num)
            end
        end



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
end

print(parseInput(testInput))
