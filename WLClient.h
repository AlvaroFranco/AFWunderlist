//
//  WLClient.h
//  AFWunderlist-Demo
//
//  Created by Alvaro Franco on 2/1/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLClient : NSObject

@property (nonatomic, strong) NSString *baseURL;

typedef void (^statusBlock)(BOOL success);
typedef void (^responseBlock)(NSDictionary *response, BOOL success);

+(instancetype)sharedClient;

-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)pass withCompletion:(statusBlock)completion;
-(void)logout;
-(BOOL)isLoged;

-(void)getListsWithCompletion:(responseBlock)completion;
-(void)createNewListWithTitle:(NSString *)title andCompletion:(statusBlock)completion;
-(void)deleteListWithID:(NSString *)listID andCompletion:(statusBlock)completion;
-(void)shareListWithID:(NSString *)listID withUser:(NSString *)email andCompletion:(statusBlock)completion;

-(void)getTasksWithCompletion:(responseBlock)completion;
-(void)createTaskWithTitle:(NSString *)title insideList:(NSString *)listID withCompletion:(statusBlock)completion;
-(void)createComment:(NSString *)comment atTask:(NSString *)taskID withCompletion:(statusBlock)completion;
-(void)getTasksCommentsWithID:(NSString *)taskID andCompletion:(responseBlock)completion;
-(void)deleteTaskWithID:(NSString *)taskID andCompletion:(statusBlock)completion;

-(void)getRemidersWithCompletion:(responseBlock)completion;
-(void)createReminderAtTaskWithID:(NSString *)taskID withDate:(NSDate *)date andCompletion:(statusBlock)completion;

-(void)getUserBasicInformationWithCompletion:(responseBlock)completion;
-(void)getUserFriendsWithCompletion:(responseBlock)completion;
-(void)getUserSettingsWithCompletion:(responseBlock)completion;

@end
