#!/bin/bash

WORKFLOW_DIRECTORY=./.github/workflows
WORKFLOW_NAME=md_bundle_publish.yaml

DOCKERFILE_DIRECTORY=./examples

echo -n "Installing bundle publish workflow to $WORKFLOW_DIRECTORY/$WORKFLOW_NAME..."
mkdir --parents $WORKFLOW_DIRECTORY
wget -O $WORKFLOW_DIRECTORY/$WORKFLOW_NAME -q https://raw.githubusercontent.com/massdriver-cloud/actions/main/example_workflows/$WORKFLOW_NAME
echo " done!"
echo 
echo "A GitHub workflow has been added at $WORKFLOW_DIRECTORY/$WORKFLOW_NAME".
echo "It publishes any updates to the bundle to Massdriver on push to main."
echo "You will need to set two secrets for the repository in GitHub:"
echo -e '\033[1mMASSDRIVER_API_KEY\033[0m and \033[1mMASSDRIVER_ORG_ID\033[0m.'
echo "The key/service account can be created at https://app.massdriver.cloud/organization/api-keys."
echo "The Organization ID can be copied from the same page."
echo

if [[ -f $DOCKERFILE_DIRECTORY/Dockerfile ]]; then
    echo "This bundle also contains a Dockerfile in the $DOCKERFILE_DIRECTORY directory."
    echo "If you do not yet have a Dockerfile for your project, you can use the provided one to get you started."
fi
