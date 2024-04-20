local utils = require('lua.nvim-todo-toggle-comment.utils')

describe("Busted Unit Test: ", function()
	describe("extract_comment_without_label: ", function()

		local labels = {"", "TODO:", "FIX:", "HACK:", "PERF:", "WARNING", "INFO"}

		-- deep check comparisons!
		it("Default use case", function()
			assert.are.same(utils.extract_label_from_comment("/* TODO: This is a comment", labels), 2)
		end)

		it("Warning use case", function()
			assert.are.same(utils.extract_label_from_comment("/* WARNING: This is a comment", labels), 6)
		end)

		it("No label use case", function()
			assert.is_nil(utils.extract_label_from_comment("/* This is a comment", labels))
		end)

	end)
end)
