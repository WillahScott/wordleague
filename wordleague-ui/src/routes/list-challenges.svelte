<script>
	import { challengeList } from '$lib/stores/challengeList';
</script>

<div class="py-10 relative h-screen flex flex-col items-center md:justify-center">
	<h3 class="text-center text-xl md:text-4xl font-bold font-mono text-purple-800">
		These are your challenges for today:
	</h3>

	<div class="py-8 px-4 w-full flex justify-center">
		<div class="w-full md:max-w-xl px-6 flex flex-col justify-center">
			{#await challengeList.load()}
				<p class="font-thin text-2xl text-purple-800 mt-8">...Loading challenges...</p>
			{:then _result}
				{#each $challengeList as challenge, i}
					<a href={`/solve?challenge=${challenge.id}`} key={challenge}>
						<div class="flex flex-row items-center">
							<div class="text-purple-300 font-serif mr-3">#{i + 1}</div>
							<div class="flex-grow flex flex-row justify-between bg-purple-300 border-2 border-purple-800 text-purple-900 font-serif rounded-md p-2 my-5">
								<div class="text-xl">
									<span class="italic text-sm">by:</span> {challenge.creator}
								</div>
								<div class="text-lg">&#x1F3C6; {challenge.league}</div>
							</div>
	
						</div>
					</a>
				{/each}
			{/await}
		</div>
	</div>
</div>
