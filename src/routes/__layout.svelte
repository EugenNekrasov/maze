<h1>
	<a href="/">Maze</a>
</h1>
<slot />

<style>
	:root {
		--main-color: #b0c4de;
		--shadow: 0 0 15px #ccc;
		font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
			Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
	}

	:global(body) {
		margin: 0 auto;
    max-width: 960px;
	}

	a {
		text-decoration: none;
		color: var(--main-color);
		letter-spacing: 0.3em;
		font-weight: 300;
		text-shadow: var(--shadow);
	}
	
	h1 {
		font-size: 5em;
		text-align: center;
	}
</style>
