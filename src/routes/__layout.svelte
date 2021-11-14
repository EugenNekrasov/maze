<script>
	import { base } from "$app/paths";
</script>

<svelte:head>
	<link rel="icon" href="{base}/favicon.png" />
</svelte:head>

<h1>
	<a href="{base}/">Maze</a>
</h1>
<slot />

<style>
	:root {
		--palette1: #bbc8de;
		--palette2: #52688f;
		--palette3: #151b25;
		--palette4: #192e41;
		--shadow: 0 0 15px var(--palette1);
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
			Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	}

	:global(body) {
		color: var(--palette1);
		background-color: var(--palette2);
		margin: 0 auto;
		max-width: 960px;
	}

	:global(a) {
		color: inherit;
	}

	:global(input) {
		color: var(--palette3);
	}

	:global(input[type="submit"]),
	:global(input[type="button"]) {
		color: inherit;
	}

	a {
		text-decoration: initial;
		letter-spacing: 0.3em;
		font-weight: 300;
		text-shadow: var(--shadow);
	}

	h1 {
		font-size: 5em;
		text-align: center;
	}
</style>
