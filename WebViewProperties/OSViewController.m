//
//  OSViewController.m
//  WebViewProperties
//
//  Created by Florin Pop on 12/11/13.
//  Copyright (c) 2013 Objective Self. All rights reserved.
//

#import "OSViewController.h"

@interface OSViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *viewLoading;
@property (weak, nonatomic) IBOutlet UILabel *labelError;

@end

@implementation OSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewLoading.layer.cornerRadius = 7;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://objectiveself.com"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.viewLoading setHidden:NO];
    [self.labelError setHidden:YES];
    [self.webView setHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.viewLoading setHidden:YES];
    [self.labelError setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.viewLoading setHidden:YES];
    [self.labelError setHidden:NO];
    [self.webView setHidden:YES];
    self.labelError.text = [error localizedDescription];
}

@end
