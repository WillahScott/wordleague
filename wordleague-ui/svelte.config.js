import path from 'path';
import adapter from '@sveltejs/adapter-auto';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		adapter: adapter(),
		vite: {
			resolve: {
				alias: {
					'@components': path.resolve('./src/components'),
					'@lib': path.resolve('./src/lib'),
					'@stores': path.resolve('./src/lib/stores'),
				}
			}
		}
	}
};

export default config;
