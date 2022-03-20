import { writable } from "svelte/store";
import { supabase } from '@lib/supabase';

export const logout = () => {
    supabase.auth.signOut();
};

export const userStore = writable(null);