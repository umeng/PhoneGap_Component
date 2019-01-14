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

- (void)registerPreProperties:(CDVInvokedUrlCommand*)command;
- (void)unregisterPreProperty:(CDVInvokedUrlCommand*)command;
- (void)getPreProperties:(CDVInvokedUrlCommand*)command;
- (void)clearPreProperties:(CDVInvokedUrlCommand*)commands;
- (void)setFirstLaunchEvent:(CDVInvokedUrlCommand*)command;

@end
