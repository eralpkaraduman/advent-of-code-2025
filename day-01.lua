require "utils"

local testInput = {
    "L68",
    "L30",
    "R48",
    "L5",
    "R60",
    "L55",
    "L1",
    "L99",
    "R14",
    "L82",
}

---@param rotationString string
---@return number
local function parseRotation(rotationString)
    local direction = rotationString:sub(1, 1)
    local distance = tonumber(rotationString:sub(2))
    assert(distance, "Invalid distance: %s", rotationString)
    if direction == "L" then
        return -distance
    end
    return distance
end
assert(parseRotation('L100') == -100)
assert(parseRotation('R100') == 100)

local function _applyRotation(input, rotationString)
    local rotation = parseRotation(rotationString)
    local numPass0 = 0
    input = input + rotation
    while input < 0 do
        input = input + 100
        numPass0 = numPass0 + 1
    end
    while input > 99 do
        input = input - 100
        numPass0 = numPass0 + 1
    end
    return input, numPass0
end

---@param input number
---@param rotationString string
---@return number, number
local function applyRotation(input, rotationString)
    local rotation = parseRotation(rotationString)
    local distance = math.abs(rotation)
    local numPass0 = 0

    if rotation > 0 then
        -- Going right: count 0 crossings
        numPass0 = math.floor((input + distance) / 100) - math.floor(input / 100)
    elseif rotation < 0 then
        -- Going left: distance to reach 0, then count subsequent crossings
        local distance_to_zero = input > 0 and input or 100
        if distance >= distance_to_zero then
            numPass0 = 1 + math.floor((distance - distance_to_zero) / 100)
        end
    end

    -- Calculate final position
    local final = (input + rotation) % 100
    if final < 0 then final = final + 100 end

    return final, numPass0
end

assert(applyRotation(50, 'R5') == 55)
assert(select(2, applyRotation(50, 'R5')) == 0)
assert(applyRotation(50, 'L5') == 45)
assert(select(2, applyRotation(50, 'L5')) == 0)
assert(applyRotation(50, 'L55') == 95)
assert(select(2, applyRotation(50, 'L55')) == 1)
assert(applyRotation(50, 'R55') == 5)
assert(select(2, applyRotation(50, 'R55')) == 1)
assert(applyRotation(50, 'L155') == 95)
assert(select(2, applyRotation(50, 'L155')) == 2)
assert(applyRotation(50, 'R155') == 5)
assert(select(2, applyRotation(50, 'R155')) == 2)
assert(applyRotation(50, 'L355') == 95)
assert(select(2, applyRotation(50, 'L355')) == 4)
assert(applyRotation(50, 'R355') == 5)
assert(select(2, applyRotation(50, 'R355')) == 4)
assert(select(2, applyRotation(50, 'R1000')) == 10)
assert(select(2, applyRotation(50, 'L1000')) == 10)
assert(select(2, applyRotation(0, 'R50')) == 0)
assert(select(2, applyRotation(0, 'R150')) == 1)
assert(select(2, applyRotation(0, 'L50')) == 0)
assert(select(2, applyRotation(0, 'L150')) == 1)

---@param rotations table
---@return number, number
local function applyRotations(rotations)
    local numFinalHit0 = 0
    local totalNumPass0 = 0
    local current = 50
    for index, value in ipairs(rotations) do
        local newCurrent, numPass0 = applyRotation(current, value)

        current = newCurrent
        if current == 0 then
            numFinalHit0 = numFinalHit0 + 1
        end

        totalNumPass0 = totalNumPass0 + numPass0
    end
    return numFinalHit0, totalNumPass0
end
assert(applyRotations(testInput) == 3)
assert(select(2, applyRotations(testInput)) == 6)

local realInput = ParseTextInput("day-01-input.txt")
local phase1, phase2 = applyRotations(realInput)
print(phase1, phase2)
assert(phase1 == 1180)
assert(phase2 == 6892)
