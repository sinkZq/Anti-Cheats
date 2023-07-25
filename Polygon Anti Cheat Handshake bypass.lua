local HashFunction = nil
local RemoteFunction = nil
local ReHashedString = ""
local ReplacedPcallArgument1 = {["script"] = "Client"}
local ReplacedPcallArgument2 = "invalid argument #1 to 'getfenv' (invalid level)"
local CurrentNumbers = {}

do
	for i,v in getgc(false) do
		if type(v) == "function" and islclosure(v) and tostring(getfenv(v).script) == "Client" then
			for i2,v2 in getconstants(v) do
				if v2 == 801385690 then
					for i3,v3 in getupvalues(v) do
						if type(v3) == "number" then
							table.insert(CurrentNumbers, v3)
						elseif type(v3) == "function" then
							HashFunction = v3
						end
					end
				end
			end
		end
	end
end

do
	for i,v in getgc(false) do
		if type(v) == "function" and islclosure(v) and getinfo(v).currentline == 14 then
			hookfunction(v, function(...)
				return true
			end)
		end
	end
end

do 
	for i,v in getnilinstances() do
		if tostring(v) == "Handshake" then
			RemoteFunction = v
			break
		end
	end
end

local OldHashFunction do
	OldHashFunction = hookfunction(HashFunction, function(String)
		ReHashedString = OldHashFunction(String)
		return OldHashFunction(String)
	end)
end



local OldNewIndex do
	OldNewIndex = hookmetamethod(game, "__newindex", function(self, Index, Value)
	    if Index == "OnClientInvoke\0" and type(Value) == "table" then
	        local CallbackFunction = getrawmetatable(Value).__call
	        
			local Argument1 = CurrentNumbers[1]
			local Argument2 = CurrentNumbers[2]
			local Argument3 = CurrentNumbers[3]
			local Argument4 = CurrentNumbers[4]
			local Argument5 = CurrentNumbers[5]
			local Argument6 = ReHashedString
			local Argument7 = ReplacedPcallArgument1
			local Argument8 = ReplacedPcallArgument2
	        
	 	 	return OldNewIndex(self, Index, function()
			    return {Argument1, Argument2, Argument3, Argument4, Argument5, Argument6, Argument7, Argument8}
			end)
	    end
	    return OldNewIndex(self, Index, Value)
	end)
end
