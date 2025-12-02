require "utils"

local testInput = {
    "11-22",                 --- has two invalid IDs, 11 and 22.
    "95-115",                --- has one invalid ID, 99.
    "998-1012",              --- has one invalid ID, 1010.
    "1188511880-1188511890", --- has one invalid ID, 1188511885.
    "222220-222224",         --- has one invalid ID, 222222.
    "1698522-1698528",       --- contains no invalid IDs.
    "446443-446449",         --- has one invalid ID, 446446.
    "38593856-38593862",     --- has one invalid ID, 38593859.
}

---@param rangeString string
---@return table<string>
local function getIdsInRange(rangeString)
    local startString, stopString = rangeString:match("(%d+)-(%d+)")
    local ids = {}
    for i = tonumber(startString), tonumber(stopString) do
        table.insert(ids, tostring(i))
    end
    return ids
end
assert(getIdsInRange("1-5")[1] == "1")
assert(getIdsInRange("1-5")[2] == "2")
assert(getIdsInRange("1-5")[4] == "4")
assert(getIdsInRange("99-101")[2] == "100")

---@param id string
---@return boolean
local function isIdInvalid(id)
    local frontSize = math.floor(#id / 2)
    local front = id:sub(1, frontSize)
    local back = id:sub(frontSize + 1)
    return front == back
end
assert(isIdInvalid("111111"))
assert(not isIdInvalid("111112"))
assert(not isIdInvalid("111"))
assert(isIdInvalid("5959"))

---@param ids table<string>
---@return table<string>
local function filterValidIds(ids)
    local validIds = {}
    for _, id in ipairs(ids) do
        if isIdInvalid(id) then
            table.insert(validIds, id)
        end
    end
    return validIds
end
assert(filterValidIds({ "22", "111", "1111" })[2] == "1111")

---@param ids table<string>
---@return number
local function sumInvalidIdValues(ids)
    local sum = 0
    for _, id in ipairs(filterValidIds(ids)) do
        sum = sum + tonumber(id)
    end
    return sum
end
assert(sumInvalidIdValues({ "22", "1111", "111" }) == 1133)

---@param input table<string>
---@return number
local function processInput(input)
    local sum = 0
    for _, idRangeString in ipairs(input) do
        local ids = getIdsInRange(idRangeString)
        local validIds = filterValidIds(ids)
        sum = sum + sumInvalidIdValues(validIds)
    end
    return sum
end
assert(processInput({ "10-12", "22-44" }) == (11 + 22 + 33 + 44))
assert(processInput(testInput) == 1227775554)

local result = processInput(ParseSeparatedByComma("day-02-input.txt"))
print(result)
