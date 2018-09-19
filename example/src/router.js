import { createStackNavigator } from 'react-navigation';

import Home from './page/Home';
import { QQShare } from './page/QQShare';


export default createStackNavigator({
        Home: {
            screen: Home
        },
        QQShare: {
            screen: QQShare
        }
    });
