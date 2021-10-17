<svelte:head>
	<title>Maze</title>
</svelte:head>

<div class="links">
	<a href="login">Login</a>
	<a href="register">Register</a>
</div>

<style>
	.links {
		display: flex;
	}

	a {
		color: var(--main-color);
		font-size: 2em;
		letter-spacing: 0.3em;
		text-align: center;
		text-decoration: none;
		text-shadow: var(--shadow);
		transition:
		letter-spacing 0.4s ease,
		text-shadow 0.4s ease;
		width: 50%;
	}

	a:hover {
		letter-spacing: normal;
		text-shadow: none;
	}
</style>