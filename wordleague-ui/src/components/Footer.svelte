<script>
	export let isUser = false;
	export const scrollToBottom = () => {
		footerRef.scrollIntoView({ behavior: 'smooth', block: 'end' });
	};
	let footerRef;
</script>

<div
	bind:this={footerRef}
	class="w-full py-4 border-t-2 md:border-0 border-t-purple-800 text-purple-800 font-mono text-center"
>
	{#if isUser}
		Thank you for being part of WordLeague!
	{:else}
		Thank you for visiting WordLeague!
	{/if}
</div>
