//
//  Card.m
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import "Card.h"

@implementation Card

- (Card *)initWithTitle:(NSString *)passedTitle body:(NSString *)passedBody; {
    self = [super init];
    if (self) {
        _title = passedTitle;
        _body = passedBody;
    }
    return self;
}

@end
