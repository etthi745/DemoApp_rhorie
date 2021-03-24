//
//  PlayerViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/15.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class PlayerView: UIView {
    
    // The player assigned to this view, if any.
    
    var player: AVPlayer? {
        get { return playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    // The layer used by the player.
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Set the class of the layer for this view.
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: UIView!
    
    
    var player = AVPlayer()
    var timeObserverToken: Any?
    var itemDuration: Double = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var nowTime: UILabel!
    @IBOutlet weak var allTime: UILabel!
    
    let playImage = UIImage(systemName: "play.fill")!
    let pauseImage = UIImage(systemName: "pause.fill")!
    var playInt = 0
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let seconds = Double(sender.value) * itemDuration
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: seconds, preferredTimescale: timeScale)
        changePosition(time: time)
//        player.play()
    }
    
    @IBAction func playBtnTapped(_ sender: Any) {
        if playInt == 0 {
            playButton.setImage(pauseImage, for: .normal)
            player.play()
            playInt = 1
        } else {
            playButton.setImage(playImage, for: .normal)
            player.pause()
            playInt = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playButton.setImage(playImage, for: .normal)
        // タップジェスチャーを作成します。
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(singleTap(_:)))
        // シングルタップで反応するように設定します。
        singleTapGesture.numberOfTapsRequired = 1
        // ビューにジェスチャーを設定します。
        playerView.addGestureRecognizer(singleTapGesture)
        
        // 端末回転の通知機能を設定します。
        let action = #selector(orientationDidChange(_:))
        let center = NotificationCenter.default
        let name = UIDevice.orientationDidChangeNotification
        center.addObserver(self, selector: action, name: name, object: nil)
        
        setupAudioSession()
                
        setupPlayer()
        
        self.nowTime.text = "--:--"
        self.allTime.text = String(format: "%02.0f:%02.0f", itemDuration / 60, itemDuration.truncatingRemainder(dividingBy: 60))
        
        if interfaceOrientation.isLandscape {
            print("横向きです")
            navigationController?.setNavigationBarHidden(true, animated: false)
            controlView.isHidden = true
        }
        
    }
    
    var tapFlag = true
    @objc func singleTap(_ gesture: UITapGestureRecognizer) {
        // シングルタップされた時の処理を記述してください。
        if interfaceOrientation.isLandscape {
            if tapFlag == true{
                navigationController?.setNavigationBarHidden(false, animated: false)
                controlView.isHidden = false
                tapFlag = false
            } else {
                navigationController?.setNavigationBarHidden(true, animated: false)
                controlView.isHidden = true
                tapFlag = true
            }
        }
       
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        // スーパークラスのメソッドを呼び出します。
        super.viewDidDisappear(animated)
        // 端末回転の通知機能の設定を解除します。
        let center = NotificationCenter.default
        let name = UIDevice.orientationDidChangeNotification
        center.removeObserver(self, name: name, object: nil)
  
    }
    

    @objc func orientationDidChange(_ notification: NSNotification) {
            // 端末の向きを判定します。
            // 縦向きを検知する場合、
            //   device.orientation.isPortrait
            // を判定します。
            let device = UIDevice.current
            if device.orientation.isLandscape {
                // 横向きの場合
                print("横向き")
                navigationController?.setNavigationBarHidden(true, animated: false)
                controlView.isHidden = true
            } else {
                // 縦向きの場合
                print("縦向き")
                navigationController?.setNavigationBarHidden(false, animated: false)
                controlView.isHidden = false
            }
        }

    
    private func setupAudioSession() {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(.playback, mode: .moviePlayback)
            } catch {
                print("Setting category to AVAudioSessionCategoryPlayback failed.")
            }
            do {
                try audioSession.setActive(true)
                print("audio session set active !!")
            } catch {
                
            }
    }
    
    private func setupPlayer() {
            playerView.player = player
            addPeriodicTimeObserver()
            
            replacePlayerItem(fileName: "MOV", fileExtension: "mov")
            
    }
    
    private func replacePlayerItem(fileName: String, fileExtension: String) {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else {
                print("Url is nil")
                return
            }
        
            let asset = AVAsset(url: url)
            itemDuration = CMTimeGetSeconds(asset.duration)
        
            let item = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: item)
    }
    
    private func changePosition(time: CMTime) {
            let rate = player.rate
            // いったんplayerをとめる
            player.rate = 0
            // 指定した時間へ移動
            player.seek(to: time, completionHandler: {_ in
                // playerをもとのrateに戻す(0より大きいならrateの速度で再生される)
                self.player.rate = rate
            })
        }
    
    func addPeriodicTimeObserver() {
            let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1.0, preferredTimescale: timeScale)
            
            timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                               queue: .main)
            { [weak self] time in
                // update player transport UI
                DispatchQueue.main.async {
                    print("update timer:\(CMTimeGetSeconds(time))")
                    // sliderを更新
                    self?.updateSlider()
                }
            }
    }
    
    //スライダーと現在の再生時間を更新
    private func updateSlider() {
        let time = player.currentItem?.currentTime() ?? CMTime.zero
        if itemDuration != 0 {
            slider.value = Float(CMTimeGetSeconds(time) / itemDuration)
            //なぜか＋0.5されてしまうので-0.5している
            nowTime.text = String(format: "%02.0f:%02.0f", CMTimeGetSeconds(time) / 60  - 0.5,CMTimeGetSeconds(time).truncatingRemainder(dividingBy: 60))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
