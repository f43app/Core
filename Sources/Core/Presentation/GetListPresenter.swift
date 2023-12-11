//
//  File.swift
//  
//
//  Created by hastu on 18/11/23.
//

import SwiftUI
import Combine

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == [Response] {

    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor

    @Published public var list: [Response] = []
    @Published public var searchWord: String = ""
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var available: Int = 0

    public init(useCase: Interactor) {
        _useCase = useCase
    }

    public func getList(request: Request?) {
        isLoading = true
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { list in
                self.list = list
                self.available = list.count
            })
            .store(in: &cancellables)
    }

    public func getSearch() {
        if searchWord.isEmpty {
            getList(request: nil)
        } else if let query = searchWord as? Request {
            getList(request: query)
        } else {
            getList(request: nil)
        }
    }
}
