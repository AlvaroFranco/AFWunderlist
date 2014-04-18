AFWunderlist
============

[![Build Status](https://travis-ci.org/AlvaroFranco/AFWunderlist.svg?branch=master)](https://travis-ci.org/AlvaroFranco/AFWunderlist)
[![alt text](https://cocoapod-badges.herokuapp.com/v/AFWunderlist/badge.png "")]()
[![alt text](https://cocoapod-badges.herokuapp.com/p/AFWunderlist/badge.png "")]()
[![alt text](https://camo.githubusercontent.com/f513623dcee61532125032bbf1ddffda06ba17c7/68747470733a2f2f676f2d736869656c64732e6865726f6b756170702e636f6d2f6c6963656e73652d4d49542d626c75652e706e67 "")]()

A Wunderlist API wrapper for Objective-C

##CocoaPods

AFWunderlist is on [CocoaPods](http://cocoapods.org), so you can get the pod by adding this line to your Podfile

    pod 'AFWunderlist', '~> 1.1'

##Usage

In order to use AFWunderlist, you also need to import to your project [AFNetworking](https://github.com/AFNetworking/AFNetworking), by [Mattt](https://twitter.com/mattt). If you're using CocoaPods, AFNetworking will be installed for you. Done this, you have to import the WLClient class into your class or classes.

    #import "WLClient.h"

Then, use the shared client to run your methods (almost all methods use blocks).

    [[WLClient sharedClient]getUserFriendsWithCompletion:^(NSDictionary *response, BOOL success) {
      //Handle the response over there, that will be a BOOL telling you if the request has been successful and, in some cases, a NSDictionary with the data retreived.
    }];

With this you're ready to go!

##Methods

All the methods are executed like that

If they have a block:

    [[WLClient sharedClient]aRandomMethod:^(NSDictionary *response, BOOL success) {
      //Handle the completion block
    }];

If they have not a block:

    [[WLClient sharedClient]logout];

Here you have all the methods that are available by the moment:

####User-related

    loginWithEmail:(NSString *)email andPassword:(NSString *)pass withCompletion:(statusBlock)completion;

Returns a token that AFWunderlist will use for making all the requests

    getUserBasicInformationWithCompletion:(responseBlock)completion;

Returns a dictionary with the user basic information

    getUserFriendsWithCompletion:(responseBlock)completion;

Returns a dictionary with the user friends list

    getUserSettingsWithCompletion:(responseBlock)completion;

Returns a dictionary with the settings that the user is using in the official Wunderlist client

    logout;

Remove the token stored for making the requests

    isLoged;

If it's true, means that the user is loged, I mean, AFWunderlist have the token. If it's false, the user is not loged and no request could be made

####Lists-related

    getListsWithCompletion:(responseBlock)completion;

Returns a dictionary with all the lists

    createNewListWithTitle:(NSString *)title andCompletion:(statusBlock)completion;

Create a list by passing the method the title which that new list will have

    deleteListWithID:(NSString *)listID andCompletion:(statusBlock)completion;

Delete a list by passing the method the list ID that you want to delete

    shareListWithID:(NSString *)listID withUser:(NSString *)email andCompletion:(statusBlock)completion;

Share a list with other person by passing the method the list ID and the email of the recipient

####Tasks-related

    getTasksWithCompletion:(responseBlock)completion;

Returns a dictionary with all the tasks

    createTaskWithTitle:(NSString *)title insideList:(NSString *)listID withCompletion:(statusBlock)completion;

Create a task by passing the method the title which that new list will have and the list ID

    createComment:(NSString *)comment atTask:(NSString *)taskID withCompletion:(statusBlock)completion;

Create a comment inside a task by passing the method the comment text and the task ID

    getTasksCommentsWithID:(NSString *)taskID andCompletion:(responseBlock)completion;

Returns a dictionary with all the comments inside a task

    deleteTaskWithID:(NSString *)taskID andCompletion:(statusBlock)completion;

Delete a task by passing the method the task ID that you want to delete

####Reminder-related

    getRemidersWithCompletion:(responseBlock)completion;

Returns a dictionary with all the reminders

    createReminderAtTaskWithID:(NSString *)taskID withDate:(NSDate *)date andCompletion:(statusBlock)completion;

Create a comment inside a task by passing the method the task ID and the date

##License

AFWunderlist is under MIT License.

##Contact
Made by Alvaro Franco. If you have any question, feel free to drop me a line at [alvarofrancoayala@gmail.com](mailto:alvarofrancoayala@gmail.com)