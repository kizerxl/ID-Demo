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
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"space"]];

}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear: YES];
    
    [self.store fetchData];
    
    self.notesArray = self.store.notes; 
    
    [self.tableView reloadData];

}

-(void)checkForFingerPrint{
    
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Please verfiy your identity";
    
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
                                        
                                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Tsk tsk tsk..."
                                                                                                       message:@"It's a secret!!!"
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
                                                                           message:@"sorry we cannot hide your secrets.."
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
    NoteTableViewCell *cell = (NoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"noteCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"noteCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lockImage.image = [UIImage imageNamed: @"lockicon"];
    cell.noteTitle.text = currentNoteDisplay.title;
    cell.noteDate.text = [self formatDate : currentNoteDisplay.dateCreated];
    cell.backgroundColor = [UIColor clearColor];
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
        
        [self checkForFingerPrint];
        
    }
    else{
        
         [self performSegueWithIdentifier:@"secretNote" sender: nil];
    }
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    SecretNoteViewController *destVC = (SecretNoteViewController *)segue.destinationViewController;
    destVC.store = self.store; 
    
    NSIndexPath *curentIndexPath = [self.tableView indexPathForSelectedRow];
    
    if (curentIndexPath){
        
        destVC.passedNote = self.notesArray[curentIndexPath.row];
        
    }
    else{
    
        //if a cell is not clicked a new note is made and is the last object in the notes Array
        NSUInteger lastIdx = self.notesArray.count - 1;
        destVC.passedNote = self.notesArray[lastIdx];
    
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

-(NSAttributedString *)convertDataToString:(NSData *)contentData{

    NSAttributedString *contentString = [NSKeyedUnarchiver unarchiveObjectWithData: contentData];

    return contentString; 
}

- (IBAction)newNoteTapped:(id)sender {
    
    //let's make a new note
    
    NoteDisplay *newNoteDisplay = [NSEntityDescription insertNewObjectForEntityForName: @"NoteDisplay" inManagedObjectContext: self.store.managedObjectContext];
    
    newNoteDisplay.isLocked = [NSNumber numberWithBool: NO];
    newNoteDisplay.dateCreated = [NSDate date];
    newNoteDisplay.title = @"New Note";
    Note *newNote = [NSEntityDescription insertNewObjectForEntityForName: @"Note" inManagedObjectContext: self.store.managedObjectContext];
    
    newNoteDisplay.actualNote = newNote;
    
    [self.store saveContext];
    
    [self performSegueWithIdentifier:@"secretNote" sender: nil];

}

@end
