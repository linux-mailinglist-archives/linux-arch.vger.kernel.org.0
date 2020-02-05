Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC5B1526FA
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 08:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBEHbh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 02:31:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39004 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBEHbh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 02:31:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so516816plp.6
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2020 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPfgMJ4whYlDNg51uPEu7Wqa2lUjKNAf/x39mbVIwkk=;
        b=dDNLjnvLZS3dMVS5LIXM8zOh9jK7OQiTTl+c96u9zHQq9ompdRdLO86ZEcYf3nt2bX
         KTDMiQEUx9sVwSdcBbJ2rsdcaufyKsXjYbhayrUSNU242+E7d9qH0t+3BehKu2ESgtyy
         s2FH8LpxQv1IeNcTrfw+84wLTS+3YxRLirrhvgD1cGUSdB96eA15umN0XNkdWgZurV9X
         FmdyavBH3eKPw4TX/CCf/1ZlRy4+pdWk6RBvi3U1BaXE/A0Na3AgWN/dF7py1Fr2Y/kW
         KS/gN2vXxUQpWLo/K9V6P0NDYKlxTi9OQ/SZodOMs9N9XX/W+SGCimic9PqdiPuhVBkB
         F2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPfgMJ4whYlDNg51uPEu7Wqa2lUjKNAf/x39mbVIwkk=;
        b=DIhQbbJgfseTOoC2fJi07aYS0hx3+Gjk6cuJCpYAFpgWEXsdrcup7wNCDVIrT/96R8
         /yokPeyYYIT4jIyU6Ctmxe18mH8veg3Q9sB+8Ry7q+Z+WibZrzzqgfSPhbTu9NndqI7l
         pb7kOfOc/dvCuaTIKpzFnAoT+0+OR+hfCtCmAmyuQoLY6qBM9q4qynmPLBGVHBVUiPZS
         +2muUKNkMhaPOl03oUmxYzkvm/wQVOTx2PC4iluvmqvaHEJWmQeYLzS0TuyU8XxQWBfq
         BzPsdSpln6swV2MjX7DoRhPpxyveoPLkVOJtLEEFlgggW2uKunsjZSKtoCX3l+UoRn1Y
         NH3A==
X-Gm-Message-State: APjAAAWLpiPuHjMblOfL0Knb0GNEKlAn11lT1ELFAnHZ0zxqCoGKEhOT
        aqGq0gfDn0Y/tV88yZlMgctdrWxGYBI=
X-Google-Smtp-Source: APXvYqxGczZYLAR8Bo8g1euu2i4lJIRcxte+MEVwWfElBDYXU9h6hJV9afJDSeT05AQhzq4f1boueg==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr4151896pju.57.1580887896181;
        Tue, 04 Feb 2020 23:31:36 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id u12sm26606555pfm.165.2020.02.04.23.31.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Feb 2020 23:31:35 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id E9D912025730AB; Wed,  5 Feb 2020 16:31:33 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v3 23/26] um lkl: add CI scripts to conduct regression tests
Date:   Wed,  5 Feb 2020 16:30:32 +0900
Message-Id: <1a518410ecf1b5efe341841931f7d6a913638786.1580882335.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1580882335.git.thehajime@gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For the continuous integration (CI), we use CircleCI with multiple test
targets triggered with a single commit.  The test also conducts memory
checks using valgrind in order to prevent enbug.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 .circleci/config.yml             | 196 +++++++++++++++++++++++++++++++
 tools/lkl/scripts/checkpatch.sh  |  60 ++++++++++
 tools/lkl/scripts/lkl-jenkins.sh |  21 ++++
 3 files changed, 277 insertions(+)
 create mode 100644 .circleci/config.yml
 create mode 100755 tools/lkl/scripts/checkpatch.sh
 create mode 100755 tools/lkl/scripts/lkl-jenkins.sh

diff --git a/.circleci/config.yml b/.circleci/config.yml
new file mode 100644
index 000000000000..5bdf059014c0
--- /dev/null
+++ b/.circleci/config.yml
@@ -0,0 +1,196 @@
+version: 2
+general:
+  artifacts:
+
+do_steps: &do_steps
+ steps:
+  - run: echo "$CROSS_COMPILE" > ~/_cross_compile
+  - restore_cache:
+      key: code-tree-shallow-{{ .Environment.CACHE_VERSION }}
+  - run:
+      name: checkout build tree
+      command: |
+        mkdir -p ~/.ssh/
+        ssh-keyscan -H github.com >> ~/.ssh/known_hosts
+        if ! [ -d .git ]; then
+          git clone --depth=1 $CIRCLE_REPOSITORY_URL .;
+        fi
+        if [[ $CIRCLE_BRANCH == pull/* ]]; then
+           git fetch --depth=1 origin $CIRCLE_BRANCH/head;
+        else
+           git fetch --depth=1 origin $CIRCLE_BRANCH;
+        fi
+        git reset --hard $CIRCLE_SHA1
+  - save_cache:
+      key: code-tree-shallow-{{ .Environment.CACHE_VERSION }}-{{ epoch }}
+      paths:
+        - /home/ubuntu/project/.git
+  - run:
+      name: clean
+      command: |
+        make mrproper
+        cd tools/lkl && make clean-conf
+        rm -rf ~/junit
+  - run: mkdir -p /home/ubuntu/.ccache
+  - restore_cache:
+      key: compiler-cache-{{ checksum "~/_cross_compile" }}-{{ .Environment.CACHE_VERSION }}
+  - run: cd tools/lkl && make -j8 ${MKARG}
+  - run: mkdir -p ~/destdir && cd tools/lkl && make DESTDIR=~/destdir
+  - save_cache:
+     paths:
+       - /home/ubuntu/.ccache
+     key: compiler-cache-{{ checksum "~/_cross_compile" }}-{{ .Environment.CACHE_VERSION }}-{{ epoch }}
+  - run:
+      name: run tests
+      command: |
+        mkdir -p ~/junit
+        make -C tools/lkl run-tests tests="--junit-dir ~/junit"
+      no_output_timeout: "90m"
+  - run:
+      name: collecting test results
+      command: |
+        find ./tools/lkl/ -type f -name "*.xml" -exec mv {} ~/junit/ \;
+  - store_test_results:
+      path: ~/junit
+  - store_artifacts:
+      path: ~/junit
+
+
+do_uml_steps: &do_uml_steps
+ steps:
+  - run: echo "$CROSS_COMPILE" > ~/_cross_compile
+  - restore_cache:
+      key: code-tree-shallow-{{ .Environment.CACHE_VERSION }}
+  - run:
+      name: checkout build tree
+      command: |
+        mkdir -p ~/.ssh/
+        ssh-keyscan -H github.com >> ~/.ssh/known_hosts
+        if ! [ -d .git ]; then
+          git clone --depth=1 $CIRCLE_REPOSITORY_URL .;
+        fi
+        if [[ $CIRCLE_BRANCH == pull/* ]]; then
+           git fetch --depth=1 origin $CIRCLE_BRANCH/head;
+        else
+           git fetch --depth=1 origin $CIRCLE_BRANCH;
+        fi
+        git reset --hard $CIRCLE_SHA1
+  - save_cache:
+      key: code-tree-shallow-{{ .Environment.CACHE_VERSION }}-{{ epoch }}
+      paths:
+        - /home/ubuntu/project/.git
+  - run: mkdir -p /home/ubuntu/.ccache
+  - restore_cache:
+      key: compiler-cache-{{ checksum "~/_cross_compile" }}-{{ .Environment.CACHE_VERSION }}
+  - run:
+      name: build
+      command: |
+        sudo apt-get update
+        sudo apt-get install -y gcc-multilib g++-multilib
+        make defconfig ARCH=um SUBARCH=$SUBARCH
+        make ARCH=um SUBARCH=$SUBARCH
+  - save_cache:
+     paths:
+       - /home/ubuntu/.ccache
+     key: compiler-cache-{{ checksum "~/_cross_compile" }}-{{ .Environment.CACHE_VERSION }}-{{ epoch }}
+  - run:
+      name: test
+      command: |
+        # XXX: i386 build doesn't work with the test
+        if [ $CIRCLE_STAGE = "i386_uml" ] || [ $CIRCLE_STAGE = "i386_uml_on_x86_64" ]; then
+          exit 0
+        fi
+        ./linux rootfstype=hostfs ro mem=1g loglevel=10 init="/bin/bash -c exit" || export RETVAL=$?
+        # SIGABRT=6 => 128+6
+        if [ $RETVAL != "134" ]; then
+          exit 1
+        fi
+
+## Customize the test machine
+jobs:
+  x86_64:
+   docker:
+     - image: lkldocker/circleci-x86_64:0.7
+   environment:
+     CROSS_COMPILE: ""
+   <<: *do_steps
+
+  i386:
+   docker:
+     - image: lkldocker/circleci-i386:0.1
+   environment:
+     CROSS_COMPILE: ""
+   <<: *do_steps
+
+  x86_64_valgrind:
+   docker:
+     - image: lkldocker/circleci-x86_64:0.7
+   environment:
+     CROSS_COMPILE: ""
+     VALGRIND: 1
+   <<: *do_steps
+
+  x86_64_uml:
+   docker:
+     - image: lkldocker/circleci-x86_64:0.7
+   environment:
+     CROSS_COMPILE: ""
+     TMPDIR: "/tmp" # required for not using /dev/shm
+     SUBARCH: "x86_64"
+   <<: *do_uml_steps
+
+  i386_uml:
+   docker:
+     - image: lkldocker/circleci-i386:0.1
+   environment:
+     CROSS_COMPILE: ""
+     SUBARCH: "i386"
+     TMPDIR: "/tmp" # required for not using /dev/shm
+   <<: *do_uml_steps
+
+  i386_uml_on_x86_64:
+   docker:
+     - image: lkldocker/circleci-x86_64:0.7
+   environment:
+     CROSS_COMPILE: ""
+     TMPDIR: "/tmp" # required for not using /dev/shm
+     SUBARCH: "i386"
+   <<: *do_uml_steps
+
+  checkpatch:
+   docker:
+     - image: lkldocker/circleci:0.5
+   environment:
+   steps:
+     - restore_cache:
+        key: code-tree-full-history-{{ .Environment.CACHE_VERSION }}
+     - checkout
+     - run: sudo pip install ply
+     - run: tools/lkl/scripts/checkpatch.sh
+     - save_cache:
+        key: code-tree-full-history-{{ .Environment.CACHE_VERSION }}-{{ epoch }}
+        paths:
+          - /home/ubuntu/project/.git
+        when: always
+
+workflows:
+  version: 2
+  build:
+    jobs:
+     - x86_64
+     - x86_64_valgrind
+     - checkpatch
+     - i386
+     - x86_64_uml
+     - i386_uml
+     - i386_uml_on_x86_64
+  nightly:
+    triggers:
+      - schedule:
+          cron: "0 0 * * *"
+          filters:
+            branches:
+              only:
+                - master
+    jobs:
+      - x86_64_valgrind
diff --git a/tools/lkl/scripts/checkpatch.sh b/tools/lkl/scripts/checkpatch.sh
new file mode 100755
index 000000000000..0c02ca6b21a2
--- /dev/null
+++ b/tools/lkl/scripts/checkpatch.sh
@@ -0,0 +1,60 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -z "$origin_master" ]; then
+    origin_master="origin/master"
+fi
+
+UPSTREAM=git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
+LKL=github.com:lkl/linux.git
+
+upstream=`git remote -v | grep $UPSTREAM | cut -f1 | head -n1`
+lkl=`git remote -v | grep $LKL | cut -f1 | head -n1`
+
+if [ -z "$upstream" ]; then
+    git fetch --tags --progress git://$UPSTREAM
+else
+    git fetch --tags $upstream
+fi
+
+if [ -z "$lkl" ]; then
+    git remote add lkl-upstream git@$LKL || true
+    lkl=`git remote -v | grep $LKL | cut -f1 | head -n1`
+fi
+
+if [ -z "$lkl" ]; then
+    echo "can't find lkl remote, quiting"
+    exit 1
+fi
+
+git fetch $lkl
+git fetch --tags $upstream
+
+# find the last upstream tag to avoid checking upstream commits during
+# upstream merges
+tag=`git tag --sort='-*authordate' | grep ^v | head -n1`
+tmp=`mktemp -d`
+
+commits=$(git log --no-merges --pretty=format:%h HEAD ^$lkl/master ^$tag)
+for c in $commits; do
+    git format-patch -1 -o $tmp $c
+done
+
+if [ -z "$c" ]; then
+    echo "there are not commits/patches to check, quiting."
+    rmdir $tmp
+    exit 0
+fi
+
+./scripts/checkpatch.pl --ignore FILE_PATH_CHANGES $tmp/*.patch
+rm $tmp/*.patch
+
+# checkpatch.pl does not know how to deal with 3 way diffs which would
+# be useful to check the conflict resolutions during merges...
+#for c in `git log --merges --pretty=format:%h HEAD ^$origin_master ^$tag`; do
+#    git log --pretty=email $c -1 > $tmp/$c.patch
+#    git diff $c $c^1 $c^2 >> $tmp/$c.patch
+#done
+
+rmdir $tmp
+
diff --git a/tools/lkl/scripts/lkl-jenkins.sh b/tools/lkl/scripts/lkl-jenkins.sh
new file mode 100755
index 000000000000..eaadc6e90143
--- /dev/null
+++ b/tools/lkl/scripts/lkl-jenkins.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+script_dir=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
+basedir=$(cd $script_dir/../../..; pwd)
+
+export PATH=$PATH:/sbin
+
+build_and_test()
+{
+    cd $basedir
+    make mrproper
+    cd tools/lkl
+    make clean-conf
+    make -j4
+    make run-tests
+}
+
+build_and_test
-- 
2.21.0 (Apple Git-122.2)

