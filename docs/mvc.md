# Model View Controller (MVC) Pattern

If a request comes in:
GET /about HTTP/1.1
Host: 127.0.0.1

GET for '/about'

# Routes

Matchers for the URL that is requested

GET for '/about'

I see you requested '/about/, we'll give that to the AboutController to handle

# Models

Database wrapper

User Model

- Query for records - all logins within a 24h
- Wrap individual records

# Views

Your response body content

- HTML
- CSV
- PDF
- XML

This is what gets sent back to the browser and displayed

# Controllers

Decides how to process a request and define a response
