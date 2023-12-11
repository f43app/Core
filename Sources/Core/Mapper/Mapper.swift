//
//  File.swift
//  
//
//  Created by hastu on 18/11/23.
//

public protocol Mapper {
    // associatedtype Response
    associatedtype Entity
    associatedtype Domain

    // func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}
