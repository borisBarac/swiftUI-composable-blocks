## SwiftUI - Composable Blocks

### This project show how you can use [ComposableArchitecture] as a replacement for **BLOCKS** or Delegates in Swift.
## Content:
> Usage of child actins as blocks or delegates

## Main approach
> We are gonna embed the States and Actions of CHILD reducer in out PARENT reducer.
> That way we can use them in the PARENT and manipulate the state in it.
> Other benefit is that we can manipulate the state of the CHILD REDUCER in itself also, and we can can compose those 2 manipulations.
> Example how is this done is detail is in [Reducer.swift]
```swift
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
        Scope(state: \.counterState, action: /Action.counterAction) { 
            CounterReducer()
        }
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
```

[ComposableArchitecture]: https://github.com/pointfreeco/swift-composable-architecture
[Reducer]: ./composable-blocks/Reducers.swift