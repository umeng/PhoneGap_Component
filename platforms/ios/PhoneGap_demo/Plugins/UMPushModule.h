//
//  UMPushModule.h
//  PhoneGap_Component
//
//  Created by wyq.Cloudayc on 30/09/2017.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface UMPushModule : CDVPlugin
- (void)addTag:(CDVInvokedUrlCommand*)command;
- (void)delTag:(CDVInvokedUrlCommand*)command;
- (void)listTag:(CDVInvokedUrlCommand*)command;
- (void)addAlias:(CDVInvokedUrlCommand*)command;
- (void)delAlias:(CDVInvokedUrlCommand*)command;
- (void)setAlias:(CDVInvokedUrlCommand*)command;
@end
