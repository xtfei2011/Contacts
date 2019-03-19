//
//  TFWebViewController.m
//  Appointment
//
//  Created by 谢腾飞 on 2018/3/3.
//  Copyright © 2018年 谢腾飞. All rights reserved.
//

#import "TFWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

typedef enum {
    TFLoadWebURLString = 0,
    TFLoadWebHTMLString,
    TFPOSTWebURLString,
}TFWebLoadType;

static void *TFBrowserContext = &TFBrowserContext;

@interface TFWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler, UINavigationControllerDelegate, UINavigationBarDelegate>
/*** 网页View ***/
@property (nonatomic ,strong) WKWebView *webView;
/*** 加载进度条 ***/
@property (nonatomic ,strong) UIProgressView *progressView;
/*** 第一次的时候加载本地JS ***/
@property (nonatomic ,assign) BOOL needLoadJS;
/*** 网页加载的类型 ***/
@property (nonatomic ,assign) TFWebLoadType loadType;
/*** 网址链接 ***/
@property (nonatomic ,strong) NSString *urlStr;
/*** POST请求体 ***/
@property (nonatomic ,strong) NSString *parameter;
/*** 返回按钮 ***/
@property (nonatomic ,strong) UIBarButtonItem *backBarItem;
/*** 关闭按钮 ***/
@property (nonatomic ,strong) UIBarButtonItem *closeBarItem;
/*** 请求链接保存 ***/
@property (nonatomic ,strong) NSMutableArray *urlArray;
@end


@implementation TFWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"正在加载内容";
    
    /*** 加载网页 ***/
    [self webViewLoadType];
    
    /*** 将WebView添加到主控制器 ***/
    [self.view addSubview:self.webView];
    
    self.webView.hidden = YES;
    /*** 加载进度条 ***/
    [self.view addSubview:self.progressView];
    
    /*** 刷新按钮 ***/
    [self rightBarButtonItem];
}

- (void)rightBarButtonItem
{
    UIButton *roadButton = [[UIButton alloc] init];
    roadButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [roadButton setTitle:@"刷新" forState:UIControlStateNormal];
    [roadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [roadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [roadButton sizeToFit];

    roadButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [roadButton addTarget:self action:@selector(roadLoadClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:roadButton];
}

/*** 刷新页面 ***/
- (void)roadLoadClicked
{
    [self.webView reload];
}

#pragma 加载方式
- (void)webViewLoadType
{
    switch (self.loadType) {
        case TFLoadWebURLString: {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            [self.webView loadRequest:request];
            break;
        }
        case TFLoadWebHTMLString: {
            [self loadHostPathURL:self.urlStr];
            break;
        }
        case TFPOSTWebURLString: {
            self.needLoadJS = YES;
            [self loadHostPathURL:self.urlStr];
            break;
        }
    }
}

/*** 加载 HTML 内容 ***/
- (void)loadHostPathURL:(NSString *)string
{
    [self.webView loadHTMLString:string baseURL:nil];
}

/*** 调用JS发送POST请求 ***/
- (void)postRequestWithJavaScript
{
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@',{%@});", self.urlStr, self.parameter];
    // 调用JS代码
    [self.webView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
        
    }];
}

/*** 加载网页链接 ***/
- (void)loadWebURLString:(NSString *)string
{
    self.urlStr = string;
    self.loadType = TFLoadWebURLString;
}

/*** 加载本地网页 ***/
- (void)loadWebHTMLSring:(NSString *)string
{
    self.urlStr = string;
    self.loadType = TFLoadWebHTMLString;
}

/*** 加载外部链接POST请求 ***/
- (void)postWebURLSring:(NSString *)string parameter:(NSString *)parameter
{
    self.urlStr = string;
    self.parameter = parameter;
    self.loadType = TFPOSTWebURLString;
}

#pragma mark === 自定义返回/关闭按钮
- (void)setupNavigationLeftItems
{
    if (self.webView.canGoBack) {
        
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = 0;
        
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.backBarItem,self.closeBarItem] animated:NO];
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.backBarItem]];
    }
}

/*** 请求链接处理 ***/
- (void)pushCurrentViewWithRequest:(NSURLRequest *)request
{
    NSURLRequest *lastRequest = (NSURLRequest *)[[self.urlArray lastObject] objectForKey:@"request"];
    
    if ([request.URL.absoluteString isEqualToString:@"about:blank"] || [lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString])   return;
    
    UIView *currentView = [self.webView snapshotViewAfterScreenUpdates:YES];
    [self.urlArray addObject:@{@"request":request,@"urlShotView":currentView}];
}

/*** 网页加载完成，导航的变化 ***/
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (self.needLoadJS) {
        [self postRequestWithJavaScript];
        self.needLoadJS = NO;
    }
    
    NSMutableString *js1 = [NSMutableString string];
    //删除顶部的导航条
    [js1 appendString:@"var header = document.getElementsByTagName('h1')[0];"];
    [js1 appendString:@"header.parentNode.removeChild(header);"];
    
    [webView evaluateJavaScript:js1 completionHandler:^(id evaluate, NSError * error) {
        self.webView.hidden = NO;
    }];
    
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];
    [ webView evaluateJavaScript:@"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 320.0;" // UIWebView中显示的图片宽度
     "for(i=1;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);ResizeImages();" completionHandler:nil];
    
    self.navigationItem.title = self.webView.title;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self setupNavigationLeftItems];
}

/*** 开始加载 ***/
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    /*** 开始加载的时候 ，显示进度条 ***/
    self.progressView.hidden = NO;
}

/*** 内容返回时调用 ***/
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    CFLog(@"内容返回");
}

/*** 跳转的时候调用 ***/
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    CFLog(@"正在跳转");
}

/*** 开始请求的时候调用 ***/
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    
    if (navigationAction.targetFrame.isMainFrame) {
        [self pushCurrentViewWithRequest:navigationAction.request];
    }
    [self setupNavigationLeftItems];
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

/*** 加载失败时候调用 ***/
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    CFLog(@"页面加载超时");
}

/*** 跳转失败的时候调用 ***/
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    CFLog(@"跳转失败啦");
}

/*** 进度条 ***/
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{}

/*** 获取 js 里面的提示信息 ***/
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

/*** js 信息的交流 ***/
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

/*** KVO监听进度条 ***/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/*** 拦截执行网页中的JS方法 ***/
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    CFLog(@"---->%@",message);
}

#pragma 控件懒加载
- (WKWebView *)webView
{
    if (!_webView) {
        /*** 网页配置 ***/
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        /*** 允许 OC ，JS 交互，选择视图 ***/
        configuration.selectionGranularity = YES;
        /*** 允许视频播放 ***/
        configuration.allowsAirPlayForMediaPlayback = YES;
        /*** 允许在线播放 ***/
        configuration.allowsInlineMediaPlayback = YES;
        /*** 网页内容处理池 ***/
        configuration.processPool = [[WKProcessPool alloc] init];
        /*** 是否把内容全部加载到内存中后再去处理 ***/
        configuration.suppressesIncrementalRendering = YES;
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController *userContent = [[WKUserContentController alloc]init];
        /*** 允许用户更改网页的设置 ***/
        configuration.userContentController = userContent;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 2, CFMainScreen_Width, CFMainScreen_Height) configuration:configuration];
        _webView.backgroundColor = CFCommonBgColor;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        /*** KVO 添加进度条 ***/
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:TFBrowserContext];
        /*** 开启手势 ***/
        _webView.allowsBackForwardNavigationGestures = YES;
        /*** 自适应尺寸 ***/
        [_webView sizeToFit];
    }
    return _webView;
}

/*** 返回按钮 ***/
- (UIBarButtonItem *)backBarItem
{
    if (!_backBarItem) {
        
        UIButton *backButton = [[UIButton alloc] init];
        [backButton setImage:[UIImage imageNamed:@"nav_return_normal"] forState:UIControlStateNormal];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(backItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _backBarItem;
}

/*** 返回按钮 ***/
- (void)backItemClicked
{
    if (self.webView.goBack) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*** 关闭按钮 ***/
- (UIBarButtonItem *)closeBarItem
{
    if (!_closeBarItem) {
        _closeBarItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
        [_closeBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Helvetica-Bold" size:14], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    }
    return _closeBarItem;
}

- (void)closeItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*** 进度条 ***/
- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 64, self.view.xtfei_width, 2);
        /*** 进度条颜色 ***/
        [_progressView setTrackTintColor:[UIColor lightTextColor]];
        _progressView.progressTintColor = CFColor(38, 123, 239);
    }
    return _progressView;
}

- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView setNavigationDelegate:nil];
    [self.webView setUIDelegate:nil];
}

/*** 移除 KVO 观察 ***/
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
@end
