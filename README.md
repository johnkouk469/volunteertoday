# VolunteerToday

*Connect with organisations near you and start planning your next volunteer opportunity.*

VolunteerToday is a web and mobile application that brings volunteers and volunteer organisations together. Organisations publish volunteer events; users find them through search and suggestions, become members of the organisations they like, sign up as volunteers, get notified about changes and can donate to an organisation.

This repository holds the complete analysis and design of the system, from user requirements to an implementation of its REST API in Node-RED. It was built by a team of four for the *Software Engineering I* course (spring 2021, School of Electrical and Computer Engineering, Aristotle University of Thessaloniki).

**Everything here is based on the project's two deliverables, written at the time, in spring 2021. Nothing new has been added to the design since; this repository presents that original work, in English, page by page.**

The original deliverables were written in Greek. The English text here is a translation made later, and the personal details in the example data (names, email addresses, passwords) have been replaced with generic values.

## What is in this repository

The two deliverables were *User Requirements and System Specification* (11 April 2021) and *Software Specification and System Implementation* (30 May 2021). Each part of them has its own page in [`docs/`](docs).

| Part | What it covers |
|---|---|
| [1. System requirements](docs/requirements.md) | 10 functional and 8 non-functional requirements with priorities, the users and external systems, and the definitions used throughout. |
| [2. Use cases](docs/use-cases.md) | The use-case diagram, and for each of the eight features its user story, its scenarios in Gherkin (28 in total, also in [`features/`](features)) and its activity diagram. |
| 3. UI mock-ups | 17 screens designed in Figma: sign in and sign up, home, event, search, organisation and user pages, and the donation flows (card, PayPal, Amazon Pay, bank deposit). |
| 4. Static model | The class model, in nine packages, using the Boundary-Entity-Controller approach. |
| 5. Design patterns | Virtual Proxy, Abstract Factory and Bridge, each chosen to satisfy a specific non-functional requirement. |
| 6. REST API | The system as REST resources (user, organisation, event, notification, donation, plus search and recommendation), documented as an OpenAPI file. |
| 7. Node-RED implementation | The REST API built as Node-RED flows on top of MongoDB, and how each user story maps onto them. |

## How the design fits together

1. **Requirements** are written as user-centred functional requirements and measurable non-functional ones (for example 1000 simultaneous users, 97% availability in Europe, a home page that loads in under a second, PCI DSS for donations and GDPR for personal data).
2. **Scenarios** turn each requirement into Gherkin scenarios, and the UI mock-ups show the screens they run through.
3. **The class model** organises the system into Boundary, Entity and Controller classes: the interface, the data concepts and the logic that connects them.
4. **The design patterns** are chosen from the non-functional requirements: the Virtual Proxy answers the loading-speed and concurrency requirements, the Abstract Factory answers iOS and Android support, and the Bridge makes it possible to add payment methods later.
5. **The REST API** exposes the model as resources, and the Node-RED flows implement it.

## The team

The project was done by four students:
[Ioannis Koukouras (@johnkouk469)](https://github.com/johnkouk469),
[Christos Skapetis (@Skapis9999)](https://github.com/Skapis9999),
[@KonKapo](https://github.com/KonKapo) and
[Stelios Topalidis (@styltopa)](https://github.com/styltopa).

We worked on everything together. We discussed each part first, then split the work roughly equally, and then merged the pieces into one common scheme. The UI mock-ups show the process: each of us first drew a wireframe of the home page alone and presented it, and the team then chose the general direction. The remaining pages were split four ways, and afterwards all the pages were reviewed together and adjusted so that they stayed consistent. The work happened in long Discord calls, several times a week.

## Course context

The course taught requirements engineering and software design through one semester-long team project, delivered in two parts and peer-reviewed by other teams against a common rubric. The group's work was in turn reviewed by other students and by the course staff.

## Status

This is a design project with a prototype implementation, not a production system. The user interface exists as mock-ups only. The payment parts describe how a donation flow could be structured; a real system would hand card data to a payment provider and never store it.
