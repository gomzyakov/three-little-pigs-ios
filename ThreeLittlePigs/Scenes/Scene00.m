//
//  Scene00.m
//  ThreeLittlePigs
//
//  Created by Alexander Gomzyakov on 23.02.14.
//  Copyright (c) 2014 Alexander Gomzyakov. All rights reserved.
//

#import "Scene00.h"
#import "Scene01.h"
#import "SKLabelNode+Utils.h"
@import AVFoundation;

@implementation Scene00
{
    /* set up your instance variables here */
    AVAudioPlayer *_backgroundMusicPlayer;
    SKSpriteNode  *_btnSound;
    BOOL          _soundOff;
}

#pragma mark - Initialize

- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        _soundOff = [[NSUserDefaults standardUserDefaults] boolForKey:@"pref_sound"];
        [self playBackgroundMusic:@"title_bgMusic.mp3"];

        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"bg_title_page"];
        background.anchorPoint = CGPointZero;
        background.position    = CGPointZero;
        background.zPosition   = -99;

        [self addChild:background];

        [self setupBookTitle];
        [self setupStartButton];
        [self makeSoundButton];
		[self makeAllPagesButton];
		
        //[self moveBookTitle:bookTitle];
    }

    return self;
}

- (void)willMoveFromView:(SKView *)view
{
}

#pragma mark - Make Scene

/**
   Создаем надпись с названием книги.
 */
- (void)setupBookTitle
{
    NSString *titleLine1 = NSLocalizedStringWithDefaultValue(@"BOOK_TITLE_THE", @"Localizable", [NSBundle mainBundle], @"The", @"Заголовок книги");
    NSString *titleLine2 = NSLocalizedStringWithDefaultValue(@"BOOK_TITLE_THREE", @"Localizable", [NSBundle mainBundle], @"Three", @"Первая строка текста первой сцены");
    NSString *titleLine3 = NSLocalizedStringWithDefaultValue(@"BOOK_TITLE_LITTLE", @"Localizable", [NSBundle mainBundle], @"Little", @"Вторая строка текста первой сцены");
    NSString *titleLine4 = NSLocalizedStringWithDefaultValue(@"BOOK_TITLE_PIGS", @"Localizable", [NSBundle mainBundle], @"Pigs", @"Вторая строка текста первой сцены");

    CGFloat TLPSmallFontSize = 50.0;
    CGFloat TLPFontSize      = 100.0;

    SKNode *nerdText = [SKNode node];

    SKLabelNode *label1 = [SKLabelNode labelNodeWithShadowFromString:titleLine1 withSize:TLPSmallFontSize];
    SKLabelNode *label2 = [SKLabelNode labelNodeWithShadowFromString:titleLine2 withSize:TLPFontSize];
    SKLabelNode *label3 = [SKLabelNode labelNodeWithShadowFromString:titleLine3 withSize:TLPFontSize];
    SKLabelNode *label4 = [SKLabelNode labelNodeWithShadowFromString:titleLine4 withSize:TLPFontSize];

    label2.position = CGPointMake(label2.position.x, label1.position.y - 90);
    label3.position = CGPointMake(label3.position.x - 10, label2.position.y - 100);
    label4.position = CGPointMake(label4.position.x, label3.position.y - 100);

    [nerdText addChild:label1];
    [nerdText addChild:label2];
    [nerdText addChild:label3];
    [nerdText addChild:label4];

    nerdText.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 100);

    [self addChild:nerdText];
}

- (void)setupStartButton
{
    SKSpriteNode *buttonStart = [SKSpriteNode spriteNodeWithImageNamed:@"button_read_bg"];
    buttonStart.name        = @"buttonStart";
    buttonStart.anchorPoint = CGPointMake(0.5, 1.0);
    buttonStart.position    = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 500.0);

    NSString *titleString = NSLocalizedStringWithDefaultValue(@"READ_STORY_BUTTON", @"Localizable", [NSBundle mainBundle], @"Read", @"Кнопка");

    CGFloat     kTitleFontSize = 65.0;
    SKLabelNode *buttonTitle   = [SKLabelNode labelNodeWithFontNamed:@"PTSerif-Caption"];
    buttonTitle.fontSize                = kTitleFontSize;
    buttonTitle.fontColor               = [UIColor colorWithRed:39.0 / 256.0 green:170.0 / 256.0 blue:225.0 / 256.0 alpha:1.0];
    buttonTitle.text                    = titleString;
    buttonTitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    buttonTitle.position                = CGPointMake(0, -(kTitleFontSize + 12));

    [buttonStart addChild:buttonTitle];

    [self addChild:buttonStart];

    [buttonStart runAction:[SKAction playSoundFileNamed:@"thompsonman_pop.wav" waitForCompletion:NO]];
}

- (void)makeSoundButton
{
    CGFloat const kOffset = 30.0;

    if (_soundOff) {
        [_btnSound removeFromParent];

        _btnSound             = [SKSpriteNode spriteNodeWithImageNamed:@"button_sound_off"];
        _btnSound.anchorPoint = CGPointMake(0.0, 1.0);
        _btnSound.position    = CGPointMake(kOffset, self.frame.size.height-kOffset);

        [self addChild:_btnSound];
        [_backgroundMusicPlayer stop];
    } else {
        [_btnSound removeFromParent];

        _btnSound             = [SKSpriteNode spriteNodeWithImageNamed:@"button_sound_on"];
        _btnSound.anchorPoint = CGPointMake(0.0, 1.0);
        _btnSound.position    = CGPointMake(kOffset, self.frame.size.height-kOffset);

        [self addChild:_btnSound];
        [_backgroundMusicPlayer play];
    }
}

- (void)makeAllPagesButton
{
    CGFloat const kOffset = 30.0;

    SKSpriteNode *allPagesButton = [SKSpriteNode spriteNodeWithImageNamed:@"button-all-pages"];
    allPagesButton.anchorPoint = CGPointMake(1.0, 1.0);
    allPagesButton.position    = CGPointMake(self.frame.size.width-kOffset, self.frame.size.height-kOffset);

    [self addChild:allPagesButton];
}

#pragma mark - Animations

- (void)moveBookTitle:(SKLabelNode *)bookTitle
{
    SKAction *actionMoveDown = [SKAction moveToY:(self.frame.size.height * 2 / 3) duration:2.0];
    [bookTitle runAction:actionMoveDown];
}

#pragma mark -
#pragma mark Code For Sound & Ambiance

- (void)playBackgroundMusic:(NSString *)filename
{
    NSError *error;
    NSURL   *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    _backgroundMusicPlayer               = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    _backgroundMusicPlayer.numberOfLoops = -1;
    _backgroundMusicPlayer.volume        = 1.0;
    [_backgroundMusicPlayer prepareToPlay];
}

- (void)showSoundButtonForTogglePosition:(BOOL)togglePosition
{
    // NSLog(@"togglePosition: %i", togglePosition);

    if (togglePosition) {
        _btnSound.texture = [SKTexture textureWithImageNamed:@"button_sound_on"];

        _soundOff = NO;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"pref_sound"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [_backgroundMusicPlayer play];
    } else {
        _btnSound.texture = [SKTexture textureWithImageNamed:@"button_sound_off"];

        _soundOff = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"pref_sound"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [_backgroundMusicPlayer stop];
    }
}

#pragma mark -
#pragma mark Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SKNode *startButton = [self childNodeWithName:@"buttonStart"];

    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        // NSLog(@"** TOUCH LOCATION ** \nx: %f / y: %f", location.x, location.y);

        if ([_btnSound containsPoint:location]) {
            // NSLog(@"xxxxxxxxxxxxxxxxxxx sound toggle");

            [self showSoundButtonForTogglePosition:_soundOff];
        } else if ([startButton containsPoint:location]) {
            [_backgroundMusicPlayer stop];

            // NSLog(@"xxxxxxxxxxxxxxxxxxx touched read button");

            Scene01      *scene           = [[Scene01 alloc] initWithSize:self.size];
            SKTransition *sceneTransition = [SKTransition fadeWithColor:[UIColor darkGrayColor] duration:1];
            [self.view presentScene:scene transition:sceneTransition];
        }
    }
}

#pragma mark - Game Loop

- (void)update:(CFTimeInterval)currentTime
{
}

@end
