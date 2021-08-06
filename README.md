# e2e-tests
[![HackMD Doc](https://hackmd.io/badge.svg)](https://hackmd.io/GlvlYyLBSfaPnRIlhxN7TA?view)
[![Build Status](https://travis-ci.org/openebs/e2e-tests.svg?branch=master)](https://travis-ci.org/openebs/e2e-tests)
[![Docker Pulls](https://img.shields.io/docker/pulls/openebs/ansible-runner.svg)](https://hub.docker.com/r/openebs/ansible-runner)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/3202/badge)](https://bestpractices.coreinfrastructure.org/projects/3202)

OpenEBS e2e-tests is a suite of functional and chaos test scenarios for workloads on Kubernetes. Our vision 
includes enabling end users to easily execute chaos experiments in their environments using a Kubernetes native 
approach, where each test scenario is specified in a declarative way.

## Overview

The primary objective of Litmus is to ensure a consistent and reliable behavior of workloads running on OpenEBS storage in Kubernetes. 
It also aims to catch hard-to-test bugs and unacceptable behaviors before users do. It strives to detect the 
real-world issues which escape during unit and integration tests.

While the experiments were developed initially to test if a given stateful workload is suitable for running 
on [OpenEBS](www.openebs.io)(_a Kubernetes dynamic storage provisioner_); the use cases are broader and overall 
system resilience can be characterized before and during operations.  

 The actual execution framework & repository of ready/configurable test experiments (mostly written as ansible playbooks & executed as Kubernetes jobs). The jobs are often executed in CI pipelines as part of e2e (refer https://openebs.ci) 

The test experiments make use of facilitator containers in [test-tools](https://github.com/e2echaos/test-tools) to 
implement the chaos, load generation, logging and other utility functions. 

The test logic is packaged into dedicated containers which makes them portable across Kubernetes deployments. 
This containerization also helps to integrate Litmus into CI/CD environments. 

And as a developer friendly framework, it also provides helpful playbooks to quickly spin-up Kubernetes clusters on different 
cloud & on-premise platforms on which to run the experiments! 

## Getting Started

The test experiment jobs(also called Litmusbooks) run using a dedicated ServiceAccount in the Litmus namespace. Setup RBAC & custom
resource definitions (CRDs) via kubectl, as shown below: 

```
git clone https://github.com/openebs/e2e-tests.git
cd e2e-tests
kubectl apply -f hack/rbac.yaml
kubectl apply -f hack/crds.yaml  
```

## Directory structure

- All the functional and chaos test scenarios are located inside `experiments` folder. Each test experiment will have the below directory structure.

```
├── data_persistence.j2   # An util for verifying data persistence. It varies based on app being used.
├── README.md             # Description about the scenario.
├── run_e2e_test.yml   # The job spec.
├── test_vars.yml         # Variables used in ansible-playbook.
└── test.yml              # The test logic in the form of ansible playbook.
```

In addition to the above files, some experiments will have util files being used in the playbook.

- The most commonly used util files are located in the directory `utils`

```
├── fcm    # Framework common modules
├── k8s    # set of kubernetes specific tasks
├── scm    # Solution common modules, Application specific tasks
    ├── applications
    ├── cloud      # Public cloud specific tasks
    └── openebs    # OpenEBS specific tasks
```

## Running an Experiment 

Let's say, you'd like to test resiliency of a stateful application pod upon container crash

- Locate the Experiment: Litmusbooks are typically placed in `experiments/<type>` folders. In this case, the corresponding
  e2ebook is present at `experiments/chaos/app_pod_failure` 

- Update the application (generally, the namespace and app labels) & chaos (if applicable) information being passed as ENVs to 
  the e2e job (`run_e2e_test.yml`). 

- Run the e2ebook:

  ```
  kubectl create -f experiments/chaos/app_pod_failure/run_e2e_test.yml
  ```
  
## Get Experiment Results 

Results are maintained in a custom resource (`e2eresult`) that bears the same name as the experiment. In this case,
`application-pod-failure`. View the experiment status via:

```
kubectl describe lr application-pod-failure
```

This custom resource(lr) will be created for every experiment in the beginning and the result gets updated finally.

## Viewing Logs 

Litmus pod (experiment-runner) console logs comprise of ansible playbbok run outputs & can be captured by any logging daemon
(such as fluentd), with most reference implementations using it as part of a standard stack (Elasticsearch-Fluentd-Kibana). 
However, you could also use the stern-based [logger](https://github.com/e2echaos/test-tools/tree/master/logger), either as 
a sidecar in the e2e job or a separate deployment to collect pod & system (kubelet) logs.

## Ways to Contribute

It needs all the help you can provide to have it cover the ever-growing Kubernetes landscape. 
Please contribute by raising issues, improving the documentation, contributing to the core framework and tooling, etc.

Another significant area of contribution is for you to describe your experiences/scenarios of running different kind of 
workloads (stateful & stateless) in your Kubernetes Environment.  For example, you can describe feature or failure (chaos) 
scenarios for a new workload or update the scenarios of an existing workload. An example template is provided below: 

```
Feature: MySQL services are not affected due to node failures.
  I need to have at least 3 nodes in my Cluster.
  I need to have enabled Storage solution that supports accessing volume from different nodes.
  I need to have my MySQL running on a persistent volume.
  I need to have MySQL running even when 33% of volume nodes are unavailable.

  Scenario: Node hits an OutOfMemory condition and becomes unresponsive.
    Given I have a Kubernetes cluster with StorageClass installed.
    Given I have a “MySQL” service running and MySQL-client access it from a different node.
    Then I launch memory hog pod on the node where “MySQL” service is running,
    Then wait for "60s",
    And verify MySQL-client can still access data.
```

For more details on contributing, please refer to [CONTRIBUTING.md](./CONTRIBUTING.md)

## Reference Projects

Litmus makes use of and extends several open source projects. Below are just some of the commonly used projects.

- [ansible](https://www.ansible.com/)
- [chaoskube](https://github.com/linki/chaoskube)
- [pumba](https://github.com/alexei-led/pumba)
- [chaostoolkit](https://github.com/chaostoolkit/chaostoolkit)

For a full list, please checkout the [test-tools](https://github.com/e2echaos/test-tools) repository.

## License

Litmus is licensed under the Apache License, Version 2.0. See [LICENSE](./LICENSE) for the full license text. Some of 
the projects used by the Litmus project may be governed by a different license, please refer to its specific license.
