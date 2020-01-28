//
//  CourseModal.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import Foundation

struct CourseModal {
    var courseData:CourseData
    
    init(courseData: CourseData) {
        self.courseData = courseData
        //self.groupedBySubjects = Dictionary(grouping: courseData.data) { $0?.subject ?? "Error" }
    }
    
    func getSubjects() -> [String?]{
        return courseData.data.map{ $0?.subject}.removingDuplicates()
    }
    
    func getCoursesForSubject(subject: String) -> [Course?]{
        return courseData.data.filter({ (course) -> Bool in
            if course?.subject == subject {
                return true
            }
            return false
        })
    }
    
    mutating func updateData(_ newData: [Course?]){
        courseData.data = newData
    }
}
