//
//  HomeRouter.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

protocol HomeRoutable {
    func navigateToCourseDetails(course: Course, relatedCourses: CourseModal?)
}

class HomeRouter {
    
    //let presenter: HomePresentable
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    static func createModule(using navigationController:UINavigationController) -> HomeViewController {
        // Create layers
        let router = HomeRouter(navigationController: navigationController)
        let interactor = HomeInteractor()
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        
        return view
    }
}

extension HomeRouter: HomeRoutable{
    
    func navigateToCourseDetails(course: Course, relatedCourses: CourseModal?){
        let view = CourseInfoRouter.createModule(using: navigationController, course: course, relatedCourses: relatedCourses)
        navigationController.pushViewController(view, animated: true)
    }
    
    
    func popBack() {
        self.navigationController.popViewController(animated: true)
    }
}



