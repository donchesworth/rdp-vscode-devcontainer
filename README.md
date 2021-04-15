# rdp-vscode-devcontainer

Here's how I currently am using Visual Studio Code, _in_ my container, by following the guidance from Microsoft's [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers), their [json reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference) and their [container templates](https://github.com/microsoft/vscode-dev-containers).

What makes rdp unique, is that it's built in order to use a base container with [RAPIDS](rapids.ai) + [Dask](dask.org) + [PyTorch](pytorch.org) = **rdp** installed.

# Get Started

I removed all my specific code, environment variables, and Dockerfile, but adding yours in should be simple. Here are the steps I'd follow:

## Clone + Add

First, clone this repo, and then move your project repository _into_ this **rdp-vscode-devcontainer** folder (don't worry - my `.gitignore` will ignore it):

``` bash
$ pwd
~/Documents/git
$ ls
my-project1/   my-project2/    rdp-vscode-devcontainer/
$ mv my-project1 rdp-vscode-devcontainer/
```

## Open Visual Studio Code and edit

Next, go ahead and open a new window in vscode, and choose the rdp-vscode-devcontainer folder. Even though it asks you to build the container:

> ℹ️ Folder contains a Dev Container configuration file. Reopen folder to develop in a container ([learn more]()).

Don't do it yet!

### .devcontainer/.env 

First, you'll definitely need to update the .env file:
- REGISTRY_HOSTNAME: This is the docker registry that you plan to push your dev container for testing (and prod)
- PROJECT_ID: This is your area in the registry (usually either your username, or your company/org/dept name, e.g. "cee-analytics")
- BASE_IMAGE: This is the rdp base container you'll use. You could probably use something like `nvcr.io/nvidia/rapidsai/rapidsai:0.18-cuda10.2-base-centos7` and add PyTorch on your own, but it might be better to build the base image with rdp al
- DEV_IMAGE: This is the name of the dev container image you'll be making (e.g. "solution-prediction-dev")
- I wouldn't change BASEDIR, DOTDEVDIR, PIP_CONFIG_FILE, or IPYTHONDIR unless you have a good reason why
- Add any additional environment variables you might need in the container (e.g. TRUSTED_DOCKER="True", REGISTRY_USER, REGISTRY_TOKEN)

### .devcontainer/pip.conf

This is the pip config file that the dev container will use for pip installs. Here you'd add anything you'd need, like:

``` dosini
[global]
extra-index-url = http://www.example.com:8181/simple/
trusted-host = www.example.com
```
### Dockerfile

This is where you put the container you need for your development environment. Mine will probably work for you, but if it doesn't, I'd keep the parts that add your requirements.txt
