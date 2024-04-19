local utils = require('utils')

describe("Busted Unit Test: ", function()
	describe("add_label_to_comment: ", function()

    it("Default use case", function()
      assert.are.same("/* TODO: This is a comment */", utils.add_label_to_comment("This is a comment", "/*%s*/", "TODO:"))
	end)

    it("Use case with space at end of label", function()
      assert.are.same("/* TODO: This is a comment */", utils.add_label_to_comment("This is a comment", "/*%s*/", "TODO: "))
	end)

    it("Fix use case with space at end of label", function()
      assert.are.same("/* FIX: This is a comment */", utils.add_label_to_comment("This is a comment", "/*%s*/", "FIX: "))
	end)

    it("No label use case with space at end of comment", function()
      assert.are.same("/* This is a comment */", utils.add_label_to_comment("This is a comment ", "/*%s*/"))
	end)

    it("No label case with space at start of comment", function()
      assert.are.same("/* This is a comment */", utils.add_label_to_comment(" This is a comment", "/*%s*/"))
	end)

    it("No label case with space at both ends of comment", function()
      assert.are.same("/* This is a comment */", utils.add_label_to_comment(" This is a comment", "/*%s*/"))
	end)

    it("TODO: label case with space at both ends of comment and label", function()
      assert.are.same("/* TODO: This is a comment */", utils.add_label_to_comment(" This is a comment ", "/*%s*/", " TODO: "))
	end)

	end)
end)
