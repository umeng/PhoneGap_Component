cordova.define("Umeng.Push", function(require, exports, module) {
/*
 * Javascript interface of Cordova plugin for Umeng Analytics SDK
 */
               
               var PushAgent = {
               
               
               addTag : function(callBack,tag) {
               
               cordova.exec(callBack, null, "PushSDK","addTag", [tag]);
               },
               delTag : function(callBack,tag) {
               
               cordova.exec(callBack, null, "PushSDK","delTag", [tag]);
               },
               listTag : function(callBack) {
               
               cordova.exec(callBack, null, "PushSDK","listTag", []);
               },
               addAlias : function(callBack,alias,type) {
               cordova.exec(callBack, null, "PushSDK","addAlias", [alias,type]);
               },
               delAlias : function(callBack,alias,type) {
               cordova.exec(callBack, null, "PushSDK","delAlias", [alias,type]);
               },
               setAlias : function(callBack,alias,type) {
               cordova.exec(callBack, null, "PushSDK","setAlias", [alias,type]);
               },
               };
               
               module.exports =PushAgent;
               
               });

