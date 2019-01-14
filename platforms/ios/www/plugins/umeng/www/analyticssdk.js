cordova.define("Umeng.Analytics", function(require, exports, module) {
/*
 * Javascript interface of Cordova plugin for Umeng Analytics SDK
 */

    var AnalyticsAgent = {

    /**
     * 自定义事件数量统计
     *
     * @param eventId
     *            String类型.事件ID，注意需要先在友盟网站注册此ID
     */
	onEvent : function(eventId) {
		cordova.exec(null, null, "AnalyticsSDK","onEvent", [ eventId ]);

	},
    /**
     * 自定义事件数量统计
     *
     * @param eventId
     *            String类型.事件ID， 注意需要先在友盟网站注册此ID
     * @param eventLabel
     *            String类型.事件标签，事件的一个属性说明
     */
	onEventWithLabel : function(eventId, eventLabel) {
		cordova.exec(null, null, "AnalyticsSDK","onEventWithLabel", [ eventId, eventLabel ]);

	},
    /**
     * 自定义事件数量统计
     *
     * @param eventId
     *            String类型.事件ID， 注意需要先在友盟网站注册此ID
     * @param eventData
     *            Dictionary类型.当前事件的属性集合，最多支持10个K-V值
     */
	onEventWithParameters : function(eventId, eventData) {
		cordova.exec(null, null, "AnalyticsSDK","onEventWithParameters", [ eventId, eventData ]);

	},
    /**
     * 自定义事件数值型统计
     *
     * @param eventId
     *            String类型.事件ID，注意要先在友盟网站上注册此事件ID
     * @param eventData
     *            Dictionary类型.事件的属性集合，最多支持10个K-V值
     * @param eventNum
     *            int 类型.事件持续时长，单位毫秒，您需要手动计算并传入时长，作为事件的时长参数
     *
     */
	onEventWithCounter : function(eventId, eventData, eventNum) {
		cordova.exec(null, null, "AnalyticsSDK","onEventWithCounter", [ eventId, eventData, eventNum ]);

	},
    /**
     * 页面统计开始时调用
     *
     * @param pageName
     *            String类型.页面名称
     */
	onPageBegin : function(pageName) {
		cordova.exec(null, null, "AnalyticsSDK","onPageBegin", [ pageName ]);

	},
    /**
     * 页面统计结束时调用
     *
     * @param pageName
     *            String类型.页面名称
     */
	onPageEnd : function(pageName) {
		cordova.exec(null, null, "AnalyticsSDK","onPageEnd", [ pageName ]);

	},
    /**
     * 获取IOS UUID
     */
	getDeviceId:function(callBack) {
        cordova.exec(callBack, null, "AnalyticsSDK", "getDeviceId", []);

    },
    /**
     * 在控制台打印log
     * @param enabled
     *           Bool类型
     */
	setLogEnabled:function(enabled) {
        cordova.exec(null, null, "AnalyticsSDK", "setLogEnabled", [enabled]);
    },
    /**
     * 统计帐号登录接口 *
     *
     * @param UID
     *            用户账号ID,长度小于64字节
     */
    profileSignInWithPUID:function(UID) {
        cordova.exec(null, null, "AnalyticsSDK", "profileSignInWithPUID", [UID]);
    },
    /**
     * 统计帐号登录接口 *
     *
     * @param provider
     *            帐号来源.用户通过第三方账号登陆,可以调用此接口进行统计.不能以下划线"_"开头,使用大写字母和数字标识,长度小于32字节;
     *            如果是上市公司,建议使用股票代码.
     * @param UID
     *            用户账号ID,长度小于64字节
     */
    profileSignInWithPUIDWithProvider:function(provider, UID) {
        cordova.exec(null, null, "AnalyticsSDK", "profileSignInWithPUIDWithProvider", [ provider, UID ]);

    },
    /**
     * 帐号统计退出接口
     */
    profileSignOff:function(){
        cordova.exec(null, null, "AnalyticsSDK", "profileSignOff", []);

    },


     /** * 设置属性 键值对 会覆盖同名的key
      * 将该函数指定的key-value写入文件；APP启动时会自动读取该文件的所有key-value。
      * @param property
      *              Dictionary类型.自定义属性
      *
      */
      registerPreProperties : function(property) {
         cordova.exec(null, null, "AnalyticsSDK","registerPreProperties", [property]);
      },

     /** * 删除指定key-value
      * @param propertyName
      *              String类型.自定义属性
      *
      */
      unregisterPreProperty : function(propertyName) {
          cordova.exec(null, null, "AnalyticsSDK","unregisterPreProperty", [propertyName]);
       },

       

       /** 返回所有key-value；如果不存在，则返回空。
        *
        */
        getPreProperties : function(callBack) {
               cordova.exec(callBack, null, "AnalyticsSDK","getPreProperties", []);
        },

        /** * 清空所有key-value。
         *
         */
         clearPreProperties : function() {
               cordova.exec(null, null, "AnalyticsSDK","clearPreProperties", []);
         },

        /** * 设置关注事件是否首次触发,只关注eventList前五个合法eventID.只要已经保存五个,此接口无效
         * @param eventList
         *              Array类型.自定义属性
         *
         */
         setFirstLaunchEvent : function(eventList) {
               cordova.exec(null, null, "AnalyticsSDK","setFirstLaunchEvent", [eventList]);
         },

       };

               module.exports =AnalyticsAgent;

});
