//
//  RuneViewProtocol.swift
//  Runar
//
//  Created by Oleg Kanatov on 26.01.21.
//

import UIKit
import Combine

public protocol RuneViewProtocol: AnyObject {
    
    var viewModel: RunesView.ViewModel? { get set }
    
    var runesSet: [RuneType] { get set }
    var cancellables: [AnyCancellable] { get set }
    var indexesAndButtons: [Int: RuneButton] { get set }
    
    func getButton(index: Int) -> RuneButton?
    
    func configureIndexesAndButtons(count: Int, availableRunes: [RuneType])
    func addButtons()
    
    func highlightFirstButton()
    func highlightNextButton()
    func openHighlightedButton()
    
    func verifyDidHighlightAllButtons()
}


public extension RuneViewProtocol where Self: UIView {
    
    
    var areAllButtonsOpened: Bool {
        !indexesAndButtons.contains(where: { $0.value.runeState != .rune })
    }
    
    var lastOpenedIndexAndButton: (Int, RuneButton)? {
        indexesAndButtons
            .sorted(by: { $0.key < $1.key })
            .last(where: { $0.value.runeState == .rune })
    }
    
    var highlightedIndexAndButton: (Int, RuneButton)? {
        indexesAndButtons
            .sorted(by: { $0.key < $1.key })
            .first(where: { $0.value.runeState == .highlighted })
    }
    
    func tintAllButtons() {
        indexesAndButtons.forEach { $0.value.setRuneState(.tinted) }
    }
    
    func highlightNextButton(previousIndex: Int) {
        guard let buttonToHighlight = getButton(index: previousIndex + 1) else { return }
        
        buttonToHighlight.setRuneState(.highlighted)
    }
    
    func openButton(index: Int) {
        guard let buttonToOpen = getButton(index: index) else { return }
        
        buttonToOpen.setRuneState(.rune)
    }
}

public extension RuneViewProtocol where Self: UIView {
    func getButton(index: Int) -> RuneButton? {
        indexesAndButtons[index]
    }
    
    func configureIndexesAndButtons(count: Int, availableRunes: [RuneType] = RuneType.allCases()) {
        runesSet.removeAll()
        
        indexesAndButtons = (0..<count).reduce(into: [Int: RuneButton](), { dict, index in
            let availableRunes = availableRunes.filter { !runesSet.contains($0) }
            
            guard let associatedRune = availableRunes.randomElement() else {
                assertionFailure("availableRunes is empty")
                return
            }
            
            runesSet.append(associatedRune)
            let runeImage = associatedRune.image
            let button = RuneButton()
            button.layer.cornerRadius = 25.heightDependent()
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.update(with: .init(runeType: associatedRune,
                                      title: "\(index + 1)", image: runeImage,
                                      openRune: {
                                        self.openButton(index: index)
                                        self.highlightNextButton(previousIndex: index)
                                        self.verifyDidHighlightAllButtons()
                                      }, runeInfo: { [self] (runeType, frame) in
                                        
                                        let oneRune = OneRuneViewController(runeType: runeType,runeLayout: self.viewModel!.runeLayout, runesSet: self.runesSet, index: index)
                                        oneRune.leaveLightAndMakeDark = {index in
                                            self.addDarkFor(index: index)
                                        }
                                        
                                        oneRune.removeAllDark = {
                                            self.removeAllDark()
                                        }
                                        oneRune.buttonFrames = viewModel?.buttonFrames
                                        
                                        guard let controller = self.viewModel?.viewController else {return}
                                        if controller.readyToOpen == true {
                                            controller.addOneRuneViewController(controller: oneRune)
                                            oneRune.leaveLightAndMakeDark!(runesSet.firstIndex(of: runeType)!)
                                        }
                                      }))
            
            dict[index] = button
        })
    }
    
    func addButtons() {
        indexesAndButtons.forEach { _, button in
            addSubview(button)
        }
    }
    
    func highlightFirstButton() {
        assert(!indexesAndButtons.isEmpty, "IndexesAndButtons is empty")
        
        tintAllButtons()
        highlightNextButton(previousIndex: -1)
    }
    
    func highlightNextButton() {
        guard let lastOpenedButtonIndex = lastOpenedIndexAndButton?.0 else { return }
        
        highlightNextButton(previousIndex: lastOpenedButtonIndex)
    }
    
    func openHighlightedButton() {

        guard let highlightedButtonIndex = highlightedIndexAndButton?.0 else { return }
        openButton(index: highlightedButtonIndex)
 
    }

    
    func verifyDidHighlightAllButtons() {
        guard areAllButtonsOpened else { return }
        viewModel?.didHighlightAllRunes(runesSet)

        let sorted = indexesAndButtons.sorted(by: {$0.key < $1.key})
        let valuesArraySorted = Array(sorted.map({ $0.value }))
        valuesArraySorted.forEach { button in
            viewModel?.buttonFrames.append(button.frame)
            //)
            
        }
    }
    
    func addDarkFor(index: Int) {
        for button in 0..<indexesAndButtons.values.count where button != index {
            indexesAndButtons[button]?.addDark()
        }
    }
    
    func removeAllDark() {
        for button in indexesAndButtons.values {
            button.removeDark()
        }
    }
}
