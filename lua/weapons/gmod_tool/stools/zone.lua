TOOL.Category = "Zone Creator"
TOOL.Name = "Zone Creator"
TOOL.Command = nil
TOOL.ConfigName = "Zone Creator" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 


TOOL.Information = {

	{ name = "info", stage = 1 },
	{ name = "left" },
	{ name = "right" },
	{ name = "right_use", icon2 = "gui/e.png" },
	{ name = "reload" },
	{ name = "reload_use", icon2 = "gui/e.png" },

}

--language.Add( "tool.zone.name", "Zone Creator Tool" )
--language.Add( "tool.zone.left", "Select an object" )
--language.Add( "tool.zone.right", "" )
--language.Add( "tool.zone.reload", "Select yourself" )
--language.Add( "tool.zone.reload_use", "Hadoken !!!!" )
--language.Add( "tool.zone.desc", "A simple tool to create zone in the game garry's mod" )

 
function TOOL:LeftClick( trace )
	--if CLIENT then return end
	PrintTable( trace )
end
 
function TOOL:RightClick( trace )
	--if CLIENT then return end
	PrintTable( trace )

	if SERVER then return end
	render.DrawWireframeBox( trace.HitPos , Angle( 0 , 0 , 0 ) , trace.HitPos , Entity( 1 ):GetEyeTrace().HitPos , Color( 255, 255, 255 ), false )
end
 
function TOOL.BuildCPanel( panel )

	--local List = vgui.Create("DPanelList", panel )
--
	--for i=1,10 do
	--	btn = vgui.Create("DButton")
	--	btn:SetText( i )
	--	List:AddItem( btn )
	--end


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