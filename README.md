# Disturb Me Maybe
_In a meeting but parents are calling you for dinner? Disturb Me Maybe helps everyone in a quarantined house know that you are not to be disturbed!_

---

## Inspiration
Being quarantined in your house with your family, 24/7, after living alone at college for years can be a serious adjustment! We realized that any time we are called in our home, there are always noises in the background, parents coming into our rooms to check if it's clean, or our siblings poking their head in asking to build a snowman! When you're at work, people know when you're busy, and when you're at lunch, people send emails or group texts for communication. Since we now work from home, why not bring that structure with us?

## What it does
That is why we bring to you: Disturb Me Maybe! Distub Me Maybe is an iOS app where families are given a unique QR code and members can join the family by scanning that code. Once they join their family "room", users can update their status (i.e. in a meeting, doing homework, etc.). With the status, users can set their availability option (available, partially available, do not disturb). Each household member can see their family's statuses, so they know when to not disturb them or when they can (maybe)! As well as that, family members can make announcements, in which all family members get push notifications about that announcement. When creating a family group, users can send an invite link for members to join, which is sent through SMS using the Twilio API.

<img src='http://g.recordit.co/LWN2EBsbkd.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://g.recordit.co/Cp1pWyqiHA.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


## How we built it
Swift, Firebase, Twilio API, Alamofire, AVFoundation framework, Core Image framework

## Challenges we ran into
One primary challenge we ran into was not being able to be with each other physically (LaHacks 2020 was a virtual hackathon), especially since we had a QR code scanner involved. However, we learned a lot from that, such as collaborating using Github and debugging through screen sharing. Another challenge we faced was that querying from Firebase was not as easy as it seemed, and delayed us by a lot. As well as that, sending push notifications to users required a certificate that was extremely complicated to get working. Through all of this, however, we truly learned to be patient and determined.

## Accomplishments that we're proud of
The app is able to scan QR codes for users to join a family. The app is also able to send notifications to each family group regarding announcements and status updates and it utilizes a fully-functioning Firestore database on Firebase!

## What we learned
We weren't very familiar with Firebase before we started and we learned a lot about updating and querying from the database. We also learned how to implement QR codes in Swift. Additionally, we learned about sending push notifications.

## What's next for DisturbMeMaybe
We want to sync up Google Calendar with our status feature so that there are automatic statuses based on a user's personal calendar. We also want to utilize machine learning to determine the availability of that status.

## Contributors
[Lenah Syed](https://github.com/123lenah)

[Iqra Abbaali](https://github.com/iabbaali)

[Saadia Karim](https://github.com/saadiak)

[Safiyah Lakhany](https://github.com/safiyahlakhany)

## Links
Demo: https://www.youtube.com/watch?v=M1XPj1_sVsk

Devpost: https://devpost.com/software/disturbmemaybe

---
 **NOTE**: When cloning this application, there are a few pieces of information you must fill in in order to build and run properly. In a separate Swift file, you need to set up credentials to access the Twilio API. After configuring these constants, you can successfully run Disturb Me Maybe!

