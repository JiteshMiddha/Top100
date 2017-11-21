//
//  AppDelegate.h
//  Top100
//
//  Created by Jitesh Middha on 21/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

