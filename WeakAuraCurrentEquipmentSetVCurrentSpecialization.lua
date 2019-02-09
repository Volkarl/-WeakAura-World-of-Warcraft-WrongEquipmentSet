

function()
    local numSets = C_EquipmentSet.GetNumEquipmentSets()

    if numSets < 1 then
        return ""
    end

    local equippedSet = {}
    local eqSetCount = 0
    for i = 0, numSets - 1 do
        -- Check all equipment sets and figure out which ones are equipped (there can be multiple equipped at once)
        local setName, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(i)
        if isEquipped then
            eqSetCount = eqSetCount + 1
            equippedSet[eqSetCount] = setName -- Arrays start at one
        end
    end
    
    if eqSetCount == 0 then -- Arrays start at one in LUA
        return "Currently no set equipped"
    end
    
    local currentSpecID = GetSpecializationInfo(GetSpecialization())
    local currentSpecName = GetSpecializationNameForSpecID(currentSpecID)
    -- If one of the equipped sets contains the spec name, then we're good
    for i = 1, eqSetCount do
        if string.find(equippedSet[i], currentSpecName) then 
            return "" 
        end
    end

    -- If neither of our equipped set contains the spec name, then we have the wrong set equipped
    if eqSetCount == 1 then
        return "Wrong equipment set: " .. equippedSet[1] .. "\nFor spec: " .. currentSpecName
    end

    local wrongSets =  equippedSet[1]
    for i = 2, eqSetCount do
        wrongSets = wrongSets .. ", " .. equippedSet[i]
    end
    return "Wrong equipment sets: " .. wrongSets .. "\nFor spec: " .. currentSpecName
end

-- To dump all equipment set info to chat for debugging purposes, do this:
-- /run for i=0,C_EquipmentSet.GetNumEquipmentSets() do print( C_EquipmentSet.GetEquipmentSetInfo(i) ) end