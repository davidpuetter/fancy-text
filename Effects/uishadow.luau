-- <shadow offset_x offset_y r g b>
-- offset_x offset_y: optional shadow offset in pixels (default 2, 2)
-- r g b: optional shadow color (default black)

local DEFAULT_OFFSET_X = 2
local DEFAULT_OFFSET_Y = 2
local DEFAULT_COLOR = Color3.fromRGB(0, 0, 0)

return {
	Init = function(char_inst: ImageLabel | TextLabel, index, trove, params)
		local offset_x = DEFAULT_OFFSET_X
		local offset_y = DEFAULT_OFFSET_Y
		local shadow_color = DEFAULT_COLOR
		local blur_radius = 20
		if params then
			offset_x = tonumber(params[1]) or DEFAULT_OFFSET_X
			offset_y = tonumber(params[2]) or DEFAULT_OFFSET_Y

			if params[3] and params[4] and params[5] then
				local r = tonumber(params[3]) or 0
				local g = tonumber(params[4]) or 0
				local b = tonumber(params[5]) or 0
				shadow_color = Color3.fromRGB(r, g, b)
			end
			
			blur_radius = tonumber(params[6]) or 20
		end

		local shadow = trove:Add(Instance.new("UIShadow"))
		shadow.Name = char_inst.Name .. "_Shadow"
		shadow.Color = shadow_color
		shadow.Offset = UDim2.fromOffset(offset_x, offset_y)
		shadow.BlurRadius = UDim.new(0, blur_radius)

		trove:Add(task.defer(function()
			shadow.Parent = char_inst
		end))

		char_inst.ZIndex += 1
		
		return {
			shadow = shadow,
			offset_x = offset_x,
			offset_y = offset_y,
			shadow_color = shadow_color,
		}
	end,

	Update = function(char_inst, index, dt, trove, shadow_data)
		local shadow = shadow_data.shadow
		local offset_x = shadow_data.offset_x
		local offset_y = shadow_data.offset_y
		local shadow_color = shadow_data.shadow_color

		shadow.Enabled = char_inst.Visible
	end,
}
