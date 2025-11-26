@echo off
setlocal ENABLEDELAYEDEXPANSION

REM --- Get the OpenShift token ---
oc whoami --show-token > openshift.login.token
set /P TOKEN=< openshift.login.token
del openshift.login.token

REM --- Get the OpenShift server ---
oc whoami --show-server > openshift.server
set /P SERVER=< openshift.server
del openshift.server

REM Remove quotes if present
set TOKEN=%TOKEN:"=%
set SERVER=%SERVER:"=%

REM --- Set required GitHub Secrets ---
gh secret set OPENSHIFT_SERVER -b "%SERVER%"
gh secret set OPENSHIFT_TOKEN -b "%TOKEN%"

REM --- Validate Registry Username ---
IF "%MY_REGISTRY_USERNAME%"=="" (
    echo ERROR: No MY_REGISTRY_USERNAME set. Please set MY_REGISTRY_USERNAME first.
    goto end
) ELSE (
    gh secret set IMAGE_REGISTRY_USER -b "%MY_REGISTRY_USERNAME%"
)

REM --- Validate Registry Password ---
IF "%MY_REGISTRY_PASSWORD%"=="" (
    echo ERROR: No MY_REGISTRY_PASSWORD set. Please set MY_REGISTRY_PASSWORD first.
    goto end
) ELSE (
    gh secret set IMAGE_REGISTRY_PASSWORD -b "%MY_REGISTRY_PASSWORD%"
)

:end
echo Done.
endlocal