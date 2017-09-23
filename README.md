# simpleSwiftApp

# Description
A simple app that uses the Deezer.com API, fetches data about an artist, their albums and the tracks, displays that data in different forms.

# Networking
In order to make API calls I have chosen to use Alamofire, a library/package for HTTPS networking. It's easy to use and very rigid. A cocopods dependency: [https://github.com/Alamofire/Alamofire]

# Design
The design of the app is inspired/based of examples. But even though I tried to make it look as close as possible the examples, my main focus was rather the functionalities. And all around how the app worked and behaves. 

# Usage
I worked on the searchApp.xcworkspace file, due to cocoapods dependencies. I imagine that is very normal.

Even though I debugged and ran the app on a simulator, it would crash sometimes. Mostly because of Xcodes bug(cleaning, building or restarting xcode would usually solve that), but sometimes it would crash beacause I was impatient and pressed a certain artist, while an api call was being made. But running on a physical device, like an Iphone, never caused any problems. Never crashed.

# Concerns/Hindsight
The autocompletesearch works in the way that for every word written in searchbar an api call is invoked, so that there is always options even though you haven't finished typing. Well aware that it is not ideal, since it is "tiring" and slow. 

This was my first time working with Swift and Xcode (other than reading about it and looking at examples), a lot of fun, easy to understand and pick up. 

My approach when creating this app was naive. But even though my naive approach got the job done, it didn't lead to a lot of extra minor problems or any serious problems at all. 

Adding an activity indicator for when you are searching for an artist and the api call is being made, I think would be informative and very useful. So that impatient people don't keep crashing the simulation...
