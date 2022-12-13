//
//  VolumeViewController.swift
//  Ambience
//
//  Created by Lucy Flores on 08/06/2021.
//

import UIKit

protocol RemovedSoundsDelegate {
    func soundRemoved(soundName: String)
    func volumeScreenClosed()
    func removeAllSounds()
}

class VolumeViewController: UIViewController {
    
    var removeSoundsDelegate: RemovedSoundsDelegate!
    
    var receivedSounds: [String] = []
    
    let volumeContainerView = AmVolumeContainerView()
    let volumeTableView = UITableView()
    
    let closeViewControllerButton = AmButton(image: SFSymbols.xMark, pointSize: 15)
    let volumeViewTitleLabel = AmSecondaryTitleLabel(textAlignment: .center, fontSize: 18)
    let removeAllButton = AmButton(title: "Remove All")
    
    var totalPadding: CGFloat = 0.0
    
 //   let userDefaults = UserDefaults.standard
//    var volumeDictionary : [Int : Float] = [:]
    

    init() {
        super.init(nibName: nil, bundle: nil)
        self.receivedSounds = SoundManager.arrayOfSounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(volumeContainerView)
        
        configureContainerView()
        configureTableView()
        layoutViewController()
        
        volumeViewTitleLabel.text = "Current Mix & Volume"
        
        closeViewControllerButton.tintColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        removeAllButton.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.6431372549, blue: 0.6941176471, alpha: 1)
        
        closeViewControllerButton.addTarget(self, action: #selector(closeViewControllerButtonTapped(sender:)), for: .touchUpInside)
        removeAllButton.addTarget(self, action: #selector(removeAllButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func configureContainerView() {
        let containerPadding : CGFloat = 20
        
        volumeContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //volumeContainerView.layoutIfNeeded()
        //let containerHeight = updateContainerViewHeight()
        
        NSLayoutConstraint.activate([
            //volumeContainerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -containerPadding),
            volumeContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -containerPadding),
            volumeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: containerPadding),
            volumeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -containerPadding),
            volumeContainerView.heightAnchor.constraint(equalToConstant: calculateContainerHeight())  //MAKE DYNAMIC!!
        ])
    
    }

    
    func configureTableView() {
        //volumeTableView.frame = view.bounds //change size?? send the table view to independent file??
        volumeTableView.rowHeight = 65
        volumeTableView.delegate = self
        volumeTableView.dataSource = self
        volumeTableView.backgroundColor = .clear
        volumeTableView.separatorStyle = .none
        
        volumeTableView.register(VolumeCell.self, forCellReuseIdentifier: VolumeCell.reuseID)
        //  volumeTableView.removeExcessCells()
   
    }
    
    func calculateContainerHeight() -> CGFloat {
        let containerHeight = (CGFloat(receivedSounds.count) * 65) //table rows
                            + 116 // elements heights & paddings
        
        return containerHeight
    }
    
//    func updateContainerHeight() {
//
//        //= volumeContainerView.bounds.height - updateTableViewHeight()
//
//        let containerHeight = closeViewControllerButton.bounds.height
//                                       + volumeViewTitleLabel.bounds.height
//                                       + volumeTableView.bounds.height
//                                       + removeAllButton.bounds.height
//                                       + totalPadding
//
//        let containerHeightConstraint = volumeContainerView.heightAnchor.constraint(equalToConstant: containerHeight)
//
//        NSLayoutConstraint.activate([containerHeightConstraint])
//        volumeContainerView.layoutIfNeeded()
//        //volumeContainerView.updateConstraints()
//
//        print(containerHeight)
//        print(volumeContainerView.bounds.height)
//        print(volumeTableView.contentSize)
//    }

    func updateTableViewHeight() -> CGFloat {
        let tableViewHeightConstraint = CGFloat(receivedSounds.count) * volumeTableView.rowHeight
    
        return tableViewHeightConstraint
    }
    
    @objc func closeViewControllerButtonTapped(sender: UIButton) {
        removeSoundsDelegate.volumeScreenClosed()
        dismissVC()
    }
    
    @objc func removeAllButtonTapped(sender: UIButton) {
        SoundManager.removeAllSounds()
        receivedSounds.removeAll()
        removeSoundsDelegate.removeAllSounds()
        
        volumeTableView.reloadData()
        dismissVCWithDelay()
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    @objc func dismissVCWithDelay() {
        // dismiss(animated: true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true)
        }
        
    }
    
    private func layoutViewController() {
        let containerPadding: CGFloat = 10
        let tableViewPadding: CGFloat = 5
        let removeAllButtoBottomPadding: CGFloat = 20
        let tableViewHeight = updateTableViewHeight()
        totalPadding = containerPadding + tableViewPadding + containerPadding + removeAllButtoBottomPadding
        
        view.addSubview(closeViewControllerButton)
        view.addSubview(volumeViewTitleLabel)
        view.addSubview(volumeTableView)
        view.addSubview(removeAllButton)
        
        closeViewControllerButton.translatesAutoresizingMaskIntoConstraints = false
        volumeViewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeTableView.translatesAutoresizingMaskIntoConstraints = false
        removeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeViewControllerButton.topAnchor.constraint(equalTo: volumeContainerView.topAnchor, constant: containerPadding),
            closeViewControllerButton.trailingAnchor.constraint(equalTo: volumeContainerView.trailingAnchor, constant: -containerPadding),
            closeViewControllerButton.heightAnchor.constraint(equalToConstant: 15),
            
            volumeViewTitleLabel.topAnchor.constraint(equalTo: closeViewControllerButton.bottomAnchor),
            volumeViewTitleLabel.centerXAnchor.constraint(equalTo: volumeContainerView.centerXAnchor),
            volumeViewTitleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            volumeTableView.topAnchor.constraint(equalTo: volumeViewTitleLabel.bottomAnchor, constant: tableViewPadding),
            volumeTableView.leadingAnchor.constraint(equalTo: volumeContainerView.leadingAnchor, constant: tableViewPadding),
            volumeTableView.trailingAnchor.constraint(equalTo: volumeContainerView.trailingAnchor, constant: -tableViewPadding),
            volumeTableView.heightAnchor.constraint(equalToConstant: tableViewHeight),
            //volumeTableView.heightAnchor.constraint(equalToConstant: 300), // MAKE Height dynamic

            removeAllButton.centerXAnchor.constraint(equalTo: volumeContainerView.centerXAnchor),
            removeAllButton.topAnchor.constraint(equalTo: volumeTableView.bottomAnchor, constant: containerPadding),
            removeAllButton.bottomAnchor.constraint(equalTo: volumeContainerView.bottomAnchor, constant: -removeAllButtoBottomPadding),
            removeAllButton.heightAnchor.constraint(equalToConstant: 40),
            removeAllButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        //updateContainerHeight()
    }
    

}

// the datasource is simple that's why it is stll on this view controller and not in a separated class.
extension VolumeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedSounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VolumeCell.reuseID) as! VolumeCell
        
        print(receivedSounds)
        let sound = receivedSounds[indexPath.row]
        
        cell.set(soundName: sound)
        print(sound)
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false        
        
        cell.removeSoundButton.titleLabel?.text = sound
        cell.removeSoundButton.tag = indexPath.row
        
        cell.volumeSlider.tag = indexPath.row
        cell.setSliderValue(value: SoundManager.currentVolume(soundName: sound))
        
        //print(SoundManager.currentVolume(soundName: sound))
        //print("cell.indexpath", indexPath.row)
        
        cell.removeSoundButton.addTarget(self, action: #selector(removeSoundButtonTapped(sender:)), for: .touchUpInside)
        cell.volumeSlider.addTarget(self, action: #selector(volumeSliderDragged(sender:)), for: .valueChanged)
//        cell.volumeSlider.addTarget(self, action: #selector(volumeSliderDragEnded(sender:)), for: [.touchUpInside, .touchUpOutside])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: VolumeCell.reuseID) as! VolumeCell

        cell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.5411764706, blue: 0.6039215686, alpha: 1)
    }
    
    @objc func volumeSliderDragged(sender: UISlider) {
        SoundManager.changeVolume(index: sender.tag, volume: sender.value)
        //print(sender.tag, sender.value)
    }
    
//    @objc func volumeSliderDragEnded(sender: UISlider) {
////        volumeDictionary = [sender.tag : sender.value]
////        print(volumeDictionary)
//    }
    
    @objc func removeSoundButtonTapped(sender: UIButton) {
        //traer la main thread??
        let sound : String = (sender.titleLabel?.text)!
        
//        print("removeSoundButtonTapped")
//        print(Int(sender.tag))
//        print(sender.titleLabel?.text ?? "nil")
 
        SoundManager.stopSound(soundName: sound)
        receivedSounds.remove(at: Int(sender.tag))
        
        //volumeTableView.updateConstraints()
        //updateContainerViewHeight()
        
        volumeTableView.reloadData()
        volumeTableView.layoutIfNeeded()
        volumeTableView.removeExcessCells()
        
        removeSoundsDelegate.soundRemoved(soundName: sound)
        
        if receivedSounds.isEmpty {
            dismissVCWithDelay()
        }
 
        //salvar el diccionario antes de cerrar la pantalla
       // userDefaults.set(volumeDictionary, forKey: "changedVolumes") // como poner varios?
       
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.volumeTableView.deleteRows(at:[indexPath], with: .fade)
        }
  
        
    }
    
    // Deactives left swipe to delete row
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if volumeTableView.isEditing {
            return .delete
        }

        return .none
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.5411764706, blue: 0.6039215686, alpha: 1)
    }

    
}
