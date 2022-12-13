//
//  VolumeTableViewCell.swift
//  Ambience
//
//  Created by Lucy Flores on 12/06/2021.
//

import UIKit

class VolumeCell: UITableViewCell {

    static let reuseID = "VolumeCell"
    
    let imageViewButton = AmButton()
    let labelAndSliderStackView = UIStackView()
    let soundNameLabel = AmSecondaryTitleLabel(textAlignment: .left, fontSize: 15)
    let volumeSlider = UISlider()
    let removeSoundButton = AmButton(image: SFSymbols.xMarkCircle, pointSize: 20)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        configureLabelSliderStackView()
        layoutUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configureCell() {
        addSubview(imageViewButton)
        addSubview(labelAndSliderStackView)
        addSubview(removeSoundButton)
    }
    
    
    func configureLabelSliderStackView() {
        labelAndSliderStackView.addArrangedSubview(soundNameLabel)
        labelAndSliderStackView.addArrangedSubview(volumeSlider)
        
        configureSlider()
        
        labelAndSliderStackView.axis = .vertical
        //labelAndSliderStackView.alignment = .fill
        labelAndSliderStackView.distribution = .fillEqually
        labelAndSliderStackView.spacing = -10
    }
    
    func configureSlider() {
        volumeSlider.thumbTintColor = .white
        volumeSlider.minimumTrackTintColor = #colorLiteral(red: 0, green: 0.8039215686, blue: 0.831372549, alpha: 1)
        volumeSlider.maximumTrackTintColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 1.0
        
        volumeSlider.contentMode = .scaleAspectFill
        
        setSliderThumbTintColor(.white)
    }
    
    func setSliderValue(value: Float) {
        volumeSlider.value = value
    }
    
    func setSliderThumbTintColor(_ color: UIColor) {
     let circleImage = makeCircleWith(size: CGSize(width: 15, height: 15),
                    backgroundColor: color)
        volumeSlider.setThumbImage(circleImage, for: .normal)
        volumeSlider.setThumbImage(circleImage, for: .highlighted)
 }

    fileprivate func makeCircleWith(size: CGSize, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(backgroundColor.cgColor)
        context?.setStrokeColor(UIColor.clear.cgColor)
        
        let bounds = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: bounds)
        context?.drawPath(using: .fill)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    
    func set(soundName: String) {

        let edgeInset : CGFloat = 5.0
        
        imageViewButton.setImage(UIImage(named: soundName), for: .normal)
        imageViewButton.imageView?.contentMode = .scaleAspectFill
        imageViewButton.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        imageViewButton.backgroundColor = #colorLiteral(red: 0.2, green: 0.3019607843, blue: 0.3607843137, alpha: 1)
        soundNameLabel.text = soundName
    }
    
    


    private func layoutUIView() {
        let topBottomPadding: CGFloat = 5
        let viewPadding: CGFloat = 15
        let sliderPadding: CGFloat = 10
        let sliderWidth: CGFloat  = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 200 : 200//238
        
        print("self bounds", self.bounds)
        print("self frame", self.frame.width)
        print("imageViewButton", imageViewButton.frame.width)
        
        print(sliderWidth)
        //print(sliderWidth)
        
        imageViewButton.translatesAutoresizingMaskIntoConstraints = false
        labelAndSliderStackView.translatesAutoresizingMaskIntoConstraints = false
        removeSoundButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageViewButton.topAnchor.constraint(equalTo: topAnchor, constant: topBottomPadding),
            imageViewButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomPadding),
            imageViewButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewPadding),
            imageViewButton.heightAnchor.constraint(equalTo: imageViewButton.widthAnchor),
    
            
            labelAndSliderStackView.topAnchor.constraint(equalTo: topAnchor, constant: topBottomPadding),
            labelAndSliderStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomPadding),
            labelAndSliderStackView.leadingAnchor.constraint(equalTo: imageViewButton.trailingAnchor, constant: sliderPadding),
            //labelAndSliderStackView.trailingAnchor.constraint(equalTo: removeSoundButton.leadingAnchor, constant: -sliderPadding),
            labelAndSliderStackView.widthAnchor.constraint(equalToConstant: sliderWidth), //MAKE DYNAMIC!!!!!!!!!!

            removeSoundButton.topAnchor.constraint(equalTo: topAnchor, constant: topBottomPadding),
            removeSoundButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -topBottomPadding),
            //removeSoundButton.leadingAnchor.constraint(equalTo: labelAndSliderStackView.trailingAnchor, constant: sliderPadding),
            removeSoundButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewPadding)//,
            //removeSoundButton.heightAnchor.constraint(equalTo: removeSoundButton.widthAnchor)
        ])

        
    }

}
