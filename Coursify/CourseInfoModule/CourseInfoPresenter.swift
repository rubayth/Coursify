//
//  CourseInfoPresenter.swift
//  Coursify
//
//  Created by Orko Haque on 1/23/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import Foundation

protocol CourseInfoPresentable {
    func getCourse() -> Course
    func viewDidLoad()
    func addPressed()
}

class CourseInfoPresenter {
    let view: CourseInfoViewable
    let router: CourseInfoRoutable
    let interactor: CourseInfoInteractable
    let course: Course
    
    init(view: CourseInfoViewable, router: CourseInfoRoutable, interactor: CourseInfoInteractable, course: Course) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.course = course
    }
}

extension CourseInfoPresenter: CourseInfoPresentable {
    func addPressed() {
        print("pressed")
    }
    
    func viewDidLoad() {
        view.initialSetup()
    }
    
    func getCourse() -> Course {
        return course
    }
    
    
}
