import { writable } from 'svelte/store';
import { supabase } from '$lib/supabase';

function createChallenge() {
	const { subscribe, set } = writable({});

	return {
		subscribe,
		load: async (id) => {
			const resp = await supabase
				.from('test_challenges')
				.select()
                .eq('id', id);

            // TODO: verify only one result
			set(resp.data[0]);
		}
	};
}

export const challenge = createChallenge();
