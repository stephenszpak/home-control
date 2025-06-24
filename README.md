# home-control

Home control dashboard app built with [Phoenix](https://www.phoenixframework.org/). The
application source lives inside the `home_dash` directory and can be run via
Docker.

## Prerequisites

* [Docker](https://docs.docker.com/get-docker/) and
  [Docker Compose](https://docs.docker.com/compose/install/)

## Setup

1. Clone this repository and change into the project directory.

   ```bash
   git clone <repo-url>
   cd home-control/home_dash
   ```

2. Create a `.env` file in `home_dash` to configure runtime values. The
   following variables are used:

   ```bash
   SECRET_KEY_BASE=<secret>           # required
   OPENWEATHER_API_KEY=<api key>      # optional, enables weather widget
   OPENWEATHER_LAT=<latitude>         # optional
   OPENWEATHER_LON=<longitude>        # optional
   PHX_HOST=example.com               # optional, host used in production
   PORT=4000                          # optional, port exposed by the container
   DATABASE_PATH=./data/home_dash_prod.db  # optional database location
   ```

The application uses SQLite. WAL mode and a long busy timeout are enabled to
avoid `database is locked` errors when multiple connections attempt to access the
database simultaneously.

3. Fetch the application dependencies to generate a `mix.lock` file:

   ```bash
   docker compose run --rm app mix deps.get
   ```

   This step only needs to be performed once after cloning the repository.

## Running the app

From the `home_dash` directory run:

```bash
docker compose up --build
```

The application will be available at `http://localhost:4000`.
