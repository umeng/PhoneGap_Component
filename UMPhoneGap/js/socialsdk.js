cordova.define("Umeng.Social", function(require, exports, module) {
/*
 * Javascript interface of Cordova plugin for  Social SDK
 */

    var SocialAgent = {


        directShare : function(callBack,text,img,url,title,platform) {
               cordova.exec(callBack, null, "SocialSDK","directShare", [text,img,url,title,platform]);
        },
        openShare : function(callBack,text,img,url,title,platforms) {
               cordova.exec(callBack, null, "SocialSDK","openShare", [text,img,url,title,platforms]);
        },
        auth : function(callBack,platform) {
               cordova.exec(callBack, null, "SocialSDK","auth", [platform]);
        },
        getInfo : function(callBack,platform) {
               cordova.exec(callBack, null, "SocialSDK","getInfo", [platform]);
        },

       };

               module.exports =SocialAgent;

});