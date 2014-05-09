//
//  NewCardViewController.m
//  trello-client
//
//  Created by Simon Chaffetz on 5/1/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import "NewCardViewController.h"
#import "Parse/Parse.h"

@interface NewCardViewController ()

- (IBAction)didPressSubmit:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *bodyField;

@end

@implementation NewCardViewController

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleField.delegate = self;
    self.bodyField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressSubmit:(id)sender {
    NSString *title = self.titleField.text;
    NSString *body = self.bodyField.text;
    PFObject *card = [PFObject objectWithClassName:@"Card"];
    [card setObject:title forKey:@"title"];
    [card setObject:body forKey:@"body"];
    // TODO: check if delegate responds to addCard selector
    if ([delegate respondsToSelector:@selector(addCard:)]) {
        [delegate addCard:card];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
