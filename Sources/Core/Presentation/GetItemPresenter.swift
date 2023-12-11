//
//  File.swift
//  
//
//  Created by hastu on 24/11/23.
//

import SwiftUI
import Combine

public class GetItemPresenter<Request, Response, Interactor: UseCase>: ObservableObject
where Interactor.Request == Request, Interactor.Response == Response {

    private var cancellables: Set<AnyCancellable> = []

    private let _useCase: Interactor

    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    @Published public var inFaved: Bool = false
    @Published public var theNote: String = ""
    @Published public var wasNoted: Bool = false

    public init(useCase: Interactor) {
        _useCase = useCase
    }

    public func getItem(request: Request?) {
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
            }, receiveValue: { element in
                self.item = element
            })
            .store(in: &cancellables)
    }

    public func putItem(_ id: Int) {
        isLoading = true
        _useCase.put(id: id)
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

            }, receiveValue: { value in
                self.inFaved = true
                self.item = value
            })
            .store(in: &cancellables)
    }

    public func check(_ id: Int) {
        _useCase.check(id: id)
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

            }, receiveValue: { value in
                self.inFaved = value
            })
            .store(in: &cancellables)
    }

    public func del(_ id: Int) {
        _useCase.del(id: id)
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

            }, receiveValue: { _ in
                self.inFaved = false
            })
            .store(in: &cancellables)
    }

    public func save(id: Int) {
        _useCase.save(id: id, note: theNote)
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

            }, receiveValue: { _ in
                self.inFaved = true
                self.wasNoted = false
            })
            .store(in: &cancellables)
    }

    public func fave(theGame: CoreDomainModel) {
        _useCase.fave(theGame: theGame)
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
            }, receiveValue: { value in
                self.inFaved = value
            })
            .store(in: &cancellables)
    }
}
