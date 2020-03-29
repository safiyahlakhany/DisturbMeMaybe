# Disturb Me Maybe
_In a meeting but parents are calling you for dinner? Disturb Me Maybe helps everyone in a quarantined house know that you are not to be disturbed!_

---

## Inspiration
Being quarantined in your house, with your family, 24/7, after living alone at college for years, can be a serious adjustment! We realized that any time we called, there were always noises in the background, or our parents coming into our rooms to check if it's clean, or our siblings poking their head in asking to build a snowman! When you're at work, people know when you're busy, and when you're at lunch, and people send emails or group texts for communication. Since we now work from home, why not bring that structure with us?

## What it does
That is why we bring to you: Disturb Me Maybe! This is primarily an app for families, where each family is given a QR code which they scan from the phone of the initial creator -admin- and are put into groups or families in which they will be communicating. Each user has a status (In a meeting, or In the shower), as well as an availability option (available, partially available, Do Not Disturb). Each household member can see their family's statuses on a console, so they know when to not disturb them or when they can (Maybe!). As well as that, family members can make announcements, in which all family members get push notifications of that announcement. There is also a console for announcements made in the past 24 hours. We also have an invite link for members to join, that is sent through SMS through the app.

## How we built it
Swift, Firebase, Twilio API, Alamofire, AVFoundation framework, Core Image framework

## Challenges we ran into
One primary challenge we ran into was not being able to be with each other physically, especially since we had a qr code involved. However, we learned a lot from that, like really collaborating using github, and having to debug through screen sharing etc. Another challenge we faced was that querying from firebase was not as easy at seemed, and delayed us by a lot. As well as that, sending push notifications to users required a certificate that was extremely complicated to get. Through all of this however, we truly learned to be patient and determined, even in the middle of the night.

## Accomplishments that we're proud of
The app is able to scan QR codes for users to join a family. The app is also able to send notifications to certain family groups as announcements and as status updates. The app also utilizes a fully-functioning Firestore database on Firebase that we created ourselves!

## What we learned
We didn't really know much about Firebase before we started, and we learned a lot about updating and querying from the database. We also learned how to implement QR codes into a swift app. We also learned about push notifications for Swift.

## What's next for DisturbMeMaybe
We want to sync up Google Calendar with our status feature so that there are automatic statuses with a user's personal calendar. We also want to utilize machine learning to see the availability of that status.

Demo: https://www.youtube.com/watch?v=M1XPj1_sVsk

Devpost: https://devpost.com/software/disturbmemaybe

---
 **NOTE**: When cloning this application, there are a few pieces of information you must fill in in order to build and run properly. In a separate Swift file, you need to set up credentials to access the Twilio API. After configuring these constants, you can successfully run Disturb Me Maybe!

