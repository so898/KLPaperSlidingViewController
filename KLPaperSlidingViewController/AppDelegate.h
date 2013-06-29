//
//  AppDelegate.h
//  KLPaperSlidingViewController
//
//  Created by so898 on 13-3-7.
//  Copyright (c) 2013年 R3 Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLPaperSlidingViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    KLPaperSlidingViewController *paperSlidingViewController;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
