//
//  UMPushModule.m
//  PhoneGap_Component
//
//  Created by wyq.Cloudayc on 30/09/2017.
//

#import "UMPushModule.h"
#import <UMPush/UMessage.h>

@implementation UMPushModule
- (void)addTag:(CDVInvokedUrlCommand*)command{
    NSLog(@"22222");
   NSString *tag = [command.arguments objectAtIndex:0];
    [UMessage addTags:tag response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
        long code = -1;
        int remainnum = 0;
        if (error) {
            code = error.code;
        }else{
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *respobj = responseObject;
                // 授权信息
                if ([[respobj allKeys] containsObject:@"success"]) {
                    if ([[respobj objectForKey:@"success"] isEqualToString:@"ok"]) {
                        code = 200 ;
                    }
                }
                if ([[respobj allKeys] containsObject:@"remain"]) {
                    remainnum = [[respobj objectForKey:@"remain"] intValue];
                }
            }
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLong:code],@"stcode",[NSNumber numberWithInt:remainnum],@"remain", nil];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
    }];
}
- (void)delTag:(CDVInvokedUrlCommand*)command{
    NSString *tag = [command.arguments objectAtIndex:0];
    [UMessage deleteTags:tag response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
        long code = -1;
        int remainnum = 0;
        if (error) {
            code = error.code;
        }else{
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *respobj = responseObject;
                // 授权信息
                if ([[respobj allKeys] containsObject:@"success"]) {
                    if ([[respobj objectForKey:@"success"] isEqualToString:@"ok"]) {
                        code = 200 ;
                    }
                }
                if ([[respobj allKeys] containsObject:@"remain"]) {
                    remainnum = [[respobj objectForKey:@"remain"] intValue];
                }
            }
        }
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithLong: code],@"stcode",[NSNumber numberWithInt:remainnum],@"remain", nil];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
    }];
}
- (void)listTag:(CDVInvokedUrlCommand*)command{
   
    [UMessage getTags:^(NSSet * _Nonnull responseTags, NSInteger remain, NSError * _Nonnull error) {
        int code = -1;
        NSString *tags = @"[";
        NSArray * tagsarray;
      
        if (error) {
            code = error.code;
        }else{
            if ([responseTags isKindOfClass:[NSSet class]]) {
                tagsarray = [responseTags allObjects];
                //                for (int i = 0; i < tagsarray.count; i++) {
                //                    NSString *str = tagsarray[i];
//                tags = [tagsarray componentsJoinedByString:@","];
//                //                }
//                tags = [tags stringByAppendingString:@"]"];
            }
        }
        
        NSLog(@"%@",tags);
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:tagsarray];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        //        callback(code,tags);
    }];
}
- (void)addAlias:(CDVInvokedUrlCommand*)command{
    NSString *alias = [command.arguments objectAtIndex:0];
   NSString *type = [command.arguments objectAtIndex:1];
    [UMessage addAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        int code = -1;
        int remainnum = 0;
        if (error) {
            code = error.code;
        }else{
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *respobj = responseObject;
                // 授权信息
                if ([[respobj allKeys] containsObject:@"success"]) {
                    if ([[respobj objectForKey:@"success"] isEqualToString:@"ok"]) {
                        code = 200 ;
                    }
                }
            }
        }
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
       
        
    }];
}
- (void)delAlias:(CDVInvokedUrlCommand*)command{
    NSString *alias = [command.arguments objectAtIndex:0];
    NSString *type = [command.arguments objectAtIndex:1];
    [UMessage removeAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        int code = -1;
        int remainnum = 0;
        if (error) {
            code = error.code;
        }else{
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *respobj = responseObject;
                // 授权信息
                if ([[respobj allKeys] containsObject:@"success"]) {
                    if ([[respobj objectForKey:@"success"] isEqualToString:@"ok"]) {
                        code = 200 ;
                    }
                }
            }
        }
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
    }];
}
- (void)setAlias:(CDVInvokedUrlCommand*)command{
    NSString *alias = [command.arguments objectAtIndex:0];
    NSString *type = [command.arguments objectAtIndex:1];
    [UMessage setAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        int code = -1;
        int remainnum = 0;
        if (error) {
            code = error.code;
        }else{
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *respobj = responseObject;
                // 授权信息
                if ([[respobj allKeys] containsObject:@"success"]) {
                    if ([[respobj objectForKey:@"success"] isEqualToString:@"ok"]) {
                        code = 200 ;
                    }
                }
            }
        }
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
    }];
}
@end
