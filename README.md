# 工程配置
首先需要说明，PhoneGap下载的只是桥接文件，不含最新版本的jar，对应组件的jar请去[下载中心](https://developer.umeng.com/sdk)下载。

如果对于文档仍有疑问的，请参照我们在github上的[demo](https://github.com/umeng/PhoneGap_Component)

* 注意：集成基础组件库 2.0.0以下及统计SDK 8.0.0以下版本的用户，请参考release1.0.0分支中样例代码集成。


## PhoneGap开发环境搭建

### 下载安装Node.js
检查node.js环境，下载地址：[https://nodejs.org/en/](https://nodejs.org/en/)

``` shell
node -v

```

### 安装PhoneGap

``` shell
npm install -g phonegap

```

安装完成后，检验是否成功，输入


``` shell 
phonegap -version

```

输出phonegap版本号标识安装成功。


### 安装Cordova

``` shell
npm install -g cordova

```

安装完成后，检验是否成功，输入

``` shell
cordova -version
```

输出cordova版本号标识安装成功。


### 创建PhoneGap应用


``` shell
phonegap create demo

cd demo

phonegap add android
phonegap add ios


```


## Android

### 初始化

将下载的jar放入app下的libs中：



![image.png](http://upload-images.jianshu.io/upload_images/1483670-9c93384e5a607551.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

首先需要拷贝common_android文件夹中的文件拷贝到你的工程中（路径为`com.umeng.plugin`）：

![image.png](http://upload-images.jianshu.io/upload_images/1483670-941b02a193d2c6b0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后再将对应平台的桥接文件根据需要拷入你的工程（由于组件的特性，本期暂时不支持使用plugin.xml）：


![image.png](http://upload-images.jianshu.io/upload_images/1483670-bd2ceb6729c4b5ed.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

打开Application文件，修改如下：

``` java
  @Override
	    public void onCreate() {
	        super.onCreate();
	        PGCommonSDK.setLogEnabled(true);
			PGCommonSDK.init(this, "59892f08310c9307b60023d0", "Umeng", UMConfigure.DEVICE_TYPE_PHONE,
	            "669c30a9584623e70e8cd01b0381dcb4");
	      
	    }
```

 
 >`PGCommonSDK.init`接口一共五个参数，其中第一个参数为Context，第二个参数为友盟Appkey，第三个参数为channel，第四个参数为应用类型（手机或平板），第五个参数为push的secret（如果没有使用push，可以为空）。
 
### 工程配置

#### 引入js桥接文件

 * 找到Android工程assets/www/plugins目录, 在此目录下建立umeng/www子目录，将三个友盟业务对应桥接js文件 analyticssdk.js、pushsdk.js、socialsdk.js拷贝到assets/www/plugins/umeng/www路径下。

 
#### 修改 cordova_plugins.js 配置

* 找到Android工程assets目录下www/cordova_plugins.js文件，添加对友盟各个业务SDK插件模块的导出：

``` js

    {   
        "file": "plugins/umeng/www/analyticssdk.js",
        "id": "Umeng.Analytics",
        "clobbers": [
            "MobclickAgent"
        ]   
    },  
    {   
            "file": "plugins/umeng/www/pushsdk.js",
            "id": "Umeng.Push",
            "clobbers": [
                "PushAgent"
            ]   
    },  
    {   
                "file": "plugins/umeng/www/socialsdk.js",
                "id": "Umeng.Social",
                "clobbers": [
                    "SocialAgent"
                ]   
    },
    

```
 

![](http://dev.umeng.com/system/images/W1siZiIsIjIwMTgvMTIvMDcvMTZfMTlfMjRfOTc1X3BpYzIucG5nIl1d/pic2.png)


#### 修改config.xml配置

 
 * 找到Android工程res目录下xml/config.xml配置文件，添加对友盟各个业务SDK插件的引用：


``` xml
 
<plugins>
        <feature name="AnalyticsSDK">
            <param name="android-package" value="com.umeng.plugin.AnalyticsSDK" />
        </feature>
        <feature name="PushSDK">
            <param name="android-package" value="com.umeng.plugin.PushSDK" />
        </feature>
        <feature name="SocialSDK">
            <param name="android-package" value="com.umeng.plugin.SocialSDK" />
        </feature>
</plugins>
    
```
 
 ![](http://dev.umeng.com/system/images/W1siZiIsIjIwMTgvMTIvMDcvMTVfNDdfNDdfNTUzX3BpYzEucG5nIl1d/pic1.png)



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

### 工程配置

#### 引入js文件

将js文件引入至plugins下

#### 配置cordova_plugins.js

将cordova_plugins.js里module.exports中加入

```
module.exports = [

                  {
                  "file": "plugins/umeng/www/analyticssdk.js",
                  "id": "Umeng.Analytics",
                  "clobbers": [
                               "AnalyticsAgent"
                               ]
                  },
                  {
                  "file": "plugins/umeng/www/pushsdk.js",
                  "id": "Umeng.Push",
                  "clobbers": [
                               "PushAgent"
                               ]
                  },
                  {
                  "file": "plugins/umeng/www/socialsdk.js",
                  "id": "Umeng.Social",
                  "clobbers": [
                               "SocialAgent"
                               ]
                  },
];
```
注意：file路径是否正确

#### 配置config.xml

找到工程中的config.xml文件，加入代码

```

<plugins>
        <feature name="AnalyticsSDK">
            <param name="ios-package" value="UMAnalyticsModule" />
        </feature>
        <feature name="PushSDK">
            <param name="ios-package" value="UMPushModule" />
        </feature>
        <feature name="SocialSDK">
            <param name="ios-package" value="UMShareModule" />
        </feature>
</plugins>

```



# 接口说明

# 统计

## Android

### 初始化
首先需要找到Activity的生命周期，添加如下代码：

``` java
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
MobclickAgent.setSessionContinueMillis(1000*30);

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

js部分首先需要使用`analyticssdk.js`文件：


## 接口说明

### 自定义事件

```
MobclickAgent.onEvent(eventId);

MobclickAgent.onEventWithLable(eventId,eventLabel);

MobclickAgent.onEventWithParameters(eventId,eventData);

MobclickAgent.onEventWithCounter(eventId,eventData,eventNum);

MobclickAgent.onEventObject(eventId, eventData);
```
* eventId 为当前统计的事件ID
* eventLabel 为分类标签
* eventData 为当前事件的属性和取值（键值对），不能为空，如：{name:"umeng",sex:"man"}
* eventNum 用户每次触发的数值的分布情况，如事件持续时间、每次付款金额等'

### 账号的统计

```
MobclickAgent.profileSignInWithPUID(puid);
```

* puid 用户账号ID.长度小于64字节

``` 
MobclickAgent.profileSignInWithPUIDWithProvider(provider,puid);
```

* provider, 账号来源。puid 用户账号ID.长度小于64字节


```
MobclickAgent.profileSignOff()；
```

* 账号登出时需调用此接口，调用之后不再发送账号相关内容



### 预置事件属性接口

```
MobclickAgent.registerPreProperties(property);
```

* 注册预置事件属性。property 事件的超级属性（可以包含多对“属性名-属性值”）,如：{name:"umeng",sex:"man"}

```
MobclickAgent.unregisterPreProperty(propertyName);
```

* 注销预置事件属性。propertyName，要注销的预置事件属性名。

```
MobclickAgent.getPreProperties(context);
```

* 获取预置事件属性, 返回包含所有预置事件属性的JSONObject。

```
MobclickAgent.clearPreProperties();
```

* 清空全部预置事件属性。

#### 设置关注事件是否首次触发

```
MobclickAgent.setFirstLaunchEvent(eventList);
```

* eventList 只关注eventList前五个合法eventID.只要已经保存五个,此接口无效,如：["list1","list2","list3"]



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


