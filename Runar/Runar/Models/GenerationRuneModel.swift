//
//  GenerationRuneModel.swift
//  Runar
//
//  Created by Maksim Harbatsevich on 9/30/21.
//

import UIKit

public class GenerationRuneModel {
    let title: String
    let description: String
    let image: GenerationRuneImage
    
    init(title: String, description: String, image: GenerationRuneImage){
        self.title = title
        self.description = description
        self.image = image
    }
}

public extension GenerationRuneModel {
    static func create(title: String, description: String, type: GenerationRuneType) -> GenerationRuneModel {
        return GenerationRuneModel(title: title, description: description, image: type.image)
    }
    
    static func create(title: String, description: String, image: UIImage) -> GenerationRuneModel {
        let image: GenerationRuneImage = GenerationRuneImage(image: image, height: 70, width: 56)
        
        return GenerationRuneModel(title: title, description: description, image: image)
    }
}

// MARK: - Structs
struct GenerationRuneImage {
    var image: UIImage
    var height: CGFloat
    var width: CGFloat
}

// MARK: - Types
public enum GenerationRuneType {
    case pattern
    case formula
    case staves
    
    var image: GenerationRuneImage {
        switch self {
        case .pattern:
            return GenerationRuneImage(image: Assets.runePattern.image, height: 160, width: 254)
        case .formula:
            return GenerationRuneImage(image: Assets.runeFormula.image, height: 74, width: 78)
        case .staves:
            return GenerationRuneImage(image: Assets.runeStaves.image, height: 65, width: 56)
        }
    }
}
