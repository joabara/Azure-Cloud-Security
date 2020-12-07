# Cloud Security Fundamentals with Azure
In this repository I will share with you one of my first exercises in creating a virtual cloud network and how I implemented organized and secured infrastructure policies to the Azure Resource Group.

## Network Topography
This is how the network was implemented on Azure:

![alt text](https://github.com/joabara/Azure-Cloud-Security/blob/main/Diagrams/AzureCloudDiagram.PNG)

## Methodology
To enable a secure way to connect to the various virtual machines, I created a Jump-Box. This Jump-Box had a strict policy to only accept incoming SSH requests from my workstation IP. This would help isolate valid connections to the Jump-Box. Furthermore, the Jump-Box was password protected with an SSH-RSA public key from my workstation.

The Jump-Box would then be the main point of operations for configuring the rest of the network. The remaining servers on the network had SSH access, but from only within the network. Furthermore, they were also password protected with an SSH-RSA public key from the Jump-Box. A load balancer was added to allow HTTP traffic and prevent DDoS attacks.

An ELK server was configured on a separate network (10.1.0.0 vs 10.0.0.0) to record logs from Web Servers 1-3.

Once all the machines were configured on Azure and security policies were implemented, I pulled an Ansible container via Docker to create various playbooks to install packages from the Jump-Box to the webservers group. This allowed me to write playbooks that could be run to install packages like ELK, Filebeat, and Metricbeat to the various servers.

Since the web servers does not produce much data, I used sample Kibana data to sample data that the Web Servers could produce. In this case, the sample data represents web traffic:

Response Codes Over Time: 
![alt text](https://github.com/joabara/Azure-Cloud-Security/blob/main/Diagrams/KibanaSampleLog.PNG)


File Type Scatter Plot:

![alt text](https://github.com/joabara/Azure-Cloud-Security/blob/main/Diagrams/KibanaSampleLog3.PNG)


