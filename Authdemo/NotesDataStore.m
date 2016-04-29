//
//  NotesDataStore.m
//  Autodemo
//
//  Created by Felix Changoo on 4/27/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import "NotesDataStore.h"

@implementation NotesDataStore

@synthesize managedObjectContext = _managedObjectContext;

# pragma mark - Singleton

+ (instancetype)sharedNotesDataStore {
    static NotesDataStore *_sharedNotesDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNotesDataStore = [[NotesDataStore alloc] init];
    });
    
    return _sharedNotesDataStore;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NoteModel.sqlite"];
    
    NSError *error = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NoteModel" withExtension:@"momd"];
    
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - test data

- (void)fetchData
{
    
    NSFetchRequest *notesRequest = [NSFetchRequest fetchRequestWithEntityName: @"NoteDisplay"];
    
    self.notes = [self.managedObjectContext executeFetchRequest: notesRequest error: nil];
    
    if (self.notes.count == 0) {
        [self createTestData];
        NSLog(@"Notes count is now: %lu", self.notes.count);
    }
    
}

-(void)createTestData{
    
    NotesDataStore *store = [NotesDataStore sharedNotesDataStore];
   
    // NotesDispaly
//    @property (nullable, nonatomic, retain) NSNumber *isLocked;
//    @property (nullable, nonatomic, retain) NSDate *dateCreated;
//    @property (nullable, nonatomic, retain) NSString *title;
//    @property (nullable, nonatomic, retain) Note *actualNote;
    
    //Note
//    @property (nullable, nonatomic, retain) NSString *content;
//    @property (nullable, nonatomic, retain) NoteDisplay *notedisplay;
    
    
    NoteDisplay *noteDisplay1 = [NSEntityDescription insertNewObjectForEntityForName: @"NoteDisplay" inManagedObjectContext: store.managedObjectContext];
    noteDisplay1.isLocked = [NSNumber numberWithBool: YES];
    
    noteDisplay1.dateCreated = [NSDate date];
    noteDisplay1.title = @"Randooooonesssssssss";
    
    Note *note1 = [NSEntityDescription insertNewObjectForEntityForName: @"Note" inManagedObjectContext: store.managedObjectContext];
    note1.content = @"This is soooo random man. I just thought I would let you know";
    
    noteDisplay1.actualNote = note1;
    
    NoteDisplay *noteDisplay2 = [NSEntityDescription insertNewObjectForEntityForName: @"NoteDisplay" inManagedObjectContext: store.managedObjectContext];
    noteDisplay2.isLocked = [NSNumber numberWithBool: YES];
    
    
    noteDisplay2.dateCreated = [NSDate date];
    noteDisplay2.title = @"Just a cool note";
    
    Note *note2 = [NSEntityDescription insertNewObjectForEntityForName: @"Note" inManagedObjectContext: store.managedObjectContext];
    note2.content = @"I thought it would be cool to write stuff in here!!!!!!";

    noteDisplay2.actualNote = note2;
    
    
    [self saveContext];
    
    
}

@end
