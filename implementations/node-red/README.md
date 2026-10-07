# Node-RED implementation

The REST API of VolunteerToday built as [Node-RED](https://nodered.org/) flows on top of a MongoDB database. The design is explained in [7. Node-RED implementation](../../docs/node-red-implementation.md) and the interface in [6. REST API](../../docs/rest-api.md).

## What is here

| Path | Contents |
|---|---|
| [`flows.json`](flows.json) | The flows, as Node-RED's import/export format: seven tabs (User, Organisation, Event, Donation, Notification, Algorithms, Debug) with 16 HTTP endpoints, and the `inject` and `http-request` flows that exercise them. |
| [`db-seed/`](db-seed) | One file per MongoDB collection (`user`, `organisation`, `event`, `notification`, `donation`) with the test documents, one JSON document per line. |
| [`diagrams/`](diagrams) | Pictures of the flows used in the documentation. |

## What it needs

- Node-RED with the MongoDB nodes (`node-red-node-mongodb`, which provides the `mongodb in` and `mongodb out` nodes).
- A MongoDB server that the flows reach as host `mongodb`, port `27017`, database `volunteerToday`.
- The flows call the API they implement at `http://localhost:1880`.

The seed files hold one JSON document per line, with the ids in MongoDB's extended JSON (`{"$oid": ...}`); each file goes into the collection of the same name.

It was run with Node-RED 5.0.7, `node-red-node-mongodb` 0.2.5 and MongoDB 4.4.29 on Windows, with the host of the MongoDB configuration node changed from `mongodb` to the local server and the five seed files loaded.

## How the pieces fit

- The endpoints use names instead of numeric ids: `username`, `organisationName`, `eventName` and `notificationMessage` take the place of `userId`, `organisationId`, `eventId` and `notificationId` of the OpenAPI definition.
- Each collection holds the documents that the matching endpoints insert, update and find. `GET /search` looks for the keyword as a username, an organisation name and an event name, and joins the three results.
- The notification text is built by the event flows when an event is created or changed.

## What it is and is not

This is a prototype of the interface, not a finished service:

- The function `Recommendation Algorithm` of the `Algorithms` tab is a placeholder: it sets an empty object, which the next node uses as its query, so `GET /user/:userId/recommend` returns every event instead of the ones that match the user.
- An unknown user, organisation or event is answered with status 200 and an empty list, not with the 400 of the OpenAPI definition.
- There is no authentication: the `JWTbearerAuth` and OAuth settings of the OpenAPI definition are not implemented in the flows, and the login endpoint has no flow.
- The `Debug` tab adds two endpoints that are not part of the API, `GET /user` and `GET /organisation`, which list all documents of the collection.
- The donation flow stores the document it receives. A real system would hand card data to a payment provider and never store it.
- The file also holds MQTT broker and extra MongoDB configuration nodes from the Node-RED template that the flows do not use.

The users, organisations, donor and card values in `db-seed/` and in the `inject` nodes are made-up test data.
