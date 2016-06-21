## <a name="resource-item">Item</a>

Stability: `prototype`

Items: Water, food, medicataion or ammunition of a survivor

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when item was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of item | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *nullable string* | name of item | `null` |
| **updated_at** | *date-time* | when item was updated | `"2015-01-01T12:00:00Z"` |


## <a name="resource-survivor">Survivor</a>

Stability: `prototype`

User of the system, surviving on the zombie-crawled wasteland. When with pending trades to accept or review a 'pending' header will be attached to all requests

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age of survivor | `42` |
| **created_at** | *date-time* | when survivor was created | `"2015-01-01T12:00:00Z"` |
| **gender** | *string* | gender of survivor | `"example"` |
| **id** | *uuid* | unique identifier of survivor | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **infections** | *nullable object* | reports of infection of survivor | `null` |
| **items** | *nullable object* | items of survivor | `null` |
| **lat** | *nullable number* | latitude of survivor | `null` |
| **lng** | *nullable number* | longitude of survivor | `null` |
| **name** | *string* | unique name of survivor | `"example"` |
| **updated_at** | *date-time* | when survivor was updated | `"2015-01-01T12:00:00Z"` |

### Survivor Create

Create a new survivor.

```
POST /survivors
```

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age of survivor | `42` |
| **encrypted_password** | *string* | encrypted password of survivor | `"example"` |
| **gender** | *string* | gender of survivor | `"example"` |
| **id** | *uuid* | unique identifier of survivor | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **lat** | *nullable number* | latitude of survivor | `null` |
| **lng** | *nullable number* | longitude of survivor | `null` |
| **name** | *string* | unique name of survivor | `"example"` |


#### Curl Example

```bash
$ curl -n -X POST https://social-zombie.herokuapp.com/survivors \
  -d '{
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "infections": null,
  "items": null,
  "lat": 42.0,
  "lng": 42.0,
  "encrypted_password": "example"
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
  "items": null,
  "infections": null,
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
$ curl -n -X DELETE https://social-zombie.herokuapp.com/survivors/$SURVIVOR_ID_OR_NAME \
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
  "items": null,
  "infections": null,
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
$ curl -n https://social-zombie.herokuapp.com/survivors/$SURVIVOR_ID_OR_NAME
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
  "items": null,
  "infections": null,
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
$ curl -n https://social-zombie.herokuapp.com/survivors
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
    "items": null,
    "infections": null,
    "lat": 42.0,
    "lng": 42.0,
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### Survivor Surivors status

Receives reports of population status, including: healthy percentage, infected percentage, and totals

```
get /survivors/status
```


#### Curl Example

```bash
$ curl -n https://social-zombie.herokuapp.com/survivors/status
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
  "items": null,
  "infections": null,
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Survivor Items status

Receives reports of items status, including: Average amount of each kind of resource by survivor (e.g. 5 waters per user) and Points lost because of infected survivor. et. al.

```
DELETE /survivors/items/status
```


#### Curl Example

```bash
$ curl -n -X DELETE https://social-zombie.herokuapp.com/survivors/items/status \
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
  "items": null,
  "infections": null,
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

#### Optional Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **age** | *integer* | age of survivor | `42` |
| **encrypted_password** | *string* | encrypted password of survivor | `"example"` |
| **gender** | *string* | gender of survivor | `"example"` |
| **id** | *uuid* | unique identifier of survivor | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **lat** | *nullable number* | latitude of survivor | `null` |
| **lng** | *nullable number* | longitude of survivor | `null` |
| **name** | *string* | unique name of survivor | `"example"` |


#### Curl Example

```bash
$ curl -n -X PATCH https://social-zombie.herokuapp.com/survivors/$SURVIVOR_ID_OR_NAME \
  -d '{
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "age": 42,
  "gender": "example",
  "infections": null,
  "items": null,
  "lat": 42.0,
  "lng": 42.0,
  "encrypted_password": "example"
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
  "items": null,
  "infections": null,
  "lat": 42.0,
  "lng": 42.0,
  "updated_at": "2015-01-01T12:00:00Z"
}
```


## <a name="resource-trade">Trade</a>

Stability: `prototype`

Represents the transaction of items between survivors

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **accepted** | *nullable boolean* | boolean to indicate acceptance of trade by 'to' recipient | `null` |
| **created_at** | *date-time* | when trade was created | `"2015-01-01T12:00:00Z"` |
| **from_items** | *nullable string* | items from the origin of transaction, represented by 'items' array of JSON Item objects | `null` |
| **id** | *uuid* | unique identifier of trade | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **reviewed** | *nullable boolean* | boolean to indicate review of trade by 'from' recipient | `null` |
| **to_items** | *nullable string* | items added to trade with origin, represented by 'items' array of JSON Item objects | `null` |
| **updated_at** | *date-time* | when trade was updated | `"2015-01-01T12:00:00Z"` |

### Trade Create

Create a new trade.

```
POST /trades
```


#### Curl Example

```bash
$ curl -n -X POST https://social-zombie.herokuapp.com/trades \
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
  "to_items": "example",
  "from_items": "example",
  "accepted": true,
  "reviewed": true,
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### Trade Delete

Delete an existing trade.

```
DELETE /trades/{trade_id}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://social-zombie.herokuapp.com/trades/$TRADE_ID \
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
  "to_items": "example",
  "from_items": "example",
  "accepted": true,
  "reviewed": true,
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
$ curl -n https://social-zombie.herokuapp.com/trades/$TRADE_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "to_items": "example",
  "from_items": "example",
  "accepted": true,
  "reviewed": true,
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
$ curl -n https://social-zombie.herokuapp.com/trades
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
    "to_items": "example",
    "from_items": "example",
    "accepted": true,
    "reviewed": true,
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### Trade Update

Update an existing trade.

```
PATCH /trades/{trade_id}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://social-zombie.herokuapp.com/trades/$TRADE_ID \
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
  "to_items": "example",
  "from_items": "example",
  "accepted": true,
  "reviewed": true,
  "updated_at": "2015-01-01T12:00:00Z"
}
```


