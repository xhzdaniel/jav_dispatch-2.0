if(GetResourceState('qb-core') ~= 'started') then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

print('Resource started with ^2[QBCore]')

local function Player(panic)
    local PlayerData = QBCore.Functions.GetPlayerData()

    return {
        id = GetPlayerServerId(PlayerId()),
        playerName = PlayerData.charinfo.firstname.. " " ..PlayerData.charinfo.lastname,
        name = PlayerData.job.name,
        label = PlayerData.job.label,
        grade = PlayerData.job.grade.name,
        panic = panic,
        allowed = true
    }
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    dispatch.player = {}

    for k,v in pairs(Shared.Dispatch.Jobs) do
        if(job.name == k) then

            dispatch.player = Player(v.panic)

            GetAllChannels()
        end
    end

end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    dispatch.player = {}

    for k,v in pairs(Shared.Dispatch.Jobs) do
        if(JobInfo.name == k) then

            dispatch.player = Player(v.panic)

            GetAllChannels()
        end
    end


    if(dispatch.cursor) then
        EnableCursor()
    end

    if(dispatch.open) then
        ShowDispatch()
    end

end)
