//
//  WLClient.m
//  AFWunderlist-Demo
//
//  Created by Alvaro Franco on 2/1/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "WLClient.h"
#import "AFHTTPRequestOperationManager.h"

@implementation WLClient

-(id)init {
    
    if (self == [super init]) {
        _baseURL = @"https://api.wunderlist.com";
    }
    return self;
}

+(instancetype)sharedClient {
    
    static WLClient *sharedWLClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedWLClient = [[WLClient alloc] init];
        
    });
    
    return sharedWLClient;
}

-(BOOL)isLoged {
    
    if ([[NSUserDefaults standardUserDefaults]integerForKey:@"afwunderlistlogin"] == 1) {
        return  YES;
    } else {
        return NO;
    }
}

-(void)logout {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"afwunderlisttoken"];
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"afwunderlistlogin"];
}

-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)pass withCompletion:(statusBlock)completion {
    
    NSDictionary *params = @{@"email": email, @"password": pass};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/login",_baseURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject objectForKey:@"id"]) {
            [[NSUserDefaults standardUserDefaults]setValue:[responseObject objectForKey:@"token"] forKey:@"afwunderlisttoken"];
            [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"afwunderlistlogin"];
            NSLog(@"Successful login");
            completion(YES);
        } else {
            NSLog(@"Login error");
            completion(NO);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error at login: %@", error);
        completion(NO);
    }];
}

-(void)getListsWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me/lists",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

            completion(responseObject, YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getListWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)deleteListWithID:(NSString *)listID andCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager DELETE:[NSString stringWithFormat:@"%@/me/%@",_baseURL,listID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at deleteListWithID:andCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)createNewListWithTitle:(NSString *)title andCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        NSDictionary *params = @{@"title": title};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager POST:[NSString stringWithFormat:@"%@/me/lists",_baseURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at createNewListWithTitle:andCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)shareListWithID:(NSString *)listID withUser:(NSString *)email andCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        NSDictionary *params = @{@"email": email};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager POST:[NSString stringWithFormat:@"%@/%@/shares",_baseURL,listID] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getListSharesWithID:andCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getTasksWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me/tasks",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject, YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getTaskWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)createTaskWithTitle:(NSString *)title insideList:(NSString *)listID withCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        NSDictionary *params = @{@"list_id": listID, @"title": title};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager POST:[NSString stringWithFormat:@"%@/me/tasks",_baseURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at createTaskWithTitle:insideList:withCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)createComment:(NSString *)comment atTask:(NSString *)taskID withCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        NSDictionary *params = @{@"channel_id": taskID, @"channel_type": @"tasks", @"text": comment};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager POST:[NSString stringWithFormat:@"%@/tasks/%@/messages",_baseURL,taskID] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at createComment:atTask:withCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getTasksCommentsWithID:(NSString *)taskID andCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/tasks/%@/messages",_baseURL,taskID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject, YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getTaskCommentsWithID:andCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)deleteTaskWithID:(NSString *)taskID andCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager DELETE:[NSString stringWithFormat:@"%@/me/%@",_baseURL,taskID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at deleteTaskWithID:andCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getRemidersWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me/reminders",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject, YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getRemindersWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)createReminderAtTaskWithID:(NSString *)taskID withDate:(NSDate *)date andCompletion:(statusBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSString *ISODate = [dateFormatter stringFromDate:date];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        NSDictionary *params = @{@"task_id": taskID, @"date": ISODate};
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager POST:[NSString stringWithFormat:@"%@/me/reminders",_baseURL] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at createReminderAtTaskWithID:withDate:andCompletion: method: %@", error);
            completion(NO);
        }];
    } else {
        completion(NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getUserBasicInformationWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject,YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getUserBasicInformationWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getUserFriendsWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me/friends",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject,YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getUserFriendsWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

-(void)getUserSettingsWithCompletion:(responseBlock)completion {
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"]) {
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"afwunderlisttoken"];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
        [manager GET:[NSString stringWithFormat:@"%@/me/settings",_baseURL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            completion(responseObject,YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error at getUserSettingsWithCompletion: method: %@", error);
            completion(nil, NO);
        }];
    } else {
        completion(nil, NO);
        NSLog(@"You must be loged before making a request");
    }
}

@end
