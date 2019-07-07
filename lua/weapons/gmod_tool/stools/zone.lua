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

local hitpos
local endpos


function TOOL:CalcEndPos( trace )

	if trace.HitPos:Distance( trace.StartPos ) < 500 then
		return trace.HitPos
	end

	return trace.StartPos
end

local CalcEndPos = TOOL.CalcEndPos
 
function TOOL:LeftClick( trace )

	if not hitpos then
		hitpos = self:CalcEndPos( trace )
	elseif not endpos then
		endpos = self:CalcEndPos( trace ) - hitpos
	else
		endpos = nil
		hitpos = nil
	end
end
 
function TOOL:RightClick( trace )
	--if CLIENT then return end
	PrintTable( trace )
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

function TOOL:DrawToolScreen( width, height )

	--surface.SetDrawColor( HSVToColor( 50 * CurTime() % 360, 1, 1 ) )
	--surface.DrawRect( 0, 0, width, height )

	draw.SimpleText( self.Name, "DermaLarge", width / 2, height / 2, Color( 0, 0, 0 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

	if not hitpos then return end
	local x, y = hitpos

	render.RenderView( {
		origin = hitpos + Vector( 0 , 0 , 20 ),
		angles = EyeAngles(),
		x = x, y = y,
		w = width, h = height
	} )

end

local f = TOOL

function TOOL:DrawPreview()

	if not hitpos then return end

	local endpos = endpos or CalcEndPos( false , LocalPlayer():GetEyeTrace() ) - hitpos
	local h , l , e = endpos.z , endpos.y , endpos.x
	

	render.DrawLine( hitpos, hitpos + Vector( e , 0 , 0), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos, hitpos + Vector( 0 , l , 0), Color( 0, 255, 0 ), true )

	render.DrawLine( hitpos + Vector( e , 0 , 0) , hitpos + Vector( e , l , 0), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( 0 , l , 0) , hitpos + Vector( e , l , 0), Color( 0, 255, 0 ), true )

	render.DrawLine( hitpos + Vector( 0 , 0 , h), hitpos + Vector( e , 0 , h), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( 0 , 0 , h), hitpos + Vector( 0 , l , h), Color( 0, 255, 0 ), true )

	render.DrawLine( hitpos + Vector( e , 0 , h) , hitpos + Vector( e , l , h), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( 0 , l , h) , hitpos + Vector( e , l , h), Color( 0, 255, 0 ), true )

	render.DrawLine( hitpos + Vector( 0 , 0 , 0), hitpos + Vector( 0 , 0 , h), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( e , 0 , 0), hitpos + Vector( e , 0 , h), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( 0 , l , 0), hitpos + Vector( 0 , l , h), Color( 0, 255, 0 ), true )
	render.DrawLine( hitpos + Vector( e , l , 0), hitpos + Vector( e , l , h), Color( 0, 255, 0 ), true )
	

	cam.Start3D2D( hitpos, Angle( 0 , 0 , 0 ), 0 )
		--surface.SetDrawColor( 0, 0, 0, 255 )
	cam.End3D2D()
end

function TOOL:Deploy()
	if CLIENT then
		endpos = nil
		hitpos = nil
		hook.Add( "PostDrawOpaqueRenderables", self.ConfigName , self.DrawPreview )
	end
end

function TOOL:Holster()
	if CLIENT then
		hook.Remove("PostDrawOpaqueRenderables", self.ConfigName )
		endpos = nil
		hitpos = nil
	end
end

function TOOL:DrawHUD()

end
