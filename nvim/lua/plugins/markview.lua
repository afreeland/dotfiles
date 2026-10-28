vim.pack.add({ 'https://github.com/OXY2DEV/markview.nvim' })

require('markview').setup({
    experimental = {
        prefer_nvim = true,
        file_open_command = 'edit',
    },
})

-- Markview currently resolves local links against Neovim's working directory.
-- Resolve them against the document, while preserving web and heading links.
local links = require('markview.links')
local parse_link = links.parse
links.parse = function(address)
    if address:match('^%a[%w+.-]*:') or address:match('^www%.') then
        return { url = address }
    end
    if address:sub(1, 1) == '#' then
        return parse_link(address)
    end

    local path, fragment = address:match('^(.-)#(.*)$')
    path = vim.fn.expand(path or address)
    if not vim.startswith(path, '/') then
        local directory = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        path = vim.fs.joinpath(directory, path)
    end
    path = vim.fs.normalize(path)

    local parsed = parse_link(address)
    if parsed.path or vim.uv.fs_stat(path) then
        return { path = path, fragment = fragment }
    end
    return parsed
end
