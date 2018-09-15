import React, { PureComponent } from 'react';
import {
    Alert,
    NativeModules,
    StyleSheet,
    View,
} from 'react-native';

import {
    HomeRow
} from '../components';

const {
    RNInterestQQ
} = NativeModules;

export class QQShare extends PureComponent {
    shareText = () => {
        RNInterestQQ
            .shareText('hello', 0)
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    shareImage = () => {
        RNInterestQQ
            .shareImage('http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                'title', 'description', 0)
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    shareNews = () => {
        RNInterestQQ
            .shareNews('www.baidu.com',
                'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                'title', 'description', 0)
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    render() {
        return (
          <View style={QQShareStyles.container}>
            <HomeRow
              text="分享文本"
              onPress={this.shareText}
            />
            <HomeRow
              text="分享图片"
              onPress={this.shareImage}
            />
            <HomeRow
              text="分享新闻"
              onPress={this.shareNews}
            />
          </View>
        );
    }

    componentDidMount() {

    }

    componentWillUnmount() {

    }
}

const QQShareStyles = StyleSheet.create({
    container: {
        flex: 1,
    },
});
