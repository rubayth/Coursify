//
//  HomePresenter.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import Foundation

protocol HomePresentable {
    func getCourses() -> CourseModal?
    func viewDidLoad()
    func didSelectCourse(course: Course)
    func textFieldUpdated(with input: String)
    func textFieldEmpty()
}

class HomePresenter{
    
    let view: HomeViewable
    let router: HomeRoutable
    let interactor: HomeInteractable
    
    var courses : CourseModal?
    var filteredCourses: CourseModal?
    
    init(view: HomeViewable, router: HomeRoutable, interactor: HomeInteractable) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

}

extension HomePresenter: HomePresentable {
    func textFieldEmpty() {
        filteredCourses = courses
        view.reloadTable()
    }
    
    func textFieldUpdated(with input: String) {
        let newData = (courses?.courseData.data.filter({ (course) -> Bool in
            guard let subject = course?.subject else { return false }
            guard let courseNumber = course?.courseNumber else { return false }
            guard let crn = course?.courseReferenceNumber else { return false }
            let subjectCourse = "\(subject) \(courseNumber)"
            
            if subjectCourse.contains(input.uppercased()) ||
                crn.contains(input){
                return true
            } else {
                return false
            }
        }))!
        filteredCourses?.updateData(newData)
        view.reloadTable()
    }
    
    func didSelectCourse(course: Course) {
        var relatedCourses = courses
        let newData = (courses?.courseData.data.filter({ (courseItem) -> Bool in
            guard let subject = courseItem?.subject else { return false }
            
            if subject.contains(course.subject!.uppercased()) {
                return true
            } else {
                return false
            }
        }))!
        relatedCourses?.updateData(newData)
        router.navigateToCourseDetails(course: course, relatedCourses: relatedCourses)
    }
    
    func getCourses() -> CourseModal?{
        return filteredCourses
    }
    
    func viewDidLoad(){
        interactor.fetchClasses { (data, error) in
            guard let json = data else { return }
            self.courses = json
            self.filteredCourses = json
            self.view.reloadTable()
        }
    }
}
