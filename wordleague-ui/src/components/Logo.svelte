<script>
	export let isLarge = false;

	$: textClasses = isLarge ? 'text-4xl md:text-6xl' : 'text-2xl md:text-4xl';
</script>

<div class="inline">
	<h1
		class={`inline font-sans font-bold md:font-semibold text-center mb-4 px-1 py-0 m-0 border border-purple-900 bg-purple-700 text-purple-200 ${textClasses}`}
	>
		WordLeague
	</h1>
</div>
