local MovingPlatform = {}

local part = nil

local maxPosition = Vector3.new(0,12,0)
local minPosition = Vector3.new(0,2,0)
local initPosition = Vector3.new(0,5,0)

local speed = 0.05

local nextPosition = nil
local intervalVector = nil
local timer = nil

local function Move()
  local distance = Vector3.Distance(part.WorldPosition, nextPosition)
  
  if distance < 0.5 then
    local isMinPosition = nextPosition == minPosition
    nextPosition = isMinPosition and maxPosition or minPosition
    local direction = nextPosition - part.WorldPosition
    intervalVector = direction.Normalized * speed
  else
    part.WorldPosition = part.WorldPosition - initPosition
end

function MovingPlatform:Start(map)
  part = map.Root:FindFirstChild("MovingPlatform", true)
  part.WorldPosition = initPosition
  
  nextPosition = minPosition
  local direction = nextPosition - part.WorldPosition
  intervalVector = direction.Normalized * speed
  
  timer = Timer.new(1, Move)
  timer.loop = true
  timer:Start()
    
end

return MovingPlatform