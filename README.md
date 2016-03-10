# ZHVender
自己常用的开发类库文件的集合

2、封装识别二维码功能类
    
    导入#import "ZHQRCodeView.h"
    
    self.codeView = [[ZHQRCodeView alloc] initWithFrame:self.view.bounds];

    self.codeView.delegate = self;

    [self.view addSubview:self.codeView];

    
    #pragma mark - ZHQRCodeViewResuleDelegate
    - (void)zhQRCodeViewDidReceivedResult:(NSString *)result{

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:result delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];

        [alertView show];

        NSLog(@"%@",result);
    }

    - (void)zhQRCodeViewDidReceivedError:(NSError *)error{

        NSLog(@"--->出错了<---");
    }

    
1、一行代码集成tableview顶部图片拉升的弹性效果

    导入#import "UITableView+SpringAnimation.h"
    
    self.tableView.pullHeaderView = [ZHPullHeaderView headerViewUsingImage:[UIImage imageNamed:@"Image2"]];
