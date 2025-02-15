//
//  SelectRuneCell.swift
//  Runar
//
//  Created by George Stupakov on 25/05/2022.
//

import UIKit

class SelectRuneCell: UICollectionViewCell {

    public var model: GenerationRuneModel?
    public var indexPath: IndexPath = IndexPath()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let runeImage: UIButton = {
        let runeImage = UIButton()
        
        runeImage.contentMode = .scaleAspectFill
        
        return runeImage
    }()
    
    private func setupViews(){
        backgroundColor = .clear
        
        addSubview(runeImage)
        
        runeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            runeImage.heightAnchor.constraint(equalToConstant: 97),
            runeImage.widthAnchor.constraint(equalToConstant: 78),
            runeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            runeImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func setRune(_ rune: GenerationRuneModel, _ indexPath: IndexPath) {
        self.model = rune
        self.indexPath = indexPath
        
        runeImage.setBackgroundImage(rune.image.image, for: .normal)
    }
    
    public func selectRune() {
        self.isSelected = true
        self.toggleState()
    }
    
    public func deselectRune() {
        self.isSelected = false
        self.toggleState()
    }
    
    public func toggleState(){
        self.runeImage.isEnabled = !self.isSelected
    }
}
