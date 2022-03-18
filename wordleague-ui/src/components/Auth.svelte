<script>
	import { supabase } from '$lib/supabase';
	import Logo from './Logo.svelte';
	import AppleSignIn from './signin/AppleSignin.svelte';
	import GoogleSignIn from './signin/GoogleSignin.svelte';

	export let footerRef;
	let showSignUp = false;
	let email;
	let password;

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

	const initCreateAccount = () => {
		footerRef.scrollIntoView({ behavior: 'smooth', block: 'end' });
	};

	const handleCreateAccount = async () => {};
</script>

<div class="py-10 relative min-h-screen flex flex-col items-center md:justify-center">
	<h1 class="text-center text-4xl md:text-6xl font-bold text-purple-800 mb-14">
		Welcome to <Logo />
	</h1>

	<div class="flex-grow flex flex-col items-center text-2xl text-purple-900">
		<div class="flex flex-col items-center justify-around pt-2 pb-2 px-8 ">
			<p class="text-2xl font-mono text-pink-400 mb-4">
				Create your own word-guessing league and challenge your friends!
			</p>
		</div>
		<div class="flex flex-col py-16 px-8 w-full">
			<p class="text-2xl text-purple-600 font-mono">Returning users</p>
			<div
				class="mt-5 self-center max-w-2xl w-full flex flex-col md:flex-row justify-between items-center"
			>
				<GoogleSignIn width={'50px'} height={'50px'} />
				<AppleSignIn width={'50px'} height={'50px'} />
			</div>
			<form class="my-6 flex flex-col justify-center" on:submit|preventDefault={handleLogin}>
				<div class="flex flex-col md:flex-row text-sm mb-2">
					<input
						type="email"
						name="email"
						id="email"
						bind:value={email}
						placeholder="Your email"
						class="md:mr-1 md:flex-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					/>
					<input
						type="password"
						name="password"
						id="password"
						bind:value={password}
						placeholder="Password"
						class="mt-1 md:mt-0 md:ml-1 md:flex-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					/>
				</div>
				<button
					type="submit"
					class="w-full rounded-sm bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
					>Sign In</button
				>
			</form>
		</div>

		<div class="mb-10 flex flex-col py-2 px-8 w-full">
			<p class="text-2xl text-purple-600 font-mono">New users</p>
			<form
				class="my-6 flex flex-col justify-center"
				on:submit|preventDefault={handleCreateAccount}
			>
				{#if !showSignUp}
					<button
						on:click={() => (showSignUp = true)}
						class="w-full rounded bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
						>Create an Account</button
					>
				{:else}
					<div class="flex flex-col w-full pb-4">
						<p class="mb-2 text-base md:text-lg text-pink-400 font-mono">
							You can choose to simply sign up using one of the following providers...
						</p>
						<div
							class=" self-center max-w-2xl w-full py-3 flex flex-col md:flex-row justify-between items-center"
						>
							<GoogleSignIn width={'50px'} height={'50px'} signup />
							<AppleSignIn width={'50px'} height={'50px'} signup />
						</div>
						<div class="flex flex-col mt-4">
							<p class="my-2 text-base md:text-lg text-pink-400 font-mono">
								...or simply create an account with an email & password:
							</p>

							<div class="flex flex-col md:flex-row text-sm mb-2 mt-2">
								<input
									type="email"
									name="email"
									id="email"
									bind:value={email}
									placeholder="Your email"
									class="md:mr-1 md:flex-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
								/>
								<input
									type="password"
									name="password"
									id="password"
									bind:value={password}
									placeholder="Password"
									class="mt-1 md:mt-0 md:ml-1 md:flex-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
								/>
							</div>
							<button
								use:initCreateAccount
								type="submit"
								class="w-full rounded-sm bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
								>Sign Up with my email</button
							>
						</div>
					</div>
				{/if}
			</form>
		</div>
	</div>
</div>
