//
//  NotesDisplay.m
//  Autodemo
//
//  Created by Felix Changoo on 5/8/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "NotesDisplay.h"

@interface NotesDisplay () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableSet *expandedIndexPaths;
@property (strong, nonatomic) NSArray *notesArray;

@end

@implementation NotesDisplay

static NSString * const cellIdentifier = @"noteCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:NSStringFromClass([NoteTableViewCell class])
                                    bundle:nil];
    [self.tableView registerNib:cellNib
         forCellReuseIdentifier: cellIdentifier];
//    self.expandedIndexPaths = [NSMutableSet set];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    self.title = @"Foldable UITableViewCells";
    
    //let's load test data
    self.store = [NotesDataStore sharedNotesDataStore];
    [self.store fetchData];
    
    self.notesArray = self.store.notes;
    
    self.title = @"SECRET";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    NoteDisplay *currentNoteDisplay = self.notesArray[indexPath.row];
    
//    NSString *currentNoteContentDisplay = currentNoteDisplay.actualNote.content;
    
    cell.lockImage.image = [UIImage imageNamed: @"lockicon"];
    cell.noteTitle.text = currentNoteDisplay.title;
    cell.noteDate.text = [self formatDate : currentNoteDisplay.dateCreated];
    cell.lockImage.hidden = ![NSNumber numberWithBool: currentNoteDisplay.isLocked];

    
//    cell.cellDesc.text = currentNoteContentDisplay.length > 10 ? [[currentNoteContentDisplay substringWithRange: NSMakeRange(0, 10)] stringByAppendingString: @"..."]: currentNoteContentDisplay;
//    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"clicked the damn cell"); 
    
    
//    if ([self.expandedIndexPaths containsObject:indexPath]) {
//        BookCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
//        [cell animateClosed];
//        [self.expandedIndexPaths removeObject:indexPath];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    } else {
//        [self.expandedIndexPaths addObject:indexPath];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        
//        BookCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
//        [cell animateOpen];
//    }
}

-(NSString *)formatDate:(NSDate *)date{
    
    if(!self.dateFormater){
        
        self.dateFormater = [[NSDateFormatter alloc] init];
        [self.dateFormater setDateFormat:@"yyyy-MM-dd"];
        
    }
    
    NSString *dateString = [self.dateFormater stringFromDate: date];
    
    return dateString;
}

#pragma mark - Private


@end
