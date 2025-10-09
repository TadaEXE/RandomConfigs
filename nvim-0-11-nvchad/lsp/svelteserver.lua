return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte", "svelte.ts", "svelte.js" },
	root_markers = {
		"svelte.config.js",
		"svelte.config.cjs",
		"svelte.config.mjs",
		"package.json",
		"tsconfig.json",
	},
}
