//
//  ViewController.swift
//  Ambience
//
//  Created by Lucy Flores on 02/04/2021.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController, UICollectionViewDelegate {

    var soundButtonsCollectionView: UICollectionView!
    var soundManager = SoundManager()

    var data: [SoundsModel] = []

    static var soundPlayerLoaded : Bool = false
    var isPauseButtonOnScreen : Bool = true

    var soundName: String = ""
    
    let screenNameLabel = AmTitleLabel(text: "Sounds", textAlignment: .left, fontSize: 28)
    let currentlyPlayingUIView = SoundPlayerView()
    
    let textFieldTest = UITextField()
    let advertisingStackView = UIStackView()

    // MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.1294117647, blue: 0.1568627451, alpha: 1)
        
        configureCollectionView()
        configureAdvertisingStackView()
        layoutUI()
          
        soundButtonsCollectionView.delegate = self
        soundButtonsCollectionView.dataSource = self

        var index = 0
        for item in buttonNames.allCases {
            data.append(SoundsModel(buttonTag: index, imageName: item.rawValue, labelName: item.rawValue))
            index +=  1
        }
  
        //currentlyPlayingUIView.isHidden = true
        currentlyPlayingUIView.chevronButton.isEnabled = false
        currentlyPlayingUIView.pausePlayButton.isEnabled = false
        currentlyPlayingUIView.soundPlayingLabel.text = "Player:"
        currentlyPlayingUIView.soundNameLabel.text = "Ready"
        
        currentlyPlayingUIView.pausePlayButton.addTarget(self, action: #selector(pauseButtonTapped(sender:)), for: .touchUpInside)
        currentlyPlayingUIView.chevronButton.addTarget(self, action: #selector(chevronButtonTapped(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Configuring elements on screen
    func configureCollectionView() {
        soundButtonsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        soundButtonsCollectionView.allowsMultipleSelection = true
        
        soundButtonsCollectionView.backgroundColor = #colorLiteral(red: 0.08524136737, green: 0.1305128029, blue: 0.1559251698, alpha: 1)
        soundButtonsCollectionView.register(SoundButtonCell.self, forCellWithReuseIdentifier: SoundButtonCell.reuseID)
    }
    
    func configureAdvertisingStackView() {
//        advertisingStackView.addArrangedSubview(volumeSlider)
//        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
//
        advertisingStackView.axis = .horizontal
        advertisingStackView.alignment = .center

//        advertisingStackView.spacing = 20
//        advertisingStackView.distribution = .fillEqually

        advertisingStackView.backgroundColor = .green
//
//        let padding: CGFloat = 10
//
//        NSLayoutConstraint.activate([
//            volumeSlider.leadingAnchor.constraint(equalTo: advertisingStackView.leadingAnchor, constant: 15),
//            volumeSlider.trailingAnchor.constraint(equalTo: advertisingStackView.trailingAnchor, constant: -25)
//        ])
        
    }
    
    

    // MARK: - Functionality: move to external class??
    func soundPlayerViewDidLoad() {
        //currentlyPlayingUIView.isHidden = false
        currentlyPlayingUIView.pausePlayButton.isEnabled = true
        currentlyPlayingUIView.chevronButton.isEnabled = true
        currentlyPlayingUIView.soundPlayingLabel.text = "Playing:"
        SoundViewController.soundPlayerLoaded = true
    }
    
    
    func clearSoundElements() {
        currentlyPlayingUIView.soundNameLabel.text = ""
        soundName = ""
        currentlyPlayingUIView.soundPlayingLabel.text = "Player:"
        currentlyPlayingUIView.soundNameLabel.text = "Paused"
        
        currentlyPlayingUIView.pausePlayButton.isEnabled = false
        isPauseButtonOnScreen = false
    }
    
    
    func limitOfSoundsMessage() {
        let alert = UIAlertController(title: "Limit reached", message: "You can only select 5 sounds", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func maxNumberOfSoundsAllowed() -> Bool {
        if SoundManager.arrayOfSounds.count >= 5 {
            return true
        } else {
            return false
        }
    }
    
//    func iterateThroughVisibleCells(userInteractionEnabled: Bool) {
//        for cell in soundButtonsCollectionView.visibleCells as [UICollectionViewCell] {
//            cell.isUserInteractionEnabled = userInteractionEnabled
//        }
//
//    }
//
//    func enableSelectedItems() {
//        if let arrayOfIndexPaths = soundButtonsCollectionView.indexPathsForSelectedItems {
//            for index in arrayOfIndexPaths {
//                let cell = soundButtonsCollectionView.cellForItem(at: index)
//                cell?.isUserInteractionEnabled = true
//            }
//        }
//    }
    
    // MARK: - Objc functions
    @objc func pauseButtonTapped(sender: UIButton) {
        if isPauseButtonOnScreen == true {
            soundManager.pauseAll()
            currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.play)
            isPauseButtonOnScreen = false
        } else {
            soundManager.playAll()
            currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.pause)
            isPauseButtonOnScreen = true
        }
    }
    
    @objc func chevronButtonTapped(sender: UIButton) {
        DispatchQueue.main.async {
            let destinationVC = VolumeViewController()
                //VolumeViewController(sounds: soundManager.arrayOfSounds)
            destinationVC.removeSoundsDelegate = self
            

            destinationVC.modalPresentationStyle = .overCurrentContext
            destinationVC.modalTransitionStyle = .crossDissolve
            
            self.present(destinationVC, animated: true)
        }
    }
    
    // MARK: - Layout function
    func layoutUI() {
        let padding: CGFloat = 15
        let _: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -10 : -15
       
        view.addSubview(screenNameLabel)
        view.addSubview(soundButtonsCollectionView)
        view.addSubview(currentlyPlayingUIView)
        view.addSubview(advertisingStackView)
  
        screenNameLabel.translatesAutoresizingMaskIntoConstraints = false
        soundButtonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        currentlyPlayingUIView.translatesAutoresizingMaskIntoConstraints = false
        advertisingStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            screenNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            screenNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            screenNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenNameLabel.heightAnchor.constraint(equalToConstant: 30),
      
            soundButtonsCollectionView.topAnchor.constraint(equalTo: screenNameLabel.bottomAnchor, constant: 5),
            soundButtonsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),//, constant: 30),
            soundButtonsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            soundButtonsCollectionView.bottomAnchor.constraint(equalTo: currentlyPlayingUIView.topAnchor, constant: 15),
            //soundButtonsCollectionView.heightAnchor.constraint(equalToConstant: 550),
       
            //currentlyPlayingUIView.bottomAnchor.constraint(equalTo: advertisingStackView.topAnchor, constant: bottomSoundPlayer),
            currentlyPlayingUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currentlyPlayingUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            currentlyPlayingUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            currentlyPlayingUIView.heightAnchor.constraint(equalToConstant: 55)//,
            
//            advertisingStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            advertisingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            advertisingStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            advertisingStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    
}

// MARK: - Extensions for CollectionView
extension SoundViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoundButtonCell.reuseID, for: indexPath) as! SoundButtonCell
        cell.set(soundButton: self.data[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? SoundButtonCell else { return }
        
        soundName = data[indexPath.item].labelName
        
        // Executed just once, when the soundplayer appears for first time
        if !SoundViewController.soundPlayerLoaded {
            soundPlayerViewDidLoad()
        }
        
        currentlyPlayingUIView.pausePlayButton.isEnabled = true
        isPauseButtonOnScreen = true
        
        soundManager.playSound(soundName: soundName)
        currentlyPlayingUIView.soundPlayingLabel.text = "Playing:"
        currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.pause)
        currentlyPlayingUIView.updateSoundNameLabel(text: soundManager.currentlySoundsPlaying())
        cell.changeButtonBackgroundColor(flag: true)
        
        print(indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SoundButtonCell else { return }
        
        soundName = data[indexPath.item].labelName
        SoundManager.stopSound(soundName: soundName)
        
        if soundManager.isAnySoundPlaying() == false {
            currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.play)
            clearSoundElements()
        } else {
            currentlyPlayingUIView.updateSoundNameLabel(text: soundManager.currentlySoundsPlaying())
        }
      
        cell.changeButtonBackgroundColor(flag: false)
    }

    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if maxNumberOfSoundsAllowed() {
            limitOfSoundsMessage()
            return false
        } else {
            return true
        }
    }

}


// MARK: - Extension RemovedSoundsDelegate
extension SoundViewController: RemovedSoundsDelegate {
    func soundRemoved(soundName: String) {
        //func soundRemoved(soundName: String) {
        var indexPath : IndexPath = [0, 0]
        for item in data {
            if item.labelName == soundName {
                print(item.buttonTag, " ", item.labelName)
                print(item.buttonTag)
                indexPath.row = item.buttonTag
                //soundButtonsCollectionView.deselectItem(at: [0, item.buttonTag], animated: false)
                break
            }
        }
        
        if let currentCell = soundButtonsCollectionView.cellForItem(at: indexPath) as? SoundButtonCell {
            currentCell.changeButtonBackgroundColor(flag: false)
        }
    }
    
    func volumeScreenClosed() {
        //  func volumeScreenClosed() {
        print(SoundManager.arrayOfSounds)
    
        if soundManager.isAnySoundPlaying() {
            currentlyPlayingUIView.updateSoundNameLabel(text: soundManager.currentlySoundsPlaying())
            
            //cell.changeButtonBackgroundColor(flag: true)
        } else {
            currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.play)
            soundButtonsCollectionView.reloadData()
            clearSoundElements()
        }
    }
    
    func removeAllSounds() {
        currentlyPlayingUIView.pausePlayButtonPressed(systemName: SFSymbols.play)
        soundButtonsCollectionView.reloadData()
        clearSoundElements()
    }
    
 
    
    
}
