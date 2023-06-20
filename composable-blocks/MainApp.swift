import SwiftUI
import ComposableArchitecture

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: MainReducer.State(counterState: CounterReducer.State()),
                                     reducer: MainReducer()))
        }
    }
}
