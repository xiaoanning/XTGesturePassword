

#import "HZBTentacleView.h"


@interface HZBTentacleView ()

@end
@implementation HZBTentacleView
{
    CGPoint _lineStartPoint;
    CGPoint _lineEndPoint;
    
    NSMutableArray <HZBGesturePasswordButton *> * _touchedArray;
    NSMutableString * _selectNumString ;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self prepareData];
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(void)prepareData
{
    _touchedArray = [[NSMutableArray alloc]initWithCapacity:10];
    _selectNumString = [NSMutableString string];
    _success = YES ;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];

    [self prepareData];
    
    if (touch)
    {
        touchPoint = [touch locationInView:self];

        for (int i = 0; i< _buttonArray.count ; i++)
        {
            HZBGesturePasswordButton * buttonTemp = [_buttonArray objectAtIndex:i];

            [buttonTemp returnToTheOriginalData];
            
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint))
            {
                [buttonTemp setSelected:YES];
                [_touchedArray addObject:buttonTemp];
                
                [_selectNumString appendString:[NSString stringWithFormat:@"%@",@(i+1)]];

                _lineStartPoint = buttonTemp.center ;
                
            }
        }
        
        if (_touchesBeginCallback)
        {
            _touchesBeginCallback();
        }
        
        [self setNeedsDisplay];
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        touchPoint = [touch locationInView:self];

        for (int i = 0 ; i < _buttonArray.count ; i ++ )
        {
            HZBGesturePasswordButton * buttonTemp = [_buttonArray objectAtIndex:i];
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint))
            {

                if ([_touchedArray containsObject:buttonTemp])
                {
                    
                }else
                {
                    [buttonTemp setSelected:YES];
                    [_touchedArray addObject:buttonTemp];
                    
                    [_selectNumString appendString:[NSString stringWithFormat:@"%@",@(i+1)]];
                    
                }

                break;
            }
        }
        _lineEndPoint = touchPoint;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    @try {
        
        if (_selectNumString.length && _touchesEndedCallback)
        {
            _touchesEndedCallback(_selectNumString);
        }

    } @catch (NSException *exception) {
        
        NSLog(@"%@",exception);
        
    } @finally {

    }
}

- (void)setSuccess:(BOOL)success
{
    _success = success;

    if (_success )
    {
        return ;
    }else
    {
        for (int i = 0 ; i < _touchedArray.count ; i ++ )
        {
            HZBGesturePasswordButton * buttonTemp = [_touchedArray objectAtIndex:i];
            [buttonTemp setSuccess:_success];
            
        }
        [self setNeedsDisplay];
    }
}


- (void)drawRect:(CGRect)rect
{

    for (int i = 0 ; i < _touchedArray.count; i ++)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        if (_success)
        {
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 0.7);
        }else
        {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);
        }
        
        CGContextSetLineWidth(context,5);
        CGPoint center = [[_touchedArray objectAtIndex:i] center];
        CGContextMoveToPoint(context, center.x, center.y);
        if (i < _touchedArray.count- 1 )
        {
            CGPoint nextCenter = [[_touchedArray objectAtIndex:i+1] center];

            CGContextAddLineToPoint(context, nextCenter.x,nextCenter.y);
        }else
        {
            if (_success)
            {
                CGContextAddLineToPoint(context, _lineEndPoint.x,_lineEndPoint.y);
            }
        }
        CGContextStrokePath(context);
    }
}

#pragma mark 清空数据 恢复到初始话状态
/**
    清空数据 恢复到初始话状态
 */

- (void)clear
{
    [self prepareData];
    
    for (int i = 0; i < _buttonArray.count; i++)
    {
        HZBGesturePasswordButton * buttonTemp = [_buttonArray objectAtIndex:i];
        [buttonTemp returnToTheOriginalData];
    }
    
    [self setNeedsDisplay];
}



@end
