return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    math.randomseed(os.time())
    local dashboard = require("alpha.themes.dashboard")
    -- Function to center quotes
    local function center_quote(quote)
      local max_width = 0
      for _, str in ipairs(quote) do
        max_width = math.max(max_width, #str)
      end

      local centered_strings = {}
      for _, str in ipairs(quote) do
        local leading_spaces = math.floor((max_width - #str) / 2)
        local trailing_spaces = max_width - leading_spaces - #str
        local centered_str = string.rep(" ", leading_spaces) .. str .. string.rep(" ", trailing_spaces)
        table.insert(centered_strings, centered_str)
      end

      -- Insert blank strings at start of table yea ik its scuffed
      table.insert(centered_strings, 1, "")
      table.insert(centered_strings, 1, "")
      return centered_strings
    end

    local logo = [[
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣤⡶⢶⣶⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⠴⠛⠛⠉⠄⠀⠀⠀⠀⠀⠀⠀⠈⠑⠒⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣤⡊⠁⣀⣤⣄⣤⣤⣤⣀⣤⣤⣤⣀⣤⣠⣶⣠⣀⠉⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⡠⠋⢀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠐⣡⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⡹⣽⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⣟⣀⣠⡤⠶⢄⡀⠲⢄⠀⠀⠀⠀⠀⠀
⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⡴⠶⣾⣿⣿⣿⣿⡿⠛⠛⠉⠉⠁⠀⠉⠀⠀⠀⠀⠈⠉⠒⢷⣄⠀⠀⠀⠀
⠀⠙⠻⣿⣿⣿⣿⣿⣿⣿⣿⣇⠀⠀⠘⣿⡿⢿⣯⣶⣶⣶⣶⣠⣴⣂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀
⠀⠀⠀⠀⠀⠉⠉⠉⠛⠋⠉⠉⡀⠀⠀⠹⡀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣺⢶⣶⣤⣀⡀⠀⠀⠘⣆⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠀⠀⠂⣧⠀⠀⠉⠛⠻⠿⣿⣿⣿⣿⠟⠉⠛⣾⣿⣿⣷⣶⣄⡀⠘⢆⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⢸⡄⠀⠀⠀⠀⠀⠈⠉⢻⠏⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣶⣼⡆
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠸⡇⠀⠀⠀⠀⠀⠰⣖⠾⢧⣴⣲⣿⡏⠉⠛⠛⠻⠿⠿⣿⠿⠃
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠂⠄⠀⢄⣧⠀⠀⠀⠀⠀⠀⠈⢹⠷⣶⡿⣯⣵⡤⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⡀⢆⢠⣿⠀⠀⠀⠀⠀⠀⡰⠋⠠⣿⣷⣶⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣷⠿⡿⢹⣿⣆⠀⠀⠀⠀⡰⠉⠉⢹⡟⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣿⣖⠘⣾⣹⡇⠀⠀⠀⡸⠁⠀⠀⣸⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣨⣾⣿⣧⡀⠀⠀⣇⠐⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢛⣿⠿⣄⣾⢷⠦⠀⢸⡿⢧⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⣿⣟⡾⢿⣿⣷⢽⡍⢷⣯⣿⠓⢤⣒⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⣴⡶⣀⠀⠀⢸⡽⠂⢸⣿⣽⣻⣿⣤⣾⣿⣿⣿⣿⣄⡀⡸⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⠉⠫⡁⠀⢻⠿⢷⣤⣿⣿⣶⣿⣿⣿⣯⣿⣻⣿⣿⣶⣠⣳⠀⠀⠐⣿⡿⠄⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⠲⠞⠒⠛⠛⠛⠛⠛⠋⠻⠛⠓⠛⠛⠛⠛⠟⠛⠛⠓⠚⠓⠛⠂⠀⠀⠀⠀⠀⠀⠀
    ]]

    dashboard.section.header.val = vim.split(logo, "\n")
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",       "<cmd> lua LazyVim.pick()() <cr>"),
      dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
      dashboard.button("r", " " .. " Recent files",    [[<cmd> lua LazyVim.pick("oldfiles")() <cr>]]),
      dashboard.button("g", " " .. " Find text",       [[<cmd> lua LazyVim.pick("live_grep")() <cr>]]),
      dashboard.button("c", " " .. " Config",          "<cmd> lua LazyVim.pick.config_files()() <cr>"),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
    }

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end

    -- Fifteen word wrap
    local quotes = {
      {
        "Whether you're cured by a fungus, or watch it cure someone else; whether you",
        "build your home from fungi, or start growing mushrooms in your home, fungi",
        "will catch you in the act. If you're alive, they already have.",
        "[Merlin Sheldrake]",
      },
      {
        "I see the mycelium as the Earth's natural Internet, a consciousness with",
        "which we might be able to communicate. Through cross-species interfacing,",
        "we may one day exchange information with these sentient cellular networks.",
        "Because these externalised neurological nets sense any impression upon",
        "them, from footsteps to falling tree branches, they could relay enormous",
        "amounts of data regarding the movements of all organisms through the",
        "landscape.",
        "[Paul Stamet]",
      },
      {
        "Science isn’t an exercise in cold-blooded rationality. Scientists are—and",
        "have always been—emotional, creative, intuitive, whole human beings,",
        "asking questions about a world that was never made to be catalogued and",
        "systematised",
        "[Merlin Sheldrake]",
      },
    }

    -- Set random quote
    dashboard.section.footer.val = center_quote(quotes[math.random(#quotes)])

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 1

    return dashboard
  end,

  config = function(_, dashboard)
    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end
    require("alpha").setup(dashboard.opts)
  end,
}
