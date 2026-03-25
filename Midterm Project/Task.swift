//
//  Task.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//
import Foundation

struct Task: Identifiable {
    let id = UUID()
    let estTime: Float
    let category: String
    let name: String
    let description: String?
    let dueDat: Date
}
