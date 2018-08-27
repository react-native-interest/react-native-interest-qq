import React from 'react';
import { View, Text } from 'react-native';

import { createStackNavigator } from 'react-navigation';

import Home from "./page/Home"


export default createStackNavigator({
        Home: {
            screen: Home
        },
    },
    {
        headerMode: 'none'
    });