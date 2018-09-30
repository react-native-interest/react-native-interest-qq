import { createStackNavigator, createBottomTabNavigator } from 'react-navigation';

import Home from './page/Home';
import { QQShare } from './page/QQShare';


export default createBottomTabNavigator({
	Home: {
		screen: Home
	},
	QQShare: {
		screen: QQShare
	},

});
