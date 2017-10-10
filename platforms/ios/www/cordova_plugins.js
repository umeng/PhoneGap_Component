cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
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
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.2",
    "Umeng": "3.0.0"
};
// BOTTOM OF METADATA
});
