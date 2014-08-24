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
          x = 706,
          y = 265,
          width = 95,
          height = 456,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 1144,
          y = 227,
          width = 64,
          height = 544,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 384,
          y = 736,
          width = 744,
          height = 51,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 531,
          y = 406,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "loving",
            ["state"] = "loving"
          }
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 998,
          y = 652,
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
          x = 1120,
          y = 160,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Depressed people need happy people"
          }
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 527,
          y = 648,
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
          x = 416,
          y = 160,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["string"] = "Angry people need caring people"
          }
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 300,
          y = 225,
          width = 64,
          height = 544,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Wall",
          shape = "rectangle",
          x = 381,
          y = 205,
          width = 744,
          height = 51,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "Person",
          shape = "rectangle",
          x = 994,
          y = 398,
          width = 0,
          height = 0,
          visible = true,
          properties = {
            ["emotion"] = "happiness",
            ["state"] = "happy"
          }
        }
      }
    }
  }
}
