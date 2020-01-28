//
//  CourseRow.swift
//  Coursify
//
//  Created by Orko Haque on 1/21/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

class CourseRow: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    var coursesForSubject : [Course?]?
    var presenter: HomePresentable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "courseCell")
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        collectionView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //setHeightOfCollectionView()
    }
    
    func setHeightOfCollectionView(){
        let width = collectionView.bounds.width
        let height = 120
        collectionHeightConstraint.constant = 120
    }
    
}

extension CourseRow: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let courses = coursesForSubject else { return 0 }
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCollectionViewCell
        
        guard let courses = coursesForSubject else { return cell }
        let course = courses[indexPath.item]
        
        cell.courseLabel.text = "\(course?.courseTitle ?? "?") \(course?.courseNumber ?? "?")"
        cell.courseNumberLabel.text = "\(course?.seatsAvailable ?? 0) / \(course?.maximumEnrollment ?? 0)"
        cell.dayOfWeekLabel.text = course?.courseReferenceNumber
        
        switch course?.seatsAvailable {
        case 0:
            cell.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case 1,2:
            cell.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        default:
            cell.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewHeight = collectionView.bounds.height
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        //        let rows: CGFloat = 1
        //        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (rows - 1)
        //        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        //        let adjustedHeight = collectionViewHeight - spaceBetweenCells - sectionInsets
        //
        //        let width: CGFloat = 150
        //        let height: CGFloat =  floor(adjustedHeight / rows)
        
        let width = (collectionView.bounds.width / 2) - 30
        let height: CGFloat = 120
        return CGSize(width: width, height: height)
    }
    
    
}

extension CourseRow: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectCourse(course: coursesForSubject![indexPath.item]!)
    }
}
