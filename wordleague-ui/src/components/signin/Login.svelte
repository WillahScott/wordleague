<script>
    import { fly } from 'svelte/transition';
	import { supabase } from '@lib/supabase';
	// import AppleSignIn from '@components/signin/AppleSignin.svelte';
	// import GoogleSignIn from '@components/signin/GoogleSignin.svelte';

	let email;
	let password;
    let signinError = '';

	const handleEmailLogin = async () => {  
		signinError = '';
		if (!email || !password) {
			signinError = 'Please provide your email and password';
			return;
		}
		try {
			const { user, session, error } = await supabase.auth.signIn({
				email: email,
				password: password
			});
			if (error) throw error;
		} catch (error) {
			signinError = error.error_description || error.message;
			console.error(error.error_description || error.message);
		}
	};
</script>

<div
class="relative flex flex-col py-4 md:py-8 px-6 w-full border-2 border-purple-700 rounded-3xl"
>
<p
    class="text-xl text-purple-700 font-mono self-center absolute -top-3.5 bg-[#2E294E] px-4 rounded-md uppercase"
>
    Sign In
</p>
<!-- <div
    class="mt-5 self-center max-w-2xl w-full flex flex-col md:flex-row justify-between items-center"
>
    <GoogleSignIn width={'50px'} height={'50px'} />
    <AppleSignIn width={'50px'} height={'50px'} />
</div> -->
<form
    class="my-6 flex flex-col justify-center md:max-w-xl md:w-full md:self-center"
    on:submit|preventDefault={handleEmailLogin}
>
    <div class="flex flex-col text-sm mb-1">
        <input
            type="email"
            name="email"
            id="email"
            bind:value={email}
            on:focus={() => (signinError = '')}
            placeholder="Your email"
            class=" text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
        />
        <input
            type="password"
            name="password"
            id="password"
            bind:value={password}
            on:focus={() => (signinError = '')}
            placeholder="Password"
            class="mt-1 text-purple-900 font-mono text-lg rounded-sm bg-purple-200 hover:ring-purple-500 focus:ring-purple-500"
        />
    </div>
    <button
        type="submit"
        class="w-full rounded-sm bg-purple-500 text-purple-900 text-xl uppercase font-mono font-bold py-2 px-10"
        >Sign In</button
    >
</form>
{#if signinError}
    <div
        class="md:max-w-2xl md:self-center w-full flex flex-col items-center"
        in:fly={{ y: -100, duration: 500 }}
    >
        <p class="text-red-800 font-mono text-lg text-center">{signinError}</p>
    </div>
{/if}
</div>