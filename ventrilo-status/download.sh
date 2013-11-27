#!/bin/bash

# By executing this script you agree to the following ventrilo legal agreements:
#
# Export Control Laws:
#
#   Ventrilo is subject to United States export controls. Ventrilo may not be
#   downloaded or otherwise exported or re-exported: into (or to a national or
#   resident of) Afghanistan, Cuba, Iran, Iraq, Libya, North Korea, Sudan, Syria or
#   any other country to which the United States has embargoed goods; or any
#   organization or company on the United States Commerce Department's "Denied
#   Parties List."
#
#   By downloading or using Ventrilo, you are agreeing to the foregoing and all
#   applicable export control laws. You are also warranting that you are not under
#   the control of, located in, or a resident or national of any such country or on
#   any such list.
#
#   The information on export laws provided herein is not necessarily complete. For
#   more information on export laws, please refer to United States Commerce
#   Department, Bureau of Export Administration.
# 
# WARNING:
# 
#   This program is protected by copyright law and international treaties.
#
#   Unauthorized reproduction or distribution of this program, or any portion of
#   it, may result in severe civil and criminal penalties, and will be prosecuted
#   to the maximum extent possible under law.
#
#   Each product either comes with an embedded LICENSE file or an installation
#   program that will display the license for you. In either case all products are
#   ultimately governed by their respective license agreements.
#
#   Server admin's should download the latest version of the server which contains
#   executables for the selected operating system. You should also read the
#   "ventrilo_srv.htm" file with an internet browser, or lynx, for detailed
#   information about how to setup and configure the server for each of the
#   supported operating systems. Each server download file contains an embedded
#   LICENSE file that you must read and agree to depending on how you plan on using
#   the server. Failure to adhere to the LICENSE will result in severe penalties.
#
curl -X POST -d "Download=I Agree" -o ventrilo_srv-3.0.3-Linux-i386.tar.gz "http://dlx2.ventrilo.com/dl.php?server_linux_i386&8881575364671"
