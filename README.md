# mongo-express nightly Docker image

This repository builds a Docker image from the latest upstream source at:

- https://github.com/mongo-express/mongo-express

The GitHub Actions workflow runs nightly and on manual dispatch, then publishes the image to:

- `kdemetter/mongo-express`

The build uses upstream's pinned Yarn release and lockfile, builds the production
assets, then removes development dependencies. Cypress and test MongoDB binaries
are not downloaded during the image build.

The image listens on `0.0.0.0:8081` by default so Docker-published ports can reach
the UI. Override `VCAP_APP_HOST` at runtime to change the bind address. Only
publish the port on trusted interfaces and configure authentication before use.

## Required GitHub secret

Set this repository secret before running the workflow:

- `DOCKERHUB_TOKEN`: Docker Hub access token for the `kdemetter` account.
