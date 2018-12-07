package com.umeng.plugin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.security.Key;
import java.util.Map;

import android.app.Activity;
import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.BitmapFactory;
import android.text.TextUtils;
import com.umeng.analytics.MobclickAgent;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.common.ResContainer;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;

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

public class SocialSDK  extends CordovaPlugin {
    private Context mContext = null;
    private Activity mActivity = null;
    private final int SUCCESS = 200;
    private final int ERROR = 0;
    private final int CANCEL = -1;


    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        this.mContext = cordova.getActivity().getApplicationContext();
        this.mActivity = cordova.getActivity();
    }


    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
        android.util.Log.e("xxxxxx","execute");
        if (action.equals("directShare")) {
            String text = args.getString(0);
            String img = args.getString(1);
            String url = args.getString(2);
            String title = args.getString(3);
            int platform = args.getInt(4);
            ShareAction shareAction = getShareAction(text,img,url,title);
            shareAction.setPlatform(getPlatform(platform));
            shareAction.setCallback(new UMShareListener() {
                @Override
                public void onStart(SHARE_MEDIA share_media) {

                }

                @Override
                public void onResult(SHARE_MEDIA share_media) {
                    callbackContext.success(SUCCESS);
                }

                @Override
                public void onError(SHARE_MEDIA share_media, Throwable throwable) {
                    callbackContext.success(ERROR);
                }

                @Override
                public void onCancel(SHARE_MEDIA share_media) {
                    callbackContext.success(CANCEL);
                }
            }).share();
            return true;
        }else if (action.equals("openShare")){
            String text = args.getString(0);
            String img = args.getString(1);
            String url = args.getString(2);
            String title = args.getString(3);
            JSONArray platforms = args.getJSONArray(4);
            ShareAction shareAction = getShareAction(text,img,url,title);
            shareAction.setDisplayList(getPlatforms(platforms));
            shareAction.setCallback(new UMShareListener() {
                @Override
                public void onStart(SHARE_MEDIA share_media) {

                }

                @Override
                public void onResult(SHARE_MEDIA share_media) {
                    callbackContext.success(SUCCESS);
                }

                @Override
                public void onError(SHARE_MEDIA share_media, Throwable throwable) {
                    callbackContext.success(ERROR);
                }

                @Override
                public void onCancel(SHARE_MEDIA share_media) {
                    callbackContext.success(CANCEL);
                }
            }).open();
            return true;
        }else if (action.equals("auth")){
            int platform = args.getInt(0);
            UMShareAPI.get(mActivity).doOauthVerify(mActivity, getPlatform(platform), new UMAuthListener() {
                @Override
                public void onStart(SHARE_MEDIA share_media) {

                }

                @Override
                public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                    try {
                        callbackContext.success(map2Json(map));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                @Override
                public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
                    try {
                        JSONObject object = new JSONObject();
                        object.put("error",throwable.getMessage());
                        callbackContext.success(object);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                @Override
                public void onCancel(SHARE_MEDIA share_media, int i) {
                    try {
                        JSONObject object = new JSONObject();
                        object.put("error","cancel");
                        callbackContext.success(object);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            });
            return true;
        }else if (action.equals("getInfo")){
            int platform = args.getInt(0);
            UMShareAPI.get(mActivity).getPlatformInfo(mActivity, getPlatform(platform), new UMAuthListener() {
                @Override
                public void onStart(SHARE_MEDIA share_media) {

                }

                @Override
                public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                    try {
                        callbackContext.success(map2Json(map));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                @Override
                public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
                    try {
                        JSONObject object = new JSONObject();
                        object.put("error",throwable.getMessage());
                        callbackContext.success(object);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }

                @Override
                public void onCancel(SHARE_MEDIA share_media, int i) {
                    try {
                        JSONObject object = new JSONObject();
                        object.put("error","cancel");
                        callbackContext.success(object);
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            });
            return true;
        }
        return false;
    }
    private JSONObject map2Json(Map<String,String> map) throws JSONException {
        JSONObject object = new JSONObject();
        for (String key:map.keySet()){
            object.put(key,map.get(key));
        }
        return object;
    }
    private ShareAction getShareAction(String text,String img ,String url,String title){
        ShareAction shareAction = new ShareAction(mActivity);

        if (!TextUtils.isEmpty(url)){
            UMWeb umWeb = new UMWeb(url);
            umWeb.setThumb(parseShareImage(img));
            umWeb.setTitle(title);
            umWeb.setDescription(text);
            shareAction.withMedia(umWeb);
        }else if (!TextUtils.isEmpty(img)){
            UMImage image = parseShareImage(img);
            image.setThumb(parseShareImage(img));
            shareAction.withMedia(image);
        }
        if (!TextUtils.isEmpty(text)){
            shareAction.withText(text);
        }
        return shareAction;
    }
    private  UMImage parseShareImage(String imgName) {
        if(TextUtils.isEmpty(imgName)) {

            return null;
        } else {
            UMImage shareImage = null;
            if(imgName.startsWith("http")) {
                shareImage = new UMImage(mActivity, imgName);
            } else if(imgName.startsWith("assets/")) {
                AssetManager imgFile = mActivity.getResources().getAssets();
                String index = getFileName(imgName);
                InputStream imgNameString = null;
                if(!TextUtils.isEmpty(index)) {
                    try {
                        imgNameString = imgFile.open(index);
                        shareImage = new UMImage(mActivity, BitmapFactory.decodeStream(imgNameString));
                        imgNameString.close();
                    } catch (IOException var14) {
                        var14.printStackTrace();
                    } finally {
                        if(imgNameString != null) {
                            try {
                                imgNameString.close();
                            } catch (IOException var13) {
                                var13.printStackTrace();
                            }
                        }

                    }
                }
            } else if(imgName.startsWith("res/")) {
                String imgFile1 = getFileName(imgName);
                if(!TextUtils.isEmpty(imgFile1)) {
                    int index1 = imgFile1.indexOf(".");
                    if(index1 > 0) {
                        String imgNameString1 = imgFile1.substring(0, index1);
                        int imgId = ResContainer.getResourceId(mActivity, "drawable", imgNameString1);
                        shareImage = new UMImage(mActivity, imgId);
                    } else {

                    }
                }
            } else {
                File imgFile2 = new File(imgName);
                if(!imgFile2.exists()) {

                } else {
                    shareImage = new UMImage(mActivity, imgFile2);
                }
            }

            return shareImage;
        }
    }
    private static String getFileName(String fullname) {
        return !fullname.startsWith("assets/") && !fullname.startsWith("res/")?"":fullname.split("/")[1];
    }
    private SHARE_MEDIA[] getPlatforms(JSONArray platforms){
        SHARE_MEDIA[] ss = new SHARE_MEDIA[platforms.length()];
        for (int i = 0;i<platforms.length();i++){
            try {
                ss[i] = getPlatform(platforms.getInt(i));
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
        return ss;
    }
    private SHARE_MEDIA getPlatform(int platform){
        switch (platform){
            case 0:
                return SHARE_MEDIA.QQ;

            case 1:
                return SHARE_MEDIA.SINA;

            case 2:
                return SHARE_MEDIA.WEIXIN;

            case 3:
                return SHARE_MEDIA.WEIXIN_CIRCLE;
            case 4:
                return SHARE_MEDIA.QZONE;
            case 5:
                return SHARE_MEDIA.EMAIL;
            case 6:
                return SHARE_MEDIA.SMS;
            case 7:
                return SHARE_MEDIA.FACEBOOK;
            case 8:
                return SHARE_MEDIA.TWITTER;
            case 9:
                return SHARE_MEDIA.WEIXIN_FAVORITE;
            case 10:
                return SHARE_MEDIA.GOOGLEPLUS;
            case 11:
                return SHARE_MEDIA.RENREN;
            case 12:
                return SHARE_MEDIA.TENCENT;
            case 13:
                return SHARE_MEDIA.DOUBAN;
            case 14:
                return SHARE_MEDIA.FACEBOOK_MESSAGER;
            case 15:
                return SHARE_MEDIA.YIXIN;
            case 16:
                return SHARE_MEDIA.YIXIN_CIRCLE;
            case 17:
                return SHARE_MEDIA.INSTAGRAM;
            case 18:
                return SHARE_MEDIA.PINTEREST;
            case 19:
                return SHARE_MEDIA.EVERNOTE;
            case 20:
                return SHARE_MEDIA.POCKET;
            case 21:
                return SHARE_MEDIA.LINKEDIN;
            case 22:
                return SHARE_MEDIA.FOURSQUARE;
            case 23:
                return SHARE_MEDIA.YNOTE;
            case 24:
                return SHARE_MEDIA.WHATSAPP;
            case 25:
                return SHARE_MEDIA.LINE;
            case 26:
                return SHARE_MEDIA.FLICKR;
            case 27:
                return SHARE_MEDIA.TUMBLR;
            case 28:
                return SHARE_MEDIA.ALIPAY;
            case 29:
                return SHARE_MEDIA.KAKAO;
            case 30:
                return SHARE_MEDIA.DROPBOX;
            case 31:
                return SHARE_MEDIA.VKONTAKTE;
            case 32:
                return SHARE_MEDIA.DINGTALK;
            case 33:
                return SHARE_MEDIA.MORE;
            default:
                return SHARE_MEDIA.QQ;
        }
    }
}
