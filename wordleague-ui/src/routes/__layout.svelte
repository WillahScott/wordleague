<script context="module">
	export async function load({ url }) {
		console.log(url.pathname);
		if (url.pathname === '/something') {
			console.log('yeah!');
		}
		return { props: { path: url.pathname } };
	}
</script>

<script>
	import { supabase } from '@lib/supabase';
	import { user } from '@lib/stores/auth';
	import Auth from '@components/Auth.svelte';
	import Nav from '@components/Nav.svelte';
	import Footer from '@components/Footer.svelte';
	import '../app.css';

	export let path;
	let scrollToBottom = null;

	user.set(supabase.auth.user());

	supabase.auth.onAuthStateChange((event, session) => {
		console.log('session');
		console.log(session);
		if (event === 'SIGNED_IN') {
			user.set(session.user);
			console.log(`Logged in user: ${session.user.email}`);
		} else if (event === 'SIGNED_OUT') {
			user.set(null);
			console.log(`No user`);
		} else {
			console.log('unknown auth state change', event);
		}
		// user.set(session?.user);
		// if (session?.user) {
		// 	// DO STUFF
		// 	console.log(`Logged in user: ${session.user.email}`);
		// } else {
		// 	console.log(`No user`);
		// }
	});
</script>

{#if $user}
	<div>
		{#if path !== '/'}
			<Nav />
		{/if}
		<slot />
		<Footer bind:scrollToBottom isUser={true} />
	</div>
{:else}
	<Auth {scrollToBottom} />
	<Footer bind:scrollToBottom isUser={false} />
{/if}
