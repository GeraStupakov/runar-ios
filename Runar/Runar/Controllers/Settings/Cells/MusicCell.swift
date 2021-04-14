//
//  MusicCell.swift
//  Runar
//
//  Created by Юлия Лопатина on 12.04.21.
//

import UIKit

extension String {
    static let music = "Музыка"
}

extension UIColor {
    static let musicIsOn = UIColor(red: 0.604, green: 0.604, blue: 0.604, alpha: 1)
}

class MusicCell: UITableViewCell {
    
    static let identifier = "MusicCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        switchControl.addTarget(self, action: #selector(switchOnTap), for: .valueChanged)
        textLabel?.font = FontFamily.SFProDisplay.regular.font(size: 20)
        textLabel?.textColor = .settingsWhiteText
        
        configureUI()
        checkPlayer()
    }
    
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    private let musicPlayer = MusicViewController.shared.audioPlayer
    private var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.thumbTintColor = UIColor.musicIsOn
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        
        switchControl.tag = 200
        return switchControl
    }()

    private func configureUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(switchControl)
        
        NSLayoutConstraint.activate([
            switchControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            switchControl.widthAnchor.constraint(equalToConstant: 36),
            switchControl.heightAnchor.constraint(equalToConstant: 20),
            switchControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        )
    }
    
    private func checkPlayer() {
        
        if ((musicPlayer?.isPlaying) != nil) {
            switchControl.isOn = true
        } else {
            switchControl.isOn = false
        }
    }
    
    @objc private func switchOnTap(_ sender: UISwitch) {
        if sender.tag == 200 {
        if !switchControl.isOn {
            musicPlayer?.stop()
        } else {
            musicPlayer?.play()
        }}
    }
}
