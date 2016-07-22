//
//  ViewController.m
//  折叠图片
//
//  Created by 王宁 on 6/4/16.
//  Copyright © 2016 王宁. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *dragView;

@property(nonatomic,weak)CAGradientLayer*gradientLayer;

@end

@implementation ViewController

// 一张图片必须要通过两个控件展示，旋转的时候，只旋转上部分控件
// 如何让一张完整的图片通过两个控件显示
// 通过layer控制图片的显示内容
// 如果快速把两个控件拼接成一个完整图片

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.topView.layer.contentsRect=CGRectMake(0, 0, 1, 0.5);
//    self.topView.layer.anchorPoint=CGPointMake(0.5, 1);
//    
//    self.bottomView.layer.contentsRect=CGRectMake(0, 0.5, 1, 0.5);
//    self.bottomView.layer.anchorPoint=CGPointMake(0.5, 0);
//    
////    [self.dragView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)]];
//    UIPanGestureRecognizer*panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)];
//    [self.dragView addGestureRecognizer:panGesture];
//
    
    // 通过设置contentsRect可以设置图片显示的尺寸，取值0~1
    _topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    _topView.layer.anchorPoint = CGPointMake(0.5, 1);
    
    _bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    _bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    // 添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [_dragView addGestureRecognizer:pan];
    
    CAGradientLayer*gradLayer=[CAGradientLayer layer];
    gradLayer.colors=@[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
    gradLayer.frame=self.bottomView.bounds;
    gradLayer.opacity=0;
    [self.bottomView.layer addSublayer:gradLayer];
    self.gradientLayer=gradLayer;
    
}

-(void)pan:(UIPanGestureRecognizer*)tap{
    
//    CGPoint point=[tap translationInView:self.dragView];
//    
//    CGFloat rotation=-point.y/200*M_PI;
//    
//    CATransform3D transform=CATransform3DIdentity;
//    
//    self.topView.layer.transform=CATransform3DRotate(transform, rotation, 1, 0, 0);
   
    
    // 获取偏移量
    CGPoint transP = [tap translationInView:_dragView];
    
    // 旋转角度,往下逆时针旋转
    CGFloat angle = -transP.y / 200.0 * M_PI;
    
    CATransform3D transfrom = CATransform3DIdentity;
    
    
    // 增加旋转的立体感，近大远小,d：距离图层的距离
    transfrom.m34 = -1 / 500.0;
    
    transfrom = CATransform3DRotate(transfrom, angle, 1, 0, 0);
    
    _topView.layer.transform = transfrom;

    self.gradientLayer.opacity=transP.y/200;
    
    if (tap.state==UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
           
            _topView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            self.gradientLayer.opacity=0;
        }];
    }
    
//    self.topView.layer.transform=CATransform3DTranslate(self.topView.layer.transform, point.x, point.y, 0);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
