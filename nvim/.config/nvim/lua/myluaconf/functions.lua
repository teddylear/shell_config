local M = {}

M.trimWhiteSpace = function()
    vim.cmd("keeppatterns %s/\\s\\+$//e")
    vim.cmd("call winrestview(winsaveview())")
end

M.setup = function()
    -- Remove whitespace
    vim.cmd("augroup THE_KENSTER")
    vim.cmd("autocmd!")
    vim.cmd(
        "autocmd BufWritePre * :lua require('myluaconf.functions').trimWhiteSpace()"
    )
    vim.cmd("augroup END")
end

M.NewNote = function()
    vim.cmd("read ~/.config/nvim/templateFiles/new_note.md")
    vim.cmd("call cursor( line('.')-1, 1)")
    vim.cmd("delete")
end

local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

M.GitCommit = function()
    local input = Input({
        position = "50%",
        size = {
            width = 70,
            height = 10,
        },
        relative = "win",
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

-- TODO: Do something to override make command
-- TODO: Do something to kill make command

local notify = require("notify")

notify.setup({
    timeout = 15,
    background_colour = "#000000",
})

local make_cmd = "test"

-- TODO: Add something to see running jobs
-- TODO: add something to kill a job

M.SetMakeCmd = function()
    -- TODO: Make a local function?
    local input = Input({
        position = "50%",
        size = {
            width = 70,
            height = 10,
        },
        relative = "win",
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

M.RunMakeCmd = function()
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

M.setup()

return M
