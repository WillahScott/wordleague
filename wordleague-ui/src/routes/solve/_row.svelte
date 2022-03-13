<script>
    export let numCols;
    export let word = "";
    export let feedback = [];
	export let index = null;
    export let isCandidate = false;
</script>

<div class="relative flex flex-row">
	{#if index}
		<div class="absolute h-full -left-10 -top-2 font-serif text-slate-700 flex items-center text-xl">
			{index}
		</div>
	{/if}
	<div class={`flex-grow grid gap-2 md:gap-3 mb-2 md:mb-3`} style={`grid-template-columns: repeat(${numCols}, 1fr);`}>
		{#each Array(numCols) as _c, c}
			<div
				class="col-span-1 border-2 border-slate-700 text-center text-4xl uppercase font-bold w-14 h-14 flex justify-center items-center"
                class:charYay={feedback[c] === 'Y'}
                class:charAlmost={feedback[c] === 'A'}
                class:charNope={feedback[c] === 'N'}
                class:candidate={isCandidate}
			>
				{word[c] || ""}
			</div>
		{/each}
	</div>
</div>



<style>
	.charYay {
		background-color: #1b998b;
		color: #fff;
	}
	.charAlmost {
		background-color: #f46036;
		color: #fff;
	}
	.charNope {
		background-color: #333;
		color: #999;
	}
    .candidate {
        border: none;
        background-color: #475569; /* bg-slate-600 */
        color: #CBD5E1; /* text-slate-300 */
    }
</style>