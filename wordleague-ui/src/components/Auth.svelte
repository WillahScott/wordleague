<script>
	import Logo from '@components/Logo.svelte';
	import Login from '@components/signin/Login.svelte';
	import Signup from '@components/signin/Signup.svelte';

	export let scrollToBottom;
	let showSignUp = false;
</script>

<div class="py-10 relative min-h-screen flex flex-col items-center md:justify-center">
	<h1 class="text-center text-4xl md:text-6xl font-bold text-purple-800 mb-14">
		Welcome to <Logo isLarge={true} />
	</h1>

	<div class="flex-grow flex flex-col items-center text-2xl text-purple-900">
		<div class="flex flex-col items-center justify-around pt-2 pb-2 px-8 ">
			<p class="text-2xl font-mono text-pink-400 mb-4">
				Create your own word-guessing league and challenge your friends!
			</p>
		</div>
		<div class="flex flex-col my-16 px-8 w-full">
			<Login />
		</div>

		{#if !showSignUp}
			<div class="w-full px-8 flex flex-col items-center">
				<p class="text-2xl text-pink-400 font-mono self-center">... new user?</p>
				<button
					on:click={() => (showSignUp = true)}
					class="w-full rounded bg-pink-400 text-pink-900 text-xl uppercase font-mono font-bold py-2 px-10 my-6"
					>Create an Account</button
				>
			</div>
		{:else}
			<div class="flex flex-col my-16 px-8 w-full">
				<Signup {scrollToBottom} />
			</div>
		{/if}
	</div>
</div>
