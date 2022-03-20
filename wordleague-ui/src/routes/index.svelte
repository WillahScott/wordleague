<script>
	import { logout } from '@stores/auth';
</script>

<div class="py-10 relative h-screen flex flex-col items-center md:justify-center">
	<h1 class="text-center text-4xl md:text-6xl font-bold text-purple-800 mb-14">
		Welcome to <span class="border px-0.5 py-0 m-0 border-purple-900 bg-purple-700 text-purple-200"
			>WordLeague</span
		>
	</h1>

	<div
		class="flex flex-col items-center justify-around text-2xl text-purple-900 font-mono font-bold md:font-normal"
	>
		<p
			class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer"
		>
			<a href="/solve">Solve Today's Challenges</a>
		</p>
		<p
			class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer"
		>
			<a href="/list-challenges">View All Challenges</a>
		</p>
		<p
			class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer"
		>
			<a href="/set-challenges">Set Challenges for Others</a>
		</p>
		<!-- <p
			class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer"
		>
			<a href="/leagues">League Stats</a>
		</p> -->
		<p
			class="px-5 py-1 my-2 rounded-sm bg-pink-400 hover:bg-purple-700 hover:text-purple-200 hover:cursor-pointer"
		>
			<a href="/profile">My Profile</a>
		</p>
		<p
			on:click={logout}
			class="px-5 py-1 mt-10 rounded-sm text-pink-300 bg-purple-700 hover:bg-pink-400 hover:text-pink-700 hover:cursor-pointer"
		>
			Logout
		</p>
	</div>
</div>
