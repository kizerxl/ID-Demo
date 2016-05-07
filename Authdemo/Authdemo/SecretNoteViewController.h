//
//  SecretNoteViewController.h
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteContent;

@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (strong, nonatomic)NSLayoutConstraint *constrainAboveView;
@property (strong, nonatomic)NSLayoutConstraint *constrainOnView;
- (IBAction)toggleButtonTapped:(id)sender;



@end
