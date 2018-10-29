//
//  YPWordToAudioTool.m
//  AVSpeechSynthesizer
//
//  Created by WorkZyp on 2018/10/26.
//  Copyright © 2018年 Zyp. All rights reserved.
//

#import "YPWordsToAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@interface YPWordsToAudioTool ()

/** 文本到语音的功能实现类  通俗来讲就是发出声音的类*/
@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;
/** 语音支持的声音列表*/
@property (strong, nonatomic) NSArray *voices;

/** 是否正在开始朗读状态*/
@property (assign, nonatomic) BOOL isSpeaking;
/** 是否处于暂停状态*/
@property (assign, nonatomic) BOOL isPause;
/** 是否处于停止状态*/
@property (assign, nonatomic) BOOL isStop;

@end



@implementation YPWordsToAudioTool

/** 获取单例对象*/
static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
        /** 初始化成员变量*/
        [_instance initMembers];
    });
    return _instance;
}

#pragma mark -
#pragma mark - initMembers
- (void)initMembers {
    self.speaker = YPSPEAKER_Linda;
    
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    /**
        -[AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"] 美式英语
        -[AVSpeechSynthesisVoice voiceWithLanguage:@"en-GB"] 英式英语
    -通过类方法：[AVSpeechSynthesisVoice speechVoices]; 可查看完整的声音支持列表
     */
    //设置为中文
    self.voices = @[[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]];
    
    //在没有设置朗读内容时，默认设置为 徐志摩-《再别康桥》
//    self.speechWords = (self.speechWords && self.speechWords.length > 0) ? self.speechWords : @"轻轻的我走了，正如我轻轻的来；我轻轻地招手，作别西天的云彩。那河畔的金柳，是夕阳中的新娘，波光里的艳影，在我的心头荡漾。软泥上的青荇，油油的在水底招摇；在康河的柔波里，我甘心做一条水草!那榆阴下的一潭，不是清泉，是天上虹揉碎在浮藻间，沉淀着彩虹似的梦。寻梦？撑一支长篙，向青草更青处漫溯，满载一船星辉，在星辉斑斓里放歌。但我不能放歌,悄悄是别离的笙箫；夏虫也为我沉默，沉默是今晚的康桥！悄悄的我走了，正如我悄悄的来；我挥一挥衣袖，不带走一片云彩。";
}


/** 开始朗读*/
- (void)beginSpeech {
    if (self.isPause) {
        [self.speechSynthesizer continueSpeaking];
        return;
    }
    if (self.isSpeaking) {
        return;
    }
    
    //实例 你要讲的话的类
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.speechWords];
    utterance.voice = self.voices[0];
    utterance.rate = self.speechRate ? self.speechRate : 0.4f;
    utterance.pitchMultiplier = self.speechPitchMultiplier ? self.speechPitchMultiplier : 0.8f;
    utterance.postUtteranceDelay = 0.1f;
    //开始读
    [self.speechSynthesizer speakUtterance:utterance];
    self.isSpeaking = YES;
    self.isPause = NO;
    self.isStop = NO;
}

/** 暂停朗读*/
- (void)pauseSpeech {
    if (self.isSpeaking) {
        self.isPause = YES;
        [self.speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryWord];
    }
}

/** 停止朗读  置 正在朗读为NO 暂停为NO*/
- (void)stopSpeech {
    self.isStop = YES;
    self.isSpeaking = NO;
    self.isPause = NO;
    [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
}

/** 几个角色*/
- (void)setSpeaker:(YPSPEAKERTYPE)speaker {
    _speaker = speaker;
    
    switch (speaker) {
        case YPSPEAKER_Linda:
        {
            self.speechRate = 0.5f;
            self.speechPitchMultiplier = 0.65f;
        }
            break;
            
            
        case YPSPEAKER_Lisa:
        {
            self.speechRate = 0.4f;
            self.speechPitchMultiplier = 1.25f;
        }
            break;
            
        case YPSPEAKER_Lucy:
        {
            self.speechRate = 0.45f;
            self.speechPitchMultiplier = 0.95f;
        }
            break;
            
        default:
            break;
    }
    
    
    
}


/** 所有的朗读者*/
- (NSArray *)getAllSpeakers {
    return @[@"Linda",@"Lisa",@"Lucy"];
}

/** 当前的朗读者*/
- (NSString *)getCurrentSpeaker {
    return  (self.speaker == YPSPEAKER_Linda) ? @"Linda" : ((self.speaker == YPSPEAKER_Lisa) ? @"Lisa" : @"Lucy");
}

@end
