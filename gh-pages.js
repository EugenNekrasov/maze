import { publish } from 'gh-pages';

publish(
 'build', // path to public directory
 {
  branch: 'gh-pages',
  repo: 'git@github.com:EugenNekrasov/maze.git', // Update to point to your repository
  // user: {
  //  name: 'Samuele de Tomasi', // update to use your name
  //  email: 'samuele@stranianelli.com' // Update to use your email
  // },
  dotfiles: true
  },
  () => {
   console.log('Deploy Complete!');
  }
);