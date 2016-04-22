//
//  ViewController.m
//  demo
//
//  Created by Mac on 16/4/12.
//  Copyright © 2016年 __ZYX. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface ViewController () <SDWebImageManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:imageView];
    
    
    [imageView  setShowActivityIndicatorView:YES];
    
    [imageView setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://bcs.img.r1.91.com/data/upload/2014/09_13/23/201409132316102240.jpg"] placeholderImage:nil]; // 缓存图片
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    manager.delegate = self;
    
    [manager.imageDownloader downloadImageWithURL:[NSURL URLWithString:@"http://bcs.img.r1.91.com/data/upload/2014/09_13/23/201409132316102240.jpg"] options:SDWebImageDownloaderContinueInBackground  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        NSLog(@"---save image is %@",image);
        
        [manager.imageCache storeImage:image forKey:@"one" toDisk:YES];
        
    }];
    
    
    //     从缓存取图片并显示
    SDWebImageManager *manager1 = [[SDWebImageManager alloc] init];
    UIImage *image = [manager1.imageCache imageFromMemoryCacheForKey:@"one"];
    
    imageView.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
