//
//  YPWordToAudioTool.h
//  AVSpeechSynthesizer
//
//  Created by WorkZyp on 2018/10/26.
//  Copyright © 2018年 Zyp. All rights reserved.
//

///<!--- 使用前需要导入AVFoundation库,支持iOS7及以上设备使用 -->

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/** 自己调节了几款音色，设置了几个虚拟人物*/
typedef enum {
    /** 默认为Lina朗读*/
    YPSPEAKER_Linda = 100,
    /** Lisa*/
    YPSPEAKER_Lisa,
    /** Lucy*/
    YPSPEAKER_Lucy,
    
}YPSPEAKERTYPE;

@interface YPWordsToAudioTool : NSObject

/** ------------Attributes----------------*/

/** 自己调节的几个人物类型...😁*/
@property (assign, nonatomic) YPSPEAKERTYPE speaker;

/** 需要朗读的内容*/
@property (strong, nonatomic) NSString *speechWords;

/** 文字转换语音时，朗读的语速 - speechRate: [0-1]区间值，默认值为0.5，0最慢，1最快*/
@property (assign, nonatomic) CGFloat speechRate;

/** 文字转换语音时，朗读的声调 -speechPitchMultiplier:[0.5-2.0]区间值，默认值为1.0，0.5最低，2.0最高*/
@property (assign, nonatomic) CGFloat speechPitchMultiplier;







/** -------------Mehods----------------*/

/** 获取单例对象*/
+ (instancetype)sharedInstance;

/** 开始朗读*/
- (void)beginSpeech;

/** 暂停朗读*/
- (void)pauseSpeech;

/** 停止朗读*/
- (void)stopSpeech;



@end
