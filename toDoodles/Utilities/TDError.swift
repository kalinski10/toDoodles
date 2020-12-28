//
//  TDError.swift
//  toDoodles
//
//  Created by Kalin Balabanov on 16/12/2020.
//

import UIKit


enum TDError: String, Error {
    
    case retrieveError  = "something went wronrg while trying to retrieve your tasks."
    case noTasks        = "You have no tasks"
    case savingError    = "something went wrong while tring to save your changes. 😔"
    
}
