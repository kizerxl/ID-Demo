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
    NSString *myLocalizedReasonString = @"Super secure password provided by Touch ID";
    
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
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Wrong pass mother******"
                                                                           message:@"U f****d up...."
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
//
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
////    if (indexPath.section == 0 && indexPath.row == 2) {
////        
////        [self checkForFingerPrint];
////    }
//
//
//}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NoteDisplay *currentNoteDisplay = self.notesArray[indexPath.row];

     NoteTableViewCell *cell = (NoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"noteCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"noteCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.cellDesc.text = currentNoteDisplay.title;
    cell.lockImage.image = [UIImage imageNamed: @"lockicon"];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0;


}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NoteTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell.lockImage.hidden) {
        
//        [UIView animateWithDuration: 2.5 animations:^{
//            
//            cell.lockImage.image = [UIImage imageNamed: @"lock-2"];
//            cell.lockImage.transform = CGAffineTransformRotate(cell.lockImage.transform, M_PI);
////            [self.tableView layoutIfNeeded];
//            [
//        }];
        
//
        
//        [self checkForFingerPrint];
        
        
        [self unlockLockAnimation]; 
    }
    


}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    


}

-(void)unlockLockAnimation{

    UIImage *firstLockImage = [UIImage imageNamed: @"endLock"];
    UIImage *endLockImage = [UIImage imageNamed: @"endLock"];


    UIImageView *firstLock = [[UIImageView alloc]initWithFrame: CGRectMake(self.view.center.x + 40
                                                                           , self.view.center.y, 100, 100)];
    firstLock.image = firstLockImage;

    
    [UIView animateKeyframesWithDuration: .8 delay: 0.0 options: UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
    

                [self.tableView addSubview: firstLock];

    } completion:nil];
    


}

-(void)goOverLockedCellAnimation:(UIImage *)image{

   
}

@end
