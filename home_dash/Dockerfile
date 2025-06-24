FROM hexpm/elixir:1.18.4-erlang-28.0.1-alpine-3.21.3 as build
WORKDIR /app
ENV MIX_ENV=prod
RUN apk add --no-cache build-base git nodejs npm
COPY mix.exs mix.lock .
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile
COPY assets assets
RUN npm --prefix ./assets install
RUN MIX_ENV=prod mix assets.deploy
COPY . .
RUN mix compile
RUN mix release

FROM alpine:3.18 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs
WORKDIR /app
COPY --from=build /app/_build/prod/rel/home_dash .
ENV HOME_DASH_ERTS=/app/erts-* PATH=/app/bin:$PATH
CMD ["/app/bin/home_dash", "start"]
