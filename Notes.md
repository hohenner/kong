# Research

Reviewed documentation for information on how Kong interfaces with RedHat Container Registry

git branching strategy: https://github.com/hohenner/kong/blob/master/CONTRIBUTING.md#git-branches
build tools: https://github.com/Kong/kong-build-tools#developing-kong

Didn't immediately find where in docs RedHat Container Registry is located, docs will need to get updated

## CI 
repo has a jenkinsfile, a .travis.yml, Github Actions .github, ?CircleCI? .ci directory, why all?

builds various flavors of linux/version

place to stop building RHEL 7.x in jenkinsfile

# 1. Removing RedHat Container Registry
## DOCKER_RELEASE_REPOSITORY 
Seems to be how the repository is defined for the scripts. 

release-kong.sh defined to deploy to a repository, written to be generic, controlled by environment variables, so can change where pushing by changing environment variable.
Where is DOCKER_RELEASE_REPOSITORY defined? Env Var in CI?

```
andy@andy-Latitude-E7440:~/src$ grep -r DOCKER_RELEASE *
kong-build-tools/Makefile:DOCKER_RELEASE_REPOSITORY ?= `grep DOCKER_RELEASE_REPOSITORY $(KONG_SOURCE_LOCATION)/.requirements | awk -F"=" '{print $$2}'`
kong-build-tools/Makefile:	DOCKER_RELEASE_REPOSITORY=$(DOCKER_RELEASE_REPOSITORY) \
kong-build-tools/release-kong.sh:DOCKER_REPOSITORY="${DOCKER_RELEASE_REPOSITORY:-kong/kong}"
```

## reference to RedHat Container Registry
andy@andy-Latitude-E7440:~/src$ grep -r  release-rhel *
docker-kong/Makefile:release-rhel: build
docker-kong/.github/workflows/test.yml:          make release-rhel

## Fix for removing RedHat Container Registry
https://github.com/hohenner/docker-kong/pull/1

# 2. Stop building / publishing RHEL 7.x

Removed reference to RHEL 7.x in Jenkinsfile:
https://github.com/hohenner/kong/pull/1
This seems like it's a too easy fix, need to dig deeper to find the catch.


# 3. how would change to make more maintainable
* There are multiple inter-related repos and makefiles, I would find out context of why it was divided how it is and look to see if there was a simpler approach. If what the deliverable is a docker image, are the makefiles necessary, or would it be easier to just do inside the CI?

* There are also multiple CI instances configured in these repos, understand why. It seems like each does something slightly different?

* Add Documentation for these decisions (may be there and I did not find in my timeboxed reading through documentation).

* There are variables like DOCKER_RELEASE_REPOSITORY that I could not find where they were defined initially, references to loading from .requirements (where it is not defined), make it more clear on where the variables are defined.
