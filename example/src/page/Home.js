/**
 * Created by iwangx on 2018/8/27.
 */

import React, {PureComponent} from "react"

import PropTypes from "prop-types"

import {
    View,
    NativeModules,
    Alert
} from "react-native"

import {
    HomeRow
} from "../components"

import * as RNInterestQQ from "react-native-interest-qq"

class Home extends PureComponent {
    constructor(props) {
        super(props);
    }

    static propTypes = {};

    static defaultProps = {};

    componentDidMount() {

    }

    login = ()=>{
        RNInterestQQ
            .login()
            .then(e=>{
                Alert.alert(JSON.stringify(e));
            }).catch(e=>{
                Alert.alert(JSON.stringify(e))
        });
    };

    loginOut = ()=>{
        RNInterestQQ
            .loginOut()
            .then(e=>{
                Alert.alert(JSON.stringify(e));
            }).catch(e=>{
            Alert.alert(JSON.stringify(e))
        });
    };


<<<<<<< HEAD
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
=======
    shareToQQ = ()=>{
        RNInterestQQ.shareToQQ(
            "这里是分享标题",
            "desc",
            "http://text/plain",
            "",
            "appname"
        ).catch(e=>{
            console.log(e);
        });
>>>>>>> 6eb56078c5be4ebfa22ac7846b54964de198a5da
    };

    render() {
        const {
            props,
            state
        } = this;

        return (
            <View>
                <HomeRow
                    text={"Login"}
                    onPress={this.login}
                />
                <HomeRow
                    text={"LoginOut"}
                    onPress={this.loginOut}
                />
                <HomeRow
                    text={"shareToQQ"}
                    onPress={this.shareToQQ}
                />
            </View>
        )
    }
}

export default Home