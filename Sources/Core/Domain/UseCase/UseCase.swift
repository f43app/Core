//
//  File.swift
//  
//
//  Created by hastu on 18/11/23.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
    func put(id: Int) -> AnyPublisher<Response, Error>
    func check(id: Int) -> AnyPublisher<Bool, Error>
    func del(id: Int) -> AnyPublisher<Bool, Error>
    func save(id: Int, note: String) -> AnyPublisher<Bool, Error>
    func fave(theGame: CoreDomainModel) -> AnyPublisher<Bool, Error>
}
