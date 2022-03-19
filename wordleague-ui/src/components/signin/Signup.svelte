<script>
	import { fly } from 'svelte/transition';
	import { supabase } from '@lib/supabase';
	// import AppleSignIn from '@components/signin/AppleSignin.svelte';
	// import GoogleSignIn from '@components/signin/GoogleSignin.svelte';

    export let scrollToBottom;
	let email;
	let password;
	let signupError = '';

	const handleCreateEmailAccount = async () => {
		signupError = '';
		if (!email || !password) {
			signupError = 'Please provide your email & password';
			return;
		}
		try {
			const { error } = await supabase.auth.signUp(
				{
					email: email,
					password: password
				},
				{
					data: {
						username: username
						// potential info about league invites
					}
				}
			);
			if (error) throw error;
		} catch (error) {
			signupError = error.error_description || error.message;
			console.error(error.error_description || error.message);
		}
	};
</script>

<div class="relative flex flex-col py-8 px-6 w-full border-2 border-pink-400 rounded-3xl">
	<p
		class="text-xl text-pink-400 font-mono self-center absolute -top-3.5 bg-[#2E294E] px-4 rounded-md uppercase"
	>
		Create Account
	</p>
	<div class="flex flex-col items-center w-full pb-4">
		<!-- 
        <p class="mb-2 text-base md:text-lg text-pink-400 font-mono">
            You can choose to sign up using one of the following providers...
        </p>
        <div
            class=" self-center max-w-2xl w-full py-3 flex flex-col md:flex-row justify-between items-center"
        >
            <GoogleSignIn width={'50px'} height={'50px'} signup />
            <AppleSignIn width={'50px'} height={'50px'} signup />
        </div>
        <p class="mt-8 text-base md:text-lg text-pink-400 font-mono">
            ...or create an account with your username, email, and password:
        </p>
        -->
		<p class="mt-2 text-base md:text-lg text-pink-400 font-mono">
			Create an account with your email & password:
		</p>

		<form
			class="mt-2 flex flex-col justify-center md:max-w-xl md:w-full md:self-center"
			on:submit|preventDefault={handleCreateEmailAccount}
		>
			<div class="flex flex-col">
				<div class="flex flex-col text-sm mb-1 mt-2">
					<input
						type="email"
						name="email"
						id="email"
						bind:value={email}
						on:focus={() => (signupError = '')}
						placeholder="Your email"
						class="mt-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					/>
					<input
						type="password"
						name="password"
						id="password"
						bind:value={password}
						on:focus={() => (signupError = '')}
						placeholder="Password"
						class="mt-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					/>
				</div>
				<button
					use:scrollToBottom
					type="submit"
					class="w-full rounded-sm bg-pink-400 text-pink-900 text-xl uppercase font-mono font-bold py-2 px-10"
					>Sign Up with my email</button
				>
			</div>
		</form>
		{#if signupError}
			<div
				class="md:max-w-2xl md:self-center mt-5 w-full flex flex-col items-center"
				in:fly={{ y: -100, duration: 500 }}
			>
				<p class="text-red-800 font-mono text-lg text-center">{signupError}</p>
			</div>
		{/if}
	</div>
</div>
