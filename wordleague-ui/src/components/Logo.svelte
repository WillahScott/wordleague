<script>
	export let isLarge = false;

	$: textClasses = isLarge ? 'text-4xl md:text-6xl' : 'text-2xl md:text-4xl';
</script>

<div>
	<h1
		class={`inline text-center font-bold mb-4 px-1 py-0 m-0 border-2 border-[#B43E8F] bg-[#14213D] ${textClasses}`}
	>
		<span class="text-[#B43E8F]">Word</span><span class="text-purple-300">League</span>
	</h1>
</div>
