//
//  CFEditPersonalInformationCell.m
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/15.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#import "CFEditPersonalInformationCell.h"
#import "CFTextField.h"

@interface CFEditPersonalInformationCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CFTextField *nameField;
@property (weak, nonatomic) IBOutlet CFTextField *phoneField;
@property (weak, nonatomic) IBOutlet CFTextField *weChatField;
@property (weak, nonatomic) IBOutlet CFTextField *qqField;
@property (weak, nonatomic) IBOutlet CFTextField *emailField;

@end

@implementation CFEditPersonalInformationCell

static NSString *const CellID = @"CFEditPersonalInformationCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    CFEditPersonalInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[[NSBundle bundleForClass:self] loadNibNamed:@"CFEditPersonalInformationCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CFAccount *account = [CFAccountTool account];
    
    self.nameField.text = account.USER_NAME;
    self.phoneField.text = account.USER_PHONE;
    self.weChatField.text = account.USER_WECHAT;
    self.qqField.text = account.USER_QQ;
    self.emailField.text = account.USER_EMAIL;
}

#pragma mark - <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nameField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }
//        else if (self.nameField.text.length >= 5) {
//            self.nameField.text = [textField.text substringToIndex:4];
//            [TFProgressHUD showInfoMsg:@"姓名最长不得超过4字"];
//            return NO;
//        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CFAccount *acount = [CFAccountTool account];
    // 更改昵称
    if (textField == self.nameField && ![self.nameField.text isEqualToString:acount.USER_NAME] && [self.nameField.text length] >= 2) {
        
        if ([self.nameField.text length] > 4) {
            self.nameField.text = [textField.text substringToIndex:4];
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = acount.USER_ID;
        params[@"userName"] = self.nameField.text;
        [self changePersonalInformation:params interface:@"user/updateUserName"];
        
//    // 更改手机号码
//    } else if (textField == self.phoneField) {
//
//        if ([self.phoneField.text isValidateMobile] && ![self.phoneField.text isEqualToString:acount.USER_PHONE]) {
//
//            NSMutableDictionary *params = [NSMutableDictionary dictionary];
//            params[@"userId"] = acount.USER_ID;
//            params[@"userPhone"] = self.phoneField.text;
//            [self changePersonalInformation:params interface:@"user/updateUserPhone"];
//        } else {
//            self.emailField.text = acount.USER_PHONE;
//        }
    // 更改微信
    } else if (textField == self.weChatField && ![self.weChatField.text isEqualToString:acount.USER_WECHAT] && [self.weChatField.text length] > 4) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = acount.USER_ID;
        params[@"userWechat"] = self.weChatField.text;
        [self changePersonalInformation:params interface:@"user/updateUserWechat"];
     
    // 更改QQ
    } else if (textField == self.qqField && ![self.qqField.text isEqualToString:acount.USER_QQ] && [self.qqField.text length] > 6) {
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"userId"] = acount.USER_ID;
        params[@"userQQ"] = self.qqField.text;
        [self changePersonalInformation:params interface:@"user/updateUserQQ"];
        
    // 更改邮箱
    } else if (textField == self.emailField) {
        
        if ([NSString isEmailAdress:self.emailField.text] && ![self.emailField.text isEqualToString:acount.USER_EMAIL]) {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userId"] = acount.USER_ID;
            params[@"userEmail"] = self.emailField.text;
            [self changePersonalInformation:params interface:@"user/updateUserEmail"];
        } else {
            self.emailField.text = acount.USER_EMAIL;
        }
    }
}

- (void)changePersonalInformation:(NSMutableDictionary *)params interface:(NSString *)interface
{
    [TFProgressHUD showLoading:nil];
    [CFNetworkTools postResultWithUrl:interface params:params success:^(id _Nonnull responseObject) {
        CFLog(@"--->%@",responseObject);
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [TFProgressHUD showSuccess:responseObject[@"message"]];
            [CFNetworkTools loadPersonalInformation];
        } else {
            [TFProgressHUD dismiss];
        }
    } failure:^(NSError * _Nonnull error) {CFLog(@"--->%@",error);[TFProgressHUD dismiss];}];
}
@end
