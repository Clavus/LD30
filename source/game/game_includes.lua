
require("game/game")

local toload = {
	{ Person = "game/classes/person" },
	{ Connection = "game/classes/connection" },
	{ TextLine = "game/classes/textline" }
}
package.loadSwappable( toload )