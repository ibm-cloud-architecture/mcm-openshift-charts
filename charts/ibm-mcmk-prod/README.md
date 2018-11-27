# Multi-cloud Manager Klusterlet Helm Chart
IBM Multi-cloud Manager provides user visibility, application-centric management (policy, deployments, health, operations), and policy-based compliance across clouds and clusters. With IBM Multi-cloud Manager, you have control of your Kubernetes clusters. You can ensure that your clusters are secure, operating efficiently, and delivering the service levels that applications expect.

## Chart Details
This chart deploys IBM Multi-cloud Manager Klusterlet Multi-cloud Manager for use on the remote-cluster.

- **IBM Multi-cloud Manager Klusterlet** is the agent that is responsible for a single Kubernetes cluster. IBM Multi-cloud Manager Klusterlet initiates a connection to the IBM Multi-cloud Manager Controller, receives work requests, then returns the results. The IBM Multi-cloud Manager Klusterlet uses a unidirectional communication pattern, where the connections are always initiated by the IBM Multi-cloud Manager Klusterlet and sent to the IBM Multi-cloud Manager Controller. The IBM Multi-cloud Manager Klusterlet connects to various services within the cluster for operations, including the Kuberenetes API service, the Helm client and Tiller service, and Weave for topology.

## Multi-arch support
By default, the chart is configured for amd64. You can change image names in the chart (mainly in values.yaml) to the arch which you intend to use.

## Online user documentation
For the complete, and most up-to-date IBM Multi-cloud Manager user documentation, see https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/ibm-multi-cloud/overview.html.

## Installing the Chart
For the complete, and most up-to-date information about preparation, installation and configuration, see https://www.ibm.com/support/knowledgecenter/SSBS6K_3.1.0/ibm-multi-cloud/install.html.