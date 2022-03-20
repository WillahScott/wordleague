<script>
	import { userStore, logout } from '@lib/stores/auth';
	import Logo from '@components/Logo.svelte';

	$: name = $userStore.user_metadata.username || $userStore.email;
</script>

<div class="w-full py-2 flex flex-row justify-center">
	<a href="/">
		<Logo />
	</a>
	{#if userStore}
		<div
			class="bg-pink-400 text-purple-800 rounded-full mx-8 px-3 flex justify-center items-center hover:cursor-pointer"
		>
			<span class="text-xl font-bold font-mono lowercase">{name}</span>
		</div>
		<button on:click={logout}>Log Out</button>
	{/if}
</div>
