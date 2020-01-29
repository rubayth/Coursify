//
//  CoursesViewController.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

protocol CourseInfoViewable {
    func initialSetup()
    func addPressed()
    func reloadTable()
}

class CourseInfoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var enrollmentLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var CRNLabel: UILabel!
    
    var presenter: CourseInfoPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension CourseInfoViewController: CourseInfoViewable {
    func initialSetup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "courseCell")
        
        guard let presenter = presenter else { return }
        let course = presenter.getCourse()
        
        self.navigationItem.title = course.courseTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPressed))
        
        let faculty = course.faculty.count > 0 ? course.faculty[0] : nil
        let meetingTime = course.meetingsFaculty[0]?.meetingTime
        
        professorLabel.text = faculty?.displayName ?? "TBA"
        emailLabel.text = faculty?.emailAddress
        
        timeLabel.text = "\(meetingTime?.beginTime ?? "?") - \(meetingTime?.endTime ?? "?")"
        dayOfWeekLabel.text = getDaysOfWeekString(meetingTime: meetingTime)
        
        buildingLabel.text = meetingTime?.buildingDescription
        roomLabel.text = " Room \(meetingTime?.room ?? "TBA")"
        
        enrollmentLabel.text = "\(course.seatsAvailable ?? 0) / \(course.maximumEnrollment ?? 0) Slots Open"
        CRNLabel.text = course.courseReferenceNumber
        
        
    }
    
    @objc func addPressed() {
        presenter?.addPressed()
    }
    
    func getDaysOfWeekString(meetingTime: MeetingTime?) -> String {
        guard let schedule = meetingTime else { return "TBA" }
        
        let M = schedule.monday ? "M" : ""
        let T = schedule.tuesday ? "T" : ""
        let W = schedule.wednesday ? "W" : ""
        let Thur = schedule.thursday ? "Th" : ""
        let F = schedule.friday ? "F" : ""
        let Sat = schedule.saturday ? "Sat" : ""
        let Sun = schedule.sunday ? "Sun" : ""
        
        return M + T + W + Thur + F + Sat + Sun
    }
    
    func reloadTable(){
        collectionView.reloadData()
    }
}

extension CourseInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "courseHeader", for: indexPath)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (presenter?.getRelatedCourses()?.courseData.data.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCollectionViewCell
        guard let course = presenter?.getRelatedCourses()?.courseData.data[indexPath.item] else { return cell }
        
        cell.courseLabel.text = "\(course.courseTitle ?? "?") \(course.courseNumber ?? "?")"
        cell.courseNumberLabel.text = "\(course.seatsAvailable ?? 0) / \(course.maximumEnrollment ?? 0)"
        cell.dayOfWeekLabel.text = course.courseReferenceNumber
        
        switch course.seatsAvailable {
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
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let columns: CGFloat = 2
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat =  100
        
        //        let width = (collectionView.bounds.width / 2) - 30
        //        let height: CGFloat = 120
        
        return CGSize(width: width, height: height)
    }
}


