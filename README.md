# simpleSwiftApp

# Description
A simple app that uses the Deezer.com API, fetches data about an artist, their albums and the tracks, displays that data in different forms.

# Networking
In order to make API calls I have chosen to use Alamofire, a library/package for HTTPS networking. It's easy to use and very rigid.

# Design
The design of the app is inspired/based of examples. But the purpose of the app was not the design, but rather functionality.

# Usage
I worked on the searchApp.xcworkspace file, due to cocoapods dependencies. I imagine that is very normal.

Even though I debugged and ran the app on a simulator, it would crash sometimes. Mostly because of Xcodes bug(cleaning, building or restarting xcode would usually worke), but sometimes it would crash beacaused I was impatient pressed a certain artist, while an api call was being made. But running a physical deivce, like an Iphone, that was never a problem. Never crashed.

# Concerns/Hindsight
The autocompletesearch works in the way that for every word written in searchbar an api call is invoked. Well aware that is not ideal, since it "tiring" and slow. 

This was my first time working with Swift and Xcode (other than reading about it and looking at examples), alot of fun, easy to understand and pick up. 

My approach when creating this app was naive. But even though my naive approach got the job done, it got the job done without having alot of extra problems or any serious problems in at all. Adding an activity indicator for when you are searching for an artist and the api call is being called, I think would be more informative and very useful. 
