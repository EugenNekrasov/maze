<svelte:head>
	<title>Login</title>
</svelte:head>

<h2>Login</h2>
<form>
	<label>
		Login
		<input type="text" name="login">
	</label>
	<label>
		Password
		<input type="password" name="password">
	</label>
	<input type="submit" value="Login">
</form>

<style>
	h2 {
		color: var(--main-color);
	}
</style>