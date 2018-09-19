/**
 * Created by iwangx on 2018/8/27.
 */

import React, { PureComponent } from 'react';

import {
	View,
	NativeModules,
	Alert,
	Text,
	Platform
} from 'react-native';

import {
	HomeRow
} from '../components';
// import { QQShare } from './QQShare';

const {
	RNInterestQQ
} = NativeModules;


const IOS = Platform.OS === 'ios';
const ANDROID = Platform.OS === 'android';


/**
 * 安卓与iOS命名方式不同点
 *
 * 登录： 安卓: ssoLogin iOS: login
 * 退出： 安卓: logout   iOS: loginOut
 *
 *
 *
 */

class Home extends PureComponent {
	static propTypes = {};

	static defaultProps = {};

	componentDidMount() {
		console.log('RNInterestQQ', RNInterestQQ);
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

		ANDROID
			?
			RNInterestQQ
			.ssoLogin()
			.then((data) => {
				console.log('data', data);

				/**
				 * 安卓返回数据
				 * access_token: "417AB3F5BD556403F9FD395E14A5B647"
				 * expires_in: "7776000"
				 * msg: ""
				 * openid: "2CC1AB2C080DF5C3D92C7FA8F676A60C"
				 * pay_token: "7774AD0460D094238C30161E1DDBBA05"
				 * pf: "desktop_m_qq-10000144-android-2002-"
				 * pfkey: "a111b41af3fb8be08abb28e247666904"
				 */
				})
			.catch((error) => {
				console.log('error', error);
			})
		:
			RNInterestQQ
				.login()
				.then((data) => {
					console.log('data', data);

					/**
					 * iOS返回数据
					 * {
					 * "passData":
					 *  {
					 *    "pf":
					 *    "openmobile_ios",
					 *    "pfkey":"68a8ba37235f38e8b06d63ab67b61c1a",
					 *    "passDataResp":[],
					 *    "pay_token":"122533ED42540C8588A0EBA01AB6042D",
					 *    "msg":"",
					 *    "user_cancelled":"NO",
					 *    "ret":0
					 *  },
					 *    "openid":"0A3D61B1224D28CDD88E4D62499B06E3",
					 *    "clientToken":"135EAD29631A4B059A8A9F20D3477480"
					 * }
					 */


				})
				.catch((error) => {
					console.log('error', error);
				});
	};

	loginOut = () => {
		RNInterestQQ
		// .logout()
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
		RNInterestQQ.shareToQQ(
		    "这里是分享标题",
		    "desc",
		    "http://text/plain",
		    "",
		    "appname",
		).catch(e=>{
		    console.log(e);
		});


		// let qqshareInfo={
		// 	url: 'hahaha',
		// 	title: '测试',
		// 	description: '测试介绍',
		// 	shareScene: 0,
		// 	image: 'https://sta-op.douyucdn.cn/dypart/2018/09/06/6e0620cfc2835e61dbeff6aeba195001.jpg',
		// }

		// RNInterestQQ.shareNews(...qqshareInfo);

		// RNInterestQQ.shareText('123213123', 0);
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
					text="QQ、QQZone、Favorite"
					onPress={this.pushToQQ}
				/>
			</View>
		);
	}
}

export default Home;
