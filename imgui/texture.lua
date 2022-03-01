--[[ 贴图类，统一处理贴图的一些操作 ]]
local texture = lua_class("texture")

function texture:ctor(path, flags, getSize)
    self.path = path
	
	if flags == nil then
		flags = 6161
	end

	self.id = render.GL_LoadTexture(path, nil, 0, flags)

	if self.id == 0 then
		print("GL_LoadTexture Error(%s)", self.path)
		return
	end

	if getSize then
		self.width = render.RenderGetParm(1, self.id)
		self.height = render.RenderGetParm(2, self.id)
	end
end

return texture