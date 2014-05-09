//
//  NewCardViewController.h
//  trello-client
//
//  Created by Simon Chaffetz on 5/1/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@protocol AddCardDelegate <NSObject>

- (void) addCard:(PFObject *)newcard;

@end

@interface NewCardViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, assign) id delegate;

@end
