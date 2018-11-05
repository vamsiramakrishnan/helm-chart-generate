# helm-chart-generate
Wercker step to generate helm charts


Options 

      --chart-dir string             Specify the location where charts will be created (default "charts")
      --configmaps stringSlice       Specify the names of configmaps(configmap@namespace) to include in chart
      --daemons stringSlice          Specify the names of daemons(daemon@namespace) to include in chart
      --deployments stringSlice      Specify the names of deployments(deployments@namespace) to include in chart
      --jobs stringSlice             Specify the names of jobs(job@namespace) to include in chart
      --kube-dir string              Specify the directory of the yaml files for Kubernetes objects
      --pods stringSlice             Specify the names of pods(pod@namespace) to include in chart
      --pvcs stringSlice             Specify the names of persistent volume claims(pvc@namespace) to include in chart
      --pvs stringSlice              Specify the names of persistent volumes(pv@namespace) to include in chart
      --rcs stringSlice              Specify the names of replication cotrollers(rc@namespace) to include in chart
      --replicasets stringSlice      Specify the names of replica sets(rs@namespace) to include in chart
      --secrets stringSlice          Specify the names of secrets(secret@namespace) to include in chart
      --services stringSlice         Specify the names of services(service@namespace) to include in chart
      --statefulsets stringSlice     Specify the names of statefulsets(statefulset@namespace) to include in chart
      --storageclasses stringSlice   Specify the names of storageclasses(storageclass@namespace) to include in chart
      --preserve-name bool           Specify if you want to preserve resources name from input yaml true/false (default: false)
