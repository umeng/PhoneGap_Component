//
//  UMAnalyticsModule
//
//  Created by wangkai on 16-04-14.
//
//

#import "UMAnalyticsModule.h"
#import <UMAnalytics/MobClick.h>



@interface UMAnalyticsModule ()

#if __has_feature(objc_arc)
@property (nonatomic, strong) NSString *currPageName;
#else
@property (nonatomic, retain) NSString *currPageName;
#endif

@end

@implementation UMAnalyticsModule

#if __has_feature(objc_arc)
#else
- (void)dealloc {
    [super dealloc];
}
#endif




- (void)onEvent:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    [MobClick event:eventId];
}

- (void)onEventWithLabel:(CDVInvokedUrlCommand*)command{
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *eventLabel = [command.arguments objectAtIndex:1];
    if ([eventLabel isKindOfClass:[NSNull class]]) {
        eventLabel = nil;
    }
    [MobClick event:eventId label:eventLabel];
}

- (void)onEventWithParameters:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSDictionary *parameters = [command.arguments objectAtIndex:1];
    if (parameters == nil && [parameters isKindOfClass:[NSNull class]]) {
        parameters = nil;
    }
    [MobClick event:eventId attributes:parameters];
}

- (void)onEventWithCounter:(CDVInvokedUrlCommand*)command {
    NSString *eventId = [command.arguments objectAtIndex:0];
    if (eventId == nil || [eventId isKindOfClass:[NSNull class]]) {
        return;
    }
    NSDictionary *parameters = [command.arguments objectAtIndex:1];
    if (parameters == nil && [parameters isKindOfClass:[NSNull class]]) {
        parameters = nil;
    }
    NSString *eventNum = [command.arguments objectAtIndex:2];
    if (eventNum == nil && [eventNum isKindOfClass:[NSNull class]]) {
        eventNum = nil;
    }
    int num = [eventNum intValue];
    [MobClick event:eventId attributes:parameters counter:num];
}

- (void)onPageBegin:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    [MobClick beginLogPageView:pageName];
}

- (void)onPageEnd:(CDVInvokedUrlCommand*)command {
    NSString *pageName = [command.arguments objectAtIndex:0];
    if (pageName == nil || [pageName isKindOfClass:[NSNull class]]) {
        return;
    }
    [MobClick endLogPageView:pageName];
}

- (void)profileSignInWithPUID:(CDVInvokedUrlCommand*)command  {
    NSString *puid = [command.arguments objectAtIndex:0];
    if (puid == nil || [puid isKindOfClass:[NSNull class]]) {
        return;
    }
    [MobClick profileSignInWithPUID:puid];
}

- (void)profileSignInWithPUIDWithProvider:(CDVInvokedUrlCommand*)command {
    NSString *provider = [command.arguments objectAtIndex:0];
    if (provider == nil && [provider isKindOfClass:[NSNull class]]) {
        provider = nil;
    }
    NSString *puid = [command.arguments objectAtIndex:1];
    if (puid == nil || [puid isKindOfClass:[NSNull class]]) {
        return;
    }
    
    [MobClick profileSignInWithPUID:puid provider:provider];
}

- (void)profileSignOff:(NSArray *)arguments {
    [MobClick profileSignOff];

}

- (void)registerPreProperties:(CDVInvokedUrlCommand*)command {
    NSDictionary *property = [command.arguments objectAtIndex:0];
    [MobClick registerPreProperties:property];
}

- (void)unregisterPreProperty:(CDVInvokedUrlCommand*)command {
    NSString *propertyName = [command.arguments objectAtIndex:0];
    if (propertyName == nil || [propertyName isKindOfClass:[NSNull class]]) {
        return;
    }
    [MobClick unregisterPreProperty:propertyName];
}

- (void)getPreProperties:(CDVInvokedUrlCommand*)command {
    
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[MobClick getPreProperties]
                                                       options:kNilOptions //TODO: NSJSONWritingPrettyPrinted  // kNilOptions
                                                         error:&error];
    if ([jsonData length] && (error == nil))
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ;
    }else{
        jsonString=@"";
    }
    NSString *callBack = [NSString stringWithFormat:@"getPreProperties('%@')",jsonString];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:callBack];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}

- (void)clearPreProperties:(CDVInvokedUrlCommand*)commands {
    [MobClick clearPreProperties];
}

- (void)setFirstLaunchEvent:(CDVInvokedUrlCommand*)command {
    NSArray *eventList = [command.arguments objectAtIndex:0];
    [MobClick setFirstLaunchEvent:eventList];
}

@end
