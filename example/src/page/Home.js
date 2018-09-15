/**
 * Created by iwangx on 2018/8/27.
 */

import React, { PureComponent } from 'react';

import {
    View,
    NativeModules,
    Alert,
    Text
} from 'react-native';

import {
    HomeRow
} from '../components';
// import { QQShare } from './QQShare';

const {
    RNInterestQQ
} = NativeModules;

class Home extends PureComponent {
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
                // e为JSON串，可使用JSON.parse(e)解析
                Alert.alert(e);
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    loginOut = () => {
        RNInterestQQ
            .loginOut()
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
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

    pushToQQZone = () => {

    };

    shareToQQ = () => {
        // RNInterestQQ.shareToQQ(
        //     "这里是分享标题",
        //     "desc",
        //     "http://text/plain",
        //     "",
        //     "appname",
        //     0
        // ).catch(e=>{
        //     console.log(e);
        // });

        RNInterestQQ.shareText('123213123', 0);
    };

    render() {
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
              text="QQ"
              onPress={this.pushToQQ}
            />
            <HomeRow
              text="QQZone"
              onPress={this.pushToQQZone}
            />
          </View>
        );
    }
}

export default Home;
