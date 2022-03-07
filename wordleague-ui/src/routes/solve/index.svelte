<script>
	import Keyboard from './_keyboard.svelte';

	let solved = false;
	let showKeyboard = true;
	let easyMode = false;

	let solution = 'LOVES';
	let maxAttempts = 6;
	let pastAttempts = ['HEATS'];
	let candidate = '';

	let charsYay = new Set([]);
	let charsAlmost = new Set([]);
	let charsNope = new Set([]);

	function evalChar(pos, char) {
		if (char === solution[pos]) {
			charsYay.add(char);
			charsYay = charsYay;  // trigger reactivity
			return 'charYay';
		} else if (solution.indexOf(char) > -1) {
			charsAlmost.add(char);
			charsAlmost = charsAlmost;  // trigger reactivity
			return 'charAlmost';
		} else {
			charsNope.add(char);
			charsNope = charsNope;  // trigger reactivity
			return 'charNope';
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
				if (easyMode && charsNope.has(newChar)) {
					return;
				}
				candidate += newChar;
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

<div class="py-10 relative h-screen flex flex-col items-center md:justify-center">
	<a href="/">
		<h1
			class="text-center text-4xl font-bold mb-4 px-1 py-0 m-0 border-2 border-[#B43E8F] bg-[#14213D] "
		>
			<span class="text-[#B43E8F]">Word</span><span class="text-purple-300">League</span>
		</h1>
	</a>

	<h3 class="text-center text-2xl font-bold font-mono text-[#B43E8F] mb-4">Solve Challenges:</h3>

	<div id="solvingPad" class="bg-[#14213D] flex flex-col">
		<div id="attempts" class="p-3 font-sans font-extrabold">
			{#each pastAttempts as attempt, i}
				<div key={i} class="relative grid grid-cols-5 gap-3 mb-3">
					<p class="absolute h-full -left-10 font-serif text-slate-700 flex items-center">
						#{i + 1}
					</p>
					{#each attempt as char, c}
						<div
							class={`${evalChar(
								c,
								char
							)} border border-slate-800 text-center text-4xl uppercase font-bold w-14 h-14 flex justify-center items-center`}
						>
							{char}
						</div>
					{/each}
				</div>
			{/each}
			{#each Array(maxAttempts - pastAttempts.length) as _b, j}
				<div key={j} class="relative grid grid-cols-5 gap-3 mt-3 opacity-20">
					{#if !solved && j === 0}
						<p class="absolute h-full -left-10 font-serif text-slate-700 flex items-center">
							&rarr;
						</p>
					{/if}
					{#if !solved}
						{#each Array(solution.length) as char, c}
							<div
								class="bg-slate-600 border border-slate-800 text-center text-4xl uppercase font-bold w-14 h-14 flex justify-center items-center"
							>
								{''}
							</div>
						{/each}
					{/if}
				</div>
			{/each}
		</div>

		<div id="candidate" class="p-3 border-t border-t-slate-400 grid grid-cols-5 gap-3" class:solved>
			{#each candidate as c, ci}
				<div
					key={ci}
					class="bg-slate-600 border border-slate-800 text-slate-300 text-center text-4xl uppercase font-bold w-14 h-14 flex justify-center items-center"
				>
					{c}
				</div>
			{/each}
			{#each Array(solution.length - candidate.length) as k}
				<div
					key={k}
					class="bg-slate-600 border border-slate-800 text-center text-4xl uppercase font-bold w-14 h-14 flex justify-center items-center"
				>
					{' '}
				</div>
			{/each}
		</div>
	</div>
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
