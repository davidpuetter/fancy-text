local TweenService = game:GetService("TweenService")

local DEFAULT_TYPEWRITE_SPEED = 0.02 -- Multiplier (0 - 1]

return {
	Init = function(char_inst: ImageLabel | TextLabel, index, trove, params)
		local typewrite_speed = DEFAULT_TYPEWRITE_SPEED
		if params and params[1] then
			typewrite_speed = tonumber(params[1]) or DEFAULT_TYPEWRITE_SPEED
		end

		trove:Add(task.delay(index * typewrite_speed, function()
			if char_inst:IsA("TextLabel") then
				TweenService:Create(char_inst, TweenInfo.new(0.5), {
					TextSize = 0,
					TextTransparency = 1,
				}):Play()
				
				local uishadow = char_inst:FindFirstChildOfClass("UIShadow")
				if uishadow then
					TweenService:Create(uishadow, TweenInfo.new(0.5), {
						Transparency = 1,
					}):Play()
				end
			elseif char_inst:IsA("ImageLabel") then
				TweenService:Create(char_inst, TweenInfo.new(0.5), {
					ImageTransparency = 1,
				}):Play()
			end
		end))
	end,
}
