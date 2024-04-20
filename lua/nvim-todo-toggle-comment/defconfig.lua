local M = {}

local def_config = {
	add_spc_end_cmt = true,
	nested_comment = {
		nested_option = "default_nested"
	},
	labels = {"", "TODO:", "FIX:", "HACK:", "PERF:", "WARNING:", "INFO:"}
}

local get_def_config = function ()
	return vim.deepcopy(def_config)
end

M.get_def_config = get_def_config

local get_config = function (config)
	if config ~= nil then
		return vim.tbl_deep_extend("force", def_config, config)
	else
		return get_def_config()
	end
end

M.get_config = get_config;

return M
