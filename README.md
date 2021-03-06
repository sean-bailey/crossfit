# kb4sre exercise

This is an exercise designed to evaluate your comfort with setting up and debugging applications.

The repository consists of a python script which can run in two places:

1. Locally via docker-compose (for testing)
1. In AWS Lambda via terraform

---
## Running the app
Locally:
* You can run the app with docker-compose:
* `docker-compose run exercise`

AWS:
To deploy the app using ansible, simply run

`sh deploy-app-ansible.sh`

When prompted, plug in your Access Key ID, Secret Key, region and
account id, and the scripts will do the rest.

To deploy the app using Terraform, run

`sh deploy.sh`

and follow the appropriate prompts.

If you want to undeploy/decommission the application, run

`sh cleanup-app-ansible.sh`

and follow the appropriate prompts.

(All of these must be run from the root of this repo)

---
## Instructions

1. Fork this repo into your own GitHub
1. Complete as much of the exercise as you can - best effort counts!
1. Identify as many problems as you can find with any file in the repo
1. Identify any improvements you would make, either by making them or commenting with the intended change(s)
1. Write a script `./deploy.sh` that can be executed to easily deploy this to AWS
1. Commit everything and send a link to your repo to your recruiter

---
## Bonus points
After fixing any issues and making any improvements you would like to see,
write another terraform file that would run this as a one-off task in ecs (fargate).

Take screenshots of the task running with its log output, and commit those to your repo as well.
