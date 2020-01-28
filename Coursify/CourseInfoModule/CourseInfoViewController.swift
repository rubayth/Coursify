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
}

class CourseInfoViewController: UIViewController {
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var enrollmentLabel: UILabel!
    
    var presenter: CourseInfoPresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension CourseInfoViewController: CourseInfoViewable {
    func initialSetup() {
        guard let presenter = presenter else { return }
        self.navigationItem.title = presenter.getCourse().courseTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPressed))
        
        let faculty = presenter.getCourse().faculty
        professorLabel.text = faculty.count > 0 ? faculty[0]?.displayName : "TBA"
        
        let meetingTime = presenter.getCourse().meetingsFaculty[0]?.meetingTime
        timeLabel.text = "\(meetingTime?.beginTime ?? "?") - \(meetingTime?.endTime ?? "?")"
        dayOfWeekLabel.text = (meetingTime?.monday)! ? "M" : ""
        enrollmentLabel.text = "course?.enrollment"
    }
    
    @objc func addPressed() {
        presenter?.addPressed()
    }
}


