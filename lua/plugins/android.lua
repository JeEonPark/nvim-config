return {
  "iamironz/android-nvim-plugin",
  lazy = false,
  config = function()
    -- Patch find_root to detect kmp/ subdirectory when opened from ios/
    local workspace = require("android.gradle.workspace")
    local orig_find_root = workspace.find_root
    workspace.find_root = function(start_path, exists)
      local root = orig_find_root(start_path, exists)
      if root then
        return root
      end
      local check = exists or function(p)
        local stat = vim.loop.fs_stat(p)
        return stat ~= nil and stat.type == "file"
      end
      -- Search for kmp/ under cwd
      local cwd = vim.fn.getcwd()
      local kmp = cwd .. "/kmp"
      if check(kmp .. "/settings.gradle.kts") or check(kmp .. "/settings.gradle") then
        return kmp
      end
      return nil
    end

    require("android").setup({
      keymaps = {
        enabled = false,
      },
    })

    local map = vim.keymap.set
    local opts = { remap = true, silent = true }

    map("n", "<leader>dam", "<Plug>(AndroidMenu)", vim.tbl_extend("force", opts, { desc = "Android Menu" }))
    map("n", "<leader>dat", "<Plug>(AndroidTargets)", vim.tbl_extend("force", opts, { desc = "Android Targets" }))
    map("n", "<leader>dao", "<Plug>(AndroidTools)", vim.tbl_extend("force", opts, { desc = "Android Tools" }))
    map("n", "<leader>daa", "<Plug>(AndroidActions)", vim.tbl_extend("force", opts, { desc = "Android Actions" }))
    -- Build with ktlintFormatAll first (same as composeApp-default)
    map("n", "<leader>dab", function()
      local kmp_dir = vim.fn.getcwd() .. "/kmp"
      vim.notify("Running ktlintFormatAll...", vim.log.levels.INFO)
      vim.fn.jobstart("cd " .. kmp_dir .. " && ./gradlew ktlintFormatAll", {
        stdout_buffered = true,
        on_exit = function(_, code)
          vim.schedule(function()
            if code == 0 then
              vim.notify("ktlintFormatAll done. Starting build...", vim.log.levels.INFO)
              vim.cmd("execute 'normal \\<Plug>(AndroidBuild)'")
            else
              vim.notify("ktlintFormatAll failed (exit code: " .. code .. ")", vim.log.levels.ERROR)
            end
          end)
        end,
      })
    end, { desc = "Android Build (with ktlint)" })
    map("n", "<leader>dar", "<Plug>(AndroidRun)", vim.tbl_extend("force", opts, { desc = "Android Run" }))
    map("n", "<leader>dal", "<Plug>(AndroidLogcat)", vim.tbl_extend("force", opts, { desc = "Android Logcat" }))

    -- which-key groups
    local ok, wk = pcall(require, "which-key")
    if ok then
      wk.add({
        { "<leader>d", group = "Dev" },
        { "<leader>da", group = "Android" },
      })
    end
  end,
}
