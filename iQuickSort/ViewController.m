//
//  ViewController.m
//  iQuickSort
//
//  Created by Bui Duc Khanh on 8/24/16.
//  Copyright © 2016 Bui Duc Khanh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtSourceHW1Number;
@property (weak, nonatomic) IBOutlet UITextField *txtSourceHW2String;
@property (weak, nonatomic) IBOutlet UILabel *lblResultHW1;
@property (weak, nonatomic) IBOutlet UILabel *lblResultHW2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Sinh ngẫu nhiên dữ liệu 10 phần tử cho HW 1
    NSString *tmp;
    
    tmp = [NSString stringWithFormat:@"%d", arc4random_uniform(100)];
    
    for (int i = 1; i < 10; i++)
        tmp = [NSString stringWithFormat:@"%@,%d", tmp, arc4random_uniform(100)];
    [_txtSourceHW1Number setText:tmp];
    
    // Sắp xếp luôn dữ liệu HW 1
    [self onBtnSortCArrayNumberTouchUpInside:nil];
    
    
    // Khởi tạo dữ liệu cho HW 2
    [_txtSourceHW2String setText:@"Khánh khanh an bằng bảo Sơn tuấn"];
    
    // Sắp xếp luôn dữ liệu HW ư
    [self onBtnSortNSArrayStringTouchUpInside:nil];
}

// Thực hiện bài tập 1
- (IBAction)onBtnSortCArrayNumberTouchUpInside:(id)sender {
    // Cắt xâu lấy int value để tạo mảng
    NSArray * items = [self.txtSourceHW1Number.text componentsSeparatedByString:@","];
    
    if (items == nil || items.count == 0)
        return;
    
    int *data = malloc(items.count * sizeof(int));
    
    for (int i = 0; i < items.count; i++)
        data[i] = [(NSString *)items[i] intValue];
    
    [self quickSort:data fromIndex:0 toIndex:((int)items.count - 1)];
    
    // Hiển thị kết quả
    NSString *tmp;
    
    tmp = [NSString stringWithFormat:@"%d", data[0]];
    
    for (int i = 1; i < items.count; i++)
        tmp = [NSString stringWithFormat:@"%@,%d", tmp, data[i]];
    
    _lblResultHW1.text = tmp;
}

// Thực hiện bài tập 2
- (IBAction)onBtnSortNSArrayStringTouchUpInside:(id)sender {
    NSArray * items = [self.txtSourceHW2String.text componentsSeparatedByString:@" "];
    
    if (items == nil || items.count == 0)
        return;
    
    NSArray * result = [self quickSortString:[items mutableCopy]];
    
    // Hiển thị kết quả
    NSString *tmp;
    
    tmp = [NSString stringWithFormat:@"%@", result[0]];
    
    for (int i = 1; i < result.count; i++)
        tmp = [NSString stringWithFormat:@"%@ %@", tmp, result[i]];
    
    _lblResultHW2.text = tmp;
}


// Hàm sắp xếp nhanh c array
-(void)quickSort:(int *)data fromIndex:(int)first toIndex:(int)last
{
    int pivot,j,temp,i;
    
    if(first<last){
        pivot=first + arc4random_uniform(last - first + 1);
        i=first;
        j=last;
        
        while(i<j){
            while(data[i]<=data[pivot]&&i<last)
                i++;
            while(data[j]>data[pivot])
                j--;
            if(i<j){
                temp=data[i];
                data[i]=data[j];
                data[j]=temp;
            }
        }
        
        temp=data[pivot];
        data[pivot]=data[j];
        data[j]=temp;
        
        [self quickSort:data fromIndex:first toIndex:(j-1)];

        [self quickSort:data fromIndex:(j+1) toIndex:last];
    }
}


// Hàm sắp xếp nhanh mảng nstring
-(NSArray *)quickSortString:(NSMutableArray *)unsortedDataArray
{
    
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
    if ([unsortedDataArray count] < 1)
    {
        return nil;
    }
    
    int randomPivotPoint = arc4random() % [unsortedDataArray count];
    NSString *pivotValue = [unsortedDataArray objectAtIndex:randomPivotPoint];
    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
    
    for (NSString *item in unsortedDataArray)
    {
        if ([item caseInsensitiveCompare:pivotValue] == NSOrderedAscending)
        {
            [lessArray addObject:item];
        }
        else
        {
            [greaterArray addObject:item];
        }
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    [sortedArray addObjectsFromArray:[self quickSortString:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSortString:greaterArray]];
    return sortedArray;
}

@end
