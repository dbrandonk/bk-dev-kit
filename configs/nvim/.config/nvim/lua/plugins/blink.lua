return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}

      opts.keymap["<Tab>"] = { "select_next", "snippet_forward", "fallback" }
      opts.keymap["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" }

      return opts
    end,
  },
}
