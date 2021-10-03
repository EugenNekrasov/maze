<svelte:head>
	<title>Login</title>
</svelte:head>

<form>
	<label>
		Username
		<input type="text" name="login" />
	</label>
	<label>
		Password
		<input type="password" name="password" />
	</label>
	<input type="submit" value="Login" />
</form>

<style>
	form {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 2em;
	}

	label {
		display: block;
	}

	input[name='login'],
	input[name='password'] {
		display: block;
	}

	input[type='submit'] {
		padding: 1em;
		letter-spacing: 0.3em;
		text-transform: initial;
		border-radius: 8px;
		font-size: 1.5em;
		cursor: pointer;
		background-color: var(--palette2);
		border: initial;
		text-shadow: var(--shadow);
		transition: text-shadow 0.4s;
	}

	input[type='submit']:hover {
		text-shadow: initial;
	}
</style>
