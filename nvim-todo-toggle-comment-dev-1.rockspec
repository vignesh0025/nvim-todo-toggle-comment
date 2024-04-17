package = "nvim-todo-toggle-comment"
version = "dev-1"
source = {
   url = "git+https://github.com/vignesh0025/nvim-todo-toggle-comment.git"
}
description = {
   summary = "# Install Luarocks from source",
   detailed = "# Install Luarocks from source",
   homepage = "https://github.com/vignesh0025/nvim-todo-toggle-comment",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      main = {
         sources = "main.c"
      },
      run = "run.lua",
      ["tests.test_spec"] = "tests/test_spec.lua",
      utils = "utils.lua"
   },
   copy_directories = {
      "tests"
   }
}
