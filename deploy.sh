JOB=gh-actions-org-runner
IMG=github-actions-runner:v4.0
ENV=gh-actions-runner-env
SUBNET_ID=/subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.Network/virtualNetworks/{vnet-name}/subnets/{snet-name}

docker build \
  -t $ACR.azurecr.io/$IMG \
  -f Dockerfile.github \
  --platform linux/amd64 \
  https://github.com/Azure-Samples/container-apps-ci-cd-runner-tutorial.git

docker push $ACR.azurecr.io/$IMG

#az containerapp env create \
#  --name $ENV \
#  --resource-group $RG \
#  --infrastructure-subnet-resource-id $SUBNET_ID \
#  --location eastus
#
#az containerapp job create \
#  --name "$JOB" \
#  --resource-group "$RG" \
#  --environment "$ENV" \
#  --trigger-type Event \
#  --image "$ACR.azurecr.io/$IMG" \
#  --registry-server "$ACR.azurecr.io" \
#  --registry-username "$ACR_USERNAME" \
#  --registry-password "$ACR_PASSWORD" \
#  --cpu 2 --memory 4Gi \
#  --min-executions 0 --max-executions 20 \
#  --polling-interval 30 \
#  --replica-timeout 3600 --replica-retry-limit 0 \
#  --parallelism 1 \
#  --scale-rule-name "github-org" \
#  --scale-rule-type "github-runner" \
#  --scale-rule-metadata \
#      "githubAPIURL=https://api.github.com" \
#      "owner=$ORG" \
#      "runnerScope=org" \
#      "labels=org-aca" \
#      "enableEtags=true" \
#      "targetWorkflowQueueLength=1" \
#  --scale-rule-auth "personalAccessToken=gh-pat" \
#  --secrets "gh-pat=$PAT_VALUE" \
#  --env-vars \
#      "GITHUB_PAT=secretref:gh-pat" \
#      "GH_URL=https://github.com/$ORG" \
#      "REGISTRATION_TOKEN_API_URL=https://api.github.com/orgs/$ORG/actions/runners/registration-token" \
#      "RUNNER_LABELS=org-aca" \
#      "RUNNER_GROUP=OrgRunners"
#
#az containerapp job logs show -g $RG -n $JOB --follow --container gh-actions-org-runner