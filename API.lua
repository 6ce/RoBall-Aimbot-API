--[[

Usage:



]]

local AimbotAPI = {}
local Metatable = {}

Metatable.__newindex = function(Self, Index, Value)
    return rawset(Self, Index, Value)
end

Metatable.__index = function(Self, Index)
    if rawget(Self, Index) ~= nil then
        return rawget(Self, Index)
    else
        return "None"
    end
end

setmetatable(AimbotAPI, Metatable)

local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local NilFunction = function() return end

------------------------------------------------------------------------------------------------------
-------------------------------------------- // PHENOM \\ --------------------------------------------
------------------------------------------------------------------------------------------------------

AimbotAPI.Phenom = {}
local Phenom = AimbotAPI.Phenom

function Phenom:IsPlayground()
    return (game.PlaceId == 4923146720)
end

Phenom.FootingData = {
    [75] = {MinDistance = 57, MaxDistance = 61},
    [80] = {MinDistance = 57, MaxDistance = 64},
    [85] = {MinDistance = 57, MaxDistance = 70},
    [90] = {MinDistance = 57, MaxDistance = 74},
    [95] = {MinDistance = 57, MaxDistance = 82},
    [100] = {MinDistance = 57, MaxDistance = 87}
}

Phenom.PowerData = {
    [75] = {
        {MinDistance = 57, MaxDistance = 59, Arc = 55},
        {MinDistance = 59, MaxDistance = 60, Arc = 50},
        {MinDistance = 60, MaxDistance = 61, Arc = 45},
        {MinDistance = 61, MaxDistance = 62, Arc = 40}
    },
    [80] = {
        {MinDistance = 57, MaxDistance = 59, Arc = 75},
        {MinDistance = 59, MaxDistance = 63, Arc = 70},
        {MinDistance = 63, MaxDistance = 65, Arc = 60},
        {MinDistance = 65, MaxDistance = 69, Arc = 50}
    },
    [85] = {
        {MinDistance = 57, MaxDistance = 63, Arc = 85},
        {MinDistance = 63, MaxDistance = 67, Arc = 80},
        {MinDistance = 67, MaxDistance = 70, Arc = 75},
        {MinDistance = 70, MaxDistance = 74, Arc = 60}
    },
    [90] = {
        {MinDistance = 57, MaxDistance = 63, Arc = 100},
        {MinDistance = 63, MaxDistance = 67, Arc = 95},
        {MinDistance = 67, MaxDistance = 69, Arc = 90},
        {MinDistance = 69, MaxDistance = 74, Arc = 85},
        {MinDistance = 74, MaxDistance = 77, Arc = 75},
        {MinDistance = 77, MaxDistance = 79, Arc = 65}
    },
    [95] = {
        {MinDistance = 57, MaxDistance = 58, Arc = 120},
        {MinDistance = 59, MaxDistance = 63, Arc = 115},
        {MinDistance = 63, MaxDistance = 68, Arc = 110},
        {MinDistance = 68, MaxDistance = 71, Arc = 105},
        {MinDistance = 71, MaxDistance = 74, Arc = 100},
        {MinDistance = 74, MaxDistance = 79, Arc = 95},
        {MinDistance = 79, MaxDistance = 81, Arc = 90},
        {MinDistance = 81, MaxDistance = 82, Arc = 65},
        {MinDistance = 82, MaxDistance = 86, Arc = 60}
    },
    [100] = {
        {MinDistance = 57, MaxDistance = 66, Arc = 130},
        {MinDistance = 66, MaxDistance = 69, Arc = 125},
        {MinDistance = 69, MaxDistance = 74, Arc = 120},
        {MinDistance = 74, MaxDistance = 79, Arc = 115},
        {MinDistance = 79, MaxDistance = 82, Arc = 110},
        {MinDistance = 82, MaxDistance = 84, Arc = 105},
        {MinDistance = 84, MaxDistance = 88, Arc = 100},
        {MinDistance = 88, MaxDistance = 90, Arc = 85},
        {MinDistance = 90, MaxDistance = 93, Arc = 65}
    }
}

Phenom.Goals = {} do
    for _, Obj in next, game:GetDescendants() do
        if Obj.Name == "Goal" and Obj:IsA("BasePart") then
            table.insert(Phenom.Goals, Obj)
        elseif Obj.Name == "Part" and Obj:IsA("BasePart") and Obj.Size == Vector3.new(5, 1, 5) then
            table.insert(Phenom.Goals, Obj)
        end
    end
end

Phenom.Shuffled, Phenom.Selected = {}, NilFunction do
    for _, Garbage in next, getgc(true) do
        if type(Garbage) == "function" and getinfo(Garbage)["name"] == "selected1" then
            Phenom.Selected = Garbage
        elseif type(Garbage) == "table" and rawget(Garbage, "1") and rawget(Garbage, "1") ~= true then
            Phenom.Shuffled = Garbage
        end
    end
end

Phenom.Clicker do
    if Phenom:IsPlayground() == false then
        Phenom.Clicker = getupvalue(Selected, 3)
    else
        Phenom.Clicker = getupvalue(Selected, 5)
    end
end

function Phenom:GetClock()
    local OldClock = getupvalue(Phenom.Selected, 3)
    local NewClock = OldClock + 1
    
    setupvalue(Phenom.Selected, 3, NewClock)
    
    return NewClock
end

function Phenom:GetKeys()
    return getupvalue(Phenom.Selected, 4)
end

function Phenom:GetKeyFromKeyTable()
    local Keys = Phenom:GetKeys()
    
    if Phenom:IsPlayground() == true then
        return "Shotta_"
    elseif type(Keys[1]) == "string" then
        return Keys[1]
    end
    
    return "Shotta"
end

function Phenom:RemoveKeyFromKeyTable()
    local StartTime = tick()
    
    repeat task.wait() until Player.Character == nil or Player.Character:FindFirstChild("Basketball") == nil or StartTime - tick() > 1.5
    
    if Player.Character == nil or StartTime - tick() > 1.5 then
        return print("Didnt remove key")
    end
    
    local Keys = Phenom:GetKeys()
    
    if type(Keys) == "table" then
        print("Removed key")
        table.remove(Keys, 1)
        setupvalue(Phenom.Selected, 4, Keys)
    end
end

function Phenom:GetRandomizedTable(TorsoPosition, ShootPosition)
    local UnrandomizedArgs = {
        X1 = TorsoPosition.X,
        Y1 = TorsoPosition.Y,
        Z1 = TorsoPosition.Z,
        X2 = ShootPosition.X,
        Y2 = ShootPosition.Y,
        Z2 = ShootPosition.Z
    }
    
    return {
        UnrandomizedArgs[Phenom.Shuffled["1"]],
        UnrandomizedArgs[Phenom.Shuffled["2"]],
        UnrandomizedArgs[Phenom.Shuffled["3"]],
        UnrandomizedArgs[Phenom.Shuffled["4"]],
        UnrandomizedArgs[Phenom.Shuffled["5"]],
        UnrandomizedArgs[Phenom.Shuffled["6"]],
    }
end

function Phenom:GetGoal()
    local Distance, Goal = 9e9
    
    for _, Obj in next, Phenom.Goals do
        local Magnitude = (Player.Character.Torso.Position - Obj.Position).Magnitude
        
        if Distance > Magnitude then
            Distance = Magnitude
            Goal = Obj
        end
    end
    
    return Goal
end

function Phenom:GetDistance()
    local Goal = Phenom:GetGoal()
    local TorsoPosition = Player.Character.Torso.Position
    
    return (TorsoPosition - Goal.Position).Magnitude
end

function Phenom:GetDirection(Position)
    return (Position - Player.Character.Torso.Position).Unit
end

function Phenom:GetBasketball()
    return Player.Character:FindFirstChildWhichIsA("Folder")
end

function Phenom:GetMoveDirection()
    local Direction = Player.Character.Humanoid.MoveDirection * 1.8
    
    if UIS:IsKeyDown(Enum.KeyCode.S) == true and UIS:IsKeyDown(Enum.KeyCode.W) == true then
        Direction = Player.Character.Humanoid.MoveDirection * 0.5
    elseif UIS:IsKeyDown(Enum.KeyCode.S) == true and UIS:IsKeyDown(Enum.KeyCode.W) == false then
        Direction = Player.Character.Humanoid.MoveDirection * 0.8
    elseif UIS:IsKeyDown(Enum.KeyCode.S) == false and UIS:IsKeyDown(Enum.KeyCode.W) == true then
        Direction = Player.Character.Humanoid.MoveDirection * 1.2
    end
        
    return Direction
end

function Phenom:GetArc()
    local Distance = Phenom:GetDistance()
    local Basketball = Phenom:GetBasketball()
    
    local Power = Basketball ~= nil and Basketball.PowerValue.Value
    
    if Power ~= nil and Phenom.PowerData[Power] ~= nil then
        local Distances = Phenom.PowerData[Power]
        
        for _, Data in ipairs(Distances) do
            if Distance > Data.MinDistance and Distance < Data.MaxDistance then
                local Arc = Data.Arc
                
                if Phenom:IsPlayground() == true and Arc ~= nil then
                    Arc = Arc - 5
                end
                
                return Arc
            end
        end
    end
end

function Phenom:DoFootingCheck()
    local Distance = Phenom:GetDistance()
    local Basketball = Phenom:GetBasketball()

    local Power = (Basketball ~= nil and Basketball.PowerValue.Value)
    
    if Power == nil then
        Phenom.IsInFooting = false

        return
    end
        
    if Power == 75 or Power == 100 then
        Distance = Distance - 1
    else
        Distance = Distance - 3
    end
    
    if Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
        if FootingDistances[Power] ~= nil and Distance > FootingDistances[Power].MinDistance and Distance < FootingDistances[Power].MaxDistance then
            Phenom.IsInFooting = true
        else
            Phenom.IsInFooting = false
        end
    else
        Phenom.IsInFooting = false
    end
end

function Phenom:Shoot()
    local Goal = Phenom:GetGoal()
    local Arc = Phenom:GetArc()
    local MoveDirection = Phenom:GetMoveDirection()
    local Hit = (Goal.Position + Vector3.new(0, Arc, 0) + MoveDirection)
    local Direction = Phenom:GetDirection(Hit)
    local RandomizedArgs = Phenom:GetRandomizedTable(Player.Character.Torso.Position, Direction)
    local Basketball = Phenom:GetBasketball()
    local Key = Phenom:GetKeyFromKeyTable()
    
    if Playground == true then
        local Clock = Phenom:GetClock()
        
        Key = Key .. Clock
    end
    
    Phenom.Clicker:FireServer(Basketball, Basketball.PowerValue.Value, RandomizedArgs, Key)
    
    if GetBasketball() ~= nil then
        RemoveKeyFromKeyTable()
    end
end

Phenom.Connections = {
    Stepped = RS.Stepped:Connect(function()
        Phenom:DoFootingCheck()
        
        if Phenom.IsInFooting then
            Phenom.Indicator.Enabled = true
        else
            Phenom.Indicator.Enabled = false
        end
        
        if Phenom.Indicator.Adornee.Parent == nil and Player.Character then
            Phenom.Indicator.Adornee = Player.Character
        end
    end),

    InputBegan = UIS.InputBegan:Connect(function(Key, GPE)
        if not GPE and Key.KeyCode == Enum.KeyCode.X and Player.Character and Phenom:GetBasketball() ~= nil and Phenom.IsInFooting == true then
            if Player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.25)
            end
            
            if Phenom:GetBasketball() ~= nil and Phenom.IsInFooting == true then
                Phenom:Shoot()
            end
        end
    end)
}

------------------------------------------------------------------------------------------------------
-------------------------------------------- // HOOPZ \\ --------------------------------------------
------------------------------------------------------------------------------------------------------
