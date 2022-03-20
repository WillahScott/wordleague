<script>
	import { fly } from 'svelte/transition';
    import { beforeNavigate } from '$app/navigation';
	import { userStore, logout } from '@lib/stores/auth';

	let isVisible = false;
    beforeNavigate(() => isVisible = false);
</script>

<div
	class={`flex flex-col items-center transition ease-in-out text-purple-800 text-xl font-mono ${isVisible ? 'py-5' : ''}`}
>
	{#if isVisible}
		<a
			href="/solve"
			class="my-2 px-5 py-1 bg-purple-300 rounded"
			transition:fly={{ y: -300, duration: 500 }}
		>
			Solve Today's Challenges
		</a>
		<a
			href="/list-challenges"
			class="my-2 px-5 py-1 bg-purple-300"
			transition:fly={{ y: -300, duration: 500 }}
		>
			View All Challenges
		</a>
		<a
			href="/set-challenges"
			class="my-2 px-5 py-1 bg-purple-300 rounded"
			transition:fly={{ y: -300, duration: 500 }}
		>
			Set Challenges for Others
		</a>
		<a
			href="/profile"
			class="my-2 px-5 py-1 bg-purple-300 rounded"
			transition:fly={{ y: -300, duration: 500 }}
		>
			My Profile
		</a>
		{#if userStore}
			<button
				class="my-2 px-5 py-1 bg-purple-300 rounded"
				on:click={logout}
				transition:fly={{ y: -300, duration: 500 }}>Log Out</button
			>
		{/if}
	{/if}
</div>
<div
	class={`absolute top-5 right-5 z-20 text-purple-400 hover:cursor-pointer`}
	on:click={() => {
		console.log('clicked!');
		isVisible = !isVisible;
	}}
>
	<svg
		xmlns="http://www.w3.org/2000/svg"
		class="h-12 w-12"
		fill="none"
		viewBox="0 0 24 24"
		stroke="currentColor"
		strokeWidth={5}
	>
		<path strokeLinecap="round" strokeLinejoin="round" d="M4 6h16M4 12h16M4 18h16" />
	</svg>
</div>
