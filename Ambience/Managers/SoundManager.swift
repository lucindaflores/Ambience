//
//  SoundManager.swift
//  Ambience
//
//  Created by Lucy Flores on 07/06/2021.
//

import Foundation
import AVFoundation

class SoundManager: AVPlayer {
    
    public static var arrayOfSounds: [String] = []
    public static var arrayOfAudioPlayers: [AVAudioPlayer] = []

    func playSound(soundName sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
                                                            options: AVAudioSession.CategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            SoundManager.arrayOfSounds.append(sound) // se pudiera tener solo uno para ambas clases **
            SoundManager.arrayOfAudioPlayers.append(audioPlayer)
       
            audioPlayer.setVolume(0.5, fadeDuration: 0)
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        
        } catch let error {
            //WARNING("Error for debugging, change later")
            print(error.localizedDescription)
            // HACER ERROR: throw soundError.fileNotFound
        }
        
    }
   
    func playAll() {
        for (index, _) in SoundManager.arrayOfSounds.enumerated() {
            SoundManager.arrayOfAudioPlayers[index].play()
        }
        
    }
    
    func pauseAll() {
        for (index, _) in SoundManager.arrayOfSounds.enumerated() {
            SoundManager.arrayOfAudioPlayers[index].pause()
        }
    }
    
    
    public static func stopSound(soundName sound: String){
        print("stop")
        for (index, soundArray) in arrayOfSounds.enumerated() {
            if soundArray == sound {
                arrayOfAudioPlayers[index].stop()
                arrayOfAudioPlayers.remove(at: index)
                arrayOfSounds.remove(at: index)
            }
        }
    }

    
    public static func changeVolume(index: Int, volume: Float) {
        print("index, volume ", index, volume)
        for (i, _) in arrayOfSounds.enumerated() {
            if index == i {
                arrayOfAudioPlayers[index].setVolume(volume, fadeDuration: 0)
            }
        }
    
    }
    
    public static func currentVolume(soundName: String) -> (Float) {
        //var tag: Int = 0
        var volume : Float = 0.0
    
        for (index, soundArray) in arrayOfSounds.enumerated() {
            if soundArray == soundName {
                //tag = index
                volume = arrayOfAudioPlayers[index].volume
                break
            }
        }
        return volume
    }
    
    
    public static func removeAllSounds() {
        for (index, _) in arrayOfSounds.enumerated() {
                arrayOfAudioPlayers[index].stop()
        }
        
        arrayOfAudioPlayers.removeAll()
        arrayOfSounds.removeAll()
    }
    
    func isAnySoundPlaying() -> Bool {
        var flag: Bool = true
        if SoundManager.arrayOfSounds.count == 0 {
            flag = false
        }
        
        return flag
    }
      
    
    func currentlySoundsPlaying() -> String {
        var currentSounds = ""
        
        switch SoundManager.arrayOfSounds.count {
        case 0:
            currentSounds = ""
        case 4...5:
            currentSounds = "Multiple sounds..."
        default:
            currentSounds = SoundManager.arrayOfSounds.joined(separator: " + ")
        }
        
        return currentSounds
    }

    
}
