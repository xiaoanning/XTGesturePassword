

#import "HZBTentacleView.h"
#import "HZBGesturePasswordButton.h"


@interface HZBTentacleView ()

@end
@implementation HZBTentacleView
{
    CGPoint _lineStartPoint;
    CGPoint _lineEndPoint;
    
    NSMutableArray * _touchedArray;
    NSMutableString * _selectNumString ;
    
    BOOL _success;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _touchedArray = [[NSMutableArray alloc]initWithCapacity:10];
        _selectNumString = [NSMutableString string];
        _success = YES ;

        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint;
    UITouch *touch = [touches anyObject];

    [_touchedArray removeAllObjects];
    _selectNumString = [NSMutableString string];
    _success = YES ;
    
    
    if (touch)
    {
        touchPoint = [touch locationInView:self];

        for (int i = 0; i< _buttonArray.count ; i++)
        {
            HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);

            [buttonTemp returnToTheOriginalData];
            
            if (CGRectContainsPoint(buttonTemp.frame,touchPoint))
            {
                [buttonTemp setSelected:YES];
                [_touchedArray addObject:buttonTemp];
                
                [_selectNumString appendString:[NSString stringWithFormat:@"%@",@(i+1)]];

                _lineStartPoint = buttonTemp.center ;
                
                break ;
            }
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
            HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);
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
    NSMutableString * resultString=[NSMutableString string];

    for ( NSDictionary * num in _touchesArray )
    {
        if(![num objectForKey:@"num"])
        {
            break;
        }
        [resultString appendString:[num objectForKey:@"num"]];
    }
    343498
    if(resultString.length == 0)
    {
        return;
    }
    if(_style==1)
    {
        [_rerificationDelegate verification:resultString];
    }else
    {
        [_resetDelegate resetPassword:resultString withArray:[_touchesArray copy]];
    }
    
}

- (void)showDifferent:(BOOL)suc
{
    _success = suc;

    for (int i = 0 ; i < _touchesArray.count ; i ++ )
    {
        NSInteger selection = [[[_touchesArray objectAtIndex:i] objectForKey:@"num"]intValue];
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:selection-1]);
        [buttonTemp setSuccess:_success];

    }
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{

    for (int i = 0 ; i < _touchesArray.count; i ++)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (![[_touchesArray objectAtIndex:i] objectForKey:@"num"])
        {
            [_touchesArray removeObjectAtIndex:i];
            continue;
        }
        if (_success)
        {
            CGContextSetRGBStrokeColor(context, 2/255.f, 174/255.f, 240/255.f, 0.7);
        }else
        {
            CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);
        }
        
        CGContextSetLineWidth(context,5);
        CGContextMoveToPoint(context, [[[_touchesArray objectAtIndex:i] objectForKey:@"x"] floatValue], [[[_touchesArray objectAtIndex:i] objectForKey:@"y"] floatValue]);
        if (i < _touchesArray.count- 1 )
        {
            CGContextAddLineToPoint(context, [[[_touchesArray objectAtIndex:i+1] objectForKey:@"x"] floatValue],[[[_touchesArray objectAtIndex:i+1] objectForKey:@"y"] floatValue]);
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

- (void)enterArgin
{
    [_touchesArray removeAllObjects];
    [_touchedArray removeAllObjects];
    for (int i=0; i<_buttonArray.count; i++)
    {
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:i]);
        [buttonTemp returnToTheOriginalData];
    }
    
    [self setNeedsDisplay];
}


- (void)enterArginRed
{
    for (int i=0; i<_touchesArray.count; i++)
    {
        NSInteger selection = [[[_touchesArray objectAtIndex:i] objectForKey:@"num"]intValue];
        HZBGesturePasswordButton * buttonTemp = ((HZBGesturePasswordButton *)[_buttonArray objectAtIndex:selection-1]);
        [buttonTemp setSuccess:NO];

    }
    [self setNeedsDisplay];
}
@end
