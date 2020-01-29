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
    func getRelatedCourses() -> CourseModal?
}

class CourseInfoPresenter {
    let view: CourseInfoViewable
    let router: CourseInfoRoutable
    let interactor: CourseInfoInteractable
    let course: Course
    var relatedCourses: CourseModal?
    
    init(view: CourseInfoViewable, router: CourseInfoRoutable, interactor: CourseInfoInteractable, course: Course, relatedCourses: CourseModal?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.course = course
        self.relatedCourses = relatedCourses
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
    
    func getRelatedCourses() -> CourseModal?{
        return relatedCourses
    }
    
//    func filterCourses(with input: String) {
//        let newData = (courses?.courseData.data.filter({ (course) -> Bool in
//            guard let subject = course?.subject else { return false }
//            
//            if subject.contains(input.uppercased()){
//                return true
//            } else {
//                return false
//            }
//        }))!
//        filteredCourses?.updateData(newData)
//    }
    
}
