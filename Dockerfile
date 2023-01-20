FROM sumankhanal/rakudo@sha256:e021be33d0f20af3928b611b21c6e5780f19ccf6d24fbc9102ada2108a73c101
LABEL maintainer="Dr Suman Khanal <suman81765@gmail.com>"

      
#Enabling Binder..................................
    
#..............................................
      
ENV PATH=$PATH:/usr/share/perl6/site/bin


RUN apt-get update \
    && apt-get install -y build-essential \
    wget libzmq3-dev ca-certificates \
    python3-pip python3-setuptools \
    && rm -rf /var/lib/apt/lists/* && pip3 install jupyter notebook asciinema jupyterlab pyscaffold --no-cache-dir \
    && zef -v install git://github.com/bduggan/raku-jupyter-kernel.git --force-test \ 
    && zef install Pod::To::HTML \
    && jupyter-kernel.raku --generate-config \
    && ln -s /usr/share/perl6/site/bin/* /usr/local/bin


....................


EXPOSE 8888

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root"]
