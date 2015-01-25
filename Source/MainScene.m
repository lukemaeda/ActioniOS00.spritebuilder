#import "MainScene.h"

@implementation MainScene
{
    // Rotationラベル
    CCLabelTTF* label11;
    // Rotationラベル
    CCLabelTTF* label12;
}

//
-(void) didLoadFromCCB
{
    
    // メニューラベル表示メソッド
    [self menuLabelBorn];
    
    // ボタン表示メソッド
    [self buttonBorn];
    
    // 回転ボタンの表示メソッド
    [self rotationLabel];
    
}

// メニューラベル表示メソッド
-(void)menuLabelBorn
{
    // メニューラベル生成
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Action 回転 移動 拡大"
                                           fontName:@"Arial"
                                           fontSize:24];
    // フォントカラー
    label.fontColor = [CCColor whiteColor];
    
    // 座標系が異なります。UIKitは左上が(0,0)、cocos2dは左下が(0,0)です。
    label.position = ccp(270, 280);
    
    // label表示
    [self addChild:label];
}

// ボタン表示メソッド
-(void)buttonBorn
{
    // Ver 3.0 CCButtonを使用してボタンを生成
    // タッチした際や、enabled=falseにしたさいの画像は、
    // 「highlightedSpriteFrame:」「disabledSpriteFrame:」で設定できます
    CCButton *bt1 = [CCButton buttonWithTitle:@"（左）Action RotateTo"
                                  spriteFrame:[CCSpriteFrame
                                               frameWithImageNamed:@"bt1.jpg"]];
    
    CCButton *bt2 = [CCButton buttonWithTitle:@"（右）Action RotateBy"
                                  spriteFrame:[CCSpriteFrame frameWithImageNamed:@"bt2.jpg"]
                       highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"bt2_o.jpg"]
                          disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"bt2.jpg"]];
    
    // ボタンをタッチした際のメソッドを設定 @selector(BtDidPushed:)
    [bt1 setTarget:self selector:@selector(BtDidPushed:)];
    [bt2 setTarget:self selector:@selector(BtDidPushed:)];
    
    // (int)tagが(NSString *)nameに変更になりました
    bt1.name = @"bt1";
    bt2.name = @"bt2";
    bt1.position = ccp(150, 50);
    bt2.position = ccp(400, 50);
    
    // タッチ可、不可を設定
    bt1.userInteractionEnabled = true;
    bt2.userInteractionEnabled = true;
    
    // （背景）画像の透明度は下記のように設定します
    [bt1 setBackgroundOpacity:0.5f forState:CCControlStateNormal];
    [bt2 setBackgroundOpacity:0.5f forState:CCControlStateNormal];
    
    // CCButtonはそのまま配置できます
    [self addChild:bt1];
    [self addChild:bt2];
}

// 回転ラベル表示メソッド
-(void)rotationLabel{
    
    // cocos2dではCCDirectorを使ってウィンドウサイズを取得
    CGSize winSize = [[CCDirector sharedDirector] designSize];
    
    // Rotationラベルの生成
    label11 = [CCLabelTTF labelWithString:@"Rotation"
                                 fontName:@"Marker Felt"
                                 fontSize:30];
    // ラベル位置
    label11.position = CGPointMake(winSize.width / 4, winSize.height / 2);
    // label11追加表示
    [self addChild:label11];
    // 45度角度
    label11.rotation = 45;
    
    // Rotationラベルの生成
    label12 = [CCLabelTTF labelWithString:@"Rotation"
                                 fontName:@"Marker Felt"
                                 fontSize:30];
    // ラベル位置
    label12.position = CGPointMake(winSize.width - winSize.width / 4 , winSize.height / 2);
    // label12追加表示
    [self addChild:label12];
    // 45度角度
    label12.rotation = 45;
}

// アクションToメソッド 指定した数値まで動作する
-(void)actionTo
{
    
    // CCActionRotateTo 3秒 45度に180度を加算した225度まで回転
    CCActionRotateTo *rotateTo = [CCActionRotateTo actionWithDuration:3 angle:180];
    
    // 「指定した座標」まで移動させます
    CCActionMoveTo *moveTo = [CCActionMoveTo
                              actionWithDuration:3
                              position:ccp(30, label11.position.y)];
    
    // 「指定した大きさ」までアニメーションします
    //CCActionScaleTo *scaleTo = [CCActionScaleTo actionWithDuration:3 scale:2.0];
    
    // 「指定した座標」までジャンプしながら移動します
    //CCActionJumpTo *jumpTo = [CCActionJumpTo actionWithDuration:3
//                                                       position:ccp(200, 100)
//                                                         height:60
//                                                          jumps:5];
//    
    // 回転アクションを適用
    [label11 runAction:rotateTo];
    
    // 移動アクションを適用
    [label11 runAction:moveTo];
    
    // 大きさ（拡大）アクションを適用
    //[label11 runAction:scaleTo];
    
    // ジャンプアクションを適用
    //[label11 runAction:jumpTo];
    
}

// アクションByメソッド 現在の位置 + 指定した数値まで動作し何度でも動作を繰り返す
-(void)actionBy
{
    // CCActionRotateBy 3秒 角度180度　現在の角度を基準にして指定分だけ加算し何度でも回転
    CCActionRotateBy *rotateBy = [CCActionRotateBy actionWithDuration:3 angle:180];
    
    // 「現在の座標 + 指定した座標」まで移動させます
    CCActionMoveBy *moveBy = [CCActionMoveBy
                              actionWithDuration:3
                              position:ccp(30, 0)];
    
    // 「現在の大きさ x 指定した大きさ」までアニメーションします
    //CCActionScaleBy *scaleBy = [CCActionScaleBy actionWithDuration:3 scale:2.0];
    
    // 「指定した座標」までジャンプしながら移動します
    //CCActionJumpBy *jumpBy = [CCActionJumpBy actionWithDuration:3

    // 回転アクションを適用
    [label12 runAction:rotateBy];
    
    // 移動アクションを適用
    [label12 runAction:moveBy];
    
    // 大きさ（拡大）アクションを適用
    //[label12 runAction:scaleBy];
    
    // ジャンプアクションを適用
    //[label12 runAction:jumpBy];
}

//ボタンをタッチした時の用のメソッド
-(void)BtDidPushed:(CCButton *)sender
{
    if ([sender.name isEqualToString:@"bt1"]) {
        
        //bt1をタッチした際の処理
        CCLOG(@"ボタン１");
        CCLOG(@"RotateTo");
        
        // アクションToメソッド 指定した数値まで動作する
        [self actionTo];
        
    }else if ([sender.name isEqualToString:@"bt2"]) {
        //bt2をタッチした際の処理
        CCLOG(@"ボタン２");
        CCLOG(@"RotateBy");
        
        // アクションByメソッド 現在の位置 + 指定した数値まで動作し何度でも動作を繰り返す
        [self actionBy];
    }
}

@end
