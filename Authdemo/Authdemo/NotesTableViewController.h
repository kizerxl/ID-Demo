//
//  NotesTableViewController.h
//  Authdemo
//
//  Created by Felix Changoo on 2/29/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteTableViewCell.h"
#import "NotesDataStore.h"
#import "SecretNoteViewController.h"
#import "Note.h"
#import "NoteDisplay.h"

@interface NotesTableViewController : UITableViewController

- (IBAction)newNoteTapped:(id)sender;
@property (strong, nonatomic)NSArray *notesArray;
@property (strong, nonatomic)NotesDataStore *store; 
@property (strong, nonatomic)UIImageView *unlock;
@property (strong, nonatomic)NSDateFormatter *dateFormater; 
@end
