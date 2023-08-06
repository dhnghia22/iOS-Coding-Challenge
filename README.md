# iOS-Coding-Challenge

Application use for view, create, update note using SwiftUI and Firease RealTime Database

https://github.com/dhnghia22/iOS-Coding-Challenge/assets/20497888/c2fa9c55-4878-4b5d-a63b-8038d36feaed

# Approach

### Architecture
- Because SwiftUI is a  is a declarative framework, so i decice to use MV (Model-View) for this project

![9de2aa2a-74a9-497e-b552-66f89637d903](https://github.com/dhnghia22/iOS-Coding-Challenge/assets/20497888/85b8bbf2-d40a-4931-b186-319dfe552bc8)

- The `View` layer contains entities that provides user interaction and handles presentation logic.
- The `Model` layer  layer are not a simple object, they serve as repositories for the application's data and embody the logic for manipulating that data. Models should be independent and could be reused across all modules of an app.
- In this project, i'm create Store (Single source of truth) to update state, and view only update from state.
- `View = f(state)`

### Database

#### Format
```
{
  "notes": {
    "-Nb-Gw6FEvWwSQj86wIJ": {
      "content": "content",
      "create_by": "nghia.dinh.test",
      "create_date": "2023-08-04T18:21:15",
      "negative_timestamp": -1691148075.4723,
      "owner_id": "-Naz-4DfH4sh1CsUqGSL",
      "timestamp": 1691148075.4723
    },
    "-Nb-GwEXcDvUCK5tFwkp": {
      "content": "content",
      "create_by": "nghia.dinh.test",
      "create_date": "2023-08-04T18:21:16",
      "negative_timestamp": -1691148076.015005,
      "owner_id": "-Naz-4DfH4sh1CsUqGSL",
      "timestamp": 1691148076.015005
    },
  },
  "users": {
    "-Naz-4DfH4sh1CsUqGSL": {
      "notes": {
        "-Nb-Gw6FEvWwSQj86wII": "-Nb-Gw6FEvWwSQj86wIJ",
        "-Nb-GwEWXsv8AtfWr4gQ": "-Nb-GwEXcDvUCK5tFwkp",
      },
      "username": "nghia.dinh.test"
    },
    "-Nb8OkyLlL7-CputadJp": {
      "notes": {
        "-Nb8Pio0cPpYClo2YKP_": "-Nb8Pio12MaQbOlgHT2T"
      },
      "username": "nghia.dinh"
    }
  }
}
```

- `notes` for save all notes all user, each notes have `owner_id` to know who create it.
- `users` for save user information, have `notes` to check id note user created (I want to use it for query, but firebase database is not support query contains array or dictionary :( )

### Design pattern
- Repository
- Dependency Inversion

# Checklist
1. [x] As a user (of the application) I can set my username.
2. [x] As a user I can save a short note on Firebase database.
3. [x] As a user I can see a list of my saved notes.
4. [x] As a user I can see all the notes from other users.

# Project Report
1.SwiftUI Exploration: Approximately 8 hours
- This phase included studying SwiftUI and understanding its usage and capabilities.
2. Database Design and Base Source Code: Approximately 8 hours
  - In this phase, the database was designed, and the foundational source code was implemented.
3. Requirements Implementation: Approximately 8 hours
 - The project involved fulfilling the requirements, which were divided into 4 tasks, with each task taking approximately 2 hours.
4. Unit Testing, Refactoring, and Updating README: Approximately 8 hours

# Known issues
1. My AppRoute is simple just use for create new View, not routing, need to implement routing mechanism easy to use, manage all route in app, can work with deeplink, univerlink.
2. Database format is not support paging when fectch user note, only support paging for all notes.
3. User login is not require password, and not save to local storage.
4. UI simple.
5. Localize text is hard code in view, need to centralize all text for manage.
6. VM is simple, easy to use, but it can be complexity in the furure, need to design or use some state management to handle state in store.

# Contact
If you have any question about this project, please contact me via email: dhnghia22@gmail.com
   
