# Giphy Search

## Project Details

This project is a simple app that looks up GIFs based on the provided search criteria.
It makes an API call to the Giphy endpoint using the specified parameters to fetch a list of GIFs to display for the user.

The project was primarily built using MVVM, with programmatic UI for the views and leverages Combine for handling the business logic, with the folder hierarchy having been organized to reflect that.

For libraries, SDWebImage was leveraged to handle loading remote images, image caching and scroll performance. This was done to prioritize app performance and to stay within the project time constraints. This library is currently installed via Swift Package Manager.

## How To Run

Either clone or download the project, set GiphySearch as the scheme, choose any of the iOS Simulator targets and hit run. The project should build without any additional setup.


