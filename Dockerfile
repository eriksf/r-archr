FROM rocker/tidyverse:4.3.0
LABEL maintainer="Erik Ferlanti <eferlanti@tacc.utexas.edu>"

# Configure ENV
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      bzip2 \
      gsl-bin \
      libbz2-dev \
      libgsl-dev \
      libxt-dev \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/*

# Install ArchR and ArchR extra packages
RUN Rscript -e 'devtools::install_github("GreenleafLab/ArchR", ref="master", repos = BiocManager::repositories())' \
    && Rscript -e 'library(ArchR); ArchR::installExtraPackages()'

CMD [ "R" ]
