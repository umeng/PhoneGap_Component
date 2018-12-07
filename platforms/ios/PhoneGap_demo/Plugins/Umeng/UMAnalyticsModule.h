//
//  UMAnalyticsModule
//
//  Created by wangkai on 16-04-14.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>


@interface UMAnalyticsModule : CDVPlugin


- (void)onEvent:(CDVInvokedUrlCommand*)command;
- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command;
- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command;
- (void)onEventWithCounter:(CDVInvokedUrlCommand*)command;
- (void)onPageBegin:(CDVInvokedUrlCommand*)command;
- (void)onPageEnd:(CDVInvokedUrlCommand*)command;
- (void)profileSignInWithPUID:(CDVInvokedUrlCommand*)command;
- (void)profileSignInWithPUIDWithProvider:(CDVInvokedUrlCommand*)command;
- (void)profileSignOff:(NSArray *)arguments;

//游戏统计

- (void)setUserLevelId:(CDVInvokedUrlCommand*)command;
- (void)startLevel:(CDVInvokedUrlCommand*)command;
- (void)finishLevel:(CDVInvokedUrlCommand*)command;
- (void)failLevel:(CDVInvokedUrlCommand*)command;
- (void)exchange:(CDVInvokedUrlCommand*)command;
- (void)pay:(CDVInvokedUrlCommand*)command ;
- (void)payWithItem:(CDVInvokedUrlCommand*)command;
- (void)buy:(CDVInvokedUrlCommand*)command;
- (void)use:(CDVInvokedUrlCommand*)command;
- (void)bonus:(CDVInvokedUrlCommand*)command;
- (void)bonusWithItem:(CDVInvokedUrlCommand*)command;

//Dplus
- (void)track:(CDVInvokedUrlCommand*)command;
- (void)trackWithProperty:(CDVInvokedUrlCommand*)command;
- (void)registerSuperProperty:(CDVInvokedUrlCommand*)command;
- (void)unregisterSuperProperty:(CDVInvokedUrlCommand*)command;
- (void)getSuperProperty:(CDVInvokedUrlCommand*)command;
- (void)getSuperProperties:(CDVInvokedUrlCommand*)command;
- (void)clearSuperProperties:(CDVInvokedUrlCommand*)commands;
- (void)setFirstLaunchEvent:(CDVInvokedUrlCommand*)command;

@end
