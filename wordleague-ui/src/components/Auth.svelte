<script>
	import { supabase } from '$lib/supabase';
    import Logo from "./Logo.svelte";

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

	<div class="flex-grow flex flex-col items-center justify-between text-2xl text-purple-900">
		<div class="flex flex-col items-center justify-around pt-2 pb-2 px-8 ">
			<p class="text-center text-3xl font-mono text-purple-600 mb-8">Public League</p>
			<p
				class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer font-mono font-bold md:font-normal"
			>
				<a href="/solve">Solve A Random Challenge</a>
			</p>
			<p class="italic text-pink-400 text-lg font-mono">
				<span class="font-serif">*</span> from the public league
			</p>
		</div>
		<div class="mt-10 flex flex-col pt-10 px-8 border-t border-t-purple-400 w-full">
			<p class="text-center text-3xl font-mono text-purple-600">Returning users</p>
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

		<div class="mt-10 flex flex-col pt-10 px-8 border-t border-t-purple-400 w-full">
			<p class="text-center text-3xl font-mono text-purple-600 mb-5">New users</p>
			<p class="text-xl font-bold text-purple-600 font-mono">
				Create your own league and challenge your friends!
			</p>
			<form class="my-6 flex flex-col justify-center" on:submit|preventDefault={handleCreateAccount}>
				<button
					type="submit"
					class="w-full rounded bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
					>Create an Account</button
				>
			</form>
		</div>
	</div>
</div>
