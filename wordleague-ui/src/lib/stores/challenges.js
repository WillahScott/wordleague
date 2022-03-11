import { writable } from 'svelte/store';
import { supabase } from '$lib/supabase';

function createChallengeList() {
	const { subscribe, set } = writable([]);

	return {
		subscribe,
		load: async () => {
			const resp = await supabase
				.from('test_challenges')
				.select()
				.order('challenge_date', { ascending: false });
			set(resp.data);
		}
	};
}

export const challengeList = createChallengeList();
