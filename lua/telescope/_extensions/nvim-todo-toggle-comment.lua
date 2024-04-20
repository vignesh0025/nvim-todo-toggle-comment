local has_telescope, telescope = pcall(require, "telescope")

if not has_telescope then
  error("This plugins requires nvim-telescope/telescope.nvim")
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"

local extension = require("nvim-todo-toggle-comment")

-- our picker function: colors
local colors = function(opts)

	-- local r = extension.preview_label_comment(entry[1])
	local current_bufnr = vim.fn.bufnr()
	local comment_node = extension.get_comment_node(current_bufnr)

	if comment_node ~= nil then
		opts = opts or {}
		local def_opts = {}
		def_opts.prompt_title = "colors"
		def_opts.previewer = previewers.new_buffer_previewer {
			title = "My preview",
			-- entry: {value, display, ordinal} from the entry_maker above
			define_preview = function (self, entry, status)
				-- entry[1] is the value selected
				local comment_text = extension.preview_label_comment(current_bufnr, comment_node, entry[1])
				vim.treesitter.start(self.state.bufnr, "c")
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { comment_text[1]})
			end
		}
		def_opts.finder = finders.new_table {
			results = extension.config.labels
		}
		def_opts.sorter = conf.generic_sorter(opts)
		def_opts.attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- vim.print(vim.inspect(selection))
				extension.add_label_comment(selection[1], current_bufnr)
			end)
			return true
		end
		pickers.new(opts, def_opts):find()

	end
end

return require("telescope").register_extension {
  exports = {
    -- stuff = require("plugin_name").stuff
	-- This SHOULD!! be name of the plugin itself
	["nvim-todo-toggle-comment"] = colors,
	color = colors
  },
}
