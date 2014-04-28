//
//  ListViewController.h
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (readonly) NSMutableArray *cards;

- (ListViewController *) initWithCards:(NSMutableArray *)cards;

@end
