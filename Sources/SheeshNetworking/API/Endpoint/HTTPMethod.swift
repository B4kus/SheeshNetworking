//
//  HTTPMethod.swift
//  CocktailBar
//
//  Created by Szymon Szysz on 22/04/2020.
//  Copyright © 2020 Szymon Szysz. All rights reserved.
//

import Foundation

/**
 The `HTTPMethod` enum represents the various HTTP methods that can be used in network requests.
 */
public enum HTTPMethod: String {
    /// The HTTP GET method is used to retrieve data from the server.
    case GET
    
    /// The HTTP POST method is used to submit data to be processed to a specified resource.
    case POST
    
    /// The HTTP PUT method is used to update an existing resource or create a new resource if it doesn't exist.
    case PUT
    
    /// The HTTP DELETE method is used to delete a specified resource.
    case DELETE
    
    /// The HTTP CONNECT method is used to establish a network connection to a specified resource.
    case CONNECT
    
    /// The HTTP HEAD method is identical to GET but does not return a message body, only headers.
    case HEAD
    
    /// The HTTP OPTIONS method is used to describe the communication options for the target resource.
    case OPTIONS
    
    /// The HTTP TRACE method is used to perform a message loop-back test along the path to the target resource.
    case TRACE
    
    /// The HTTP PATCH method is used to apply partial modifications to a resource.
    case PATCH
}
