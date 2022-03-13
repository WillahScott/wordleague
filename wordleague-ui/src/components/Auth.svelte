<script>
	import { supabase } from '$lib/supabase';
	import Logo from './Logo.svelte';

	let loading = false;
	let email;

	const handleLogin = async () => {
		try {
			loading = true;
			const { error } = await supabase.auth.login({
				email: email
				// password: document.getElementById("password").value
			});
			if (error) throw error;
		} catch (error) {
			console.error(error.error_description || error.message);
		} finally {
			alert('check your email!');
		}
	};

	const handleCreateAccount = async () => {};
</script>

<div class="py-10 relative h-screen flex flex-col items-center md:justify-center">
	<h1 class="text-center text-4xl md:text-6xl font-bold text-purple-800 mb-14">
		Welcome to <Logo />
	</h1>

	<div class="flex-grow flex flex-col items-center text-2xl text-purple-900">
		<div class="flex flex-col items-center justify-around pt-2 pb-2 px-8 ">
			<p class="text-2xl font-mono text-pink-400 mb-8">
				Create your own word-guessing league and challenge your friends!
			</p>
		</div>
		<div class="flex flex-col py-14 px-8 w-full">
			<p class="text-2xl text-purple-600 font-mono">
				Returning users
			</p>
			<form class="my-6 flex flex-col justify-center" on:submit|preventDefault={handleLogin}>
				<div class="flex flex-col text-sm mb-2">
					<input
						type="email"
						name="email"
						id="email"
						bind:value={email}
						placeholder="Your email"
						class="text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					/>
				</div>
				<button
					type="submit"
					class="w-full rounded-sm bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
					>Log In</button
				>
			</form>
		</div>

		<div class="mb-10 flex flex-col py-14 px-8 w-full">
			<p class="text-2xl text-purple-600 font-mono">
				Create your own league and challenge your friends!
			</p>
			<form
				class="my-6 flex flex-col justify-center"
				on:submit|preventDefault={handleCreateAccount}
			>
				<button
					type="submit"
					class="w-full rounded bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
					>Create an Account</button
				>
			</form>
		</div>
	</div>
</div>
