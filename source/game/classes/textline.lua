
local TextLine = class("TextLine", Entity)

local text_font = love.graphics.newFont(24)
local lg = love.graphics

function TextLine:initialize( text, color )

	Entity.initialize( self )

	self.text = text
	self.color = color or Color.White
	self.text_width = text_font:getWidth(self.text)
end

function TextLine:draw()

	local x, y = self:getPos()

	local oldcol = { lg.getColor() }
	local oldfont = lg.getFont()
	
	lg.setColor( self.color:unpack() )
	lg.setFont( text_font )

	lg.print( self.text, x-self.text_width/2, y )
	--lg.line( x, y, x + 5, y )
	--lg.line( x, y, x, y + 5 )
	
	lg.setColor( unpack( oldcol ) )
	lg.setFont( oldfont )
	
end

return TextLine