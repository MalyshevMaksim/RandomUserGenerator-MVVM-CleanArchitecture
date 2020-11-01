# Random User Generator
Implementing a mobile client for [Random User Generator](https://randomuser.me/)

## Technologies
- MVVM using Bond binding framework
- Alamofire for network layer
- Realm Database for persistent storage
- Programmatically UI using SnapKit
- Unit and UI tests

## Screenshots
<p align="center">
  <img src = "https://github.com/MalyshevMaksim/RandomUserGenerator-MVVM-CleanArchitecture/blob/main/Images/UserGenerated.png" width="250"/>
</p>

## Architecture Details
Clean Achitecture is a method for building an application architecture, [proposed](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) by Robert Martin in 2012.

### Simplified class diagram
![Alt text](Images/Simplified.png?raw=true "Simplified class diagram")

This diagram intentionally does not provide specific frameworks and libraries. The application architecture should not depend on such details. For example, for persistent storage, you can use Core Data, Realm, or even plain text files. 

### File structure
![Alt text](Images/FileStructure.png?raw=true "File structure")

### Use Cases
