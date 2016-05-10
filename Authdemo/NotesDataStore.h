//
//  NotesDataStore.h
//  Autodemo
//
//  Created by Felix Changoo on 4/27/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Note.h"
#import "NoteDisplay.h"

@interface NotesDataStore : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (instancetype) sharedNotesDataStore;
- (void)fetchData; 

@property (strong, nonatomic)NSArray *notes;

@end
