//
//  main.m
//  Fautauwstroom
//
//  Created by Matthias on 20/09/13.
//  Copyright (c) 2013 Matthias. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Library/Application Support/iLifeAssetManagement/assets/sub/"];
        NSFileManager *localFileManager=[[NSFileManager alloc] init];
        NSDirectoryEnumerator *dirEnum =[localFileManager enumeratorAtPath:docsDir];
        
        NSError* error = nil;
        NSString *file;
        NSMutableArray *imagesList = [[NSMutableArray alloc] init];
        int count = 0;
        while ((file = [dirEnum nextObject]))
        {
            if ([[file pathExtension] isEqualToString: @"JPG"])
            {
                // process the document
                
               // NSString *lastPath = [file lastPathComponent];

                NSString *imgString = [docsDir stringByAppendingPathComponent:file];
                count++;
                NSDictionary* properties = [[NSFileManager defaultManager]attributesOfItemAtPath:imgString error:&error];
                NSDate* modDate = [properties objectForKey:NSFileModificationDate];
                if(error == nil)
                {
                    [imagesList addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   imgString, @"path",
                                                   modDate, @"lastModDate",
                                                   nil]];
                }
                
                
                //[imagesList addObject:imgString];
               
               // NSLog(@"%@", imgString);
                //[self scanDocument: [docsDir stringByAppendingPathComponent:file]];
       
            }
            
        }
       // NSArray *sortedStrings  = [imagesList sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        
        NSArray* sortedFiles = [imagesList sortedArrayUsingComparator:
                                ^(id path1, id path2)
                                {
                                    // compare
                                    NSComparisonResult comp = [[path1 objectForKey:@"lastModDate"] compare:[path2 objectForKey:@"lastModDate"]];
                                    // invert ordering
                                    if (comp == NSOrderedDescending) {
                                        comp = NSOrderedAscending;
                                    }
                                    else if(comp == NSOrderedAscending){
                                        comp = NSOrderedDescending;
                                    }
                                    return comp;
                                }];

        NSMutableArray *finalList = [[NSMutableArray alloc]init];
        NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"\""];
        for (int i = 0; i < [sortedFiles count]; i++)
        {
                 NSString *kak = [[sortedFiles[i] valueForKey:@"path"] stringByTrimmingCharactersInSet:chs];
            NSLog(@"%@", kak);
            [finalList addObject:kak];
            
        }
        
   
        
        //NSLog(@"%@",[sortedFiles valueForKey:@"path"]);
        NSLog(@"%@", finalList);
        NSLog(@"%i", count);
        
    }
    return 0;
   }
    
    
    /*
    
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsPath = [searchPaths objectAtIndex: 0];
    
    NSError* error = nil;
    NSArray* filesArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath error:&error];
    if(error != nil) {
        NSLog(@"Error in reading files: %@", [error localizedDescription]);
        return;
    }
    
    // sort by creation date
    NSMutableArray* filesAndProperties = [NSMutableArray arrayWithCapacity:[filesArray count]];
    for(NSString* file in filesArray)
    {
        NSString* filePath = [iMgr.documentsPath stringByAppendingPathComponent:file];
        NSDictionary* properties = [[NSFileManager defaultManager]
                                    attributesOfItemAtPath:filePath
                                    error:&error];
        NSDate* modDate = [properties objectForKey:NSFileModificationDate];
        
        if(error == nil)
        {
            [filesAndProperties addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                           file, @"path",
                                           modDate, @"lastModDate",
                                           nil]];
        }
    }
    
    // sort using a block
    // order inverted as we want latest date first
    NSArray* sortedFiles = [filesAndProperties sortedArrayUsingComparator:
                            ^(id path1, id path2)
                            {
                                // compare
                                NSComparisonResult comp = [[path1 objectForKey:@"lastModDate"] compare:
                                                           [path2 objectForKey:@"lastModDate"]];
                                // invert ordering
                                if (comp == NSOrderedDescending) {
                                    comp = NSOrderedAscending;
                                }
                                else if(comp == NSOrderedAscending){
                                    comp = NSOrderedDescending;
                                }
                                return comp;
                            }];
}
*/
// ~/Library/Application Support/iLifeAssetManagement/assets/sub

