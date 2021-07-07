--------------------------------------------------------------------------------------------------------------------------------------------

## Index
* [Current Architecture](#current-architecture)
* [Current Diagram](#current-diagram)
* [Questions](#current-questions)
* [Proposed Architecture](#proposed-architecture)
* [CICD - Architecture](#jenkins)
* [Terratest](#terratest)
* [Observability](#observability)
* [Permissions](#permissions)
* [Migration](#migration)
* [Budget](#budget)
* [Next Steps](#next-steps)
* [CICD - Application](#cicd-application)


--------------------------------------------------------------------------------------------------------------------------------------------

## Current Architecture.
<details>
<summary>Test Details</summary>

```
Let’s imagine that a Bank has a monolithic architecture to handle the enrollment for new credit cards.
A potential customer will enter a bunch of data through some online forms.
Once a day there will be a batch processing job that will process all this
data (The job will trigger a monolithic application that extracts the day’s
data and run the following tasks) The job will trigger a monolith service).

• It will verify if it’s an existing customer and if it is, it will verify any
potential loans or red flags in case the customer is not eligible for a
new credit card.
• It will verify the customer’s identity. We reach an external API (e.g.
Equifax) to verify all the provided details are accurate and also verify
if there is any red flag.
• It will calculate the amount limit assigned for the credit card. It will
also auto-generate a new Credit Card number so the customer can
start using it right away until the actual credit card is received.
All the data is currently persisted on an on-premise Oracle DB. This DB
holds all the personal data the user inputs in the forms and also additional
data that will help to calculate his/her credit rating.

## The Goal
As a company-wide initiative, we’ve been asked to
1. Migrate all our systems to Azure cloud
2. The company is shifting to event-driven architecture with
microservices

## The Test
This test will mix some designs (text and diagrams are expected) and
some coding. We are absolutely not aiming to build this system. We just
want to test some relevant points we’ll explicitly point out.
1. Given the 2 goals we mentioned in the previous section, imagine a
new architecture including text, diagrams, and any other useful
resource. Give special attention how to handle exceptions if the job
stops for any reason. How do we recover? How will the deployment
process will be? Also, think about permissions, how are we going the
Azure resources permissions?
2. How are you going to handle the migration of data? Design a
strategy (maybe using cloud resources o anything else?) and tell us
about it.
3. Let’s assume the current DB is a traditional Oracle relational DB.
Write all the necessary scripts to migrate this data to a new DB in
Azure. There are several options. Please explain which one you
choose and why.
4. Given the new architecture in Azure you designed let’s assume we’ll
provision new resources through Terraform. Build some of the infra
(let’s discuss which parts will be more relevant) with Terraform and
deploy it.
5. What kind of monitoring would be relevant to add? What kind of
resources would be helpful to achieve this?
We are expecting:
1. A detailed explained for each step
2. The reasons to choose each resource in Azure.
3. Details on how those resources work. 
```
</details>

## Current Diagram (Shown as example)
![alt text](/images/current_example.png "Current diagram")

## Questions (Shown as example)

Ask Questions! Examples

<details>
<summary>User / Permissions Migration</summary>

```
Are the users using auth/authentication federated service? SSO auth?

User’s apply through filling out forms without the necessity of creating an account with the bank (it is open to anyone) so there should be no auth involved.
In the future we might incorporate federated auth that will allow us to fill out some information that we currently request to users. So any prep work for the future would be great.
```
</details>
<details>
<summary>Data Migration</summary>
  
```

```
</details>
<details>
<summary>Interface System Constraints</summary>
  
```

```
</details>
<details>
<summary>Budget</summary>
  
```

```
</details>
<details>
<summary>Application design</summary>
  
```

```
</details>

# Proposed Architecture (Shown as example)
![alt text](/images/proposed_example.png "Proposed diagram")

## Requirement (Shown as example)
Add the requirements to run the test

Example
* Azure with a Visual Studio Subscription
* Jenkins
* Terraform => v0.12
* AZ cli --> (curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash)
* For Terratest --> Go v0.13

### Constrains (Shown as example)
* Blob Storage for Terraform State
* Due to GDPR compliance we will store our data resources under in eu-west region
* Vm server should be RHEL due to application requirements

(#jenkins)## CICD Automation
![alt text](/Images/example_cicd.png "CICD Automation")

## Terraform plan / Terratest (Shown as example)

Add Output of Terraform PLan
<details>
<summary>Summary</summary>
  
```

------------------------------------------------------------------------
------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Plan: xx to add, 0 to change, 0 to destroy.


------------------------------------------------------------------------
------------------------------------------------------------------------

```
</details>

## Observability (Shown as example)
What things will you consider?

```
Example: Latency

```
<details>
<summary>Summary</summary>
  
Latency
* What: How long something takes to respond or complete
* Why: Direct impact on customer experience

</details>

## Permissions

### Best Practices (Shown as example)
Example of Best Practices
* Enable multi-factor authentication (MFA) for privileged users

![alt text](/images/example_permissions.png "Permissions")

## Disaster Recovery Plan (Shown as example)

Example:

* Database Backup


## Compliance (Shown as example)
Example:
* GDPR (data layer stored in EU-WEST)

# Migration (Shown as example)
![alt text](https://cdn-images-1.medium.com/max/1600/0*WW36nabYAh5wn2v3. "Migration").

What Migration Strategy would you choose?

## App Migration Plan (Shown as example)
Explain how would you do it

## Database Migration Plan (Shown as example)
Explain how would you do it

# CICD Application (Shown as example)

Using a CI/CD we will automate the build and deploy processes. You can create multiple stages in the pipeline, each stage running based on the result of the previous one. 

# Budget (Shown as example)

Calculation Report


# Next Steps (Shown as example)

## Anything that we need to consider in the future?

* Query data when generating the report
