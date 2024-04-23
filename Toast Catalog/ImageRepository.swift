//
//  ImageRep.swift
//  Toast Catalog
//
//  Created by Egor Anoshin on 23.04.2024.
//

import UIKit

class ImageRepository {
    func imageForItemIdentifier(_ itemIdentifier: Int) -> UIImage? {
        let systemImageName: String
        if itemIdentifier >= 50 {
            systemImageName = "\(itemIdentifier).circle.fill"
        } else {
            systemImageName = "questionmark.circle.fill"
        }
        return UIImage(systemName: systemImageName)
    }
}




