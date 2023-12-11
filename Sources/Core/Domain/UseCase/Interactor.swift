//
//  File.swift
//  
//
//  Created by hastu on 18/11/23.
//

import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {

    private let _repository: R
    public init(repository: R) {
        _repository = repository
    }

    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        _repository.execute(request: request)
    }

    public func put(id: Int) -> AnyPublisher<Response, Error> {
        _repository.put(id: id)
    }

    public func check(id: Int) -> AnyPublisher<Bool, Error> {
        _repository.check(id: id)
    }

    public func del(id: Int) -> AnyPublisher<Bool, Error> {
        _repository.del(id: id)
    }

    public func save(id: Int, note: String) -> AnyPublisher<Bool, Error> {
        _repository.save(id: id, note: note)
    }

    public func fave(theGame: CoreDomainModel) -> AnyPublisher<Bool, Error> {
        _repository.fave(theGame: theGame)
    }
}
