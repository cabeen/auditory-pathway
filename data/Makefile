################################################################################
#
# Quantitative Imaging Toolkit (QIT) (c) 2017 Ryan Cabeen
# All rights reserved.
#
# The Software remains the property of Ryan Cabeen ("the Author").
#
# The Software is distributed "AS IS" under this Licence solely for
# non-commercial use in the hope that it will be useful, but in order
# that the Author as a charitable foundation protects its assets for
# the benefit of its educational and research purposes, the Author
# makes clear that no condition is made or to be implied, nor is any
# warranty given or to be implied, as to the accuracy of the Software,
# or that it will be suitable for any particular purpose or for use
# under any specific conditions. Furthermore, the Author disclaims
# all responsibility for the use which is made of the Software. It
# further disclaims any liability for the outcomes arising from using
# the Software.
#
# The Licensee agrees to indemnify the Author and hold the
# Author harmless from and against any and all claims, damages and
# liabilities asserted by third parties (including claims for
# negligence) which arise directly or indirectly from the use of the
# Software or the sale of any products based on the Software.
#
# No part of the Software may be reproduced, modified, transmitted or
# transferred in any form or by any means, electronic or mechanical,
# without the express permission of the Author. The permission of
# the Author is not required if the said reproduction, modification,
# transmission or transference is done without financial return, the
# conditions of this Licence are imposed upon the receiver of the
# product, and all original and amended source code is included in any
# transmitted product. You may be held legally responsible for any
# copyright infringement that is caused or encouraged by your failure to
# abide by these terms and conditions.
#
# You are not permitted under this Licence to use this Software
# commercially. Use for which any financial return is received shall be
# defined as commercial use, and includes (1) integration of all or part
# of the source code or the Software into a product for sale or license
# by or on behalf of Licensee to third parties or (2) use of the
# Software or any derivative of it for research with the final aim of
# developing software products for sale or license to a third party or
# (3) use of the Software or any derivative of it for research with the
# final aim of developing non-software products for sale or license to a
# third party, or (4) use of the Software to provide any service to an
# external organisation for which payment is received.
#
################################################################################

ROOT := $(dir $(abspath $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))))

BUNDLE_MIN        := 0.01       # the minimum volume fraction for tracking
BUNDLE_ANGLE      := 65         # the maximum turning angle
BUNDLE_FACTOR     := 5          # the seed count multiplier
BUNDLE_HYBFAC     := 50         # the seed count multiplier for prior tracking
BUNDLE_HYBSUM     := 0.01       # the minimum total fiber volume fraction 
BUNDLE_HYBDISP    := 0.15       # the dispersion used in hybrid tracking 
BUNDLE_STEP       := 1.0        # the tracking stepsize
BUNDLE_INTERP     := Trilinear  # the interpolation mode
BUNDLE_SMOOTH     := 1          # the smoothing (compute from voxel dimension)
BUNDLE_DISPERSE   := 0.05       # the amount of tracking dispersion
BUNDLE_MAXLEN     := 10000      # the maximum track length
BUNDLE_LIMIT      := 1000000    # the maximum number of tracks

BUNDLE_METHOD     := Hybrid     # the type of tracking (e.g. Prior Determ Prob)

PROJECT_SIGMA     := 0          # compute from the voxel dimension
PROJECT_ANGLE     := 45         # the minimum angle for hybrid projection
PROJECT_NORM      := 0.01       # the minimum norm for inclusion
PROJECT_FRAC      := 0.025      # the minimum single fraction for inclusion
PROJECT_FSUM      := 0.05       # the minimum total fraction for inclusion

SIMPLE_COUNT      := 10000      # the maximum number in a simplified bundle
SIMPLE_DIST       := 1          # the distance threshold for simplification

MY_BUNDLE_BASE ?= tract.auditory

all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.dti.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.along.dti.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.fwdti.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.along.fwdti.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.noddi.map
all.auditory: diff.$(MY_BUNDLE_BASE)/bundles.along.noddi.map

BUNDLE_LIST       := $(ROOT)/bundles.txt
BUNDLE_DIR        := $(ROOT)/bundles

include brain.makefile

$(foreach n, $(shell cat $(BUNDLE_LIST)), $(eval $(call bundle.seg, \
  tone.$(MY_BUNDLE_BASE), $(ATLAS_TONE_XFM), $(TONE_ATLAS_XFM), $(BUNDLE_DIR), $(n))))

$(foreach n, $(shell cat $(BUNDLE_LIST)), $(eval $(call bundle.seg, \
  diff.$(MY_BUNDLE_BASE), $(ATLAS_DIFF_XFM), $(DIFF_ATLAS_XFM), $(BUNDLE_DIR), $(n))))

$(foreach s, tone diff, \
  $(eval $(call bundles.map, $(s).$(MY_BUNDLE_BASE)/bundles, $(BUNDLE_LIST))) \
  $(eval $(call bundles.core.map, $(s).$(MY_BUNDLE_BASE)/bundles, $(BUNDLE_LIST))) \
  $(eval $(call bundles.along.map, $(s).$(MY_BUNDLE_BASE)/bundles, $(BUNDLE_LIST))) \
  $(foreach p, whole.vertex whole.voxel whole.core along.vertex along.voxel along.core, \
    $(eval $(call bundles.param.map, $(s).$(MY_BUNDLE_BASE)/bundles, $(BUNDLE_LIST), $(p)))))

################################################################################
# End of file 
################################################################################

