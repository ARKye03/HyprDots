if true then return {} end
return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function() require("supermaven-nvim").setup {} end,
  },
}
