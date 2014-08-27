//
//  AISTestDemoViewController.m
//  AISTestDemo
//
//  Created by 李晓川 on 11-8-11.
//  Copyright 2011 哈尔滨理工大学. All rights reserved.
//

#import "AISTestDemoViewController.h"


@implementation AISTestDemoViewController

@synthesize alert;
@synthesize pv;
- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	//NSString *responseString = [request responseString];
	
	// Use when fetching binary data
	//NSData *responseData = [request responseData];
	
	[alert dismissWithClickedButtonIndex:0 animated:YES];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSURL *url = [NSURL URLWithString:@"http://192.168.1.101/2012/download/test.jar"];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
	
	alert = [[UIAlertView alloc] initWithTitle:@""
														message:NSLocalizedString(@"Please wait...",nil) 
													   delegate:self 
											  cancelButtonTitle:nil
											  otherButtonTitles:nil];
    
	
    pv = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f, 225.0f, 90.0f)];
    [pv setProgressViewStyle:UIProgressViewStyleBar];
	[alert addSubview:pv];
	
	//[self.view removeFromSuperview];
	
	[request setDownloadProgressDelegate:pv];
	
	[request setShowAccurateProgress:YES];
	[alert show];
	
	
    [super viewDidLoad];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[pv release];
	[alert release];
    [super dealloc];
}

@end
