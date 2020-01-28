//
//  CourseCollectionViewCell.swift
//  Coursify
//
//  Created by Orko Haque on 1/21/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseNumberLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }

}
