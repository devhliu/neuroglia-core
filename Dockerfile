FROM neurodebian:stretch-non-free
MAINTAINER <alik@robarts.ca>

RUN mkdir -p /src/install_scripts
COPY install_scripts/ /src/install_scripts

ENV DEBIAN_FRONTEND noninteractive
RUN bash /src/install_scripts/00.install_basics_sudo.sh
RUN bash /src/install_scripts/03.install_anaconda2_nipype_dcmstack_by_binary.sh /opt
RUN bash /src/install_scripts/04.install_octave_sudo.sh 
RUN bash /src/install_scripts/10.install_afni_fsl_sudo.sh
RUN python /src/install_scripts/fslinstaller.py -d /opt/fsl
RUN bash /src/install_scripts/12.install_c3d_by_binary.sh /opt
RUN bash /src/install_scripts/15.install_freesurfer_minimal_by_binary.sh /opt
RUN bash /src/install_scripts/16.install_ants_by_binary.sh /opt
RUN bash /src/install_scripts/17.install_dcm2niix_by_binary.sh /opt
RUN bash /src/install_scripts/23.install_heudiconv_by_source.sh /opt
RUN bash /src/install_scripts/24.install_bids-validator_sudo.sh
RUN bash /src/install_scripts/25.install_niftyreg_by_source.sh /opt
RUN bash /src/install_scripts/28.install_gradunwarp_by_source.sh /opt


#remove all install scripts
RUN rm -rf /src


#anaconda2
ENV PATH /opt/anaconda2/bin/:$PATH

#c3d
ENV PATH /opt/c3d/bin:$PATH

#fsl
ENV FSLDIR /opt/fsl
ENV POSSUMDIR $FSLDIR
ENV PATH $FSLDIR/bin:$PATH
ENV FSLOUTPUTTYPE NIFTI_GZ
ENV FSLMULTIFILEQUIT TRUE
ENV FSLTCLSH /usr/bin/tclsh
ENV FSLWISH /usr/bin/wish
ENV FSLBROWSER /etc/alternatives/x-www-browser
ENV LD_LIBRARY_PATH $FSLDIR/lib:${LD_LIBRARY_PATH}


#ants
ENV PATH /opt/ants:$PATH
ENV ANTSPATH /opt/ants

#dcm2niix
ENV PATH /opt/mricrogl_lx:$PATH

#heudiconv
ENV PYTHONPATH /opt/heudiconv:$PYTHONPATH

#niftyreg
ENV LD_LIBRARY_PATH /opt/niftyreg-1.3.9/lib:$LD_LIBRARY_PATH 
ENV PATH /opt/niftyreg-1.3.9/bin:$PATH

#matlab on graham (requires user to be on sharcnet matlab users list)
ENV JAVA_HOME /cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121
ENV MLM_LICENSE_FILE /cvmfs/restricted.computecanada.ca/config/licenses/matlab/inst_uwo/graham.lic
ENV PATH /cvmfs/restricted.computecanada.ca/easybuild/software/2017/Core/matlab/2017a:/cvmfs/restricted.computecanada.ca/easybuild/software/2017/Core/matlab/2017a/bin:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121:/cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121/bin:$PATH
ENV _JAVA_OPTIONS -Xmx256m
ENV LIBRARY_PATH /cvmfs/soft.computecanada.ca/easybuild/software/2017/Core/java/1.8.0_121/lib

#freesurfer - minimal
ENV FREESURFER_HOME /opt/freesurfer_minimal
ENV PATH $FREESURFER_HOME/bin:$PATH

