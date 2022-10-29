local map = vim.api.nvim_set_keymap

local function createTestScript()
    vim.cmd(":tabnew")
    -- TODO:Maybe check if exists?

    -- From nvim-treesitter
    local bash_location = vim.fn.system("which bash")
    if vim.v.shell_error ~= 0 then
        -- TODO: Actual error here
        print("error!")
    end
    local bufnr = vim.api.nvim_get_current_buf()

    -- Sanitize
    if string.sub(bash_location, -1) == "\n" then
        bash_location = string.sub(bash_location, 1, string.len(bash_location) - 1)
    end
    -- TODO: Add hello world?
    vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, { "#!" .. bash_location })

    vim.cmd(":w test.sh")

    -- From nvim-treesitter
    local result = vim.fn.system("chmod +x test.sh")
    if vim.v.shell_error ~= 0 then
        -- TODO: Actual error here
        print("error setting chmod!")
    end
    -- TODO:Print result vim notification
end

local function openTermSplit()
    -- split below and focus
    vim.cmd("belowright split")
    -- resize window to 4/5th hight of new current window
    vim.cmd("exe 'resize ' . (winheight(0) * 4/5)")
    require("harpoon.term").gotoTerminal(1)
end

local function screenShare()
    local Path = require("plenary.path")
    local alacritty_config_path_string =
        "~/shell_config/alacritty/.config/alacritty/alacritty.yml"
    local alacritty_config_path = Path:new(alacritty_config_path_string)
    local alacritty_file_contents = alacritty_config_path:readlines()
    local size_line_index
    for i, line in ipairs(alacritty_file_contents) do
        -- Check for contents of line and see if size is there
        if string.find(line, "size") then
            size_line_index = i
        end
    end
    local size_config_string = alacritty_file_contents[size_line_index]

    -- split string
    local t = {}
    for str in string.gmatch(size_config_string, "([^" .. " " .. "]+)") do
        table.insert(t, str)
    end

    -- size value is always second value
    local current_size = tonumber(t[2])
    if current_size == 16 then
        alacritty_file_contents[size_line_index] = "  size: 23.0"
        vim.wo.relativenumber = false
    elseif current_size == 23 then
        alacritty_file_contents[size_line_index] = "  size: 16.0"
        vim.wo.relativenumber = true
    else
        error("Current size is not expected value:", current_size)
    end

    local alacritty_file_string = table.concat(alacritty_file_contents, "\n")
    alacritty_config_path:write(alacritty_file_string, "w")
end

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local function gitCommit()
    local input = Input({
        position = "50%",
        size = {
            width = 70,
            height = 10,
        },
        relative = "editor",
        border = {
            highlight = "GitCommit",
            style = "rounded",
            text = {
                top = "Enter commit message",
                top_align = "center",
            },
        },
        win_options = {
            winblend = 10,
            winhighlight = "Normal:Normal",
        },
    }, {
        prompt = "> ",
        default_value = "",
        on_close = function()
            print("Commit cancelled!")
        end,
        on_submit = function(commit_message)
            if commit_message == "" then
                print("You have to enter a commit message silly")
            else
                vim.cmd('Git commit -m "' .. commit_message .. '"')
            end
        end,
    })
    input:mount()
    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

local notify = require("notify")

-- TODO: Do something to override make command
-- TODO: Do something to kill make command

notify.setup({
    timeout = 15,
    background_colour = "#000000",
})

local make_cmd = "test"

-- TODO: Add something to see running jobs
-- TODO: add something to kill a job

local function setMakeCmd()
    -- TODO: Make a local function?
    local input = Input({
        position = "50%",
        size = {
            width = 70,
            height = 10,
        },
        relative = "editor",
        border = {
            highlight = "MakeCmd",
            style = "rounded",
            text = {
                top = "Enter Make command",
                top_align = "center",
            },
        },
        win_options = {
            winblend = 10,
            winhighlight = "Normal:Normal",
        },
    }, {
        prompt = "> ",
        default_value = "",
        on_close = function()
            print("No new make command set!")
        end,
        on_submit = function(new_make_cmd)
            if new_make_cmd == "" then
                print("You have to enter a make command silly")
            else
                make_cmd = new_make_cmd
                notify("New Make command set", "info", {
                    title = "Complete!",
                })
            end
        end,
    })
    input:mount()
    input:on(event.BufLeave, function()
        input:unmount()
    end)
end

local function runMakeCmd()
    local cmd_string = string.format("make %s", make_cmd)
    notify(string.format("Running %s", cmd_string), "info", {
        title = "Running make command",
    })

    local lines = { "" }
    local error_occurred = false

    local function on_exit(job_id, data, event)
        vim.fn.setqflist({}, " ", {
            title = cmd_string,
            lines = lines,
            -- TODO: Do I want formatting?
        })

        if error_occurred then
            notify(
                string.format("Error running %s completed", cmd_string),
                "Error",
                {
                    title = "Error!",
                }
            )
        else
            notify("Make command completed successfully!", "info", {
                title = "Complete!",
            })
        end
    end

    local function on_stdout_or_stderr(job_id, data, event)
        if event == "stdout" or event == "stderr" then
            if data then
                vim.list_extend(lines, data)
            end
        end

        -- HACK: to see if error actually occurred
        if event == "stderr" and data[1] ~= "" then
            error_occurred = true
        end
    end

    -- TODO: Set to global to store this to kill job
    local job_id = vim.fn.jobstart(cmd_string, {
        on_stderr = on_stdout_or_stderr,
        on_stdout = on_stdout_or_stderr,
        on_exit = on_exit,
        stdout_buffered = true,
        stderr_buffered = true,
    })
end


map("n", "<leader>ts", "", {
    noremap = true,
    callback = createTestScript,
    desc = "Create Test Script",
})

map("n", "<leader>gc", "", {
    noremap = true,
    callback = gitCommit,
    desc = "Git commit custom function",
})

map("n", "<leader>to", "", {
    noremap = true,
    callback = openTermSplit,
    desc = "Open harpoon terminal in split buffer below",
})

map("n", "<leader>sc", "", {
    noremap = true,
    silent = false,
    callback = screenShare,
    desc = "Enter screen share mode in alacritty",
})

map("n", "<leader>mt", "", {
    noremap = true,
    silent = false,
    callback = runMakeCmd,
    desc = "Run set make command in background",
})

map("n", "<leader>ms", "", {
    noremap = true,
    silent = false,
    callback = setMakeCmd,
    desc = "Set make command that can be run in background",
})

-- TODO: make refresh func that reloads files for after formatting / branch switching
-- ideally put in under <leader>rf or something similar
