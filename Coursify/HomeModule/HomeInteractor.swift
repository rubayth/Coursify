//
//  HomeInteractor.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//

import Foundation

protocol HomeInteractable {
    func fetchClasses(completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void)
    func performRequest(with urlString: String, completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void)
    func readJSONFromFile(fileName: String, completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void)
}

class HomeInteractor{
    let url = "https://ggc.gabest.usg.edu/StudentRegistrationSsb/ssb/searchResults/searchResults?txt_term=202005&uniqueSessionId=6gs0y1579539964806&pageOffset=0&pageMaxSize=50&sortColumn=subjectDescription&sortDirection=asc&[object%20Object]"
    
    private func parseJSON(_ courseData: Data) -> CourseModal?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CourseData.self, from: courseData) //self used to turn CourseData to a type instead of object
            
            let courseModal = CourseModal(courseData: decodedData)
            return courseModal
            
        } catch {
            print(error)
            return nil
        }
    }
}

extension HomeInteractor: HomeInteractable {
    func fetchClasses(completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void){
        //        let urlString = url
        //        performRequest(with: urlString) { (data, error) in
        //            completion(data, error)
        //        }
        readJSONFromFile(fileName: "testData") { (courseData, error) in
            completion(courseData, error)
        }
        
        
    }
    
    func performRequest(with urlString: String, completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void){
        //1. create url
        if let url = URL(string: urlString){
            //2. create URLSession
            let session = URLSession(configuration: .default)
            
            
            //3. give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(nil, error)
                }
                if let safeData = data {
                    
                    let parsedJson = self.parseJSON(safeData)
                    DispatchQueue.main.async {
                        completion(parsedJson, nil)
                    }
                }
            }
            
            //4. start the task
            task.resume()
        }
    }
    
    func readJSONFromFile(fileName: String, completion: @escaping(_ classModal: CourseModal?, _ error: Error?) -> Void) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let parsedJson = self.parseJSON(data)
                DispatchQueue.main.async {
                    completion(parsedJson, nil)
                }
                
            } catch {
                // Handle error here
            }
        }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
