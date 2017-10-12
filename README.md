# 工程配置
首先需要说明，PhoneGap下载的只是桥接文件，不含最新版本的jar，对应组件的jar请去[下载中心](https://github.com/umeng/Hybrid_Component)下载。
如果对于文档仍有疑问的，请参照我们在github上的[demo](https://github.com/umeng/React_Native_Compent)

## Android
### 初始化

将下载的jar放入app下的libs中：



![image.png](http://upload-images.jianshu.io/upload_images/1483670-9c93384e5a607551.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

首先需要拷贝common_android文件夹中的文件拷贝到你的工程中（路径为`com.umeng.plugin`）：

![image.png](http://upload-images.jianshu.io/upload_images/1483670-941b02a193d2c6b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后再将对应平台的桥接文件根据需要拷入你的工程（由于组件的特性，本期暂时不支持使用plugin.xml）：


![image.png](http://upload-images.jianshu.io/upload_images/1483670-bd2ceb6729c4b5ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

打开Application文件，修改如下：

```
  @Override
	    public void onCreate() {
	        super.onCreate();
	        PGCommonSDK.setLogEnabled(true);
			PGCommonSDK.init(this, "59892f08310c9307b60023d0", "Umeng", UMConfigure.DEVICE_TYPE_PHONE,
	            "669c30a9584623e70e8cd01b0381dcb4");
	      
	    }
```

 
 >`PGCommonSDK.init`接口一共五个参数，其中第一个参数为Context，第二个参数为友盟Appkey，第三个参数为channel，第四个参数为应用类型（手机或平板），第五个参数为push的secret（如果没有使用push，可以为空）。

至此，所有的工程配置已经完成，接下来请按照各个组件的文档进行初始化。

## iOS
### 初始化
+ 将已下载的友盟SDK添加到项目

![](http://upload-images.jianshu.io/upload_images/1483670-1dc704e7b7c5dd42.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


+ 添加需要的组件桥接文件
 ![](http://upload-images.jianshu.io/upload_images/7304622-62d16ae4a9e99442.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
 
+ 添加友盟初始化配置文件

![](http://upload-images.jianshu.io/upload_images/1483670-647d9c2bb0df8aa4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 
+ 在 Appdelegate.m 中设置初始化代码

```
#import "UMCommonModule.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [UMConfigure setLogEnabled:YES];
   [UMCommonModule initWithAppkey:@"571459ad67e58ea24c0016fd" channel:@"App Store"];
  ...
}
```

## 接口说明
# 统计
## Android
### 初始化
首先需要找到Activity的生命周期，添加如下代码：

```
  @Override
    public void onResume() {
        super.onResume();
        MobclickAgent.onResume(this);
    }
    @Override
    protected void onPause() {
        super.onPause();
        MobclickAgent.onPause(this);
    }
```


并在`onCreat`中设置统计的场景，以及发送间隔：

```
MobclickAgent.setSessionContinueMillis(1000);
MobclickAgent.setScenarioType(this, EScenarioType.E_DUM_NORMAL);
```

## iOS
### 初始化
在工程的 AppDelegate.m 文件中引入相关组件头文件 ，且在 application:didFinishLaunchingWithOptions: 方法中添加如下代码：

```
[MobClick setScenarioType:E_UM_NORMAL];

```
如果需要引入多个场景：

```
[MobClick setScenarioType:E_UM_E_UM_GAME|E_UM_DPLUS];

```

js部分首先需要使用`UMAnalytics.js`文件：


## 接口说明
### 自定义事件
AnalyticsUtil.onEvent(eventId);

AnalyticsUtil.onEventWithLable(eventId,eventLabel);

AnalyticsUtil.onEventWithMap(eventId,eventData);

AnalyticsUtil.onEventWithMapAndCount(eventId,eventData,eventNum);

* eventId 为当前统计的事件ID
* eventLabel 为分类标签
* eventData 为当前事件的属性和取值（键值对），不能为空，如：{name:"umeng",sex:"man"}
* eventNum 用户每次触发的数值的分布情况，如事件持续时间、每次付款金额等

### 账号的统计
AnalyticsUtil.profileSignInWithPUID(puid);

* puid 用户账号ID.长度小于64字节

AnalyticsUtil.profileSignOff()；

 * 账号登出时需调用此接口，调用之后不再发送账号相关内容

### Dplus 统计
#### track事件
AnalyticsUtil.track(eventName);

AnalyticsUtil.trackWithMap(eventName, property);

* eventName 事件名称
* property 事件的自定义属性（可以包含多对“属性名-属性值”）,如：{name:"umeng",sex:"man"}

#### 超级属性

AnalyticsUtil.registerSuperProperty(property);

* property 事件的超级属性（可以包含多对“属性名-属性值”）,如：{name:"umeng",sex:"man"}

AnalyticsUtil.clearSuperProperties();

* 清空所有超级属性

#### 设置关注事件是否首次触发

AnalyticsUtil.setFirstLaunchEvent(eventList);

* eventList 只关注eventList前五个合法eventID.只要已经保存五个,此接口无效,如：["list1","list2","list3"]

### 游戏统计

#### 关卡
AnalyticsUtil.startLevel(level); //进入关卡

AnalyticsUtil.failLevel(level); //通过关卡

AnalyticsUtil.finishLevel(level); //完成关卡

* level 关卡ID

#### 充值

AnalyticsUtil.pay(cash, source, price);

AnalyticsUtil.payWithItem(cash, source, item, amount, price);

* cash 真实币数量，>=0的数,最多只保存小数点后2位
* source 支付渠道，1 ~ 99的整数, 其中1..20 是预定义含义,其余21-99需要在网站设置。
* coin 虚拟币数量，大于等于0的整数, 最多只保存小数点后2位
* item 道具ID
* amount 道具数量，大于0的整数
* price 虚拟币数量

#### 购买

AnalyticsUtil.buy(item, amount, price);

* item 道具ID
* amount 道具数量,大于0的整数
* price 道具单价

#### 消耗

AnalyticsUtil.use(item, amount, price);

* item 道具ID
* amount 道具数量,大于0的整数
* price 道具单价

#### 额外奖励

AnalyticsUtil.bonus(coin, source); //赠送金币

AnalyticsUtil.bonusWithItem(item, amount, price, source); //赠送道具

 * coin 虚拟币数量，大于0的整数, 最多只保存小数点后2位
 * source 奖励渠道，取值在 1~10 之间。“1”已经被预先定义为“系统奖励”，2~10 需要在网站设置含义
 * item 道具ID，非空字符串
 * amount 道具数量，大于0的整数
 * price 道具单价

#### 交易兑换货币

AnalyticsUtil.exchange(orderId, currencyAmount, currencyType, virtualAmount, channel);

* currencyAmount 现金或等价物总额
* currencyType 为ISO4217定义的3位字母代码，如CNY,USD等（如使用其它自定义等价物作为现金，可使用ISO4217中未定义的3位字母组合传入货币类型）
* virtualAmount 虚拟币数量
* channel 支付渠道
* orderId 交易订单ID


# 推送
## Android
### 初始化
首先，Android push需要让Android app依赖我们提供的push module（请替换最新的umeng-push-xx.jar），再根据文档进行相应的初始化。

Push SDK 的平台配置与单独 Native 项目集成相同，请参考 [接入Push SDK](http://dev.umeng.com/sdk_integate/android_sdk/android_push_doc#1) 以及 [初始化设置部分](http://dev.umeng.com/sdk_integate/android_sdk/android_push_doc#2_1)


## iOS
### 初始化
Push SDK 的平台配置与单独 Native 项目集成相同，请参考 [接入Push SDK](http://dev.umeng.com/sdk_integate/ios-integrate-guide/push#1) 以及 [初始化设置部分](http://dev.umeng.com/sdk_integate/ios-integrate-guide/push#1)
## 接口说明
首先需要使用`pushsdk.js`文件：

### 添加tag
```
PushAgent.addTag( function(r){displayjson(r);},tag)
```
* tag 此参数为tag
* callback 中会返回一个jsonobject 第一个key stcode为错误码，当为200时标记成功。第二个key为remain值。其中displayjson为：
```
function displayjson(jsonObj) {
    var jStr = "{ ";
    for(var item in jsonObj){

        jStr += "'"+item+"':'"+jsonObj[item]+"',";
    }
        jStr += " }";
       alert(jStr);
    }
```



### 删除tag
```
PushAgent.delTag( function(r){displayjson(r);},tag)
```
* tag 此参数为tag
* callback 中会返回一个jsonobject 第一个key stcode为错误码，当为200时标记成功。第二个key为remain值。其中displayjson为：
```
function displayjson(jsonObj) {
    var jStr = "{ ";
    for(var item in jsonObj){

        jStr += "'"+item+"':'"+jsonObj[item]+"',";
    }
        jStr += " }";
       alert(jStr);
    }
```


### 展示tag
```
PushAgent.listTag(function(r){alert(r);})
```

* callback 为一个数组，标记为所有tag：


### 添加Alias
```
PushAgent.addAlias(  function(r){alert('' +r);},alias,type)
```
* alias 此参数为alias
* type  此参数为alias type
* callback 为回调方法，r为int类型的错误码，200为成功


### 添加额外Alias
```
PushAgent.setAlias(  function(r){alert('' +r);},alias,type)
```
* alias 此参数为alias
* type  此参数为alias type
* callback 为回调方法，r为int类型的错误码，200为成功


### 删除Alias
```
PushAgent.delAlias(  function(r){alert('' +r);},alias,type)
```
* alias 此参数为alias
* type  此参数为alias type
* callback 为回调方法，r为int类型的错误码，200为成功


# Share
## Android
### 初始化
在share_android文件夹下有一个social的module，开发者可以依赖这个module，并将下载所需的平台的jar放入这个module的lib中，也可以不依赖这个module，直接将使用平台的jar和res放入主module。
在Application中设置使用的三方平台的appkey：

```
 {

        PlatformConfig.setWeixin("wxdc1e388c3822c80b", "3baf1193c85774b3fd9d18447d76cab0");
        //豆瓣RENREN平台目前只能在服务器端配置
        PlatformConfig.setSinaWeibo("3921700954", "04b48b094faeb16683c32669824ebdad", "http://sns.whalecloud.com");
        PlatformConfig.setYixin("yxc0614e80c9304c11b0391514d09f13bf");
        PlatformConfig.setQQZone("100424468", "c7394704798a158208a74ab60104f0ba");

    }
```

找到使用的Activity，添加回调所需代码：

```
  @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);
    }
```

分享其它工程配置请参照[分享工程配置](http://dev.umeng.com/sdk_integate/android_sdk/android_share_doc#1_3_2)

## iOS
### 初始化
UShare SDK 的平台配置与单独 Native 项目集成相同，请参考 [接入U-Share SDK](http://dev.umeng.com/social/ios/quick-integration#1_1) 以及 [初始化设置部分](http://dev.umeng.com/social/ios/quick-integration#2)

## 接口说明
首先需要使用`UMShare.js`文件：


### 获取用户资料

获取用户资料可以直接使用`SocialAgent.getInfo( function(r){displayjson(r);},platform)`，其中platform为平台id，第一个参数为回调，回调参数为r为jsonObject。
平台与id的对应关系如下：


| id |平台 | 备注 |
| -------- | -------- | -------- |
| 0     | QQ     |     |
| 1     | SINA     |     |
| 2     | 微信     |     |
| 3     | 朋友圈     |     |
| 4     | QQ空间     |     |
| 5     | 电子邮件     |     |
| 6     | 短信     |     |
| 7     | facebook     |     |
| 8     | twitter     |     |
| 9     | 微信收藏     |     |
| 10     | google+     |     |
| 11     | 人人     |     |
| 12     | 腾讯微博     |     |
| 13     | 豆瓣     |     |
| 14     | facebook messager     |     |
| 15     | 易信     |     |
| 16     | 易信朋友圈     |     |
| 17     | INSTAGRAM     |     |
| 18     | PINTEREST     |     |
| 19     | 印象笔记     |     |
| 20     | POCKET     |     |
| 21     | LINKEDIN     |     |
| 22     | FOURSQUARE     |     |
| 23     | 有道云笔记     |     |
| 24     | WHATSAPP     |     |
| 25     | LINE     |     |
| 26     | FLICKR     |     |
| 27     | TUMBLR     |     |
| 28     | 支付宝     |     |
| 29     | KAKAO     |     |
| 30     | DROPBOX     |     |
| 31     | VKONTAKTE     |     |
| 32     | 钉钉     |     |
| 33     | 系统菜单     |     |




### 分享
分享示例如下：

```
SocialAgent.directShare( function(r){alert('' +r);}, text,img,url,title,platform)
```
* 回调方法中的回调参数为错误码，当错误码为200时，标识成功
* text 为分享内容
* img 为图片地址，可以为链接，本地地址以及res图片（如果使用res,请使用如下写法：`res/icon.png`）
* url 为分享链接，可以为空
* title 为分享链接的标题
* platform为平台id，id对照表与授权相同

 
### 分享面板
分享面板示例如下：

```
SocialAgent.openShare( function(r){alert('' +r);}, text,img,url,title,platforms)
```
* 回调方法中的回调参数为错误码，当错误码为200时，标识成功
* text 为分享内容
* img 为图片地址，可以为链接，本地地址以及res图片（如果使用res,请使用如下写法：`res/icon.png`）
* url 为分享链接，可以为空
* title 为分享链接的标题
* platforms为平台id数组，id对照表与授权相同


