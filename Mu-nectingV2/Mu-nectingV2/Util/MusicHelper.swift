//
//  MusicHelper.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 8/12/24.
//

import Foundation
import AVFoundation

protocol MusicHelperDelegate: AnyObject {
    func trackDidChange( track: Track )
}

class MusicHelper : NSObject{
    static let shared = MusicHelper()
    
    var trackList : [Track]!
    var track : Track!
    var musicPlayer : AVAudioPlayer!
    var currentPlayNum = 0
    var isPaused = false
    var delegate : MusicHelperDelegate?
    
    func setInit(tracks : [Track], currentNum : Int){
        self.trackList = tracks
        self.currentPlayNum = currentNum
    }
    
    func playMusic(){
        if let player = musicPlayer, isPaused {
            // 중지 상태에서 재생일경우
            player.play()
            isPaused = false
            return
        }
        
        self.track = self.trackList[self.currentPlayNum]
        let url = URL(string: self.track.trackPreview!)
        
        URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            guard let urlData = data else { return }
            
            do{
                musicPlayer = try AVAudioPlayer(data: urlData)
                musicPlayer.numberOfLoops = 0
                musicPlayer.delegate = self
                
                musicPlayer.prepareToPlay()
                musicPlayer.play()
            }catch{
                print("musicPlayer 세팅 에러")
                print(error)
            }
        }.resume()
        
        delegate?.trackDidChange(track: self.track)
    }
    
    
    func pauseMusic(){
        self.musicPlayer.pause()
        isPaused = true
    }
    
    func checkIsPlayingMusic() -> Bool{
        if self.musicPlayer != nil {
            return self.musicPlayer.isPlaying
        }else{
            return false
        }
    }
    
    func getCurrentTrack() -> Track {
        return self.track
    }
    
    func nextMusic(){
        currentPlayNum += 1
        if currentPlayNum >= trackList.count {
            currentPlayNum = 0
        }
        
        musicPlayer?.stop()
        musicPlayer = nil
        isPaused = false
        
        playMusic()
    }
}


extension MusicHelper : AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        print("finish")
        nextMusic()
    }
}
