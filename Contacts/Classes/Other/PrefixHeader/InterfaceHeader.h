//
//  InterfaceHeader.h
//  Contacts
//
//  Created by 谢腾飞 on 2019/3/7.
//  Copyright © 2019 谢腾飞. All rights reserved.
//

#ifndef InterfaceHeader_pch
#define InterfaceHeader_pch

/*** 如果希望某些内容能拷贝到任何源代码文件(OC\C\C++等), 那么就不要写在#ifdef __OBJC__和#endif之间 ***/

/***** 在#ifdef __OBJC__和#endif之间的内容, 只会拷贝到OC源代码文件中, 不会拷贝到其他语言的源代码文件中 *****/
#ifdef __OBJC__

/************************************  接口  ******************************************/
/*** 公共接口 ***/
#define Comment_Interface                    @"http://connections.ysmpmall.cn/"

#define Common_Interface_Montage(A)          [NSString stringWithFormat:@"%@%@", Comment_Interface ,A]

/*** 微信授权登录 ***/
#define Login_Interface                         @"/user/addUser"
/*** 验证码 ***/
#define Verification_Code_Interface             @"user/send"


/*** 我的 ***/
#define Mine_Interface                          @"user/selectUserIndex"
/*** 更换头像 ***/
#define Replace_Header_Interface                @"user/updateUserPhoto"

/*** 添加点赞 ***/
#define Add_Praise_Interface                    @"relationship/addLike"
/*** 添加收藏 ***/
#define Add_Collection_Interface                @"relationship/addCollection"
/*** 银行卡识别 ***/
#define Bank_Card_Identification_Interface      @"user/selectBankType"
/*** 获取个人信息 ***/
#define Information_Interface                   @"user/SelectUserMp"
/*** 名片详情 ***/
#define Business_Card_Interface                 @"user/businessCard"
/*** 编辑个人信息 ***/
#define Editor_Information_Interface            @"user/addUserMp"
/*** 验证验证码 ***/
#define Validation_Code_Interface               @"user/selectSend"
/*** 添加名片 ***/
#define AddBusiness_Card_Interface              @"user/addUserUnit"
/*** 编辑名片 ***/
#define EditBusiness_Card_Interface             @"user/updateUnit"
/*** 删除名片 ***/
#define DeleBusiness_Card_Interface             @"user/deleteUnit"
/*** 查询名片 ***/
#define Business_Interface                      @"user/selectUnitList"
/*** 用户提现 ***/
#define Withdraw_Deposit_Interface              @"user/selectUserTx"


/*** 首页信息 ***/
#define Home_Interface                          @"people/addressPeople"
/*** 分类接口 ***/
#define Classification_Interface                @"station/selectTradeList"
/*** 分类内容信息 ***/
#define Classification_Content_Interface        @"people/findSomeone"
/*** 卡列表 ***/
#define Card_Interface                          @"user/selectBank"
/*** 删除卡 ***/
#define Delete_Card_Interface                   @"user/deleteBank"
/*** 绑定卡 ***/
#define Binding_Card_Interface                  @"user/addBank"
/*** 收益 ***/
#define Earnings_Interface                      @"user/selectIncome"
/*** 收藏 ***/
#define Collection_Interface                    @"user/userFavorites"
/*** 三维人脉 ***/
#define Contacts_Interface                      @"people/gradePeople"
/*** 浏览 ***/
#define Browse_Detail_Interface                 @"relationship/addBrowse"
/*** 职位选项 ***/
#define Position_List_Interface                 @"station/selectStationAll"

/*** 浏览我的 ***/
#define Browse_Interface                        @"user/userBrowse"
/*** 关注我的 ***/
#define Attention_Interface                     @"user/userCollection"
/*** 点赞我的 ***/
#define Praise_Interface                        @"user/userLike"
/*** 支付 ***/
#define Payment_Interface                       @"wxPay/wxPay"

#endif
/***** 在#ifdef __OBJC__和#endif之间的内容, 只会拷贝到OC源代码文件中, 不会拷贝到其他语言的源代码文件中 *****/

#endif /* InterfaceHeader_pch */
