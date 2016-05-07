//
//  SecretNoteViewController.m
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "SecretNoteViewController.h"

@interface SecretNoteViewController ()

@end

@implementation SecretNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.constrainAboveView = [self.optionsView.bottomAnchor constraintEqualToAnchor: self.view.topAnchor ];
    self.constrainAboveView.active = YES;
    
    
}
//
//
//- (void)goBack:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)toggleOptions{

    self.constrainAboveView.active = !self.constrainAboveView.active;
    self.constrainOnView.active = !self.constrainAboveView.active;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)toggleButtonTapped:(id)sender {
    
    [self toggleOptions]; 
}
@end
