//
//  File.swift
//  
//
//  Created by hastu on 18/11/23.
//

import Combine

public protocol RemoteSource {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
