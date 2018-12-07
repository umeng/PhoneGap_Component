//
//  UMShareModule.h
//  PhoneGap_Component
//
//  Created by wyq.Cloudayc on 30/09/2017.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface UMShareModule : CDVPlugin

- (void)getInfo:(CDVInvokedUrlCommand*)command;
@end
