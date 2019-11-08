Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E68F3F57
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfKHFE1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:27 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46621 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKHFE1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so3814831pfc.13
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fks9wSbUJ+kC5hvrb/d3gYtZgeZ3GOt0V9E8ftVXrv0=;
        b=jif0I7BBFZV/PvH3i2IiQVMhDzZvf9rW67+2kDSO87msB0VWxjSpUyneqxmNh1uZCg
         PcOPu34wK0Ld/MpSs5anDqUMLXsTGBzZJU3rCdCCmq4KF7bjLOGCpmbwsjqJafVzjWQr
         QYBF3Tb1gBPuz8rEZ/HCnpi55qyP1oQiaeFC5rNUyiE+NQknyo2XAtx9LoEaflYzdqyL
         9yFjZyzYoP4ds/3tlROvHb62wJEG3YXAJJzzm/tlLUTnPPo9VQ2N8wDO++vkIxN5w3Zk
         YRMriLr/K88cQxJ202zFrJKXXuQYQ+pRmb3gurRJK4zdgp+b4CMzs5ifx3O9usZy8cRK
         7TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fks9wSbUJ+kC5hvrb/d3gYtZgeZ3GOt0V9E8ftVXrv0=;
        b=aWNJaXe6YhBV3xI+nhoivvzQIcV9GSuyfJw0yftpYgrT+ZTt8svFoKnqXr9FqMNMce
         ZWw60MlY/1u/f608rV6ZK5jV3WESCAycHpXGZYdaGjvbABx04YGu2ntGk1aG9Jvps5qW
         +lK4WobBSJZhS0lFoUWUuH9gJ/qXBuT222UGDMxu2iHCGDcLBUhk4dOqDmUP8w7FkukB
         8nFVtg7Irq9Z02+YjlfW2otwa4DkUIhEXj/3+iLwtlXCvXe7aJYa5TS05N+QnGCKgpCl
         k1i5rX9d87ta0YP/5bnH3mVipuqLxj53H43kYMvt7M9e8fuBtok+NTpNIs28JgiiYes9
         HfHA==
X-Gm-Message-State: APjAAAV/4Mj7gMd+6Oref4B0w1PxRoiGxtk2IGVT8drzlYx+3rgHJ5pe
        4P85ROPM/F2VxhmIQ9nldHg=
X-Google-Smtp-Source: APXvYqzighXCDmZ62e/x8lyMtbNIM5EN72p6qguyakenljWjbCFfBBdjlipHJYybk0yfCfDGnnXK+A==
X-Received: by 2002:a63:4206:: with SMTP id p6mr9277702pga.270.1573189466275;
        Thu, 07 Nov 2019 21:04:26 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id fz12sm3627791pjb.15.2019.11.07.21.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:24 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id D939C201ACFEB8; Fri,  8 Nov 2019 14:04:22 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 34/37] lkl: Android ARM (arm/arm64) support
Date:   Fri,  8 Nov 2019 14:02:49 +0900
Message-Id: <ec1915b36d1e4de138bfad60862beaaef0b47274.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Initial attempt to run an application with hijack library on Android
platform.  Tested mostly on Android 6.x and 7.x.

The build process assumes that the android ndk toolchain is installed in
a host system. arm32 build is required to use alternate linker in order
to avoid a link issue during the build (described in *1).

*1
https://github.com/lkl/linux/issues/59#issuecomment-308961122

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/lkl/Kconfig            |  1 +
 tools/lkl/Makefile.autoconf    |  7 +++-
 tools/lkl/lib/hijack/hijack.c  | 13 ++++++++
 tools/lkl/lib/hijack/init.c    | 11 ++++++
 tools/lkl/tests/disk.sh        | 11 +++++-
 tools/lkl/tests/hijack-test.sh | 43 ++++++++++++++++++------
 tools/lkl/tests/test.sh        | 61 +++++++++++++++++++++++++++++++++-
 7 files changed, 134 insertions(+), 13 deletions(-)

diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index 1629e2679b75..fc501b64a2af 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -23,6 +23,7 @@ config LKL
        select 64BIT if "$(OUTPUT_FORMAT)" = "pe-x86-64"
        select HAVE_UNDERSCORE_SYMBOL_PREFIX if "$(OUTPUT_FORMAT)" = "pe-i386"
        select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-x86-64-freebsd"
+       select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-littleaarch64"
        select NET
        select MULTIUSER
        select INET
diff --git a/tools/lkl/Makefile.autoconf b/tools/lkl/Makefile.autoconf
index 1631f5cc25ac..7222a95c314f 100644
--- a/tools/lkl/Makefile.autoconf
+++ b/tools/lkl/Makefile.autoconf
@@ -1,4 +1,4 @@
-POSIX_HOSTS=elf64-x86-64 elf32-i386 elf64-x86-64-freebsd
+POSIX_HOSTS=elf64-x86-64 elf32-i386 elf64-x86-64-freebsd elf32-littlearm elf64-littleaarch64
 NT_HOSTS=pe-i386 pe-x86-64
 
 define set_autoconf_var
@@ -17,6 +17,10 @@ define is_defined
 $(shell $(CC) -dM -E - </dev/null | grep $(1))
 endef
 
+define android_host
+  $(call set_autoconf_var,ANDROID,y)
+endef
+
 define bsd_host
   $(call set_autoconf_var,BSD,y)
 endef
@@ -54,6 +58,7 @@ define posix_host
   LDFLAGS += -pie
   CFLAGS += -fPIC -pthread
   SOSUF := .so
+  $(if $(call is_defined,__ANDROID__),$(call android_host),LDLIBS += -lrt -lpthread)
   $(if $(filter $(1),elf64-x86-64-freebsd),$(call bsd_host))
   $(if $(filter $(1),elf32-littlearm),$(call arm_host))
   $(if $(filter $(1),elf64-littleaarch64),$(call aarch64_host))
diff --git a/tools/lkl/lib/hijack/hijack.c b/tools/lkl/lib/hijack/hijack.c
index 485c15d7c279..3a95b9dbe88b 100644
--- a/tools/lkl/lib/hijack/hijack.c
+++ b/tools/lkl/lib/hijack/hijack.c
@@ -204,7 +204,11 @@ int socket(int domain, int type, int protocol)
 }
 
 HOST_CALL(ioctl);
+#ifdef __ANDROID__
+int ioctl(int fd, int req, ...)
+#else
 int ioctl(int fd, unsigned long req, ...)
+#endif
 {
 	va_list vl;
 	long arg;
@@ -586,6 +590,15 @@ void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
 	return lkl_sys_mmap(addr, length, prot, flags, fd, offset);
 }
 
+#ifndef __ANDROID__
+HOST_CALL(__xstat64)
+int stat(const char *pathname, struct stat *buf)
+{
+	CHECK_HOST_CALL(__xstat64);
+	return host___xstat64(0, pathname, buf);
+}
+#endif
+
 ssize_t send(int fd, const void *buf, size_t len, int flags)
 {
 	return sendto(fd, buf, len, flags, 0, 0);
diff --git a/tools/lkl/lib/hijack/init.c b/tools/lkl/lib/hijack/init.c
index 2145fb7ec2cb..de00f2018e59 100644
--- a/tools/lkl/lib/hijack/init.c
+++ b/tools/lkl/lib/hijack/init.c
@@ -170,6 +170,17 @@ hijack_init(void)
 	if (single_cpu_mode == 1)
 		PinToFirstCpu(&ori_cpu);
 
+#ifdef __ANDROID__
+	struct sigaction sa;
+
+	sa.sa_handler = SIG_IGN;
+	sa.sa_flags = 0;
+	if (sigaction(32, &sa, 0) == -1) {
+		perror("sigaction");
+		exit(1);
+	}
+#endif
+
 	ret = lkl_start_kernel(&lkl_host_ops, cfg->boot_cmdline);
 	if (ret) {
 		fprintf(stderr, "can't start kernel: %s\n", lkl_strerror(ret));
diff --git a/tools/lkl/tests/disk.sh b/tools/lkl/tests/disk.sh
index 9bdcb16f2d5c..e2ec6cf69d4b 100755
--- a/tools/lkl/tests/disk.sh
+++ b/tools/lkl/tests/disk.sh
@@ -15,6 +15,12 @@ function prepfs()
 
     yes | mkfs.$1 $file
 
+    if ! [ -z $ANDROID_WDIR ]; then
+        adb shell mkdir -p $ANDROID_WDIR
+        adb push $file $ANDROID_WDIR
+        rm $file
+        file=$ANDROID_WDIR/$(basename $file)
+    fi
     if ! [ -z $BSD_WDIR ]; then
         $MYSSH mkdir -p $BSD_WDIR
         ssh_copy $file $BSD_WDIR
@@ -29,7 +35,10 @@ function cleanfs()
 {
     set -e
 
-    if ! [ -z $BSD_WDIR ]; then
+    if ! [ -z $ANDROID_WDIR ]; then
+        adb shell rm $1
+        adb shell rm $ANDROID_WDIR/disk
+    elif ! [ -z $BSD_WDIR ]; then
         $MYSSH rm $1
         $MYSSH rm $BSD_WDIR/disk
     else
diff --git a/tools/lkl/tests/hijack-test.sh b/tools/lkl/tests/hijack-test.sh
index 097af6cff3ba..a62aa5b251e0 100755
--- a/tools/lkl/tests/hijack-test.sh
+++ b/tools/lkl/tests/hijack-test.sh
@@ -15,7 +15,11 @@ set_cfgjson()
 {
     cfgjson=${wdir}/hijack-test$1.conf
 
-    cat > ${cfgjson}
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        adb shell cat \> ${cfgjson}
+    else
+        cat > ${cfgjson}
+    fi
 
     export_vars cfgjson
 }
@@ -54,6 +58,11 @@ test_mount_and_dump()
 {
     set -e
 
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        echo "TODO: android-23 doesn't call destructor..."
+        return $TEST_SKIP
+    fi
+
     set_cfgjson << EOF
     {
         "mount":"proc,sysfs",
@@ -377,6 +386,10 @@ test_tap_qdisc()
 {
     set -e
 
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        return $TEST_SKIP
+    fi
+
     set_cfgjson << EOF
     {
         "gateway":"$(ip_host)",
@@ -655,15 +668,25 @@ if [[ ! -e ${basedir}/lib/hijack/liblkl-hijack.so ]]; then
     exit 0
 fi
 
-# Make a temporary directory to run tests in, since we'll be copying
-# things there.
-wdir=$(mktemp -d)
-cp `which ping` ${wdir}
-cp `which ping6` ${wdir}
-ping=${wdir}/ping
-ping6=${wdir}/ping6
-hijack=$basedir/bin/lkl-hijack.sh
-netperf=$basedir/tests/run_netperf.sh
+if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+    wdir=$ANDROID_WDIR
+    adb_push lib/hijack/liblkl-hijack.so bin/lkl-hijack.sh tests/net-setup.sh \
+             tests/run_netperf.sh tests/hijack-test.sh
+    ping="ping"
+    ping6="ping6"
+    hijack="$wdir/bin/lkl-hijack.sh"
+    netperf="$wdir/tests/run_netperf.sh"
+else
+    # Make a temporary directory to run tests in, since we'll be copying
+    # things there.
+    wdir=$(mktemp -d)
+    cp `which ping` ${wdir}
+    cp `which ping6` ${wdir}
+    ping=${wdir}/ping
+    ping6=${wdir}/ping6
+    hijack=$basedir/bin/lkl-hijack.sh
+    netperf=$basedir/tests/run_netperf.sh
+fi
 
 fifo1=${wdir}/fifo1
 fifo2=${wdir}/fifo2
diff --git a/tools/lkl/tests/test.sh b/tools/lkl/tests/test.sh
index cda932b98058..a40d08fd6185 100644
--- a/tools/lkl/tests/test.sh
+++ b/tools/lkl/tests/test.sh
@@ -100,6 +100,19 @@ lkl_test_exec()
 
     if file $file | grep PE32; then
         WRAPPER="wine"
+    elif file $file | grep "interpreter /system/bin/linker" ; then
+        adb push "$file" $ANDROID_WDIR
+        if [ -n "$SUDO" ]; then
+            ANDROID_USER=root
+            SUDO=""
+        fi
+        if [ -n "$ANDROID_USER" ]; then
+            SU="su $ANDROID_USER"
+        else
+            SU=""
+        fi
+        WRAPPER="adb shell $SU"
+        file=$ANDROID_WDIR/$(basename $file)
     elif file $file | grep ARM; then
         WRAPPER="qemu-arm-static"
     elif file $file | grep "FreeBSD" ; then
@@ -134,13 +147,48 @@ lkl_test_cmd()
         SHOPTS="-x"
     fi
 
-    if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
+    if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+        if [ "$1" = "sudo" ]; then
+            ANDROID_USER=root
+            shift
+        fi
+        if [ -n "$ANDROID_USER" ]; then
+            SU="su $ANDROID_USER"
+        else
+            SU=""
+        fi
+        WRAPPER="adb shell $SU"
+    elif [ -n "$LKL_HOST_CONFIG_BSD" ]; then
         WRAPPER="$MYSSH $SU"
     fi
 
     echo "$@" | $WRAPPER sh $SHOPTS
 }
 
+adb_push()
+{
+    while [ -n "$1" ]; do
+        if [[ "$1" = *.sh ]]; then
+            type="script"
+        else
+            type="file"
+        fi
+
+        dir=$(dirname $1)
+        adb shell mkdir -p $ANDROID_WDIR/$dir
+
+        if [ "$type" = "script" ]; then
+            sed "s/\/usr\/bin\/env bash/\/system\/bin\/sh/" $basedir/$1 | \
+                adb shell cat \> $ANDROID_WDIR/$1
+            adb shell chmod a+x $ANDROID_WDIR/$1
+        else
+            adb push $basedir/$1 $ANDROID_WDIR/$dir
+        fi
+
+        shift
+    done
+}
+
 # XXX: $MYSSH and $MYSCP are defined in a circleci docker image.
 # see the definitions in lkl/lkl-docker:circleci/freebsd11/Dockerfile
 ssh_push()
@@ -169,11 +217,22 @@ ssh_copy()
     $MYSCP -P 7722 -r $1 root@localhost:$2
 }
 
+lkl_test_android_cleanup()
+{
+    adb shell rm -rf $ANDROID_WDIR
+}
+
 lkl_test_bsd_cleanup()
 {
     $MYSSH rm -rf $BSD_WDIR
 }
 
+if [ -n "$LKL_HOST_CONFIG_ANDROID" ]; then
+    trap lkl_test_android_cleanup EXIT
+    export ANDROID_WDIR=/data/local/tmp/lkl
+    adb shell mkdir -p $ANDROID_WDIR
+fi
+
 if [ -n "$LKL_HOST_CONFIG_BSD" ]; then
     trap lkl_test_bsd_cleanup EXIT
     export BSD_WDIR=/root/lkl
-- 
2.20.1 (Apple Git-117)

