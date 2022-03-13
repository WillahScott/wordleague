// Resource:
// https://www.reddit.com/r/sveltejs/comments/mor0qd/comment/guc4nnh/?utm_source=share&utm_medium=web2x&context=3


import state from '$lib/state'; // stores related to app state, auth state

let auth = { ...state.initialAuthState };
state.auth.subscribe(authState => auth = authState);

const authGuard = async ({ page }) => {
  const loggedIn = auth.loggedIn;

  if (loggedIn && page.path === '/login') {
    return { status: 302, redirect: '/' };
  } else if (loggedIn || page.path === '/login') {
    return {};
  } else {
    return { status: 302, redirect: '/login' }
  }
};

export default authGuard;
