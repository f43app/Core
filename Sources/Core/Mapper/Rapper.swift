//
//  File.swift
//  
//
//  Created by hastu on 20/11/23.
//

public protocol Rapper {
    // associatedtype Response
    associatedtype Response
    associatedtype Domain

    func transformResponseToDomain(response: Response) -> Domain
    // func transformEntityToDomain(entity: Entity) -> Domain
}
