require "utils"

---@type string[]
local testInput = {
    "3-5",
    "10-14",
    "16-20",
    "12-18",
    "",
    "1",
    "5",
    "8",
    "11",
    "17",
    "32 ",
}


---@param input string[]
local function processInput(input)
    ---@type boolean[]
    local ingredientStatus = {}

    ---@type boolean
    local statusIndexComplete = false

    ---@type integer
    local freshIngredientCount = 1

    for _, entry in ipairs(input) do
        if #entry == 0 then
            statusIndexComplete = true
            goto continue
        end
        if not statusIndexComplete then
            local aStr, bStr = entry:match("(%d+)-(%d+)")
            local a = math.tointeger(aStr)
            local b = math.tointeger(bStr)
            if not a or not b then
                error("failed to parse range")
            end

            for i = #ingredientStatus + 1, b do
                ingredientStatus[i] = i < a
            end
        else
            local ingredientId = math.tointeger(entry)
            if not ingredientId then
                error("failed to parse int")
            end
            if ingredientStatus[ingredientId] then
                freshIngredientCount = freshIngredientCount + 1
            end
        end
        ::continue::
    end
    return freshIngredientCount
end

assert(processInput(testInput) == 3)
-- print(processInput(ParseLinesIntoTable("day-05-input.txt")))
