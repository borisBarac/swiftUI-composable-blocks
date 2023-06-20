import Foundation
import ComposableArchitecture
import SwiftUI

struct MainReducer: Reducer {
    struct State: Equatable {
        var counterState: CounterReducer.State
    }

    enum Action {
        case counterAction(CounterReducer.Action)
        case randomClick
    }

    var body:  some ReducerOf<Self> {
        Reduce(_reduce)
        Scope(state: \.counterState, action: /Action.counterAction) { CounterReducer() }
    }

    private func _reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .counterAction(counterAction):
            switch counterAction {
            case .decrement:
                state.counterState.value = state.counterState.value - 1
            case .increment:
                state.counterState.value = state.counterState.value + 1
            case .randomize:
                state.counterState.value = Int.random(in: 1...1000)
            }
        case .randomClick:
            return .send(.counterAction(.randomize))
        }

        return .none
    }

}

struct CounterReducer: Reducer {
    struct State: Equatable {
        var value: Int = 0
        var color: UInt = 0x00FF00
    }

    enum Action {
        case randomize
        case increment
        case decrement
    }

    var body:  some ReducerOf<Self> {
        Reduce(_reduce)
    }

    private func _reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrement:
            state.color = 0xFF0000
        case .increment:
            state.color = 0x00FF00
        case .randomize:
            state.color = 0x0000FF
        }
        return .none
    }

}
