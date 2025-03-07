# CSTV
This is a Challenge Project assess de developer technical skills.

## Libraries used
### Alamofire
Used to perform HTTP requests.
### Kingfisher
Used to perform image lazy loading and caching.

## Design pattern
### Architecture
The project was built over MVVM-Coordinator architecture, using Combine to assure UI and Business layers consistency.
### UI Framework
The UI was built using Storyboard for interface blueprinting, and view-code for behaviour and formatting.
### Dependency management
All of the dependencies are managed by SPM, compatible to the latest versions respectivelly.
### Unit tests
  
## Running
To run the project, make sure the local main branch is updated with the remote and if possible use the Xcode's latest version.
Before running, update SPM's dependencies. If any dependency error occurs, cleaning the cache is recommended.

## Optionals covered
- Unit tests
- MVVM architecture (MVVM-C)
- Pagination support
- Reactive programming (Combine)
