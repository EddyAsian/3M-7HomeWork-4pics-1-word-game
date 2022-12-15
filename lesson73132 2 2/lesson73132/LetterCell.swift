//
//  LetterCell.swift
//  lesson73132
//
//  Created by User on 12/8/22.
//

import Foundation
import UIKit

class LetterCell: UICollectionViewCell {
    
    @IBOutlet weak var letterLabel: UILabel!
    
    
    override func layoutSubviews() {
//        backgroundColor = .green
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
    }
    
}


class WordCell: UICollectionViewCell {
    
 
    @IBOutlet weak var wordLabel: UILabel!
    
    
    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
    }
}
