//
//  SecretNoteViewController.m
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "SecretNoteViewController.h"

@interface SecretNoteViewController () <UITextViewDelegate>

@end

@implementation SecretNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.noteContent.delegate = self; 
    [self load];
    
    self.optionsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.constrainAboveView = [self.optionsView.bottomAnchor constraintEqualToAnchor: self.view.topAnchor];
    self.constrainOnView = [self.optionsView.topAnchor constraintEqualToAnchor: self.view.topAnchor];
    
    self.constrainAboveView.active = YES;
    self.constrainOnView.active = NO;

   
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear: YES];
    
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear: YES];
    
    NSString *titleSubstring = [self.noteContent attributedText].string.length > 0 ?[self.noteContent attributedText].string : @"Empty Note";
    self.passedNote.title = titleSubstring.length > 10 ? [[titleSubstring substringWithRange: NSMakeRange(0, 10)] stringByAppendingString: @"..."]: titleSubstring;

    [self save];
    
}


//-(void)toggleOptions{
//
//    self.constrainAboveView.active = !self.constrainAboveView.active;
//    self.constrainOnView.active = !self.constrainOnView.active;
//    
//    
//}

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

-(void)save{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: [self.noteContent attributedText]];
    
    self.passedNote.actualNote.content = data;
    self.passedNote.dateCreated = [NSDate date];
    
    [self.store saveContext];
    
    NSLog(@"note saved!!!!!!!!!!!");
    
}



-(void)load{

    NSData *content = self.passedNote.actualNote.content;
    
    if (content) {
        
        self.noteContent.attributedText = [NSKeyedUnarchiver unarchiveObjectWithData: content];
    }


}

- (void)textViewDidChange:(UITextView *)textView{

    [self save];

}

@end
