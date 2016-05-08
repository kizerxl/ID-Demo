//
//  NotesTableViewController.m
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "NotesTableViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "SecretNoteViewController.h"


@interface NotesTableViewController ()
@end

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.store = [NotesDataStore sharedNotesDataStore];

    [self.store fetchData];
    
    self.notesArray = self.store.notes;
    
    
    UINib *cellNib = [UINib nibWithNibName:@"noteCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"noteCell"];
    

}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear: YES];
    
    [self.store fetchData];
    
    [self.tableView reloadData];

}

-(void)checkForFingerPrint{
    
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Secure password for your Notes!!!";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [self performSegueWithIdentifier:@"secretNote" sender:nil];
                                    });
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Naughty, Naughty!"
                                                                                                       message:@"Your picture will be taken and it will sent to the owner of the phone."
                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                        
                                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Good bye!" style:UIAlertActionStyleDefault
                                                                                              handler:^(UIAlertAction * action) {}];
                                        
                                        [alert addAction:defaultAction];
                                        [self presentViewController:alert animated:YES completion:nil];
                                    });
                                }
                            }];
    }
    
    
    
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Touch ID not supported"
                                                                           message:@"we will put something cool in here..."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
           [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
       });
    }




}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.notesArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NoteDisplay *currentNoteDisplay = self.notesArray[indexPath.row];
    NSString *currentNoteContentDisplay = currentNoteDisplay.actualNote.content;

     NoteTableViewCell *cell = (NoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"noteCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"noteCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lockImage.image = [UIImage imageNamed: @"lockicon"];
    cell.noteTitle.text = currentNoteDisplay.title;
    cell.noteDate.text = [self formatDate : currentNoteDisplay.dateCreated];
    
//    cell.cellDesc.text = currentNoteContentDisplay.length > 10 ? [[currentNoteContentDisplay substringWithRange: NSMakeRange(0, 10)] stringByAppendingString: @"..."]: currentNoteContentDisplay;
    
    cell.lockImage.hidden = ![NSNumber numberWithBool: currentNoteDisplay.isLocked];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65.0;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoteTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell.lockImage.hidden) {
        
//        [self unlockLockAnimation];
        [self checkForFingerPrint];
        
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecretNoteViewController *destVC = (SecretNoteViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString: @"secretNote"] ) {
        
        [self unlockLockAnimation];
        
    }

    
}

-(void)unlockLockAnimation{

    UIImage *openLockImage = [UIImage imageNamed: @"openLock"];

    //692 * 573
    self.unlock = [[UIImageView alloc]initWithFrame: CGRectMake(self.view.center.x - 172, self.view.center.y - 200, 345, 285)];
    self.unlock.image = openLockImage;
    
    [UIView animateKeyframesWithDuration: 3.0 delay: 0.0 options:UIViewKeyframeAnimationOptionCalculationModePaced animations:^{
        
        [UIView addKeyframeWithRelativeStartTime: 0.0 relativeDuration: 2.0 animations:^{
            
            [self.view addSubview: self.unlock];
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime: 2.0 relativeDuration: 0.8  animations:^{
            
            self.unlock.transform = CGAffineTransformScale(self.unlock.transform, 100.0, 100.0);
        }];
        
        [UIView addKeyframeWithRelativeStartTime: 2.8 relativeDuration: 0.2  animations:^{
            
            self.unlock.alpha = 0.0;
        }];
        
        
    } completion:^(BOOL finished) {
        
        //clean up
        [self.unlock removeFromSuperview];
    }];
    

    
}

-(NSString *)formatDate:(NSDate *)date{
    
    if(!self.dateFormater){
    
        self.dateFormater = [[NSDateFormatter alloc] init];
        [self.dateFormater setDateFormat:@"yyyy-MM-dd"];
        
    }
    
    NSString *dateString = [self.dateFormater stringFromDate: date];
    
    return dateString;
}


-(void)goOverLockedCellAnimation:(UIImage *)image{

    //might do an hover animation ? Is that even necessary?
    
   
}

@end
