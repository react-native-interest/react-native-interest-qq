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
            .shareText('hello', RNInterestQQ.Favorite)
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
                'title', 'description', RNInterestQQ.Favorite)
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
                'title', 'description', RNInterestQQ.Favorite)
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };


    shareAudio = () => {
        RNInterestQQ
            .shareAudio('www.baidu.com', 'http://ra01.sycdn.kuwo.cn/resource/n3/32/56/3260586875.mp3',
                'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                'title', 'description', RNInterestQQ.Favorite)
            .then((e) => {
                Alert.alert(JSON.stringify(e));
            })
            .catch((e) => {
                Alert.alert(JSON.stringify(e));
            });
    };

    shareVideo = () => {
        RNInterestQQ
            .shareVideo('www.baidu.com', 'http://ra01.sycdn.kuwo.cn/resource/n3/32/56/3260586875.mp3',
                'http://e.hiphotos.baidu.com/image/pic/item/a1ec08fa513d2697e542494057fbb2fb4316d81e.jpg',
                'title', 'description', RNInterestQQ.Favorite)
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
            <HomeRow
              text="分享音频"
              onPress={this.shareAudio}
            />
            <HomeRow
              text="分享视频"
              onPress={this.shareVideo}
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
