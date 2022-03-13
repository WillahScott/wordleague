<script>
	import { onMount } from 'svelte';
	import confetti from 'canvas-confetti';
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
	let solution = '';
	let pastAttempts = [];

	onMount(async () => {
		if (challengeID) {
			console.log(`Loading challenge #: ${challengeID}`);
			await challenge.load(challengeID);
		} else {
			console.log(`Loading random challenge`);
			await challenge.loadRandom();
		}
		solution = $challenge.word.toUpperCase();
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
					confetti({
						particleCount: 25,
						spread: 26,
						startVelocity: 55,
						origin: { y: 0.6 },
						disableForReducedMotion: true,
						colors: ["#D8B4FE", "#B43E8F", "#14213D"],
					});
					confetti({
						particleCount: 20,
						spread: 60,
						origin: { y: 0.6 },
						disableForReducedMotion: true,
						colors: ["#D8B4FE", "#B43E8F", "#14213D"],
					});
					confetti({
						particleCount: 35,
						spread: 100,
						decay: 0.91,
						scalar: 0.8,
						origin: { y: 0.6 },
						disableForReducedMotion: true,
						colors: ["#D8B4FE", "#B43E8F", "#14213D"],
					});

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

<div class="py-10 relative min-h-screen flex flex-col items-center">
	<a href="/">
		<h1
			class="text-center text-4xl font-bold mb-4 px-1 py-0 m-0 border-2 border-[#B43E8F] bg-[#14213D] "
		>
			<span class="text-[#B43E8F]">Word</span><span class="text-purple-300">League</span>
		</h1>
	</a>

	{#if loading}
		<p class="text-[#B43E8F] text-2xl font-serif py-20">Loading challenge...</p>
	{:else}
		<div id="solvingPad" class="bg-[#14213D] flex flex-col mt-6">
			<div id="attempts" class="p-3 font-sans font-extrabold">
				{#each pastAttempts as attempt, i}
					<Row
						index={i + 1}
						word={attempt}
						feedback={attempt.split('').map((c, i) => evalChar(i, c))}
						numCols={solution.length}
					/>
				{/each}
				{#each Array(maxAttempts - pastAttempts.length) as _b, j}
					{#if !solved && j === 0}
						<Row index="&rarr" numCols={solution.length} />
					{:else if !solved}
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
