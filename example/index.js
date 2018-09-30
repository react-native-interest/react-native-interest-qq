import { AppRegistry } from 'react-native';
import router from './src/router';
console.ignoredYellowBox = [ 'Warning: isMounted(...)', 'Require cycle: app/utils'];

AppRegistry.registerComponent('example', () => router);
