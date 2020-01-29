//
//  CourseInfoRouter.swift
//  Coursify
//
//  Created by Orko Haque on 1/23/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

protocol CourseInfoRoutable {
    
}

class CourseInfoRouter {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController:UINavigationController, course: Course, relatedCourses: CourseModal?) -> CourseInfoViewController {
        // Create layers
        let router = CourseInfoRouter(navigationController: navigationController)
        let interactor = CourseInfoInteractor()
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseInfoView") as! CourseInfoViewController
        let presenter = CourseInfoPresenter(view: view, router: router, interactor: interactor, course: course, relatedCourses: relatedCourses)
        view.presenter = presenter
        
        return view
    }
}

extension CourseInfoRouter: CourseInfoRoutable {
    
}
