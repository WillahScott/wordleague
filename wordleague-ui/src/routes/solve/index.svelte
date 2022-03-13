<script>
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { challenge } from '$lib/stores/challenge';

	import Row from './_row.svelte';
	import Keyboard from './_keyboard.svelte';
	let challengeID = $page.url.searchParams.get('challenge');

	const ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	let solved = false;
	let showKeyboard = true;
	let easyMode = false;

	let maxAttempts = 6;
	let candidate = '';
	let charsYay = new Set([]);
	let charsAlmost = new Set([]);
	let charsNope = new Set([]);

	let loading = true;
	let solution = 'LOVES';
	let pastAttempts = [];

	onMount(async () => {
		if (challengeID) {
			console.log(`Loading challenge #: ${challengeID}`);
			await challenge.load(challengeID);
		} else {
			console.log(`Loading random challenge`);
			await challenge.loadRandom();
		}
		solution = $challenge.word;
		loading = false;

		charsYay = new Set([]);
		charsAlmost = new Set([]);
		charsNope = new Set([]);
	});

	function evalChar(pos, char) {
		if (char === solution[pos]) {
			charsYay.add(char);
			charsYay = charsYay; // trigger reactivity
			return 'Y';
		} else if (solution.indexOf(char) > -1) {
			charsAlmost.add(char);
			charsAlmost = charsAlmost; // trigger reactivity
			return 'A';
		} else {
			charsNope.add(char);
			charsNope = charsNope; // trigger reactivity
			return 'N';
		}
	}

	function updateCandidate(newChar) {
		if (solved) {
			console.log('dude, you got it already!');
			return;
		}

		if (['ENTER', 'GO'].indexOf(newChar) > -1) {
			// handle submit
			if (candidate.length === solution.length) {
				pastAttempts = [...pastAttempts, candidate.toUpperCase()];
				if (solution.toUpperCase() === candidate.toUpperCase()) {
					solved = true;
				}
				candidate = '';
			}
		} else if (['BACKSPACE', 'DEL'].indexOf(newChar) > -1) {
			// handle delete
			candidate = candidate.slice(0, -1);
		} else {
			if (candidate.length < solution.length) {
				if (ALPHABET.indexOf(newChar) > -1) {
					if (easyMode && charsNope.has(newChar)) {
						return;
					}
					candidate += newChar;
				}
			}
		}
	}

	function handleKeydown(event) {
		updateCandidate(event.key.toUpperCase());
	}
	function handleCustomKeydown(event) {
		updateCandidate(event.detail.char);
	}
</script>

<svelte:window on:keydown={handleKeydown} />

<div class="py-10 relative min-h-screen flex flex-col items-center md:justify-center">
	<a href="/">
		<h1
			class="text-center text-4xl font-bold mb-4 px-1 py-0 m-0 border-2 border-[#B43E8F] bg-[#14213D] "
		>
			<span class="text-[#B43E8F]">Word</span><span class="text-purple-300">League</span>
		</h1>
	</a>

	<h3 class="text-center text-2xl font-bold font-mono text-[#B43E8F] mb-4">Solve Challenges:</h3>

	{#if challengeID}
		<h4 class="text-center text-sm font-bold font-serif text-[#B43E8F] mb-4">
			Challenge ID: {challengeID}
		</h4>
	{/if}

	{#if loading}
		<p>Loading challenge...</p>
	{:else}
		<div id="solvingPad" class="bg-[#14213D] flex flex-col mt-6">
			<div id="attempts" class="p-3 font-sans font-extrabold">
				{#each pastAttempts as attempt, i}
					<Row
						index={i + 1}
						word={attempt}
						feedback={attempt.split("").map((c, i) => evalChar(i, c))}
						numCols={solution.length}
					/>
				{/each}
				{#each Array(maxAttempts - pastAttempts.length) as _b, j}
					{#if !solved && j === 0}
						<Row index="&rarr" numCols={solution.length} />
					{:else}
						<Row numCols={solution.length} />
					{/if}
				{/each}
			</div>

			<div
				id="candidate"
				class={`p-3 border-t border-t-slate-400 grid grid-cols-w${solution.length} gap-3`}
				class:solved
			>
				<Row numCols={solution.length} word={candidate} isCandidate={true} />
			</div>
		</div>
	{/if}

	{#if !solved && showKeyboard}
		<Keyboard
			on:keydown={handleKeydown}
			on:customKey={handleCustomKeydown}
			{charsYay}
			{charsAlmost}
			{charsNope}
		/>
	{/if}
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
	.solved {
		display: none;
	}
</style>
