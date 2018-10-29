//
//  ViewController.m
//  AVSpeechSynthesizer
//
//  Created by WorkZyp on 2018/10/26.
//  Copyright © 2018年 Zyp. All rights reserved.
//

#import "ViewController.h"
#import "YPWordsToAudioTool.h"

@interface ViewController () <UITextViewDelegate>

/** 需要转换的文字内容*/
@property (strong, nonatomic) UITextView *textView;

/** 开始朗诵功能触发的按钮*/
@property (strong, nonatomic) UIButton *startBtn;
/** 暂停按钮*/
@property (strong, nonatomic) UIButton *pauseBtn;
/** 停止按钮*/
@property (strong, nonatomic) UIButton *stopBtn;

/** 切换说话人的按钮*/
@property (strong, nonatomic) UIButton *switchSpeakerBtn;

@end

@implementation ViewController

#pragma mark – ⬇️ 💖 Life Cycle 💖 ⬇️

#pragma mark -
#pragma mark - viewWillAppear:
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark -
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubMembers];
}

#pragma mark -
#pragma mark - viewWillDisappear:
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

#pragma mark -
#pragma mark - dealloc
- (void)dealloc {
    
}

#pragma mark – ⬇️ 💖 Events 💖 ⬇️
#pragma mark -
#pragma mark - startBtnClicked
- (void)startBtnClicked {
    NSLog(@"开始朗诵！！！");
    [YPWordsToAudioTool sharedInstance].speechWords = self.textView.text;
    [[YPWordsToAudioTool sharedInstance] beginSpeech];
}

#pragma mark -
#pragma mark - pauseBtnClicked
- (void)pauseBtnClicked {
    [[YPWordsToAudioTool sharedInstance] pauseSpeech];
}

#pragma mark -
#pragma mark - stopBtnClicked
- (void)stopBtnClicked {
    [[YPWordsToAudioTool sharedInstance] stopSpeech];
}

#pragma mark -
#pragma mark - switchSpeakerBtnClicked:
- (void)switchSpeakerBtnClicked:(UIButton *)btn {
    [self stopBtnClicked];
    NSString *titleStr = [btn titleForState:UIControlStateNormal];
    if ([titleStr containsString:@"Linda"]) {//当前是Linda ->切换到Lisa上
        [YPWordsToAudioTool sharedInstance].speaker = YPSPEAKER_Lisa;
        [btn setTitle:@"朗读者-Lisa(点我一下切换)" forState:UIControlStateNormal];
    }else if ([titleStr containsString:@"Lisa"]) {//当前是Lisa ->切换到Lucy上
        [YPWordsToAudioTool sharedInstance].speaker = YPSPEAKER_Lucy;
        [btn setTitle:@"朗读者-Lucy(点我一下切换)" forState:UIControlStateNormal];
    }else if ([titleStr containsString:@"Lucy"]) {//当前是Lucy ->切换到Linda上
        [YPWordsToAudioTool sharedInstance].speaker = YPSPEAKER_Linda;
        [btn setTitle:@"朗读者-Linda(点我一下切换)" forState:UIControlStateNormal];
    }
    [self startBtnClicked];
    
}

#pragma mark – ⬇️ 💖 Methods 💖 ⬇️
#pragma mark -
#pragma mark - initSubMembers
- (void)initSubMembers {
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.startBtn];
    
    [self.view addSubview:self.pauseBtn];
    
    [self.view addSubview:self.stopBtn];
    
    [self.view addSubview:self.switchSpeakerBtn];
}

#pragma mark -
#pragma mark - 快速创建按钮
- (UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title sel:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = frame;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 8.0f;
    NSArray *colors = @[[UIColor orangeColor],[UIColor purpleColor],[UIColor blueColor],[UIColor redColor]];
    NSInteger index = arc4random() % (colors.count);
    btn.backgroundColor = colors[index];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


#pragma mark – ⬇️ 💖 Delegate 💖 ⬇️

#pragma mark - UITextView Delegate Methods
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark – ⬇️ 💖 Getters / Setters 💖 ⬇️
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(50, 80, 300, 200)];
        _textView.delegate = self;
        _textView.text = @"轻轻的我走了，正如我轻轻的来；我轻轻地招手，作别西天的云彩。那河畔的金柳，是夕阳中的新娘，波光里的艳影，在我的心头荡漾。软泥上的青荇，油油的在水底招摇；在康河的柔波里，我甘心做一条水草!那榆阴下的一潭，不是清泉，是天上虹揉碎在浮藻间，沉淀着彩虹似的梦。寻梦？撑一支长篙，向青草更青处漫溯，满载一船星辉，在星辉斑斓里放歌。但我不能放歌,悄悄是别离的笙箫；夏虫也为我沉默，沉默是今晚的康桥！悄悄的我走了，正如我悄悄的来；我挥一挥衣袖，不带走一片云彩。";
    }
    
    return _textView;
}


- (UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [self createButtonWithFrame:CGRectMake(50, 280, 200, 40) title:@"开始文字转语音" sel:@selector(startBtnClicked)];
    }
    
    return _startBtn;
}

- (UIButton *)pauseBtn {
    if (!_pauseBtn) {
        _pauseBtn = [self createButtonWithFrame:CGRectMake(50, 340, 200, 40) title:@"暂停" sel:@selector(pauseBtnClicked)];
    }
    
    return _pauseBtn;
}

- (UIButton *)stopBtn {
    if (!_stopBtn) {
        _stopBtn = [self createButtonWithFrame:CGRectMake(50, 400, 200, 40) title:@"停止" sel:@selector(stopBtnClicked)];
    }
    
    return _stopBtn;
}
- (UIButton *)switchSpeakerBtn {
    if (!_switchSpeakerBtn) {
        _switchSpeakerBtn = [self createButtonWithFrame:CGRectMake(50, 480, 300, 40) title:@"朗读者-Linda(点我一下切换)" sel:@selector(switchSpeakerBtnClicked:)];
    }
    
    return _switchSpeakerBtn;
}

@end
