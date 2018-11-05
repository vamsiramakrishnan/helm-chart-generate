#!/bin/sh

helm="$WERCKER_STEP_ROOT/helm"
kubectl="$WERCKER_STEP_ROOT/kubectl"

main() {
  display_helm_kubectl_version
  
#   if [ -z "$WERCKER_HELM_COMMAND" ]; then
#     fail "wercker-helm: command argument cannot be empty"
#   fi

  cmd="cluster-info"
  
  # Global args
  global_args=
  raw_global_args="$WERCKER_HELM_RAW_GLOBAL_ARGS"

  # token
  if [ -n "$WERCKER_HELM_TOKEN" ]; then
    global_args="$global_args --token=\"$WERCKER_HELM_TOKEN\""
  fi

  # username
  if [ -n "$WERCKER_HELM_USERNAME" ]; then
    global_args="$global_args --username=\"$WERCKER_HELM_USERNAME\""
  fi

  # password
  if [ -n "$WERCKER_HELM_PASSWORD" ]; then
    global_args="$global_args --password=\"$WERCKER_HELM_PASSWORD\""
  fi

  # server
  if [ -n "$WERCKER_HELM_SERVER" ]; then
    global_args="$global_args --server=\"$WERCKER_HELM_SERVER\""
  fi

  # insecure-skip-tls-verify
  if [ -n "$WERCKER_HELM_INSECURE_SKIP_TLS_VERIFY" ]; then
    global_args="$global_args --insecure-skip-tls-verify=\"$WERCKER_HELM_INSECURE_SKIP_TLS_VERIFY\""
  fi
    # certificate-authority
  if [ -n "$WERCKER_HELM_CERTIFICATE_AUTHORITY" ]; then
    global_args="$global_args --certificate-authority=\"$WERCKER_HELM_CERTIFICATE_AUTHORITY\""
  fi
    # client-certificate
  if [ -n "$WERCKER_HELM_CLIENT_CERTIFICATE" ]; then
    global_args="$global_args --client-certificate=\"$WERCKER_HELM_CLIENT_CERTIFICATE\""
  fi
    # client-key
  if [ -n "$WERCKER_HELM_CLIENT_KEY" ]; then
    global_args="$global_args --client-key=\"$WERCKER_HELM_CLIENT_KEY\""
  fi


  mkdir -p $HOME/.kube
  $WERCKER_STEP_ROOT/envsubst < "$WERCKER_STEP_ROOT/config" > "$HOME/.kube/config"

  # export KUBECONFIG= $HOME/.kube/config
  info "Connecting to the Cluster as specified in kubeconfig"
  $kubectl cluster-info --kubeconfig $HOME/.kube/config
  

}

display_helm_kubectl_version() {
  info "Running kubectl version:"
  "$kubectl" version --client
  echo ""
  info "Running helm version:"
  "$helm" version --client
  echo ""
}

main;
