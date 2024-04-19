local mod = require('lua.nvim-todo-toggle-comment.defconfig')


describe("Busted Unit Test: ", function()
	describe("check_config_user_override_spec: ", function()

		it("Return config without user override", function()
			-- local exp_cfg = { add_spc_end_cmt = true }
			local exp_cfg = mod.get_def_config()
			assert.are.same(exp_cfg, mod.get_config())
		end)

		it("Return config with user override", function()
			local exp_cfg = mod.get_def_config()

			exp_cfg.add_spc_end_cmt = false
			exp_cfg.nested_comment.nested_option = "nested override"

			assert.are.same(exp_cfg, mod.get_config(exp_cfg))
		end)
	end)
end)
