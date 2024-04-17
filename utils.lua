local M = {}

-- comment_string: full comment string
-- comment_extract_pattern: Extracts comment test from commant_string "(/%*)(.-)(%*/)" or "(//)(.-)"
local extract_comment_without_label = function (comment_string, comment_extract_pattern, label_token)
	local label_extract_pattern = "%s*"..label_token.."%s*" -- <space>TODO:<space>
	local trim_space_start_end_pattern = "%s*(.-)%s*$"

	local _, _, comment_text = string.find(comment_string, comment_extract_pattern, 0)
	local raw_comment = ""
	if comment_text == nil then
		error("ToVignesh: Can't extract comment_text with "..comment_extract_pattern.." from "..comment_string, 2)
	else
		raw_comment = string.gsub(comment_text, label_extract_pattern, ""):gsub(trim_space_start_end_pattern, "%1")
	end

	return raw_comment
end

M.extract_comment_without_label = extract_comment_without_label;

local toggle_comment = function (comment_string, comment_extract_pattern, label_token)
	local token_string_new = " "..label_token.. " "

	-- print(comment_start_token)
	-- print(comment_end_token)
	-- print(comment_text)
	if start ~= nil then
		local final_comment_string = ""
		-- Remove the label if present and then extra space at start and end of string
		local raw_comment = string.gsub(comment_text, label_extract_pattern, ""):gsub(trim_space_start_end_pattern, "%1")
		print(raw_comment)
		-- There is token in the comment already
		if token_string ~= nil then
			final_comment_string = comment_start_token..raw_comment..comment_end_token
		else -- There is no token in the comment string
			final_comment_string = comment_start_token..token_string_new..raw_comment..comment_end_token
		end
		local lines = {}
		for line in final_comment_string:gmatch("[^\r\n]+") do
			table.insert(lines, line)
		end
		return lines
	else
		error("Can't extract comment_text with "..comment_extract_pattern.." from "..comment_string)
	end
end

return M
