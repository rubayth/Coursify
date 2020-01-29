//
//  ViewController.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import UIKit

protocol HomeViewable {
    func reloadTable()
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    var presenter: HomePresentable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "GGC Courses"
        searchTextfield.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CourseRow", bundle: nil), forCellReuseIdentifier: "CourseRowCell")
        presenter?.viewDidLoad()
    }
}

extension HomeViewController: HomeViewable {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let input = searchTextfield.text {
//            //presenter?.textFieldUpdated(with: input)
//        }
//        return true
//    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let input = textField.text {
            if input.count == 1 && string.isEmpty {
                presenter?.textFieldEmpty()
            } else if string.count == 0{
                var modifiedInput = input
                modifiedInput.removeLast()
                presenter?.textFieldUpdated(with: modifiedInput)
            } else {
                presenter?.textFieldUpdated(with: input + string)
            }
        }
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if let input = searchTextfield.text {
//            presenter?.textFieldUpdated(input)
//        }
//    }
}

extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let courses = presenter?.getCourses() else { return 0 }
        return courses.getSubjects().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let courses = presenter?.getCourses() else { return "Error" }
        return courses.getSubjects()[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.cellForRow(at: indexPath) as? CourseRow
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseRowCell", for: indexPath) as! CourseRow
        cell.presenter = presenter
        
        let courseModal = presenter?.getCourses()
        let subject = courseModal?.getSubjects()[indexPath.section]
        
        guard let subjectName = subject else { return cell }
        cell.coursesForSubject = courseModal?.getCoursesForSubject(subject: subjectName)
        
        return cell
    }
}

