//
//  CardViewController.h
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFObject;

@interface CardViewController : UIViewController

- (CardViewController *)initWithCard:(PFObject *)passedCard;

@end
