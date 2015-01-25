#!/bin/sh
#
# Cookbook Name:: wawision
# Test:: regen.sh
#
# Author:: Stephan Linz <linz@li-pro.net>
#
# Copyright:: 2015, Li-Pro.Net
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

JSON_FILES=`find . -name '*.json' -type f`
for jf in ${JSON_FILES}; do

  # cookbook default values
  JSON_FILE_NAME="$(basename $(dirname ${jf}))/$(basename ${jf})"
  JSON_COOKBOOK_NAME="wawision"
  JSON_COOKBOOK_AUTHOR="Stephan Linz <linz@li-pro.net>"
  JSON_COOKBOOK_COPYRIGHT="2015, Li-Pro.Net"

  # application default values (see: attributes/app.rb)
  APP_INSTALL_METHOD="tar"
  APP_VERSION="3.1-rc3"
  APP_SERVER="http://downloads.sourceforge.net"
  APP_SOURCE="${APP_SERVER}/project/wawision"
  APP_SOURCE="${APP_SOURCE}/wawision_oss_testing-${APP_VERSION}.tar.gz"
  APP_CHECKSUM="a48df4938363d82ef7d362c8fdf519b8f65adcd1a95575c23fb7be623c8352ed"
  APP_OSSREV="3143"
  APP_COMMENT="ERP/CRM web application"
  APP_USER="wawision"
  APP_GROUP="wawision"
  APP_USE_SYSTEM_ACCOUNTS="true"
  APP_HOME="/var/lib/wawision"
  APP_DIRMODE="755"

  # platform dependent values
  case "$(basename $(dirname ${jf}))" in
    redhat|centos|oracle|amazon)
      PLATFORM_SAMPLE="known"
      ;;
    *)
      PLATFORM_SAMPLE="unknown"
      ;;
  esac

  # generate json files
  echo "*** regen: ${jf}"
  {
    cat << EOF
/*
 * Cookbook Name:: @@JSON_COOKBOOK_NAME@@
 * Test:: @@JSON_FILE_NAME@@
 *
 * Author:: @@JSON_COOKBOOK_AUTHOR@@
 *
 * Copyright:: @@JSON_COOKBOOK_COPYRIGHT@@
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

{
  "wawision": {
    "install_method": "@@APP_INSTALL_METHOD@@",
    "version": "@@APP_VERSION@@",
    "server": "@@APP_SERVER@@",
    "source": "@@APP_SOURCE@@",
    "checksum": "@@APP_CHECKSUM@@",
    "ossrev": "@@APP_OSSREV@@",
    "comment": "@@APP_COMMENT@@",
    "user": "@@APP_USER@@",
    "group": "@@APP_GROUP@@",
    "use_system_accounts": @@APP_USE_SYSTEM_ACCOUNTS@@,
    "home": "@@APP_HOME@@",
    "dirmode": "@@APP_DIRMODE@@"
  }
}

// vim: ts=2 sts=2 sw=2 ai si et ft=javascript
EOF
  } | sed \
    -e "s|@@JSON_FILE_NAME@@|${JSON_FILE_NAME}|g" \
    -e "s|@@JSON_COOKBOOK_NAME@@|${JSON_COOKBOOK_NAME}|g" \
    -e "s|@@JSON_COOKBOOK_AUTHOR@@|${JSON_COOKBOOK_AUTHOR}|g" \
    -e "s|@@JSON_COOKBOOK_COPYRIGHT@@|${JSON_COOKBOOK_COPYRIGHT}|g" \
    -e "s|@@APP_INSTALL_METHOD@@|${APP_INSTALL_METHOD}|g" \
    -e "s|@@APP_VERSION@@|${APP_VERSION}|g" \
    -e "s|@@APP_SERVER@@|${APP_SERVER}|g" \
    -e "s|@@APP_SOURCE@@|${APP_SOURCE}|g" \
    -e "s|@@APP_CHECKSUM@@|${APP_CHECKSUM}|g" \
    -e "s|@@APP_OSSREV@@|${APP_OSSREV}|g" \
    -e "s|@@APP_COMMENT@@|${APP_COMMENT}|g" \
    -e "s|@@APP_USER@@|${APP_USER}|g" \
    -e "s|@@APP_GROUP@@|${APP_GROUP}|g" \
    -e "s|@@APP_USE_SYSTEM_ACCOUNTS@@|${APP_USE_SYSTEM_ACCOUNTS}|g" \
    -e "s|@@APP_HOME@@|${APP_HOME}|g" \
    -e "s|@@APP_DIRMODE@@|${APP_DIRMODE}|g" \
    -e "s|@@PLATFORM_SAMPLE@@|${PLATFORM_SAMPLE}|g" \
    > ${jf}

done

# vim: ts=2 sts=2 sw=2 ai si et ft=sh
