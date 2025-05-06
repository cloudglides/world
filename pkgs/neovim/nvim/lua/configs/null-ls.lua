local null_ls = require("null-ls")
local b = null_ls.builtins

return {
  -- Add this line for proper setup
  setup = function(on_attach)
    null_ls.setup({
      on_attach = on_attach,
      sources = {
        -- diagnostics
        b.diagnostics.deadnix,
        b.diagnostics.staticcheck,
        -- code actions
        b.code_actions.statix,
        b.code_actions.gomodifytags,
        b.code_actions.impl,
      }
    })
  end,
}
