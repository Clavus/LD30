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
          type = "Wall",
          shape = "rectangle",
          x = 248,
          y = 263,
          width = 55,
          height = 365,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 316,
          y = 219,
          width = 744,
          height = 51,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 1070,
          y = 267,
          width = 55,
          height = 365,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 312,
          y = 621,
          width = 744,
          height = 51,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 932,
          y = 454,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "sad"
          }
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 447,
          y = 452,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "happy"
          }
        },
        {
          name = "",
          type = "CameraStartPos",
          shape = "rectangle",
          x = 696,
          y = 371,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Text",
          shape = "rectangle",
          x = 697,
          y = 167,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Then drag and release to get things moving..."
          }
        },
        {
          name = "",
          type = "Text",
          shape = "rectangle",
          x = 697,
          y = 135,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Click on a person (the emotes) with left mouse"
          }
        }
      }
    }
  }
}
