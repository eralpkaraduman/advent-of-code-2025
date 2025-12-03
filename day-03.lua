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
    local b = #bank
    local v = #bank
    for u = 1, #bank do
        v = #bank - u + 1
        if u < b then
            local numU = math.tointeger(bank:sub(u, u))
            local numA = math.tointeger(bank:sub(a, a))
            if numU > numA then
                a = u
            end
        end
        if v > a then
            local numV = math.tointeger(bank:sub(v, v))
            local numB = math.tointeger(bank:sub(b, b))
            if numV > numB then
                b = v
            end
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
