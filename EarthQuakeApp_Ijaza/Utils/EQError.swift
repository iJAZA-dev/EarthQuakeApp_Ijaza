//
//  EQError.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import Foundation

enum EQError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse  = "Invalid response from the server please try again"
    case invalidData      = "The data received from the server was invalid. Please try again"
}
