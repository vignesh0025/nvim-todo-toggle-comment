local utils = require('utils')

--negative cases
-- print(utils.extract_comment_without_label("/* TODO: This is todo comment", "/%*(.+)%*/", "TODO:"))

describe("Busted unit testing framework", function()
  describe("Testing comment extraction from label", function()
	--
	-- deep check comparisons!
    it("Default use case", function()
      assert.are.same(utils.extract_comment_without_label("/* TODO: This is todo comment */", "/%*(.+)%*/", "TODO:"), "This is todo comment")
	end)

	it("Default use case", function()
      assert.are.same(utils.extract_comment_without_label("/* This is default comment */", "/%*(.+)%*/", "FIX:"), "This is default comment")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/* This is default comment */", "/%*(.+)%*/", "FIX:"), "This is default comment")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/*This is default comment with no start end space*/", "/%*(.+)%*/", "FIX:"), "This is default comment with no start end space")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/*This is default comment with no end space */", "/%*(.+)%*/", "FIX:"), "This is default comment with no end space")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/* This is default comment with no start space*/", "/%*(.+)%*/", "FIX:"), "This is default comment with no start space")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("// FIX: This is fix inline comment", "//(.+)", "FIX:"), "This is fix inline comment")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("//FIX: This is fix inline comment variant 1", "//(.+)", "FIX:"), "This is fix inline comment variant 1")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("//FIX:This is fix inline comment variant 2", "//(.+)", "FIX:"), "This is fix inline comment variant 2")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/*TODO: This is todo comment with no start space */", "/%*(.+)%*/", "TODO:"), "This is todo comment with no start space")
	end)

	it("Default use case", function()
		assert.are.same(utils.extract_comment_without_label("/*TODO:This is todo comment with no space around space*/", "/%*(.+)%*/", "TODO:"), "This is todo comment with no space around space")
	end)


    it("Match raw comment extraction", function()
      assert.are.same(utils.extract_comment_without_label("/* FIX: This is fix comment */", "/%*(.+)%*/", "FIX:"), "This is fix comment")
    end)

	-- Need to wrap error call in function()
	it("Negative Test", function ()
		assert.has_error(function() utils.extract_comment_without_label("/* TODO: This is todo comment", "/%*(.+)%*/", "TODO:") end,
		"ToVignesh: Can't extract comment_text with /%*(.+)%*/ from /* TODO: This is todo comment")
	end)

    it("Match raw comment extraction", function()
      -- or check by reference!
      -- assert.are_not.equal({ table = "great"}, { table = "great"})
      --
      -- assert.truthy("this is a string") -- truthy: not false or nil
      --
      -- assert.True(1 == 1)
      -- assert.is_true(1 == 1)
      --
      -- assert.falsy(nil)
      -- assert.has_error(function() error("Wat") end, "Wat")
    end)

-- 	print(utils.extract_comment_without_label("/* TODO: This is todo comment", "/%*(.+)%*/", "TODO:"))
--
-- 	it("should provide some shortcuts to common functions", function()
-- 		assert.are.unique({{ thing = 1 }, { thing = 2 }, { thing = 3 }})
-- 	end)
--
-- it("should have mocks and spies for functional tests", function()
--   local thing = require("thing_module")
--   spy.on(thing, "greet")
--   thing.greet("Hi!")
--
--   assert.spy(thing.greet).was.called()
--   assert.spy(thing.greet).was.called_with("Hi!")
-- end)
  end)
end)
