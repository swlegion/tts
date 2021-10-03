-- Standard library (globals) available.
std = {
  globals = {
    "onDestroy",
    "onLoad",
    "onSave",
  },

  read_globals = {
    "getObjectFromGUID",

    self = {
      fields = {
        interactable = {
          read_only = false,
        },

        createButton = {
          read_only = true,
        },

        AssetBundle = {
          read_only = true,

          fields = {
            playTriggerEffect = {
              read_only = true,
            },
          },
        },
      },
    },

    Global = {
      fields = {
        getVar = {
          read_only = true,
        },

        setVar = {
          read_only = true,
        },

        getTable = {
          read_only = true,
        },

        setTable = {
          read_only = true,
        },
      }
    }
  }
}
