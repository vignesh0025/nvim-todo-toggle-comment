local M = {}

-- Function to trim whitespace from start and end of string
local function trim(s)
    return s:gsub("^%s*(.-)%s*$", "%1")
end

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

local add_label_to_comment = function (raw_comment, comment_pattern, label)
	raw_comment = trim(raw_comment)
	if label ~= nil then
		label = string.gsub(label, "%s+", "") -- Trim label if necessary
		-- pattern /*<space>TODO:<space>actual comment<space>*/
		local label_added_pattern = string.format(" %s %s ", label, raw_comment)
		return string.format(comment_pattern, label_added_pattern)
	else
		local space_added_pattern = string.format(" %s ", raw_comment)
		return string.format(comment_pattern, space_added_pattern)
	end
end

M.add_label_to_comment = add_label_to_comment;

return M
