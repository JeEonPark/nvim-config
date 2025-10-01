return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts = opts or {}
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        any = {
          { event = "notify", find = "-32603: Internal error" },
          { event = "msg_show", find = "-32603: Internal error" },
        },
      },
      opts = { skip = true },
    })
    return opts
  end,
}


