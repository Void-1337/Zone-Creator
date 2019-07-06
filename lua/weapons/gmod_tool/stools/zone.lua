TOOL.Category = "Zone Creator"
TOOL.Name = "Zone Creator"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 
 
TOOL.ClientConVar[ "myparameter" ] = "fubar"
 
function TOOL:LeftClick( trace )
end
 
function TOOL:RightClick( trace )
end
 
function TOOL.BuildCPanel( panel )
	panel:AddControl("Header", { Text = "Waw", Description = "A simple and easy tool to create custom zone" })
	
	if(LocalPlayer():IsAdmin()) then
		panel:AddControl("button", {
			Label = "Open zone creator menu",
			Command = "zone_open"
		})
	else
		panel:AddControl("label", {
			Text = "You don't have permission to use this tool"
		})
	end
end

if SERVER then return end