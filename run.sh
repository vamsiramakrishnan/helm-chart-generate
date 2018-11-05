#!/bin/sh

chartify= "$WERCKER_STEP_ROOT/gocode/bin/chartify"
kubectl="$WERCKER_STEP_ROOT/kubectl"

main() {
  display_kubectl_version
  display_chartify_version
  
  cmd="cluster-info"
  
  # Global args
  global_args=
  raw_global_args="$WERCKER_HELM_CHART_GENERATE_RAW_GLOBAL_ARGS"

  # token
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CHART_GENERATE_TOKEN" ]; then
    global_args="$global_args --token=\"$WERCKER_HELM_CHART_GENERATE_TOKEN\""
  fi

  # username
  if [ -n "$WERCKER_HELM_CHART_GENERATE_USERNAME" ]; then
    global_args="$global_args --username=\"$WERCKER_HELM_CHART_GENERATE_USERNAME\""
  fi

  # password
  if [ -n "$WERCKER_HELM_CHART_GENERATE_PASSWORD" ]; then
    global_args="$global_args --password=\"$WERCKER_HELM_CHART_GENERATE_PASSWORD\""
  fi

  # server
  if [ -n "$WERCKER_HELM_CHART_GENERATE_SERVER" ]; then
    global_args="$global_args --server=\"$WERCKER_HELM_CHART_GENERATE_SERVER\""
  fi

  # insecure-skip-tls-verify
  if [ -n "$WERCKER_HELM_CHART_GENERATE_INSECURE_SKIP_TLS_VERIFY" ]; then
    global_args="$global_args --insecure-skip-tls-verify=\"$WERCKER_HELM_CHART_GENERATE_INSECURE_SKIP_TLS_VERIFY\""
  fi
    # certificate-authority
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CERTIFICATE_AUTHORITY" ]; then
    global_args="$global_args --certificate-authority=\"$WERCKER_HELM_CHART_GENERATE_CERTIFICATE_AUTHORITY\""
  fi
    # client-certificate
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CLIENT_CERTIFICATE" ]; then
    global_args="$global_args --client-certificate=\"$WERCKER_HELM_CHART_GENERATE_CLIENT_CERTIFICATE\""
  fi
    # client-key
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CLIENT_KEY" ]; then
    global_args="$global_args --client-key=\"$WERCKER_HELM_CHART_GENERATE_CLIENT_KEY\""
  fi


  mkdir -p $HOME/.kube
  $WERCKER_STEP_ROOT/envsubst < "$WERCKER_STEP_ROOT/config" > "$HOME/.kube/config"

  # export KUBECONFIG= $HOME/.kube/config
  info "Connecting to the Cluster as specified in kubeconfig"
  $kubectl cluster-info --kubeconfig $HOME/.kube/config
  
  # Global args
  chartify_args=
  chartify_cmd=
  
  
  # chart-name
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CHART_NAME" ]; then
	chartify_args="$chartify_args \"WERCKER_HELM_CHART_GENERATE_CHART_NAME\""
  fi 
  
  # chart-dir 
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CHART_DIR" ]; then
	chartify_args="$chartify_args --chart-dir=\"WERCKER_HELM_CHART_GENERATE_CHART_DIR\""
  fi
  
  # configmaps 
  if [ -n "$WERCKER_HELM_CHART_GENERATE_CONFIGMAPS" ]; then
	chartify_args="$chartify_args --configmaps=\"WERCKER_HELM_CHART_GENERATE_CONFIGMAPS\""
  fi
  
  # daemons 
  if [ -n "$WERCKER_HELM_CHART_GENERATE_DAEMONS" ]; then
	chartify_args="$chartify_args --daemons=\"WERCKER_HELM_CHART_GENERATE_DAEMONS\""
  fi
  
  # deployments 
  if [ -n "$WERCKER_HELM_CHART_GENERATE_DEPLOYMENTS" ]; then
	chartify_args="$chartify_args --deployments=\"WERCKER_HELM_CHART_GENERATE_DEPLOYMENTS\""
  fi
  
  # jobs
  if [ -n "$WERCKER_HELM_CHART_GENERATE_JOBS" ]; then
	chartify_args="$chartify_args --jobs=\"WERCKER_HELM_CHART_GENERATE_JOBS\""
  fi  
  
  # kube-dir 
  if [ -n "$WERCKER_HELM_CHART_GENERATE_KUBE_DIR" ]; then
	chartify_args="$chartify_args --kube-dir=\"WERCKER_HELM_CHART_KUBE_DIR\""
  fi  
  
  # pods
  if [ -n "$WERCKER_HELM_CHART_GENERATE_PODS" ]; then
	chartify_args="$chartify_args --pods=\"WERCKER_HELM_CHART_PODS\""
  fi 
  
  # pvcs
  if [ -n "$WERCKER_HELM_CHART_GENERATE_PVCS" ]; then
	chartify_args="$chartify_args --pvcs=\"WERCKER_HELM_CHART_PVCS\""
  fi 
  
  # pvs
  if [ -n "$WERCKER_HELM_CHART_GENERATE_PVS" ]; then
	chartify_args="$chartify_args --pvs=\"WERCKER_HELM_CHART_PVS\""
  fi 
  
  # rcs
  if [ -n "$WERCKER_HELM_CHART_GENERATE_RCS" ]; then
	chartify_args="$chartify_args --rcs=\"WERCKER_HELM_CHART_RCS\""
  fi 
  
  # replicasets
  if [ -n "$WERCKER_HELM_CHART_GENERATE_REPLICASETS" ]; then
	chartify_args="$chartify_args --replicasets=\"WERCKER_HELM_CHART_REPLICASETS\""
  fi 
  
  # secrets
  if [ -n "$WERCKER_HELM_CHART_GENERATE_SECRETS" ]; then
	chartify_args="$chartify_args --secrets=\"WERCKER_HELM_CHART_SECRETS\""
  fi 
  
  # services
  if [ -n "$WERCKER_HELM_CHART_GENERATE_SERVICES" ]; then
	chartify_args="$chartify_args --services=\"WERCKER_HELM_CHART_SERVICES\""
  fi 
  
  # statefulsets
  if [ -n "$WERCKER_HELM_CHART_GENERATE_STATEFULSETS" ]; then
	chartify_args="$chartify_args --statefulsets=\"WERCKER_HELM_CHART_STATEFULSETS\""
  fi   
  
  # preserve-name
  if [ -n "$WERCKER_HELM_CHART_GENERATE_PRESERVE_NAME" ]; then
	chartify_args="$chartify_args --preserve-name=\"WERCKER_HELM_CHART_PRESERVE_NAME\""
  fi  


  info "executing chartify command"
  $chartify $chartify_cmd $chartify_args
}

display_kubectl_version() {
  info "Running kubectl version:"
  "$kubectl" version --client
  echo ""
}

display_chartify_version() {
  info "Running chartify version:"
  "$chartify" version
  echo ""
}

main;
