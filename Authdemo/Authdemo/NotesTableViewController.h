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

@interface NotesTableViewController : UITableViewController

@property (strong, nonatomic)NSArray *notesArray;
@property (strong, nonatomic)NotesDataStore *store; 

@end
