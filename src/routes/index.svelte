<svelte:head>
	<title>Maze</title>
</svelte:head>

<div class="links">
	<a href="login">Log in</a>
	<a href="register">Register</a>
</div>

<style>
	.links {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 2em;
	}

	a {
		font-size: 2em;
		letter-spacing: 0.3em;
		text-decoration: initial;
		text-shadow: var(--shadow);
		transition: letter-spacing 0.4s, text-shadow 0.4s;
	}

	a:hover {
		letter-spacing: normal;
		text-shadow: initial;
	}

	@media (min-width: 850px) {
		.links {
			flex-direction: row;
			gap: initial;
		}

		a {
			text-align: center;
			width: 50%;
			padding-top: 2em;
			padding-bottom: 3em;
		}
	}
</style>
