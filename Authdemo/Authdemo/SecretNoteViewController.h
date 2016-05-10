//
//  SecretNoteViewController.h
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDisplay.h"
#import "NotesDataStore.h"

@interface SecretNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteContent;

@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (strong, nonatomic) NSLayoutConstraint *constrainAboveView;
@property (strong, nonatomic) NSLayoutConstraint *constrainOnView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsWidthConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *optionsHeightConstrain;

@property (strong, nonatomic) NoteDisplay *passedNote; 
@property (strong, nonatomic) NotesDataStore *store;

@end
