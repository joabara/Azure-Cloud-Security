## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![network_diagram](https://github.com/joabara/Azure-Cloud-Security/blob/main/Diagrams/AzureCloudDiagram.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the ```install-elk.yml``` file may be used to install only certain pieces of it, such as Filebeat.

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting ssh traffic to the network (from the Jump-Box).

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log events and operating system metrics.

The configuration details of each machine may be found below.

| Server Name | Function     | IP Address | Operating System |
|-------------|--------------|------------|------------------|
| Jump-Box    | Gateway      | 10.0.0.4   | Linux            |
| Web-1       | Web Server 1 | 10.0.0.5   | Linux            |
| Web-2       | Web Server 2 | 10.0.0.6   | Linux            |
| Web-3       | Web Server 3 | 10.0.0.7   | Linux            |
| ELK         | Elk Server   | 10.1.0.5   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 107.142.180.61

Machines within the network can only be accessed by the Jump-Box Provisoner. The public IP address was 13.72.78.188 and its private IP address was 10.0.0.4.

A summary of the access policies in place can be found in the table below.

| Policy Name | Publicly Accessible | Allowed IP Addresses    |
|-------------|---------------------|-------------------------|
| Jump-Box    | Yes                 | 107.142.180.61          |
| Web-1       | No                  | 10.0.0.4                |
| Web-2       | No                  | 10.0.0.4                |
| Web-3       | No                  | 10.0.0.4                |
| ELK Server  | Yes                 | 10.0.0.4 107.142.180.61 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because we can a implement various configurations to a large number of machines automatically. While this network only has a handful of machines, one can imagine a larger network would require automated configurations; manual configurations would just take too long!

The playbook implements the following tasks:
* Install Docker.io
* Install python-pip3
* Increase virtual memory
* Use sysctl to use more memory
* Download and launch an elk container, while listing the ports it will run on

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
![docker ps](https://github.com/joabara/Azure-Cloud-Security/blob/main/Diagrams/docker%20ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
* Web-1 10.0.0.5
* Web-2 10.0.0.6
* Web-3 10.0.0.7

We have installed the following Beats on these machines:
* Web-1 10.0.0.5
* Web-2 10.0.0.6
* Web-3 10.0.0.7

These Beats allow us to collect the following information from each machine:
Filebeat allows us to collect data on system files and set log events to understand how the files on the systems are changing. Metricbeat allows us to collect various metrics and statistics from the operating system and various processes running on the web-servers.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-playbook.yml file to roles directory.
- Update the hosts file to include the IPs of each group so that Ansible knows which machines need to be run on a given playbook
- Run the playbook, and navigate to Kibana, running on ```52.252.62.49:5601/app/kibana```, then going to Filebeat and Metric to check that the installation worked as expected.

