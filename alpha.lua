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

    local quotes = {
      {
        "We should save the old growth forest as a matter of national defense",
      },
      {
        "Fungi are the interface organisms between life and death",
      },
      {
        "True wealth is not measured in material possessions but by the abundance of options and choices",
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
