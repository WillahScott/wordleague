<script>
	import { profileStore } from '@stores/profile';
	import { userStore } from '@lib/stores/auth';
</script>

<div class="py-10 relative h-screen flex flex-col items-center md:justify-center">
	<h3 class="text-center text-2xl md:text-4xl font-bold font-mono text-purple-800">My Profile</h3>

	<div class="flex flex-col my-10">
		{#if Object.keys($profileStore).length === 0}
			<h3 class="text-2xl font-mono my-5 text-purple-400">Welcome new user!!</h3>
		{/if}
		<form action="">
			<div class="flex flex-row justify-end items-center my-3">
				<label class="mr-3 text-xl font-mono text-purple-800" for="email">Email</label>
				<input
					class="w-96 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					type="email"
					name="email"
					id="email"
					value={$userStore.email}
					disabled
				/>
			</div>
			<div class="flex flex-row justify-end items-center my-3">
				<label class="mr-3 text-xl font-mono text-purple-800" for="username">Username</label>
				<input
					class="w-96 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
					type="text"
					name="username"
					id="username"
				/>
			</div>
		</form>
		<p class="text-xl font-mono my-5 text-purple-600">
			Check back for new goodies and updates soon...
		</p>
	</div>
</div>
