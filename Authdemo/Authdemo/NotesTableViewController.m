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
    
    UINib *cellNib = [UINib nibWithNibName:@"noteCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"noteCell"];
    [self createTestData];
    
}

-(void)checkForFingerPrint{
    
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Touch ID Test to show Touch ID working in a custom app";
    
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

//purpose of this method is to run test data to populate table till core data implementation
-(void)createTestData{

    self.notesArray = [@[@"note1", @"I'm a happy boy", @"little girl swag", @"got that swag juice girl"]mutableCopy];


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

    NSString *currentNote = self.notesArray[indexPath.row];

     NoteTableViewCell *cell = (NoteTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"noteCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"noteCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.cellDesc.text = currentNote;
    cell.lockImage.image = [UIImage imageNamed: @"lock-2"]; 
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;


}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    


}



@end
