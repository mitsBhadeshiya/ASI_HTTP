//
//  FirstViewController.m
//  TestNSURL
//
//  Created by MitulB on 18/05/15.
//  Copyright (c) 2015 com. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize arrList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDataFromAPI];
}


-(void)getDataFromAPI
{
    NSURL *aUrl = [NSURL URLWithString:@"http://45.55.140.34/webservice/index.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request setHTTPMethod:@"POST"];

    /*
    [dictParam setValue:@"userfavorite" forKey:@"action"];
    [dictParam setValue:@"usersList" forKey:@"type"];
    [dictParam setValue:@"1" forKey:@"userid"];
     */
    
    NSString *postString = @"action=userfavorite&type=usersList&userid=1";
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection= [[NSURLConnection alloc] initWithRequest:request
                                                                 delegate:self];
    if (connection) {
        receiveData = [NSMutableData data];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark -
#pragma mark - NSURL CONNECTION DELEGATE

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    receiveData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [receiveData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSError *jsonError;
    
    // 2
    NSDictionary *notesJSON =
    [NSJSONSerialization JSONObjectWithData:receiveData
                                    options:NSJSONReadingAllowFragments
                                      error:&jsonError];

    arrList = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dict in [notesJSON objectForKey:@"teamList"]){
        [arrList addObject:dict];
    }
    [tblList reloadData];
    
    NSLog(@"Not %@", notesJSON);
    if (!jsonError) {
        // TODO 2: More coming here!
    }
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"GETTING ERROR %@", error);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [arrList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [arrList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"username"];
    cell.detailTextLabel.text = [dict objectForKey:@"useremail"];
    
    return cell;
    
}



@end
