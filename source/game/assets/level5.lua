return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 100,
  height = 100,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      name = "objects",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 980,
          y = 367,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "loving",
            ["impulse_x"] = "200",
            ["state"] = "interested"
          }
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 1019,
          y = 537,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "depressed"
          }
        },
        {
          name = "",
          type = "CameraStartPos",
          shape = "rectangle",
          x = 1281,
          y = 403,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 1521,
          y = 459,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "loving",
            ["state"] = "angry"
          }
        },
        {
          name = "",
          type = "Text",
          shape = "rectangle",
          x = 1280,
          y = 160,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Press \"R\" to restart if you get stuck"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 581,
          y = 212,
          width = 47,
          height = 449,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 1430,
          y = 324,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["impulse_x"] = "30",
            ["impulse_y"] = "250",
            ["state"] = "content"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 640,
          y = 192,
          width = 1396,
          height = 46,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 1061,
          y = 505,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "loving",
            ["state"] = "interested"
          }
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 1561,
          y = 423,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "content"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 640,
          y = 640,
          width = 1396,
          height = 46,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Text",
          shape = "rectangle",
          x = 1280,
          y = 128,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Make everyone happy by connecting to the right friends"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 2048,
          y = 219,
          width = 47,
          height = 449,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
