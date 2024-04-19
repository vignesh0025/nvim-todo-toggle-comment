local M = {}

local utils = require('nvim-todo-toggle-comment.utils')

M.test = function ()
	print(utils.add_label_to_comment("This is a comment", "/*%s*/", "TODO:"))
end

return M
