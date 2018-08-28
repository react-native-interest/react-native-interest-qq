# react-native-interest-qq

## 本项目由react-native兴趣交流群开源并维护

### 欢迎加入react-native兴趣交流群：397885169。
### 想加入并共同维护该项目，欢迎加入RN开源项目维护群：831849780

## 提交代码的要求:
  1. 请严格按照eslint检查并提交代码。
  2. 请对每行代码添加flow强类型检查。
  3. 在提交代码时，请使用中文将更新内容书写清楚。
  4. 在提交代码时，请标明每一点（在1. 后面添加空格)。
  5. 待定。

## 根据官方Demo总结的功能列表
| 功能                     | iOS  | Android | React-Naitve中方法名 |
| :----------------------- | :--: | :--: | ------------ |
| 是否安装QQ | ✅ |    ✅   | checkClientInstalled |
| 第三方登录               | ✅ |     ✅     | login |
| 第三方扫码登录           | ✅ |    ❌    | loginWithQRlogin |
| 退出账号                 | ✅ |     ✅    | logout |
| 查看缓存Token            | ✅ |     ❌     | viewCachedToken |
| 删除缓存                 | ✅ |     ❌     | deleteCachedToken |
| 分享文本消息             | ✅ |   ❌      | shareText |
| 分享图片（本地图片）     | ✅ |    ✅     | shareImage |
| 分享多图                 | ✅ |    ❌     | shareMutileImage |
| 分享新闻（本地/网络图片）消息 | ✅ |      ✅   | shareNews |
| 分享音频消息             | ✅ |   ✅      | shareAudio |
| 分享视频消息             | ✅ |     ❌   | shareVideo |
| 分享文件（数据线）       | ✅ |      ❌   | shareFile |
| 添加好友                 | ✅ |      ❌     | addFriend |
| 分享纯文本到QZone        | ✅ |    ❌     | shareTextToQZone |
| 分享图片到QZone          | ✅ |   ✅      | shareImgToQZone |
| 分享视频到QZone          | ✅ |     ✅    | shareVideoToQZone |
| 获取用户信息             | ✅ |    ✅     | getInfo |
| UnionID                  | ✅ |   ✅      | requestUnionId |
| 一键加群                 | ✅ |    ❌     | joinGroup |
| 游戏绑定公会群           | ✅ |     ❌      | gameConsortiumBindingGroup |
| 分享文本+图片+链接       |❌|✅|shareToQQ
| 分享文本+图片+链接到QZone|❌|✅| shareToQzone

`请Android的同学将Android端独有的方法，添加到表格内。可以添加到相关方法的后面，或者添加到表格最下面`

`React-Native方法名是根据iOS SDK中的方法添加的，如有异议可修改`

`Android同学在构建与JS桥接文件的时候，方法尽量与iOS端保持一致` 

