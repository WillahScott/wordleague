<script context="module">
	export async function load({ url }) {
		return { props: { path: url.pathname } };
	}
</script>

<script>
	import { supabase } from '@lib/supabase';
	import { userStore } from '@lib/stores/auth';
	import Auth from '@components/Auth.svelte';
	import Nav from '@components/Nav.svelte';
	import Footer from '@components/Footer.svelte';
	import '../app.css';

	export let path;
	let scrollToBottom = null;

	userStore.set(supabase.auth.user());

	supabase.auth.onAuthStateChange((event, session) => {
		console.log('session');
		console.log(session);

		if (session?.user) {
			userStore.set(session.user);
		} else {
			userStore.set(null);
		}

		if (event === 'SIGNED_IN') {
			console.log(`Logged in user: ${session.user.email}`);
		} else if (event === 'SIGNED_OUT') {
			console.log(`No user`);
		} else {
			console.log('unknown auth state change', event);
		}
	});
</script>

{#if $userStore}
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
