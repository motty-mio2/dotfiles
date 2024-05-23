local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.actionlint,
		null_ls.builtins.diagnostics.ansible_lint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.textlint,
		null_ls.builtins.diagnostics.verilator,
		null_ls.builtins.diagnostics.zsh,
		null_ls.builtins.formatting.biome,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.blackd,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.isortd,
		null_ls.builtins.formatting.markdownlint,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.sqlformat,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.textlint,
		null_ls.builtins.formatting.verible_verilog_format,
		null_ls.builtins.formatting.yapf,
		null_ls.builtins.hover.dictionary,

		-- nonels-extras
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.ruff,
		null_ls.builtins.formatting.ruff_format,
	},
})
