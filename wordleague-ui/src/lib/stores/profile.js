import { writable } from 'svelte/store';
import { supabase } from '$lib/supabase';

function createProfile() {
	const { subscribe, set } = writable({});

	return {
		subscribe,
		load: async () => {
			const resp = await supabase
				.from('test_profiles')
				.select()
				.order('profile_id', { ascending: false });

			if (resp.data) {
				set(resp.data);
			}
		}
	};
}

export const profileStore = createProfile();
