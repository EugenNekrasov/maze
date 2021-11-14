import preprocess from 'svelte-preprocess';
import adapter from '@sveltejs/adapter-static';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	preprocess: preprocess({}),
	kit: {
		target: 'body',
		paths: {
			base: '/maze',
		},
		adapter: adapter({
			pages: 'build',
			assets: 'build',
			fallback: null,
		}),
	}
};

export default config;
