# 1. System requirements

The functional and non-functional requirements of VolunteerToday, the users and external systems around it, and the terms used throughout the project. This page is the English version of section 1 of the group's *User Requirements and System Specification* (version 2.0, 11 April 2021).

**Notation.** `FR-n` is a functional requirement and `NFR-n` a non-functional requirement. Each requirement carries two scores out of 10: **user priority** (how much the user needs it) and **technical priority** (how much the system depends on it). The source distinguishes requirements the system *must* meet from those it *should* meet; the wording below keeps that distinction. <ins>Underlined</ins> terms are defined in [section 1.4](#14-definitions).

## At a glance

| ID | Requirement | Wording | User priority | Technical priority |
|---|---|---|---|---|
| FR-1 | Manage personal information | must | 10 | 5 |
| FR-2 | Search for users, organisations and volunteer events | must | 8 | 10 |
| FR-3 | View the information of a user, organisation or volunteer event | must | 10 | 4 |
| FR-4 | Create and manage a volunteer event | must | 10 | 10 |
| FR-5 | Suggest current volunteer events to a user | should | 8 | 4 |
| FR-6 | Become or stop being a member of an organisation | should | 6 | 4 |
| FR-7 | Notify the members of an organisation about its current events | should | 9 | 3 |
| FR-8 | Declare or withdraw participation in a current event | must | 10 | 10 |
| FR-9 | Notify volunteers about changes to their events | should | 9 | 2 |
| FR-10 | Donate to an organisation | should | 7 | 1 |
| NFR-1 | Serve at least 1000 simultaneous users | must | 10 | 10 |
| NFR-2 | 97% availability in Europe, 8:00 to 00:00 GMT | must | 10 | 10 |
| NFR-3 | Home page loads in under 1 second | should | 7 | 5 |
| NFR-4 | Notification latency under 5 minutes in 95% of cases | should | 7 | 4 |
| NFR-5 | Support iOS 14.x and Android 8.1 to 12 | must | 10 | 7 |
| NFR-6 | Dates shown as DD/MM/YY | should | 6 | 2 |
| NFR-7 | Donations comply with PCI DSS | must | 10 | 10 |
| NFR-8 | Personal data handling complies with GDPR | must | 10 | 1 |

The short names in the second column are summaries; the full wording of each requirement follows.

## 1.1 Functional requirements

### FR-1

The <ins>user</ins>/<ins>organisation</ins> must be able to <ins>manage information</ins> about themselves.

**Description:** Users of the application can present themselves, their interests and their past <ins>volunteer events</ins> in a <ins>profile</ins>. Likewise, the volunteer organisations that use the application can present information about themselves, such as name, field of activity and more (<ins>organisation information</ins>).

**User priority:** 10/10. The user must know an organisation's field of activity and basic information in order to choose whether or not to take part in the causes it organises. Conversely, the organisation can use the user information to see which users are most interested in the various volunteer events it organises.

**Technical priority:** 5/10. Not important for the application's basic functionality, which is for the user to take part in volunteer events.

### FR-2

The <ins>user/organisation</ins> must be able to search for <ins>users/organisations/volunteer events</ins> based on <ins>user/organisation/volunteer event information</ins>.

**Description:** In this way the user/organisation can search for the users, organisations and volunteer events that interest them, based on their information.

**User priority:** 8/10. A good tool for making the user aware that an organisation or volunteer event exists. It lets the user search for organisations and events and learn their information. It also lets organisations search for specific users based on their information.

**Technical priority:** 10/10. Considered a prerequisite for all the other functions that make the application useful to the user. It must therefore be implemented in the very first stages of development.

### FR-3

The <ins>user</ins>/<ins>organisation</ins> must be able to view the <ins>information</ins> of a <ins>user/organisation</ins>/<ins>volunteer event</ins>.

**Description:** It is important that the user can access the information of every organisation, to judge whether they want to become a member for its upcoming events and possibly declare participation in them. The usefulness is similar for the organisation, which can learn about the users who wish to take part in the events it organises. Both the organisation and the user must be able to see the information of an event.

**User priority:** 10/10. The most important function for the user. Its aim is for the user to decide whether they want to be informed about an organisation's volunteer events. For organisations, knowing the user's information is also important.

**Technical priority:** 4/10. Making user and organisation information visible to one another is not of major importance for the operation of the system.

### FR-4

The <ins>organisation</ins> must be able to create a <ins>volunteer event</ins> and manage its <ins>information</ins>.

**Description:** The <ins>organisation</ins> must be able to create a volunteer event: fill in an appropriate form with the information of the volunteer event it wants to carry out, submit it, and possibly modify or delete it.

**User priority:** 10/10. Organisations would have no reason to use the application without this function. It matters to the organisation because, by creating and changing the details of a current volunteer event, users can learn about the event and request to take part in it as <ins>volunteers</ins>.

**Technical priority:** 10/10. A necessary condition for users to take part in events, which is the application's core function.

### FR-5

The <ins>system</ins> should be able to suggest current <ins>volunteer events</ins> to the <ins>user</ins> based on their <ins>information</ins>.

**Description:** Based on the user's information, the system chooses, out of all the volunteer events, the current ones that are most likely to suit the user.

**User priority:** 8/10. It plays a very important role, especially when a user does not search for volunteer events themselves in order to request participation as a volunteer. This lets the user discover available events that may interest them without having to be a member of every organisation that organises them.

**Technical priority:** 4/10. Without this requirement the system stays functional, in the sense that the user can take part in volunteer events, but new ones will not be suggested to them.

### FR-6

The <ins>user</ins> should be able to be added to, or removed from, an <ins>organisation</ins> as a <ins>member</ins>.

**Description:** The user must be able to become a member of an organisation, that is, to register with it in order to be notified about its volunteer events. If they no longer want to be a member, they can remove themselves from it.

**User priority:** 6/10. Important to the user as a desirable function, since they can receive notifications about volunteer events that interest them.

**Technical priority:** 4/10. A useful tool for the user, and not a condition for the smooth operation of the system.

### FR-7

The <ins>system</ins> should be able to <ins>notify</ins> the <ins>members</ins> of an organisation about the organisation's <ins>current volunteer events</ins>.

**Description:** A direct consequence of the user being able to become a member of an organisation is that they receive notifications about the upcoming volunteer events the organisation will run.

**User priority:** 9/10. Without this feature the user would have to search by themselves for the individual volunteer events organised by the organisations they belong to, which is the problem this application promises to solve. For that reason it holds the highest priority.

**Technical priority:** 3/10. Not a condition for the operation of the system.

### FR-8

The <ins>user</ins> must be able to declare participation in a <ins>current volunteer event</ins> as a <ins>volunteer</ins>, or withdraw their declaration.

**Description:** The user tells the application that they will take part in a current volunteer event, or, if they are already a volunteer, that they will not take part.

**User priority:** 10/10. The user considers it necessary to declare participation through the application and to withdraw it whenever they wish. This serves the goal of getting more users involved in volunteer events.

**Technical priority:** 10/10. Very important for the system, because without it all the functionality of the application is lost.

### FR-9

The <ins>system</ins> should be able to <ins>notify</ins> the <ins>volunteer</ins> about modifications to their <ins>volunteer events</ins>.

**Description:** The user is informed about changes that the organisation has made to volunteer events in which they are a volunteer.

**User priority:** 9/10. The user is directly interested in modifications to the volunteer events in which they are a volunteer.

**Technical priority:** 2/10. Not necessary for the correct operation of the system.

### FR-10

The <ins>user</ins> should be able to make a <ins>donation</ins> to an <ins>organisation</ins> using <ins>payment methods</ins>.

**Description:** The user can pay a sum of money to an organisation through the <ins>electronic payment system</ins>.

**User priority:** 7/10. It is important for the user to be able to support an organisation by donating a sum of their choice. Through this requirement the user can also contribute when they cannot take part in a volunteer event.

**Technical priority:** 1/10. The system can run without interruption even without the ability to make monetary donations.

## 1.2 Users and external systems

The platform presupposes an account, which is created the first time the application is used. When creating the account, one chooses between a user account and an organisation account. Unless stated otherwise, *user* means a user who is logged in with an account in the system, and likewise *organisation* means an organisation that is logged in with an account.

### 1.2.1 User

This category covers the natural persons who look for volunteer events in order to request to take part in them. A user can search for a volunteer event or an organisation based on its information, or discover events of interest through the system's suggestions. A user can also become a member of an organisation to be notified about its new events. Finally, a user can donate a sum of money to an organisation of their choice.

### 1.2.2 Organisation

Any natural person, or legal person of public or private law, that uses the application to promote the volunteer events it organises. Creating events, managing the information that concerns it and accessing the information of the volunteers in each of its events are some of the capabilities an organisation has.

### 1.2.3 Electronic payment system

Implements the acceptance of electronic payments for online transactions from users to organisations.

## 1.3 Significant non-functional requirements

### 1.3.1 Reliability requirements

#### NFR-1

The <ins>system</ins> must serve at least 1000 <ins>users</ins> simultaneously.

**Description:** At any moment the system must be able to serve 1000 or more users without crashing.

**User priority:** 10/10. Necessary so that the user can use the system without interruption.

**Technical priority:** 10/10. Necessary so that the system does not collapse.

#### NFR-2

The <ins>application</ins> must be 97% available in Europe every day from 8:00 to 00:00 GMT.

**Description:** Because of the nature of the application and its target audience, most users are expected to use it in this time window.

**User priority:** 10/10. It is necessary that the user finds the application working during the hours when they are most likely to use it.

**Technical priority:** 10/10. Without this requirement the application does not work.

### 1.3.2 Speed requirements

#### NFR-3

The <ins>home page</ins> should load in less than 1 second¹ in a desktop Chrome browser, including rendering of text and images, on an LTE connection.

**Description:** The servers running the system must have a specific response time, so that the user's train of thought is not interrupted and the experience stays pleasant. A shorter response time is not considered necessary.

**User priority:** 7/10. It is important for the user to have a pleasant experience.

**Technical priority:** 5/10. It is important, but not necessary, that the infrastructure needed to meet the requirement is available.

#### NFR-4

The <ins>system</ins> should have a latency of less than 5 minutes in 95% of cases.

**Description:** The notification system must not have a long response time, so that notifications are sent within a reasonable time.

**User priority:** 7/10. It is important that the notification system informs the user in good time.

**Technical priority:** 4/10. A fast response from the notification system is not vital for the operation of the system.

### 1.3.3 Compatibility and portability requirements

#### NFR-5

The <ins>mobile application</ins> must support devices running iOS (versions 14.0, 14.1, 14.2, 14.3, 14.4) and Android (versions 8.1, 9, 10, 11, 12).

**Description:** The application must work on Android as well as on iOS.

**User priority:** 10/10. Necessary, because users must be able to use the application on both Android and iOS.

**Technical priority:** 7/10. Compatibility with the newest software versions is necessary, but compatibility with older versions is of lower importance.

### 1.3.4 Usage requirements

#### NFR-6

The date format should be DD/MM/YY.

**Description:** Since the application is used in Europe, dates must be displayed this way.

**User priority:** 6/10. It is good for the user to understand at once the date they see in the application; it makes it easy to check their availability for volunteer events straight away.

**Technical priority:** 2/10. The system can work even if the date is not displayed this way.

### 1.3.5 Security requirements

#### NFR-7

<ins>Donations</ins> must comply with **PCI DSS**².

**Description:** Donations to volunteer organisations must be protected from fraud and theft.

**User priority:** 10/10. The user must feel safe when making transactions.

**Technical priority:** 10/10. The system can be implemented and be functional without this requirement, but it can collapse in the case of malicious activity.

### 1.3.6 Privacy requirements

#### NFR-8

The management of personal data must comply with the **GDPR**³.

**Description:** The management of the user's personal data must follow the European Union's GDPR rules, so that the application is legally sound.

**User priority:** 10/10. Correct management of the user's personal data is important for compliance with the legal framework.

**Technical priority:** 1/10. The system can stay functional even if the personal data protection rules are not applied.

¹ <https://www.nngroup.com/articles/response-times-3-important-limits/>
² <https://en.wikipedia.org/wiki/Payment_Card_Industry_Data_Security_Standard>
³ <https://gdpr.eu/>

A further non-functional requirement, support for current and future payment methods, is added with the design patterns in [5. Design patterns](design-patterns.md).

## 1.4 Definitions

| Term | Meaning |
|---|---|
| **Application functions** | All the functions available to the user, such as the notifications sent by the system, search, the relationships between users and organisations, the creation of events, and so on. |
| **Current volunteer event** | A volunteer event that still accepts volunteers. Its information marks it with the status `recruiting`. |
| **Donation** | The user can pay a sum of money to an organisation using a credit card. |
| **Electronic payment system** | Implements the acceptance of electronic transactions from users to organisations. |
| **Event information** | Name, place, time, whether special clothing is needed, equipment, whether it accepts new volunteers, whether it is in progress and whether it has been completed. |
| **Homepage** | The home page of the website or of the mobile app. |
| **Manage** | To enter and edit my information as a user or organisation, or, if I am an organisation, the information of a volunteer event I organise. |
| **Member of an organisation** | A user who is registered with the organisation and receives notifications from it. |
| **Mobile application** | The website turned into an application available for mobile phones, tablets and other smart devices. |
| **Non-current volunteer event** | A volunteer event that no longer accepts volunteers. It is either under way (accepting no new volunteers) or completed; its information marks it with the status `in progress` or `completed` respectively. |
| **Notify** | The function of sending messages to the user inside the application. It is the responsibility of the system. |
| **Organisation** | Any natural person, or legal person of public or private law, that uses the application. |
| **Organisation information** | Name, year of founding, field of activity (the kinds of volunteer events it organises), its volunteer events and, if it accepts donations, its bank account IBAN. |
| **Payment methods** | All the methods available for donating to an organisation through the web application: bank transfer, PayPal, Google Pay or Amazon Pay. |
| **Profile** | The application screen that holds all the information of a user or organisation. |
| **System** | All the functional parts of the application: the interface and the business logic. |
| **User** | The natural person who uses the application. |
| **User information** | Name, age, place of residence, occupation, interests, history of participation in events, a list of the organisations the user is a member of, and a user picture. |
| **Volunteer** | A user who takes part in a specific volunteer event. |
| **Volunteer event** | Any initiative organised by an organisation that can be supported by users who take part in it. |

---

Next: [2. Use cases](use-cases.md)
