//
//  UMShareModule.m
//  PhoneGap_Component
//
//  Created by wyq.Cloudayc on 30/09/2017.
//

#import "UMShareModule.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@implementation UMShareModule

- (UMSocialPlatformType)platformType:(NSInteger)platform
{
    switch (platform) {
        case 0: // QQ
            return UMSocialPlatformType_QQ;
        case 1: // Sina
            return UMSocialPlatformType_Sina;
        case 2: // wechat
            return UMSocialPlatformType_WechatSession;
        case 3:
            return UMSocialPlatformType_WechatTimeLine;
        case 4:
            return UMSocialPlatformType_Qzone;
        case 5:
            return UMSocialPlatformType_Email;
        case 6:
            return UMSocialPlatformType_Sms;
        case 7:
            return UMSocialPlatformType_Facebook;
        case 8:
            return UMSocialPlatformType_Twitter;
        case 9:
            return UMSocialPlatformType_WechatFavorite;
        case 10:
            return UMSocialPlatformType_GooglePlus;
        case 11:
            return UMSocialPlatformType_Renren;
        case 12:
            return UMSocialPlatformType_TencentWb;
        case 13:
            return UMSocialPlatformType_Douban;
        case 14:
            return UMSocialPlatformType_FaceBookMessenger;
        case 15:
            return UMSocialPlatformType_YixinSession;
        case 16:
            return UMSocialPlatformType_YixinTimeLine;
        case 17:
            return UMSocialPlatformType_Instagram;
        case 18:
            return UMSocialPlatformType_Pinterest;
        case 19:
            return UMSocialPlatformType_EverNote;
        case 20:
            return UMSocialPlatformType_Pocket;
        case 21:
            return UMSocialPlatformType_Linkedin;
        case 22:
            return UMSocialPlatformType_UnKnown; // foursquare on android
        case 23:
            return UMSocialPlatformType_YouDaoNote;
        case 24:
            return UMSocialPlatformType_Whatsapp;
        case 25:
            return UMSocialPlatformType_Line;
        case 26:
            return UMSocialPlatformType_Flickr;
        case 27:
            return UMSocialPlatformType_Tumblr;
        case 28:
            return UMSocialPlatformType_AlipaySession;
        case 29:
            return UMSocialPlatformType_KakaoTalk;
        case 30:
            return UMSocialPlatformType_DropBox;
        case 31:
            return UMSocialPlatformType_VKontakte;
        case 32:
            return UMSocialPlatformType_DingDing;
        case 33:
            return UMSocialPlatformType_UnKnown; // more
        default:
            return UMSocialPlatformType_QQ;
    }
}

- (void)shareWithText:(NSString *)text icon:(NSString *)icon link:(NSString *)link title:(NSString *)title platform:(NSInteger)platform completion:(UMSocialRequestCompletionHandler)completion
{
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    if (link.length > 0) {
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:icon];
        shareObject.webpageUrl = link;
        
        messageObject.shareObject = shareObject;
    } else if (icon.length > 0) {
        id img = nil;
        if ([icon hasPrefix:@"http"]) {
            img = icon;
        } else {
            if ([icon hasPrefix:@"/"]) {
                img = [UIImage imageWithContentsOfFile:icon];
            } else {
                img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:icon ofType:nil]];
            }
        }
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        shareObject.thumbImage = img;
        shareObject.shareImage = img;
        messageObject.shareObject = shareObject;
        
        messageObject.text = text;
    } else if (text.length > 0) {
        messageObject.text = text;
    } else {
        if (completion) {
            completion(nil, [NSError errorWithDomain:@"UShare" code:-3 userInfo:@{@"message": @"invalid parameter"}]);
            return;
        }
    }
    
    [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:messageObject currentViewController:nil completion:completion];
    
}

- (void)directShare:(CDVInvokedUrlCommand*)command
{
    NSArray *args = command.arguments;
  
    UMSocialPlatformType platform = [args[4] integerValue];
    NSString *text = args[0];
    NSString *icon = args[1];
    NSString *link = args[2];
    NSString *title = args[3];
    
    UMSocialPlatformType plf = [self platformType:platform];
    if (plf == UMSocialPlatformType_UnKnown) {
        [self handleShareResult:-2  result:nil command:command];
        return;
    }
    
    [self shareWithText:text icon:icon link:link title:title platform:plf completion:^(id result, NSError *error) {
        if (error) {
            NSString *msg = error.userInfo[@"NSLocalizedFailureReason"];
            if (!msg) {
                msg = error.userInfo[@"message"];
            }if (!msg) {
                msg = @"share failed";
            }
            [self handleShareResult:error.code  result:nil  command:command];
            
        } else {
            [self handleShareResult:0  result:nil  command:command];
        }
    }];
    
}

- (void)openShare:(CDVInvokedUrlCommand*)command
{
    NSArray *args = command.arguments;
    NSArray *platforms = args[4];
    NSString *text = args[0];
    NSString *icon = args[1];
    NSString *link = args[2];
    NSString *title = args[3];
    
    
    
    NSMutableArray *plfs = [NSMutableArray array];
    for (NSNumber *plf in platforms) {
        [plfs addObject:@([self platformType:plf.integerValue])];
    }
    if (plfs.count > 0) {
        [UMSocialUIManager setPreDefinePlatforms:plfs];
    }
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWithText:text icon:icon link:link title:title platform:platformType completion:^(id result, NSError *error) {
            if (error) {
                NSString *msg = error.userInfo[@"NSLocalizedFailureReason"];
                if (!msg) {
                    msg = error.userInfo[@"message"];
                }if (!msg) {
                    msg = @"share failed";
                }
                [self handleShareResult:error.code result:nil command:command];
            } else {
                [self handleShareResult:0 result:nil command:command];
            }
        }];
    }];
}


- (void)getInfo:(CDVInvokedUrlCommand*)command
{
    NSArray *args = command.arguments;
    UMSocialPlatformType platform = [args[0] integerValue];
   
    
    UMSocialPlatformType plf = [self platformType:platform];
    if (plf == UMSocialPlatformType_UnKnown) {
        [self handleResult:-1 message:@"invalid platform" result:nil  command:command];
        return;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:plf currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSString *msg = error.userInfo[@"NSLocalizedFailureReason"];
            if (!msg) {
                msg = error.userInfo[@"message"];
            }if (!msg) {
                msg = @"share failed";
            }
            [self handleResult:error.code message:msg result:nil command:command];
            
        } else {
            UMSocialUserInfoResponse *authInfo = result;
            
            NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithCapacity:8];
            retDict[@"uid"] = authInfo.uid;
            retDict[@"openid"] = authInfo.openid;
            retDict[@"unionid"] = authInfo.unionId;
            retDict[@"accessToken"] = authInfo.accessToken;
            retDict[@"refreshToken"] = authInfo.refreshToken;
            retDict[@"expiration"] = [authInfo.expiration isKindOfClass:[NSDate class]]?[authInfo.expiration description]:authInfo.expiration;
            
            retDict[@"name"] = authInfo.name;
            retDict[@"iconurl"] = authInfo.iconurl;
            retDict[@"gender"] = authInfo.unionGender;
            
            NSDictionary *originInfo = authInfo.originalResponse;
            retDict[@"city"] = originInfo[@"city"];
            retDict[@"province"] = originInfo[@"province"];
            retDict[@"country"] = originInfo[@"country"];
            
            [self handleResult:0 message:nil result:retDict  command:command];
        }
    }];
}


- (NSInteger)switchCode:(NSInteger)code
{
    switch (code) {
        case 0: // success
            return 200;
            break;
        case 2009: // cancel
            return -1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)handleResult:(NSInteger)retCode message:(NSString *)message result:(NSDictionary *)result command:(CDVInvokedUrlCommand*)command
{
    NSInteger stCode = [self switchCode:retCode];
    
    if (stCode == 200) {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        NSDictionary *dict;
        if (stCode == -1) {
            dict = [NSDictionary dictionaryWithObjectsAndKeys:@"cancel",@"error", nil];
        }else{
            dict = [NSDictionary dictionaryWithObjectsAndKeys:message,@"error", nil];
        }
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)handleShareResult:(NSInteger)retCode  result:(NSDictionary *)result  command:(CDVInvokedUrlCommand*)command
{
    NSInteger stCode = [self switchCode:retCode];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:stCode];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
