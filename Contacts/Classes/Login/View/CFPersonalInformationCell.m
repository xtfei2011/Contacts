//
//  CFPersonalInformationCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/8.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFPersonalInformationCell.h"
#import "CFTextField.h"
#import "CFAddBusinessCardController.h"
#import "CFEditorController.h"

@interface CFPersonalInformationCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CFTextField *nameField;
@property (weak, nonatomic) IBOutlet CFTextField *codeField;
@property (weak, nonatomic) IBOutlet CFTextField *weChatField;
@property (weak, nonatomic) IBOutlet CFTextField *qqField;
@property (weak, nonatomic) IBOutlet CFTextField *phoneField;
@property (weak, nonatomic) IBOutlet CFTextField *emailField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic ,strong) NSString *msg_id;
@end

@implementation CFPersonalInformationCell
static NSString *const CellID = @"CFPersonalInformationCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFPersonalInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFPersonalInformationCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.phoneField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    
    [TFExtension chageControllerCircular:self.confirmBtn cornerRadius:3 borderWidth:1 borderColor:CFColor(23, 181, 104) masksToBounds:YES];
}

#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.phoneField.text isValidateMobile]) {
        self.codeBtn.backgroundColor = CFColor(23, 181, 104);
        self.codeBtn.enabled = YES;
    } else {
        self.codeBtn.backgroundColor = [UIColor lightGrayColor];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.enabled = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nameField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
//        else if (self.nameField.text.length >= 8) {
//            self.nameField.text = [textField.text substringToIndex:8];
//            [TFProgressHUD showInfoMsg:@"姓名最长不得超过4字"];
//            return NO;
//        }
    } else if (textField == self.phoneField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (self.phoneField.text.length >= 11) {
            return NO;
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.nameField) {
        if ([self.nameField.text length] > 4) {
            self.nameField.text = [textField.text substringToIndex:4];
        }
    } else if (textField == self.emailField) {
        if (![NSString isEmailAdress:self.emailField.text]) {
            [TFProgressHUD showInfoMsg:@"邮箱输入有误!"];
        }
    }
}

- (IBAction)codeButtonClick:(UIButton *)sender
{
    if (![self.phoneField.text isValidateMobile]) {
        [TFProgressHUD showFailure:@"手机号码输入有误！"];
        return;
    } else {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.phoneField.text;
        
        [CFNetworkTools postResultWithUrl:Verification_Code_Interface params:params success:^(id  _Nonnull responseObject) {
            CFLog(@"%@",responseObject);
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                self.msg_id = responseObject[@"msgId"];
                [TFProgressHUD showMessage:[NSString stringWithFormat:@"验证码已发送到:%@ 请注意查收！",self.phoneField.text]];
            }
        } failure:^(NSError * _Nonnull error) {}];
    }
    __block NSInteger time = 59; //设置倒计时时间
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if (time <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [weakSelf.codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [weakSelf.codeBtn setBackgroundColor:CFColor(23, 181, 104)];
                weakSelf.codeBtn.userInteractionEnabled = YES;
            });
        } else {
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [weakSelf.codeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                [weakSelf.codeBtn setBackgroundColor:[UIColor lightGrayColor]];
                weakSelf.codeBtn.userInteractionEnabled = NO;
            });
            time --;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)confirmButtonClick:(UIButton *)sender
{
    if ([self.nameField.text length] == 0 || [self.phoneField.text length] == 0 || [self.codeField.text length] == 0 || [self.weChatField.text length] == 0 || [self.qqField.text length] == 0 || [self.emailField.text length] == 0) {
        [TFProgressHUD showFailure:@"请将所有信息填写完整"];
        return;
    } else {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"msgId"] = self.msg_id;
        params[@"num"] = self.codeField.text;
        params[@"userId"] = [CFUSER_DEFAULTS objectForKey:@"userID"];
        params[@"userPhone"] = self.phoneField.text;
        CFLog(@"%@", params);
        __weak typeof(self) weakSelf = self;
        [TFProgressHUD showLoading:nil];
        [CFNetworkTools postResultWithUrl:Validation_Code_Interface params:params success:^(id _Nonnull responseObject) {
            CFLog(@"--->%@",responseObject);
            if ([responseObject[@"code"] isEqualToString:@"200"]) {
                [weakSelf confirmPersonalInformation:sender];
                [TFProgressHUD dismiss];
            }
        } failure:^(NSError * _Nonnull error) {
            [TFProgressHUD dismiss];
        }];
    }
}

- (void)confirmPersonalInformation:(UIButton *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = self.nameField.text;
    params[@"userWechat"] = self.weChatField.text;
    params[@"userQQ"] = self.qqField.text;
    params[@"userEmail"] = self.emailField.text;
    params[@"userPhoto"] = [CFUSER_DEFAULTS objectForKey:@"header_image"];
    params[@"userPhone"] = self.phoneField.text;
    params[@"userId"] = [CFUSER_DEFAULTS objectForKey:@"userID"];
    
    CFLog(@"%@", params);
    [TFProgressHUD showLoading:nil];
    [CFNetworkTools postResultWithUrl:Editor_Information_Interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [TFProgressHUD showMessage:@"保存成功"];
            CFEditorController *editor = (CFEditorController *)[sender currentViewController];
            CFAddBusinessCardController *addBusiness = [[CFAddBusinessCardController alloc] init];
            addBusiness.isFirst = YES;
            [editor.navigationController pushViewController:addBusiness animated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [TFProgressHUD dismiss];
    }];
}
@end
