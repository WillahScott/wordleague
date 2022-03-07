<script>
	import { createEventDispatcher } from 'svelte';
	import LAYOUT from './_qwerty_english.json';

	const numRows = Math.max(...LAYOUT.map((c) => c.row), 0) + 1;

	const dispatch = createEventDispatcher();

	function dispatchKey(key) {
		dispatch('customKey', { char: key });
	}

	export let charsYay = new Set();
	export let charsAlmost = new Set();
	export let charsNope = new Set();
</script>

<div id="keyboard" class="md:max-w-4xl w-full h-full flex flex-col mt-6">
	{#each [...Array(numRows).keys()] as r}
		<div key={r} class="px-2 my-2 flex flex-row gap-3 h-12">
			{#each LAYOUT.filter((c) => c.row === r) as k}
				<div
					class="flex-1 rounded border border-slate-500 uppercase bg-slate-700 font-bold text-slate-400 flex justify-center items-center text-2xl"
					class:charYay={charsYay.has(k.char.toUpperCase())}
					class:charAlmost={charsAlmost.has(k.char.toUpperCase())}
					class:charNope={charsNope.has(k.char.toUpperCase())}
                    on:click={() => dispatchKey(k.char.toUpperCase())}
				>
					{k.char}
				</div>
			{/each}
		</div>
	{/each}
</div>

<style>
	.charYay {
		background-color: #1b998b;
		color: #fff;
	}
	.charYay.charAlmost {
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
        opacity: 0.2;
	}
</style>
