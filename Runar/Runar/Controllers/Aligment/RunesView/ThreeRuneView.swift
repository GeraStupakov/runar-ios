//
//  ThreeRuneView.swift
//  Runar
//
//  Created by Oleg Kanatov on 24.01.21.
//

import UIKit
import Combine

class ThreeRuneView: UIView, RuneViewProtocol {
    
    //-------------------------------------------------
    // MARK: - Variables
    //-------------------------------------------------
    
    
    public var viewModel: RunesView.ViewModel?
    public var runesSet: [RuneType] = []
    public var cancellables: [AnyCancellable] = []
    public var indexesAndButtons: [Int : RuneButton] = [:]
    
    //-------------------------------------------------
    // MARK: - Methods
    //-------------------------------------------------
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpContent()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpContent()
    }
    
    private func setUpContent() {
        
        configureIndexesAndButtons(count: 3)
        addButtons()
        setupViewConstraints()
        highlightFirstButton()
    }
    
    private func setupViewConstraints() {
        guard
            let buttonOne = getButton(index: 0),
            let buttonTwo = getButton(index: 1),
            let buttonThree = getButton(index: 2)
            else {
            assertionFailure("Unexpected number of buttons. Expected number: 3. ExistingNumber: \(indexesAndButtons.count)")
            return
        }
        
        NSLayoutConstraint.activate([
            buttonOne.leadingAnchor.constraint(equalTo: buttonTwo.trailingAnchor, constant: 26.widthDependent()),
            buttonOne.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonOne.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonOne.heightAnchor.constraint(equalToConstant: 90.widthDependent()),

            buttonTwo.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonTwo.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonTwo.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonTwo.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
            
            buttonThree.trailingAnchor.constraint(equalTo: buttonTwo.leadingAnchor, constant: -26.widthDependent()),
            buttonThree.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonThree.widthAnchor.constraint(equalToConstant: 68.widthDependent()),
            buttonThree.heightAnchor.constraint(equalToConstant: 90.widthDependent()),
        ])
    }
}
