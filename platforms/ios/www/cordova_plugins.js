cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "id": "Umeng.Umeng",
        "file": "plugins/Umeng/www/UMAnalytics.js",
        "pluginId": "Umeng",
        "clobbers": [
            "MobclickAgent"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.2",
    "Umeng": "3.0.0"
};
// BOTTOM OF METADATA
});
