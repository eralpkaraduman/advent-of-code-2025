require "utils"

---@type table<string>
local testInput = {
    "987654321111111",
    "811111111111119",
    "234234234234278",
    "818181911112111",
}

---@param bank string
---@return string
local function largestNumbersInBank(bank)
    local a = 1
    local aNum = math.tointeger(bank:sub(a, a))
    for i = 2, #bank - 1 do
        local iNum = math.tointeger(bank:sub(i, i))
        if iNum > aNum then
            a = i
            aNum = iNum
        end
    end

    local b = #bank
    local bNum = math.tointeger(bank:sub(b, b))
    for i = #bank - 1, a + 1, -1 do
        local iNum = math.tointeger(bank:sub(i, i))
        if iNum > bNum then
            b = i
            bNum = iNum
        end
    end
    return bank:sub(a, a) .. bank:sub(b, b)
end
assert(largestNumbersInBank("123") == "23")
assert(largestNumbersInBank("321") == "32")
assert(largestNumbersInBank("312") == "32")
assert(largestNumbersInBank("987654321111111") == "98")
assert(largestNumbersInBank("811111111111119") == "89")
assert(largestNumbersInBank("234234234234278") == "78")
assert(largestNumbersInBank("818181911112111") == "92")

---@param input table<string>
---@return number
local function processInput(input)
    local sum = 0
    for _, bank in ipairs(input) do
        local num = math.tointeger(largestNumbersInBank(bank))
        sum = sum + num
    end
    return sum
end
assert(processInput(testInput) == 357)

print(processInput(ParseLinesIntoTable("day-03-input.txt")))
