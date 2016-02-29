//
//  ViewController.m
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

-(void)viewWillAppear:(BOOL)animated{

        LAContext *myContext = [[LAContext alloc] init];
        NSError *authError = nil;
        NSString *myLocalizedReasonString = @"Touch ID Test to show Touch ID working in a custom app";
        
        if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
            [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                      localizedReason:myLocalizedReasonString
                                reply:^(BOOL success, NSError *error) {
                                    if (success) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [self performSegueWithIdentifier:@"gotIn" sender:nil];
                                        });
                                    } else {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                message: @"Yup, just cancel and walk away"
                                                                                               delegate:self
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles:nil, nil];
                                            [alertView show];
                                            // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
                                        });
                                    }
                                }];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Give up, this phone is not for you :P"
                                                                    message:authError.description
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
                // Rather than show a UIAlert here, use the error to determine if you should push to a keypad for PIN entry.
            });
        }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    

}


@end
