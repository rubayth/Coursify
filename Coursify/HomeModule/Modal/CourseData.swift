//
//  CourseData.swift
//  Coursify
//
//  Created by Orko Haque on 1/20/20.
//  Copyright © 2020 Rubayth. All rights reserved.
//


struct CourseData:Decodable {
    let totalCount: Int?
    var data: [Course?]
    
}

struct Course: Decodable {
    let id: Int?
    let term: String?
    let courseReferenceNumber: String?
    let courseNumber: String?
    let courseTitle: String?
    let subject: String?
    let subjectDescription: String?
    let sequenceNumber: String?
    let maximumEnrollment: Int?
    let enrollment: Int?
    let seatsAvailable: Int?
    
    let faculty: [Faculty?]
    let meetingsFaculty: [MeetingsFaculty?]
    
}


struct Faculty: Decodable {
    let displayName: String?
    let emailAddress: String?
}

struct MeetingsFaculty: Decodable {
    let meetingTime: MeetingTime?
}

struct MeetingTime: Decodable {
    let beginTime: String?
    let endTime: String?
    let building: String?
    let buildingDescription: String?
    let room: String?
    
    let monday: Bool?
    let tuesday: Bool?
    let wednesday: Bool?
    let thursday: Bool?
    let friday: Bool?
    let saturday: Bool?
    let sunday: Bool?
}

