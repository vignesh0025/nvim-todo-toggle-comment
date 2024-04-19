local utils = require('nvim-todo-toggle-comment.utils')
local defconfig = require('nvim-todo-toggle-comment.defconfig')

local M = {}

M.config = {}

M.test = function ()
	print(utils.add_label_to_comment("This is a comment", "/*%s*/", "TODO:"))
end

M.setup = function (config)
	M.config = defconfig.get_config(config);
	-- vim.print(M.config)
end

return M
