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
	let scrollToBottom;

	user.set(supabase.auth.user());

	supabase.auth.onAuthStateChange((_, session) => {
		user.set(session?.user);
		if (session?.user) {
			// DO STUFF
		}
	});
</script>

{#if $user}
	<div>
		{#if path !== '/'}
			<Nav />
		{/if}
		<slot />
		<Footer {scrollToBottom} isUser={true} />
	</div>
{:else}
	<Auth {scrollToBottom} />
	<Footer bind:scrollToBottom isUser={false} />
{/if}
