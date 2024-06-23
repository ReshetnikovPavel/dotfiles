return {
	"rose-pine/neovim",
	"xiyaowong/transparent.nvim",
	{ "aveplen/ruscmd.nvim",             opts = {} },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" }
	},
	"mbbill/undotree",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	}
}
