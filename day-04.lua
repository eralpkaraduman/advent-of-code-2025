local testInput = {
    "..@@.@@@@.",
    "@@@.@.@.@@",
    "@@@@@.@.@@",
    "@.@@@@..@.",
    "@@.@@@@.@@",
    ".@@@@@@@.@",
    ".@.@.@.@@@",
    "@.@@@.@@@@",
    ".@@@@@@@@.",
    "@.@.@@@.@.",
}

---@type table<{x: integer, y: integer}>
local adjacentLocationOffsets = {
    { -1, -1 }, { 0, -1 }, { 1, -1 },
    { -1, 0 }, { 1, 0 },
    { -1, 1 }, { 0, 1 }, { 1, 1 },
}

---@param x integer
---@param y integer
---@param input table<string>
---@return string
local function getAdjacentPositions(x, y, input)
    ---@type string
    local positions = ""
    local maxY = #input
    for _, offset in ipairs(adjacentLocationOffsets) do
        local newx = x + offset[1]
        local newy = y + offset[2]
        if newx >= 1 and newy >= 1 then
            ---@type string
            local row = input[newy]
            local maxX = #row
            if newx <= maxX and newy <= maxY then
                positions = positions .. row:sub(newx, newx)
            end
        end
    end
    return positions
end
print(getAdjacentPositions(1, 1, testInput))
print(getAdjacentPositions(10, 10, testInput))
