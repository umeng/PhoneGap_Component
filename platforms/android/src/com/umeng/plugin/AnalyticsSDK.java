package com.umeng.plugin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import android.content.Context;
import android.util.Log;
import com.umeng.analytics.MobclickAgent;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

//import com.umeng.analytics.dplus.UMADplus;
//import com.umeng.analytics.game.UMGameAgent;

/**
 * 示例： SDK 接口桥接封装类，并未封装SDK所有API(仅封装常用API接口)，设置配置参数类API应在Android原生代码中
 * 调用，例如：SDK初始化函数，Log开关函数，子进程自定义事件埋点使能函数，异常捕获功能使能/关闭函数等等。
 * 如果还需要封装其它SDK API，请参考本例自行封装。
 * Created by wangfei on 17/9/26.
 * -- 适配海棠版(common 2.0.0 + analytics 8.0.0) modify by yujie on 18/12/28
 */

public class AnalyticsSDK extends CordovaPlugin {
    private Context mContext = null;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.mContext = cordova.getActivity().getApplicationContext();
    }

    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);

        MobclickAgent.onResume(mContext);
    }

    @Override
    public void onPause(boolean multitasking) {
        super.onPause(multitasking);
        Log.d("UMPlugin", "onPause");
        MobclickAgent.onPause(mContext);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Log.d("UMPlugin", "execute action:" + action + "|||args:" + args);
        if (action.equals("onEvent")) {
            String eventId = args.getString(0);
            MobclickAgent.onEvent(mContext, eventId);
            return true;
        } else if (action.equals("onEventWithLabel")) {
            String eventId = args.getString(0);
            String label = args.getString(1);
            MobclickAgent.onEvent(mContext, eventId, label);
            return true;
        } else if (action.equals("onEventWithParameters")) {
            String eventId = args.getString(0);
            JSONObject obj = args.getJSONObject(1);
            Map<String, String> map = new HashMap<String, String>();
            Iterator<String> it = obj.keys();
            while (it.hasNext()) {
                String key = String.valueOf(it.next());
                Object o = obj.get(key);
                if (o instanceof Integer) {
                    String value = String.valueOf(o);
                    map.put(key, value);
                } else if (o instanceof String) {
                    String strValue = (String) o;
                    map.put(key, strValue);
                }
            }
            MobclickAgent.onEvent(mContext, eventId, map);
            return true;
        } else if (action.equals("onEventWithCounter")) {
            String eventId = args.getString(0);
            JSONObject obj = args.getJSONObject(1);
            Map<String, String> map = new HashMap<String, String>();
            Iterator<String> it = obj.keys();
            while (it.hasNext()) {
                String key = String.valueOf(it.next());
                Object o = obj.get(key);
                if (o instanceof Integer) {
                    String value = String.valueOf(o);
                    map.put(key, value);
                } else if (o instanceof String) {
                    String strValue = (String) o;
                    map.put(key, strValue);
                }
            }
            int value = args.getInt(2);
            MobclickAgent.onEventValue(mContext, eventId, map, value);
            return true;
        } else if (action.equals("onPageBegin")) {
            String pageName = args.getString(0);
            MobclickAgent.onPageStart(pageName);
            return true;
        } else if (action.equals("onPageEnd")) {
            String pageName = args.getString(0);
            MobclickAgent.onPageEnd(pageName);
            return true;
        } else if (action.equals("getDeviceId")) {
            try {
                android.telephony.TelephonyManager tm = (android.telephony.TelephonyManager) mContext
                    .getSystemService(Context.TELEPHONY_SERVICE);
                String deviceId = tm.getDeviceId();
                callbackContext.success(deviceId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return true;
        } else if (action.equals("profileSignInWithPUID")) {
            String puid = args.getString(0);
            MobclickAgent.onProfileSignIn(puid);
            return true;
        } else if (action.equals("profileSignInWithPUIDWithProvider")) {
            String provider = args.getString(0);
            String puid = args.getString(1);
            MobclickAgent.onProfileSignIn(provider, puid);
            return true;
        } else if (action.equals("profileSignOff")) {
            MobclickAgent.onProfileSignOff();
            return true;
        } else if (action.equals("onEventObject")) {
            String eventName = args.getString(0);
            JSONObject obj = args.getJSONObject(1);
            Map<String, Object> map = new HashMap<String, Object>();
            Iterator<String> it = obj.keys();
            while (it.hasNext()) {
                String key = String.valueOf(it.next());
                Object o = obj.get(key);
                map.put(key, o);
            }
            MobclickAgent.onEventObject(mContext, eventName, map);
            return true;
        } else if (action.equals("registerPreProperties")) {
            for(int i=0 ; i < args.length() ;i++)
            {
                //获取每一个JsonObject对象
                MobclickAgent.registerPreProperties(mContext, args.getJSONObject(i));
                //String res = MobclickAgent.getPreProperties(mContext).toString();
            }
            return true;
        } else if (action.equals("unregisterPreProperty")) {
            String propertyName = args.getString(0);
            MobclickAgent.unregisterPreProperty(mContext, propertyName);
            return true;
        } else if (action.equals("getPreProperties")) {
            String res = MobclickAgent.getPreProperties(mContext).toString();
            callbackContext.success(res);
            return true;
        } else if (action.equals("clearPreProperties")) {
            MobclickAgent.clearPreProperties(mContext);
            return true;
        } else if (action.equals("setFirstLaunchEvent")) {
            JSONArray array = args.getJSONArray(0);
            List<String> list = new ArrayList<String>();
            for (int i = 0; i < array.length(); i++) {
                list.add(array.getString(i));
            }
            MobclickAgent.setFirstLaunchEvent(mContext, list);

            return true;
        }
        return false;
    }
}
