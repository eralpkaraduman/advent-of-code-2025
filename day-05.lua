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
    ---@type integer[]
    local ingredients = {}

    ---@type boolean
    local ingredientsComplete = false

    ---@type integer
    local freshIngredientCount = 0

    for i = #input, 1, -1 do
        local entry = input[i]
        if #entry == 0 then
            ingredientsComplete = true
            goto continue
        end
        if ingredientsComplete then
            local aStr, bStr = entry:match("(%d+)-(%d+)")
            local a = math.tointeger(aStr)
            local b = math.tointeger(bStr)
            if not a or not b then
                error("failed to parse range")
            end

            for j, ingredient in ipairs(ingredients) do
                if ingredient >= a and ingredient <= b then
                    table.remove(ingredients, j)
                    freshIngredientCount = freshIngredientCount + 1
                end
            end
        else
            local ingredientId = math.tointeger(entry)
            if not ingredientId then
                error("failed to parse int")
            end
            table.insert(ingredients, ingredientId)
        end
        ::continue::
    end
    return freshIngredientCount
end

assert(processInput(testInput) == 3)
-- print(processInput(ParseLinesIntoTable("day-05-input.txt")))
