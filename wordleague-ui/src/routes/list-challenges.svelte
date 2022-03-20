<script>
	import { challengeList } from '$lib/stores/challengeList';
</script>

<div class="py-10 relative h-screen flex flex-col items-center pt-20 md:pt-10 md:justify-center">
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
							<div class="flex-grow flex flex-col p-2 my-5 pl-8 sm:pl-2 sm:flex-row justify-between bg-purple-300 border-2 border-purple-800 text-purple-900 rounded-md">
								<div class="text-xl font-mono flex items-center">
									<span class="italic text-sm font-serif mr-2">by:</span> {challenge.creator}
								</div>
								<div class="text-base font-mono flex items-center">&#x1F3C6; {challenge.league}</div>
							</div>
	
						</div>
					</a>
				{/each}
			{/await}
		</div>
	</div>
</div>
