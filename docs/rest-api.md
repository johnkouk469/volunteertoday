# 6. REST API

Section 2 of the group's *Software Specification and System Implementation* (version 1.0, 30 May 2021): the system as REST resources, and the documentation of the resulting interface. The interface was designed and documented in SwaggerHub. The definition, in the OpenAPI (Swagger 2.0) format, is in this repository in two forms:

- [`api/VolunteerToday-1.0.0-resolved.yaml`](../api/VolunteerToday-1.0.0-resolved.yaml)
- [`api/VolunteerToday-1.0.0-swagger.json`](../api/VolunteerToday-1.0.0-swagger.json)

The deliverable documented every endpoint with SwaggerHub screenshots of its parameters, of a test call and of the server's response. This page gives the same information as text, taken from the definition. The test calls were made against SwaggerHub's virtual server, which answers with placeholder values (`"string"`, `0`), so the responses below show the shape of the data and not real content.

## 6.1 Identification of the system's resources

Each requirement of [section 1](requirements.md) that the system must serve is mapped to a Boundary, Entity or Controller class of the [static model](static-model.md), to a REST resource and to an HTTP verb. `<User>` and the other names in angle brackets stand for the data models of [section 6.2](#62-documentation-of-the-rest-interface).

| FR | BEC class | REST resource | HTTP verb | Input parameters | Response (200) |
|---|---|---|---|---|---|
| 0 | LoginSignInController | `/user/login` | PUT | `username: string`<br>`password: string` | `token: string` |
| 1, 6, 8 | User | `/user/{userId}` | PUT | `userId: integer`<br>`<User>` | |
| 1 | User | `/user` | POST | `<User>` | |
| 1 | Organisation | `/organisation` | POST | `<Organisation>` | |
| 1, 6 | Organisation | `/organisation/{organisationId}` | PUT | `organisationId: integer`<br>`<Organisation>` | |
| 2 | HeaderController | `/search` | GET | `keyword: string` | `[<Event>]`<br>`[<User>]`<br>`[<Organisation>]` |
| 3 | User | `/user/{userId}` | GET | `userId: integer` | `<User>` |
| 3 | Organisation | `/organisation/{organisationId}` | GET | `organisationId: integer` | `<Organisation>` |
| 3 | Event | `/organisation/{organisationId}/event/{eventId}` | GET | `organisationId: integer`<br>`eventId: integer` | `<Event>` |
| 4, 7 | Event | `/organisation/{organisationId}/event` | POST | `organisationId: integer`<br>`<Event>` | `<Notification>` |
| 4, 8, 9 | Event | `/organisation/{organisationId}/event/{eventId}` | PUT | `organisationId: integer`<br>`eventId: integer`<br>`<Event>` | `<Notification>` |
| 5 | PageController | `/user/{userId}/recommend` | GET | `userId: integer` | `[<Event>]` |
| 7, 9 | Notification | `/organisation/{organisationId}/event/{eventId}/notification` | POST | `organisationId: integer`<br>`eventId: integer`<br>`<Notification>` | |
| 7, 9 | Notification | `/organisation/{organisationId}/event/{eventId}/notification/{notificationId}` | GET | `organisationId: integer`<br>`eventId: integer`<br>`notificationId: integer` | `<Notification>` |
| 10 | Donation | `/organisation/{organisationId}/donation` | POST | `organisationId: integer`<br>`<Donation>` | `<Donation>` |

FR-0 is the requirement that a user can log in. The interface definition uses it; the requirements of [section 1](requirements.md) are numbered FR-1 to FR-10.

## 6.2 Documentation of the REST interface

The interface has five resources (user, organisation, event, notification, donation), two further endpoints (recommendation and search) and two further data models (token and search results). Security is declared in the definition in two ways: an API key in the `Authorization` header (`JWTbearerAuth`), which is the setting for the whole API, and an OAuth 2 implicit flow with the scope `write:Donations` (`volunteerToday`), declared for the donation endpoint.

### 6.2.1 User resource

#### User data model

| Property | Type | Description |
|---|---|---|
| `name` | string |  |
| `surname` | string |  |
| `age` | integer (int8) |  |
| `placeOfLiving` | string |  |
| `work` | string |  |
| `pastEvents` | array of `Event` |  |
| `currentEvents` | array of `Event` |  |
| `memberships` | array of `Organisation` |  |

#### Endpoint PUT /user/login of the User resource

*Log user into the system*

The requirements it serves, as written in the API definition:

- FR-0 - A user must be able to login to their account by providing their username and password

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `username` | query | string | yes | The user name for login |
| `password` | query | string | yes | The password for login in clear text |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | successful operation | `Token` |
| 400 | Invalid username/password supplied |  |

Response headers of code 200:

- `X-Rate-Limit` (integer, int32): calls per hour allowed by the user
- `X-Expires-After` (string, date-time): date in UTC when token expires

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `PUT /user/login` with the query parameters `username` and `password` filled in. Server response: 200, `content-length: 44`, body `{ "token": "string" }`.

#### Endpoint POST /user of the User resource

*Create a new user account*

The requirements it serves, as written in the API definition:

- FR-1 - The user/organisation must be able to manage their information.

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `body` | body | `User` | yes | User model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful operation |  |
| 400 | Bad input parameter |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `POST /user` with a `User` body. Server response: 200, `content-length: 20`.

#### Endpoint GET /user/{userId} of the User resource

*Find users*

The requirements it serves, as written in the API definition:

- FR-3 - The user/organisation must be able to view user/organisation/event information

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `userId` | path | integer | yes | User's identification number |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | successful operation | `User` |
| 400 | Invalid userId value |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET /user/123`. Server response: 200, `content-length: 352`, body: a `User`.

#### Endpoint PUT /user/{userId} of the User resource

*Update user information*

The requirements it serves, as written in the API definition:

- FR-1 - The user/organisation must be able to manage their information.
- FR-6 - The user should be able to become or unbecome member of an organisation
- FR-8 - The user must be able to become or unbecome a volunteer of a volunteer event

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `userId` | path | integer | yes | User whose information is to be updated |
| `body` | body | `User` | yes | User model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 400 | Bad input parameter |  |
| 200 | successful operation |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `PUT /user/123` with a `User` body. Server response: 200, `content-length: 20`.

### 6.2.2 Organisation resource

#### Organisation data model

| Property | Type | Description |
|---|---|---|
| `name` | string |  |
| `founded` | string |  |
| `acceptingDonations` | boolean |  |
| `bankAccount` | array of integer |  |
| `memberships` | array of `User` |  |

#### Endpoint POST /organisation of the Organisation resource

*Create a new organisation account*

The requirements it serves, as written in the API definition:

- FR-1 - The user/organisation must be able to manage their information.

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `body` | body | `Organisation` | yes | Organisation model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 400 | Bad input parameter |  |
| 200 | successful operation |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `POST /organisation` with an `Organisation` body. Server response: 200, `content-length: 20`.

#### Endpoint GET /organisation/{organisationId} of the Organisation resource

*Find organisations*

The requirements it serves, as written in the API definition:

- FR-3 - The user/organisation must be able to view user/organisation/event information

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | The organisationId |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | successful operation | `Organisation` |
| 400 | Invalid organisationId value |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET /organisation/12902`, asking for `application/xml`. Server response: 200, `content-length: 339`, body: an `Organisation`, as XML.

#### Endpoint PUT /organisation/{organisationId} of the Organisation resource

*Update organisation information*

The requirements it serves, as written in the API definition:

- FR-1 - The user/organisation must be able to manage their information.
- FR-6 - The user should be able to become or unbecome member of an organisation

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | The organisation to be updated |
| `body` | body | `Organisation` | yes | Organisation model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 400 | Bad input parameter |  |
| 200 | successful operation |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `PUT /organisation/12902` with an `Organisation` body. Server response: 200, `content-length: 20`.

### 6.2.3 Event resource

#### Event data model

| Property | Type | Description |
|---|---|---|
| `name` | string |  |
| `location` | string |  |
| `date` | string (date-time) |  |
| `specialOutfit` | array of string |  |
| `specialEquipment` | array of string |  |
| `status` | string, one of `in progress`, `recruiting`, `completed` |  |
| `volunteers` | array of `User` |  |

#### Endpoint POST /organisation/{organisationId}/event of the Event resource

*Create a new event*

The requirements it serves, as written in the API definition:

- FR-4 - The organisation must be able to create an event and to manage its information
- FR-7 - The system should be able to notify a member of an organisation about current volunteer events of the latter.

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | Organisation which the event belongs to |
| `body` | body | `Event` | yes | Event model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 400 | Bad input parameter |  |
| 200 | successful operation | `Notification` |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `POST /organisation/12902/event` with an `Event` body. Server response: 200, `content-length: 78`, body: a `Notification`.

#### Endpoint GET /organisation/{organisationId}/event/{eventId} of the Event resource

*Find events*

The requirements it serves, as written in the API definition:

- FR-3 - The user/organisation must be able to view user/organisation/event information

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | The organisationId |
| `eventId` | path | integer | yes | The eventId |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | successful operation | `Event` |
| 400 | Invalid eventId value |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET /organisation/12902/event/51`. Server response: 200, `content-length: 290`, body: an `Event`.

#### Endpoint PUT /organisation/{organisationId}/event/{eventId} of the Event resource

*Update event information/Join/Leave Event*

The requirements it serves, as written in the API definition:

- FR-4 - The organisation must be able to create an event and to manage its information.
- FR-8 - The user must be able to become or unbecome a volunteer of a volunteer event.
- FR-9 - The system should be able to notify a volunteer about changes of the volunteer event.

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | Organisation which the event belongs to |
| `eventId` | path | integer | yes | Event whose information we want to update |
| `body` | body | `Event` | yes | Event model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 400 | Bad input parameter |  |
| 200 | successful operation | `Notification` |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `PUT /organisation/12902/event/51` with an `Event` body. Server response: 200, `content-length: 78`, body: a `Notification`.

### 6.2.4 Notification resource

#### Notification data model

| Property | Type | Description |
|---|---|---|
| `message` | string |  |
| `date` | string (date-time) | the date and time when the notification was created |

#### Endpoint POST /organisation/{organisationId}/event/{eventId}/notification of the Notification resource

*Create a notification*

The requirements it serves, as written in the API definition:

- FR-7 - The system should be able to notify the members of an organisation about current volunteer events of the latter
- FR-9 - The system should be able to notify volunteers about changes of the volunteer event

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | the identification number of the organisation whose event the notification is about |
| `eventId` | path | integer | yes | the identification number of the event the notification is about |
| `notification` | body | `Notification` | yes | Notification Model |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful creation |  |
| 400 | Bad input parameter |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `POST /organisation/12902/event/51/notification` with a `Notification` body. Server response: 200, `content-length: 20`.

#### Endpoint GET /organisation/{organisationId}/event/{eventId}/notification/{notificationId} of the Notification resource

*Retrieves a notification*

The requirements it serves, as written in the API definition:

- FR-7 - The system should be able to notify the members of an organisation about current volunteer events of the latter
- FR-9 - The system should be able to notify volunteers about changes of their volunteer events

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer | yes | the identification number of the organisation whose event the notification is about |
| `eventId` | path | integer | yes | the identification number of the event the notification is about |
| `notificationId` | path | integer | yes | the identification number of the notification |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful retrieval | `Notification` |
| 400 | Failed to retrieve the notification |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET` with `organisationId` 12902, `eventId` 51 and `notificationId` 36. Server response: 200, `content-length: 78`, body: a `Notification`.

### 6.2.5 Donation resource

#### Donation data model

| Property | Type | Description |
|---|---|---|
| `paymentMethod` | string |  |
| `amount` | integer (int32) |  |
| `name` | string |  |
| `surname` | string |  |
| `cardNumber` | integer |  |
| `expiryDate` | string |  |
| `securityCode` | integer (int32) |  |
| `postalCode` | integer (int64) |  |
| `paypalMailAddress` | string |  |
| `paypalPhoneNumber` | integer |  |
| `amazonPayMailAddress` | string |  |
| `amazonPayPhoneNumber` | integer |  |
| `amazonPayPassword` | string |  |
| `iban` | string |  |
| `pin` | integer (int32) |  |

#### Endpoint POST /organisation/{organisationId}/donation of the Donation resource

*Create a donation for an organisation*

The requirements it serves, as written in the API definition:

- FR-10 - A user should be able to make a donation to an organisation via payment methods

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `organisationId` | path | integer (int64) | yes | Organisation which the donation is made for |
| `donation` | body | `Donation` | yes | The donation made |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful donation submission | `Donation` |
| 400 | Unsuccessful donation submission |  |
| 405 | Invalid donation parameters as input |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `POST /organisation/12902/donation` with a `Donation` body. Server response: 200, `content-length: 171`, body: the `Donation`.

### 6.2.6 Other endpoints that were used

#### Endpoint GET /user/{userId}/recommend

*Recommend active events*

The requirements it serves, as written in the API definition:

- FR-5 - The system must be able to suggest current volunteer events to a user based on their information

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `userId` | path | integer | yes | User that gets the recommendation |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful operation | array of `Event` |
| 400 | Bad input parameter |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET /user/123/recommend`. Server response: 200, `content-length: 291`, body: an array of `Event`.

#### Endpoint GET /search

*User or organisation can search for users, organisations or events*

The requirements it serves, as written in the API definition:

- FR-2 - A user/organisation must be able to search users/organisations/events by information of user/organisation/event

**Parameters of the resource**

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| `keyword` | query | string | yes | Keyword to search by |

**Responses**

| Code | Description | Content |
|---|---|---|
| 200 | Successful operation | `Search_Results` |
| 400 | Bad input parameter |  |

**Test of the endpoint and server response**

Test call on the SwaggerHub virtual server: `GET /search?keyword=HelpingHands`. Server response: 200, `content-length: 474`, body: a `Search_Results`.

### 6.2.7 Other data models that were used

#### Token data model

| Property | Type | Description |
|---|---|---|
| `token` | string | JWT token |

#### Search_Results data model

| Property | Type | Description |
|---|---|---|
| `events` | array of `Event` |  |
| `organisation` | array of `Organisation` |  |
| `user` | array of `User` |  |

---

Previous: [5. Design patterns](design-patterns.md) · Next: [7. Node-RED implementation](node-red-implementation.md)
