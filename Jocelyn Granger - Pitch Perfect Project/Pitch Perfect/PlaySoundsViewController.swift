//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Jocelyn Granger on 3/31/15.
//  Copyright (c) 2015 Jocelyn Granger. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    var receivedAudio : RecordedAudio!  // contains NSURL to sound file
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set path to audio player object
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        
        // Must be done before changing rate of audio player speed
        audioPlayer.enableRate = true
        
        // Initialize its value
        audioEngine = AVAudioEngine()
        
        // Initialize audioFile, by using receivedAudio's NSURL
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0   // Set pointer to beginning of sound file
        audioPlayer.play()
    }
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0   // Set pointer to beginning of sound file
        audioPlayer.play()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        // Stop playing, before starting to play new file
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)  // start the audio engine
        
        audioPlayerNode.play()  // play the audio player
    }

    
    @IBAction func stopPlaying(sender: UIButton) {
        audioPlayer.stop()
    }
    
}
