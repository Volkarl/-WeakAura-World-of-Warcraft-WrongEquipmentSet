

function()
    local equipedSet = nil
    for i = 1, C_EquipmentSet.GetNumEquipmentSets() do
        -- Check all equipment sets and figure out which one is equipped
        local currentEquipmentSet, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(i)
        if isEquipped and currentEquipmentSet ~= nil then
            equipedSet = currentEquipmentSet
            break
        end
    end
    
    if equipedSet == nil then
        return "Currently no set equipped"
        
    else
        local currentSpecID = GetSpecializationInfo(GetSpecialization())
        local currentSpecName = GetSpecializationNameForSpecID(currentSpecID)
        if not string.find(equipedSet, currentSpecName) then 
            return "Wrong equipment set: " .. equipedSet .. "For spec: " .. currentSpecName
            -- Returns here if it cannot find the current spec name inside the equipmentSetName
        else 
            return "" 
        end 
    end
end

