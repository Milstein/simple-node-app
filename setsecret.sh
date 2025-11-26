#!/bin/bash

# Get token and server from oc
TOKEN=$(oc whoami --show-token)
SERVER=$(oc whoami --show-server)

# Set required GH repo secrets
gh secret set OPENSHIFT_SERVER -b "$SERVER"
gh secret set OPENSHIFT_TOKEN -b "$TOKEN"

# Check registry username
if [ -z "$MY_REGISTRY_USERNAME" ]; then
  echo "$0: No MY_REGISTRY_USERNAME set. Please export MY_REGISTRY_USERNAME."
  exit 1
else
  gh secret set IMAGE_REGISTRY_USER -b "$MY_REGISTRY_USERNAME"
fi

# Check registry password
if [ -z "$MY_REGISTRY_PASSWORD" ]; then
  echo "$0: No MY_REGISTRY_PASSWORD set. Please export MY_REGISTRY_PASSWORD."
  exit 1
else
  gh secret set IMAGE_REGISTRY_PASSWORD -b "$MY_REGISTRY_PASSWORD"
fi