/**
 * Created by iwangx on 2018/8/27.
 */

import React, { PureComponent } from 'react';

import PropTypes from 'prop-types';

import {
    View,
    NativeModules,
    Alert,
    Text
} from 'react-native';
import {
    HomeRow
} from '../components';

// import * as RNInterestQQ from 'react-native-interest-qq';
const {
    RNInterestQQ
} = NativeModules;


class Home extends PureComponent {
    constructor(props) {
        super(props);
    }

    static propTypes = {};

    static defaultProps = {};

    componentDidMount() {

    }

    checkClientInstalled = () => {
        RNInterestQQ
            .checkClientInstalled()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    login = () => {
        RNInterestQQ
            .login()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            }).catch((e) => {
                Alert.alert(JSON.stringify(e));
        });
    };

    loginOut = () => {
        RNInterestQQ
            .loginout()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            }).catch((e) => {
            Alert.alert(JSON.stringify(e));
        });
    };


    shareToQQ = () => {
        RNInterestQQ.shareToQQ(
            '这里是分享标题',
            'desc',
            'http://text/plain',
            '',
            'appname'
        ).catch((e) => {
            console.log(e);
        });
    };

    viewCachedToken = () => {
        RNInterestQQ
            .viewCachedToken()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    deleteCachedToken = () => {
        RNInterestQQ
            .deleteCachedToken()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    pushToQQ = () => {
        this.props.navigation.navigate('QQShare');
    };

    getUserInfo = () => {
        RNInterestQQ
            .getUserInfo()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    }

    render() {
        const {
            props,
            state
        } = this;

        return (
          <View style={{ paddingTop: 20 }}>
            <Text>登录相关</Text>
            <HomeRow
              text="checkClientInstalled"
              onPress={this.checkClientInstalled}
            />
            <HomeRow
              text="Login"
              onPress={this.login}
            />
            <HomeRow
              text="LoginOut"
              onPress={this.loginOut}
            />
            <HomeRow
              text="shareToQQ"
              onPress={this.shareToQQ}
            />

            <Text>Token相关</Text>
            <HomeRow
              text="查看缓存Token"
              onPress={this.viewCachedToken}
            />
            <HomeRow
              text="删除缓存Token"
              onPress={this.deleteCachedToken}
            />
            <Text>API</Text>
            <HomeRow
              text="QQ、QQZone、Favorite"
              onPress={this.pushToQQ}
            />

            <HomeRow
              text="获取用户信息"
              onPress={this.getUserInfo}
            />
          </View>
        );
    }
}

export default Home;
