local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins/"
local subdirs = vim.fn.globpath(plugin_dir, "*/", false, true)

local plugins = {}

for _, dir in ipairs(subdirs) do
    local dirname = dir:match(".+/([^/]+)/$")
    table.insert(plugins, { import = "plugins." .. dirname })
end

return plugins
