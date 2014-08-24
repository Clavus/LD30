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
          x = 219,
          y = 385,
          width = 152,
          height = 404,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 1140,
          y = 425,
          width = 166,
          height = 368,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 384,
          y = 741,
          width = 744,
          height = 51,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 512,
          y = 487,
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
          type = "Person",
          shape = "rectangle",
          x = 1012,
          y = 563,
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
          x = 751,
          y = 429,
          width = 0,
          height = 0,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Text",
          shape = "rectangle",
          x = 749,
          y = 146,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "You can make a person happier by connecting with happier friends"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "polygon",
          x = 377,
          y = 381,
          width = 0,
          height = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 370, y = -72 },
            { x = 355, y = -171 },
            { x = -103, y = -133 },
            { x = -158, y = -1 }
          },
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "polygon",
          x = 1137,
          y = 421,
          width = 0,
          height = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -385, y = -114 },
            { x = -373, y = -213 },
            { x = 123, y = -143 },
            { x = 167, y = 0 }
          },
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 506,
          y = 645,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "content"
          }
        }
      }
    }
  }
}
