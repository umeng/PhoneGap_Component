package com.umeng.plugin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.umeng.message.PushAgent;
import com.umeng.message.UTrack;
import com.umeng.message.common.inter.ITagManager;
import com.umeng.message.tag.TagManager;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by wangfei on 17/9/26.
 */

public class PushSDK  extends CordovaPlugin {
    private Context mContext = null;
    private Activity ma = null;
    private final int SUCCESS = 200;
    private final int ERROR = 0;
    private final int CANCEL = -1;
    private PushAgent mPushAgent;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.mContext = cordova.getActivity().getApplicationContext();
        this.ma = cordova.getActivity();
        mPushAgent = PushAgent.getInstance(ma);
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {

        if (action.equals("addTag")) {
            String tag = args.getString(0);
            mPushAgent.getTagManager().addTags(new TagManager.TCallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final ITagManager.Result result) {
                    if (isSuccess) {
                        callbackContext.success(getTagJson(SUCCESS, result.remain));
                    } else {
                        callbackContext.success(getTagJson(ERROR, 0));
                    }
                }
            }, tag);
            return true;
        } else if (action.equals("delTag")) {
            String tag = args.getString(0);
            mPushAgent.getTagManager().deleteTags(new TagManager.TCallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final ITagManager.Result result) {
                    if (isSuccess) {
                        callbackContext.success(getTagJson(SUCCESS, result.remain));
                    } else {
                        callbackContext.success(getTagJson(ERROR, 0));
                    }
                }
            }, tag);
            return true;
        } else if (action.equals("listTag")) {
            mPushAgent.getTagManager().getTags(new TagManager.TagListCallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final List<String> result) {

                    if (isSuccess) {
                        if (result != null) {
                            String r = "";
                            for (int i = 0; i < result.size(); i++) {
                                r = r + result.get(i) + ",";
                            }
                            r.substring(0, r.length() - 1);
                            callbackContext.success(getJsonArry(result));
                        } else {
                            callbackContext.success(new JSONArray());
                        }
                    } else {
                        callbackContext.success(new JSONArray());
                    }

                }
            });
            return true;
        } else if (action.equals("addAlias")) {
            String alias = args.getString(0);
            String aliasType = args.getString(1);
            mPushAgent.addAlias(alias, aliasType, new UTrack.ICallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final String message) {

                    Log.e("xxxxxx", "isuccess" + isSuccess);
                    if (isSuccess) {
                        callbackContext.success(SUCCESS);
                    } else {
                        callbackContext.success(ERROR);
                    }

                }
            });
            return true;
        } else if (action.equals("delAlias")) {
            String alias = args.getString(0);
            String aliasType = args.getString(1);
            mPushAgent.deleteAlias(alias, aliasType, new UTrack.ICallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final String message) {

                    Log.e("xxxxxx", "isuccess" + isSuccess);
                    if (isSuccess) {
                        callbackContext.success(SUCCESS);
                    } else {
                        callbackContext.success(ERROR);
                    }

                }
            });
            return true;
        } else if (action.equals("setAlias")) {
            String alias = args.getString(0);
            String aliasType = args.getString(1);
            mPushAgent.setAlias(alias, aliasType, new UTrack.ICallBack() {
                @Override
                public void onMessage(final boolean isSuccess, final String message) {

                    Log.e("xxxxxx", "isuccess" + isSuccess);
                    if (isSuccess) {
                        callbackContext.success(SUCCESS);
                    } else {
                        callbackContext.success(ERROR);
                    }

                }
            });
            return true;
        }
        return false;
    }

    private JSONArray getJsonArry(List<String> list) {
        JSONArray jsonArray = new JSONArray();
        for (String t : list) {
            jsonArray.put(t);
        }
        return jsonArray;
    }

    private JSONObject getTagJson(int stCode, int remain) {
        try {
            JSONObject object = new JSONObject();
            object.put("stcode", stCode);
            object.put("remain", remain);
            return object;
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return null;
    }

}