# iOS-Coding-Challenge

Application use for view, create, update note using SwiftUI and Firease RealTime Database

https://github.com/dhnghia22/iOS-Coding-Challenge/assets/20497888/c2fa9c55-4878-4b5d-a63b-8038d36feaed

# Approach

### Architecture
- Because SwiftUI is a  is a declarative framework, so i decice to use MV (Model-View) for this project

![9de2aa2a-74a9-497e-b552-66f89637d903](https://github.com/dhnghia22/iOS-Coding-Challenge/assets/20497888/85b8bbf2-d40a-4931-b186-319dfe552bc8)

- The `View` layer contains entities that provides user interaction and handles presentation logic.
- The `Model` layer  layer are not a simple object, they serve as repositories for the application's data and embody the logic for manipulating that data. Models should be independent and could be reused across all modules of an app.
- In this project, i'm create Store to update state, and view only update from state.
- `View = f(State)`
