# MotoSol

  To start the container:
    * Clone the repo
    * Go into moto_sol folder
    * run: docker-compose run --rm --service-ports web /bin/bash
    * only for the first time:
    * ---
    * mix deps.get
    * mix ecto.setup
    * ---
    * mix phx.server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
