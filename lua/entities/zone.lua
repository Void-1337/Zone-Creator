--salut mec


AddCSLuaFile()
DEFINE_BASECLASS( "base_gmodentity" )

TOOL.Category = "Examples"
TOOL.Name = "Your Tools name"
TOOL.Command = nil
TOOL.ConfigName = "" --Setting this means that you do not have to create external configuration files to define the layout of the tool config-hud 
 
TOOL.ClientConVar[ "myparameter" ] = "fubar"
 
function TOOL:LeftClick( trace )
end
 
function TOOL:RightClick( trace )
end
 
function TOOL.BuildCPanel( panel )
	panel:AddControl("Header", { Text = "Example TOOL", Description = "Just an little example" })
 
	panel:AddControl("CheckBox", {
	    Label = "A Boolean Value",
	    Command = "example_bool"
	})
	panel:AddControl("Slider", {
	    Label = "Example Number",
	    Type = "Float",
	    Min = "0",
	    Max = "10000",
	    Command = "example_number"
	})
 
	panel:AddControl("Color", {
	    Label = "A Color",
	    Red = "example_color_r",
	    Blue = "example_color_b",
	    Green = "example_color_g",
	    Alpha = "example_color_a",
	    ShowHSV = 1,
	    ShowRGB = 1,
	    Multiplier = 255 --You can change this to make the rgba values go up to any value
	})
end
 