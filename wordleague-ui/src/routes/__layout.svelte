<script>
	import { supabase } from '$lib/supabase';
	import Auth from '../components/Auth.svelte';
	import Logo from '../components/Logo.svelte';
	import { user } from '$lib/stores/auth';

	import '../app.css';

	user.set(supabase.auth.user());

	supabase.auth.onAuthStateChange((_, session) => {
		user.set(session?.user);
		if (session?.user) {
			// DO STUFF
		}
	});

	const logout = () => {
		console.log('logount');
		supabase.auth.signOut();
	};
</script>

{#if $user}
	<div>
		<Logo />
		<h1>Welcome {user}</h1>
		<button on:click={logout}>Log Out</button>
		<slot />
	</div>
{:else}
	<Auth />
{/if}
