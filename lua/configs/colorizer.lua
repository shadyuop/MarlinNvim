local M = {}

local user_plugin_opts = require("core.utils").user_plugin_opts

function M.config()
  local present, colorizer = pcall(require, "colorizer")
  if present then
    local colorizer_opts = user_plugin_opts("plugins.colorizer", {
      { "*", css = { css = true } },
      {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all css features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background", -- Set the display mode
      },

    })
    colorizer.setup(colorizer_opts[1], colorizer_opts[2])
  end
end

return M
