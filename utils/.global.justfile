alias f := formatting
alias t := tests

default:
  @just --list

###############
#### TESTS #### 
###############

formatting:
    sh run_formatting.sh

black:
    black .

tests:
    sh run_tests.sh

tests_staged:
    sh run_tests.sh staged

###############
##### CDK ##### 
###############

syn:
    cdk synth --context config=develop --quiet && echo "Success" || chimeerror

dep:
    cdk deploy --context config=develop && chime || chimeerror

diff:
    cdk diff --context config=develop

###############
##### GIT ##### 
###############

clean_branches:
    git branch | grep -E 'feature|hotfix|bugfix' | xargs git branch -D

clean_hotfixes:
    git branch | grep -E 'hotfix' | xargs git branch -D

###############
### DOCKER #### 
###############

