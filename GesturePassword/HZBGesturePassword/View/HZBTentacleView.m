

#import "HZBTentacleView.h"
#import "HZBGesturePasswordButton.h"


@interface HZBTentacleView ()

@end
@implementation HZBTentacleView
{
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    
    NSMutableArray * touchesArray;
    NSMutableArray * touchedArray;
    BOOL success;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        touchesArray = [[NSMutableArray alloc]initWithCapacity:0];
        touchedArray = [[NSMutableArray alloc]initWithCapacity:0];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
        success = 1;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    [touchesArray removeAllObjects];
    [touchedArray removeAllObjects];

    success = 1 ;
    if (touch)
    {
        touchPoint = [touch locationInView:self];

        for (int i=0; i<_buttonArray.count; i++)
        {
            HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);

            [buttonTemp returnToTheOriginalData];
            
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint)) {
                CGRect frameTemp = buttonTemp.frame;
                CGPoint point = CGPointMake(frameTemp.origin.x+frameTemp.size.width/2,frameTemp.origin.y+frameTemp.size.height/2);
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",point.x],@"x",[NSString stringWithFormat:@"%f",point.y],@"y", nil];
                [touchesArray addObject:dict];
                //线的起始点
                lineStartPoint = touchPoint;
            }
        }
        
        [self setNeedsDisplay];
    }
}

//当手指在屏幕上移时，动就会调用touchesMoved:withEvent方法
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    if (touch) {
        touchPoint = [touch locationInView:self];
//        NSLog(@"touchPoint :%f  %f",touchPoint.x,touchPoint.y);
        //找出选中的按钮
        for (int i=0; i<_buttonArray.count; i++) {
            HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint)) {
                //已选
                if ([touchedArray containsObject:[NSString stringWithFormat:@"num%d",i]]) {
                    //线末尾
                    lineEndPoint = touchPoint;
                    [self setNeedsDisplay];
                    return;
                }
                //未选
                [touchedArray addObject:[NSString stringWithFormat:@"num%d",i]];
                [buttonTemp setSelected:YES];
                [buttonTemp setNeedsDisplay];
                CGRect frameTemp = buttonTemp.frame;
                CGPoint point = CGPointMake(frameTemp.origin.x+frameTemp.size.width/2,frameTemp.origin.y+frameTemp.size.height/2);
                NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",point.x],@"x",[NSString stringWithFormat:@"%f",point.y],@"y",[NSString stringWithFormat:@"%d",i+1],@"num", nil];
                //保存按钮坐标和数据
                [touchesArray addObject:dict];
//                NSLog(@"%@",touchesArray);
                break;
            }
        }
        lineEndPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableString * resultString=[NSMutableString string];
    //合并结果得到密码
    for ( NSDictionary * num in touchesArray ){
        if(![num objectForKey:@"num"])break;
        [resultString appendString:[num objectForKey:@"num"]];
    }
    if(resultString.length == 0){
        return;
    }
    if(_style==1){
        [_rerificationDelegate verification:resultString];
    }
    else {
        [_resetDelegate resetPassword:resultString withArray:[touchesArray copy]];
    }
    
}

- (void)showDifferent:(BOOL)suc{
    success = suc;
    //成功或失败显示不同效果
    for (int i=0; i<touchesArray.count; i++) {
        NSInteger selection = [[[touchesArray objectAtIndex:i] objectForKey:@"num"]intValue];
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:selection-1]);
        [buttonTemp setSuccess:success];
        [buttonTemp setNeedsDisplay];
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    if (touchesArray.count<2)return;
    //画线
    for (int i=0; i<touchesArray.count; i++) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (![[touchesArray objectAtIndex:i] objectForKey:@"num"]) { //防止过快滑动产生垃圾数据
            [touchesArray removeObjectAtIndex:i];
            continue;
        }
        if (success) {
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 0.7);//线条颜色
        }
        else {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);//红色
        }
        
        CGContextSetLineWidth(context,5);
        CGContextMoveToPoint(context, [[[touchesArray objectAtIndex:i] objectForKey:@"x"] floatValue], [[[touchesArray objectAtIndex:i] objectForKey:@"y"] floatValue]);
        if (i<touchesArray.count-1) {
            CGContextAddLineToPoint(context, [[[touchesArray objectAtIndex:i+1] objectForKey:@"x"] floatValue],[[[touchesArray objectAtIndex:i+1] objectForKey:@"y"] floatValue]);
        }
        else{
            if (success) {
                CGContextAddLineToPoint(context, lineEndPoint.x,lineEndPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
}

- (void)enterArgin {
    [touchesArray removeAllObjects];
    [touchedArray removeAllObjects];
    for (int i=0; i<_buttonArray.count; i++)
    {
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);
        [buttonTemp setSelected:NO];
        [buttonTemp setSuccess:YES];
        [buttonTemp setNeedsDisplay];
    }
    
    [self setNeedsDisplay];
}


- (void)enterArginRed{
    for (int i=0; i<touchesArray.count; i++) {
        NSInteger selection = [[[touchesArray objectAtIndex:i] objectForKey:@"num"]intValue];
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:selection-1]);
        [buttonTemp setSuccess:NO];
        [buttonTemp setNeedsDisplay];
    }
    [self setNeedsDisplay];
}
@end
