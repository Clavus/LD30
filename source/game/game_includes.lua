
require("game/game")

local toload = {
	{ Person = "game/classes/person" },
	{ Connection = "game/classes/connection" }
}
package.loadSwappable( toload )