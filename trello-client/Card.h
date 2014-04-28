//
//  Card.h
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (readonly) NSString* title;
@property (readonly) NSString* body;

- (Card *)initWithTitle:(NSString *)passedTitle body:(NSString *)passedBody;

@end
