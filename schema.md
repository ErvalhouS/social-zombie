## <a name="resource-infection">Infection</a>

Stability: `prototype`

Infection reports of survivors, when a survivor is reported as infected 3 times, he/she is considered a zombie and therefore cannot trade or interact anymore.

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when item was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of infection | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **reporter_id** | *uuid* | unique identifier of item owner | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **survivor_id** | *uuid* | unique identifier of item owner | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **updated_at** | *date-time* | when item was updated | `"2015-01-01T12:00:00Z"` |

### Infection Create

Report another survivor as infected, only works when logged.

```
POST /infections/{infection_id}
```


#### Curl Example

```bash
$ curl -n -X POST https://github.com/ErvlahouS/social-zombie/infections/$INFECTION_ID \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "reporter_id": "01234567-89ab-cdef-0123-456789abcdef",
  "survivor_id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-item">Item</a>

Stability: `prototype`

Items - Water, food, medicataion or ammunition of a survivor

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when item was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of item | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **item_value** | *number* | value of item | `42.0` |
| **name** | *string* | unique name of item | `"example"` |
| **survivor_id** | *uuid* | unique identifier of item owner | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **updated_at** | *date-time* | when item was updated | `"2015-01-01T12:00:00Z"` |

### Item Info

Info for existing item.

```
GET /items/{item_id}
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/items/$ITEM_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "item_value": 42.0,
  "survivor_id": "01234567-89ab-cdef-0123-456789abcdef",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-survivor">Survivor</a>

Stability: `prototype`

User of the system, surviving on the zombie-crawled wasteland. When with pending trades to accept or review a pending_trade HTTP header will be attached to all requests

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age of survivor | `42` |
| **created_at** | *date-time* | when survivor was created | `"2015-01-01T12:00:00Z"` |
| **gender** | *string* | gender of survivor | `"example"` |
| **id** | *uuid* | unique identifier of survivor | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **lat** | *nullable number* | latitude of survivor | `null` |
| **lng** | *nullable number* | longitude of survivor | `null` |
| **name** | *string* | unique name of survivor | `"example"` |
| **updated_at** | *date-time* | when survivor was updated | `"2015-01-01T12:00:00Z"` |

### Survivor Create

Create a new survivor.

```
POST /survivors
```


#### Curl Example

```bash
$ curl -n -X POST https://github.com/ErvlahouS/social-zombie/survivors \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor Delete

Delete an existing survivor.

```
DELETE /survivors/{survivor_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://github.com/ErvlahouS/social-zombie/survivors/$SURVIVOR_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor Info

Info for existing survivor.

```
GET /survivors/{survivor_id_or_name}
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/survivors/$SURVIVOR_ID_OR_NAME
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor List

List existing survivors.

```
GET /survivors
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/survivors
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "age": 42,
    "gender": "example",
    "lat": 42.0,
    "lng": 42.0,
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### Survivor Survivors status

Receives reports of population status, including - healthy percentage, infected percentage, and totals

```
GET /reports/status
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/reports/status
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor Items status

Receives reports of items status, including - Average amount of each kind of resource by survivor (e.g. 5 waters per user) and Points lost because of infected survivor. et. al.",

```
GET /reports/items
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/reports/items
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor Update

Update an existing survivor.

```
PATCH /survivors/{survivor_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://github.com/ErvlahouS/social-zombie/survivors/$SURVIVOR_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-trade">Trade</a>

Stability: `prototype`

Represents the transaction of items between survivors, while a survivor has a trade that hasn't been marked as :accepted and :reviewed it will receive all logged on requests marked with a 'pending_trade' HTTP header, which contains the trade's information as JSON

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **accepted** | *nullable uuid* | boolean to indicate acceptance of trade by :to recipient | `null` |
| **created_at** | *date-time* | when trade was created | `"2015-01-01T12:00:00Z"` |
| **from_items** | *string* | items from the origin of transaction, represented by 'items' array of JSON Item objects | `"example"` |
| **id** | *uuid* | unique identifier of trade | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **reviewed** | *nullable uuid* | boolean to indicate review of trade by 'from' recipient and, after value is set to true it's items are exchanged | `null` |
| **to** | *uuid* | survivor recipient of the trade, will be warned of pending trade through pending_trade HTTP header on every logged request, until it is marked as :accepted and :reviewed | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **to_items** | *nullable uuid* | items added to trade with :from_items :owner, represented by 'items' array of JSON Item objects. It's owner will be warned of pending trade through pending_trade HTTP header on every logged request, until it is marked as :accepted and :reviewed | `null` |
| **updated_at** | *date-time* | when trade was updated | `"2015-01-01T12:00:00Z"` |

### Trade Create

Create a new trade, at this point, only the attributes :to and :from_items must to be passed. After it's creation both users will receive all responses marked with pending_trade HHTP header, containing the data for this trade, until marked as :accepted and :reviewed.

```
POST /trades
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **from_items** | *string* | items from the origin of transaction, represented by 'items' array of JSON Item objects | `"example"` |
| **to** | *uuid* | survivor recipient of the trade, will be warned of pending trade through pending_trade HTTP header on every logged request, until it is marked as :accepted and :reviewed | `"01234567-89ab-cdef-0123-456789abcdef"` |


#### Curl Example

```bash
$ curl -n -X POST https://github.com/ErvlahouS/social-zombie/trades \
  -d '{
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "accepted": "01234567-89ab-cdef-0123-456789abcdef",
  "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "01234567-89ab-cdef-0123-456789abcdef",
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Trade Info

Info for existing trade.

```
GET /trades/{trade_id}
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/trades/$TRADE_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "accepted": "01234567-89ab-cdef-0123-456789abcdef",
  "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "01234567-89ab-cdef-0123-456789abcdef",
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Trade List

List existing trades.

```
GET /trades
```


#### Curl Example

```bash
$ curl -n https://github.com/ErvlahouS/social-zombie/trades
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "accepted": "01234567-89ab-cdef-0123-456789abcdef",
    "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
    "to_items": "01234567-89ab-cdef-0123-456789abcdef",
    "to": "01234567-89ab-cdef-0123-456789abcdef",
    "from_items": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### Trade Delete

Delete an existing trade, only possible if logged survivor is one the :to or :from_items survivors and if trade isn't accepted and reviewed.

```
DELETE /trades/{trade_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://github.com/ErvlahouS/social-zombie/trades/$TRADE_ID \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "accepted": "01234567-89ab-cdef-0123-456789abcdef",
  "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "01234567-89ab-cdef-0123-456789abcdef",
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Trade Update

Update an existing trade, at this point there are 2 options for trade update 1 - The :to survivor is replying with :accepted and :to_items 2 - The survivor that owns :from_survivor is replying with :reviewed, so that the trade can be completed

```
PATCH /trades/{trade_id}
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **accepted** | *nullable uuid* | boolean to indicate acceptance of trade by :to recipient | `null` |
| **from_items** | *string* | items from the origin of transaction, represented by 'items' array of JSON Item objects | `"example"` |
| **reviewed** | *nullable uuid* | boolean to indicate review of trade by 'from' recipient and, after value is set to true it's items are exchanged | `null` |
| **to** | *uuid* | survivor recipient of the trade, will be warned of pending trade through pending_trade HTTP header on every logged request, until it is marked as :accepted and :reviewed | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **to_items** | *nullable uuid* | items added to trade with :from_items :owner, represented by 'items' array of JSON Item objects. It's owner will be warned of pending trade through pending_trade HTTP header on every logged request, until it is marked as :accepted and :reviewed | `null` |


#### Curl Example

```bash
$ curl -n -X PATCH https://github.com/ErvlahouS/social-zombie/trades/$TRADE_ID \
  -d '{
  "accepted": "01234567-89ab-cdef-0123-456789abcdef",
  "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "01234567-89ab-cdef-0123-456789abcdef",
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "accepted": "01234567-89ab-cdef-0123-456789abcdef",
  "reviewed": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "01234567-89ab-cdef-0123-456789abcdef",
  "to": "01234567-89ab-cdef-0123-456789abcdef",
  "from_items": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```
