# mongo-express nightly Docker image

This repository builds a Docker image from the latest upstream source at:

- https://github.com/mongo-express/mongo-express

The GitHub Actions workflow runs nightly and on manual dispatch, then publishes the image to:

- `kdemetter/mongo-express`

## Required GitHub secret

Set this repository secret before running the workflow:

- `DOCKERHUB_TOKEN`: Docker Hub access token for the `kdemetter` account.
