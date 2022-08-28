Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9125A3B12
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 04:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiH1Cp7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 22:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiH1Cp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 22:45:58 -0400
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B8DF3B
        for <linux-arch@vger.kernel.org>; Sat, 27 Aug 2022 19:45:56 -0700 (PDT)
Received: from conuserg-11.nifty.com ([10.126.8.74])by condef-03.nifty.com with ESMTP id 27S2eonn018053
        for <linux-arch@vger.kernel.org>; Sun, 28 Aug 2022 11:40:50 +0900
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gn030639;
        Sun, 28 Aug 2022 11:40:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gn030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654409;
        bh=h8cc33O5fH+ce9OkOOKqDFD3WxGfcUP5sv1a7xwgUbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1gwWnJi8Qpng30JrLNAtQrbyQ8EU1cCiyLkux/mqCpsPh1VAJImiy1Q8+d2NchtyV
         rdt2z59XWfUq/SS6jBAp6+k00PxEF7rwZ8C8thh4VNR8n3+ZVPcZ9HKlqPbNSc/VNl
         +0jf4woFvBdWtfSafmzLxyChncrT/YThici123riMU/4qDc1TOQSLwopAtnnWdH4Kj
         QximtMwxODid7gUo3PhNW/PdVXSB4A83IlII+YknaWmYkD4Be+BbjZgCVaMeidimlm
         ET2dhr/C3KchLdOQxxxTxFEOfDTNuIVnytHRSyucBUQ3LTB9+L4KWpR4CrfbNqnpEi
         UIrHR9h3yd+vQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 05/15] kbuild: build init/built-in.a just once
Date:   Sun, 28 Aug 2022 11:39:53 +0900
Message-Id: <20220828024003.28873-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kbuild builds init/built-in.a twice; first during the ordinary
directory descending, second from scripts/link-vmlinux.sh.

We do this because UTS_VERSION contains the build version and the
timestamp. We cannot update it during the normal directory traversal
since we do not yet know if we need to update vmlinux. UTS_VERSION is
temporarily calculated, but omitted from the update check. Otherwise,
vmlinux would be rebuilt every time.

When Kbuild results in running link-vmlinux.sh, it increments the
version number in the .version file and takes the timestamp at that
time to really fix UTS_VERSION.

However, updating the same file twice is a footgun. To avoid nasty
timestamp issues, all build artifacts that depend on init/built-in.a
must be atomically generated in link-vmlinux.sh, where some of them
do not need rebuilding.

To fix this issue, this commit changes as follows:

[1] Split UTS_VERSION out to include/generated/utsversion.h from
    include/generated/compile.h

    include/generated/utsversion.h is generated just before the
    vmlinux link. It is generated under include/generated/ because
    some decompressors (s390, x86) use UTS_VERSION.

[2] Split init_uts_ns and linux_banner out to init/version-timestamp.c
    from init/version.c

    init_uts_ns and linux_banner contain UTS_VERSION. During the ordinary
    directory descending, they are compiled with __weak and used to
    determine if vmlinux needs relinking. Just before the vmlinux link,
    they are compiled without __weak to embed the real version and
    timestamp.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/s390/boot/version.c         |  1 +
 arch/x86/boot/compressed/kaslr.c |  1 +
 arch/x86/boot/version.c          |  1 +
 init/Makefile                    | 53 ++++++++++++++-----
 init/build-version               | 10 ++++
 init/version-timestamp.c         | 31 +++++++++++
 init/version.c                   | 36 +++++--------
 scripts/link-vmlinux.sh          | 17 ++----
 scripts/mkcompile_h              | 89 ++++----------------------------
 9 files changed, 112 insertions(+), 127 deletions(-)
 create mode 100755 init/build-version
 create mode 100644 init/version-timestamp.c

diff --git a/arch/s390/boot/version.c b/arch/s390/boot/version.c
index d32e58bdda6a..fd32f038777f 100644
--- a/arch/s390/boot/version.c
+++ b/arch/s390/boot/version.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <generated/utsversion.h>
 #include <generated/utsrelease.h>
 #include <generated/compile.h>
 #include "boot.h"
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4a3f223973f4..e476bcbd9b42 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -29,6 +29,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
+#include <generated/utsversion.h>
 #include <generated/utsrelease.h>
 
 #define _SETUP
diff --git a/arch/x86/boot/version.c b/arch/x86/boot/version.c
index a1aaaf6c06a6..945383f0f606 100644
--- a/arch/x86/boot/version.c
+++ b/arch/x86/boot/version.c
@@ -11,6 +11,7 @@
  */
 
 #include "boot.h"
+#include <generated/utsversion.h>
 #include <generated/utsrelease.h>
 #include <generated/compile.h>
 
diff --git a/init/Makefile b/init/Makefile
index d82623d7fc8e..63f53d210cad 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -19,20 +19,47 @@ mounts-y			:= do_mounts.o
 mounts-$(CONFIG_BLK_DEV_RAM)	+= do_mounts_rd.o
 mounts-$(CONFIG_BLK_DEV_INITRD)	+= do_mounts_initrd.o
 
-# dependencies on generated files need to be listed explicitly
-$(obj)/version.o: include/generated/compile.h
+#
+# UTS_VERSION
+#
+
+smp-flag-$(CONFIG_SMP)			:= SMP
+preempt-flag-$(CONFIG_PREEMPT_BUILD)	:= PREEMPT
+preempt-flag-$(CONFIG_PREEMPT_DYNAMIC)	:= PREEMPT_DYNAMIC
+preempt-flag-$(CONFIG_PREEMPT_RT)	:= PREEMPT_RT
+
+build-version = $(or $(KBUILD_BUILD_VERSION), $(build-version-auto))
+build-timestamp = $(or $(KBUILD_BUILD_TIMESTAMP), $(build-timestamp-auto))
+
+# Maximum length of UTS_VERSION is 64 chars
+filechk_uts_version = \
+	utsver=$$(echo '$(pound)'"$(build-version)" $(smp-flag-y) $(preempt-flag-y) "$(build-timestamp)" | cut -b -64); \
+	echo '$(pound)'define UTS_VERSION \""$${utsver}"\"
+
+#
+# Build version.c with temporary UTS_VERSION
+#
+
+$(obj)/utsversion-tmp.h: FORCE
+	$(call filechk,uts_version)
 
-# compile.h changes depending on hostname, generation number, etc,
-# so we regenerate it always.
-# mkcompile_h will make sure to only update the
-# actual file if its content has changed.
+$(obj)/version.o: include/generated/compile.h $(obj)/utsversion-tmp.h
+CFLAGS_version.o := -include $(obj)/utsversion-tmp.h
 
-quiet_cmd_compile.h = CHK     $@
-      cmd_compile.h = \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
-	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT_BUILD)"	\
-	"$(CONFIG_PREEMPT_DYNAMIC)" "$(CONFIG_PREEMPT_RT)" \
-	"$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
+filechk_compile.h = $(srctree)/scripts/mkcompile_h \
+	"$(UTS_MACHINE)" "$(CONFIG_CC_VERSION_TEXT)" "$(LD)"
 
 include/generated/compile.h: FORCE
-	$(call cmd,compile.h)
+	$(call filechk,compile.h)
+
+#
+# Build version-timestamp.c with final UTS_VERSION
+#
+
+include/generated/utsversion.h: build-version-auto = $(shell $(srctree)/$(src)/build-version)
+include/generated/utsversion.h: build-timestamp-auto = $(shell LC_ALL=C date)
+include/generated/utsversion.h: FORCE
+	$(call filechk,uts_version)
+
+$(obj)/version-timestamp.o: include/generated/utsversion.h
+CFLAGS_version-timestamp.o := -include include/generated/utsversion.h
diff --git a/init/build-version b/init/build-version
new file mode 100755
index 000000000000..39225104f14d
--- /dev/null
+++ b/init/build-version
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+VERSION=$(cat .version) 2>/dev/null &&
+VERSION=$(expr $VERSION + 1) 2>/dev/null ||
+VERSION=1
+
+echo ${VERSION} > .version
+
+echo ${VERSION}
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
new file mode 100644
index 000000000000..179e93bae539
--- /dev/null
+++ b/init/version-timestamp.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+#include <linux/version.h>
+#include <linux/proc_ns.h>
+#include <linux/refcount.h>
+#include <linux/uts.h>
+#include <linux/utsname.h>
+
+struct uts_namespace init_uts_ns = {
+	.ns.count = REFCOUNT_INIT(2),
+	.name = {
+		.sysname	= UTS_SYSNAME,
+		.nodename	= UTS_NODENAME,
+		.release	= UTS_RELEASE,
+		.version	= UTS_VERSION,
+		.machine	= UTS_MACHINE,
+		.domainname	= UTS_DOMAINNAME,
+	},
+	.user_ns = &init_user_ns,
+	.ns.inum = PROC_UTS_INIT_INO,
+#ifdef CONFIG_UTS_NS
+	.ns.ops = &utsns_operations,
+#endif
+};
+
+/* FIXED STRINGS! Don't touch! */
+const char linux_banner[] =
+	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
diff --git a/init/version.c b/init/version.c
index 3391c4051bf3..01d4ab05f0ba 100644
--- a/init/version.c
+++ b/init/version.c
@@ -18,24 +18,6 @@
 #include <generated/utsrelease.h>
 #include <linux/proc_ns.h>
 
-struct uts_namespace init_uts_ns = {
-	.ns.count = REFCOUNT_INIT(2),
-	.name = {
-		.sysname	= UTS_SYSNAME,
-		.nodename	= UTS_NODENAME,
-		.release	= UTS_RELEASE,
-		.version	= UTS_VERSION,
-		.machine	= UTS_MACHINE,
-		.domainname	= UTS_DOMAINNAME,
-	},
-	.user_ns = &init_user_ns,
-	.ns.inum = PROC_UTS_INIT_INO,
-#ifdef CONFIG_UTS_NS
-	.ns.ops = &utsns_operations,
-#endif
-};
-EXPORT_SYMBOL_GPL(init_uts_ns);
-
 static int __init early_hostname(char *arg)
 {
 	size_t bufsize = sizeof(init_uts_ns.name.nodename);
@@ -51,11 +33,6 @@ static int __init early_hostname(char *arg)
 }
 early_param("hostname", early_hostname);
 
-/* FIXED STRINGS! Don't touch! */
-const char linux_banner[] =
-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
-
 const char linux_proc_banner[] =
 	"%s version %s"
 	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
@@ -63,3 +40,16 @@ const char linux_proc_banner[] =
 
 BUILD_SALT;
 BUILD_LTO_INFO;
+
+/*
+ * init_uts_ns and linux_banner contain the build version and timestamp,
+ * which are really fixed at the very last step of build process.
+ * They are compiled with __weak first, and without __weak later.
+ */
+
+struct uts_namespace init_uts_ns __weak;
+const char linux_banner[] __weak;
+
+#include "version-timestamp.c"
+
+EXPORT_SYMBOL_GPL(init_uts_ns);
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index eecc1863e556..8d982574145a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -75,6 +75,8 @@ vmlinux_link()
 		objs="${objs} .vmlinux.export.o"
 	fi
 
+	objs="${objs} init/version-timestamp.o"
+
 	if [ "${SRCARCH}" = "um" ]; then
 		wl=-Wl,
 		ld="${CC}"
@@ -213,19 +215,6 @@ if [ "$1" = "clean" ]; then
 	exit 0
 fi
 
-# Update version
-info GEN .version
-if [ -r .version ]; then
-	VERSION=$(expr 0$(cat .version) + 1)
-	echo $VERSION > .version
-else
-	rm -f .version
-	echo 1 > .version
-fi;
-
-# final build of init/
-${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
-
 #link vmlinux.o
 ${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
 
@@ -260,6 +249,8 @@ if is_enabled CONFIG_MODULES; then
 	${MAKE} -f "${srctree}/scripts/Makefile.vmlinux" .vmlinux.export.o
 fi
 
+${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init init/version-timestamp.o
+
 btf_vmlinux_bin_o=""
 if is_enabled CONFIG_DEBUG_INFO_BTF; then
 	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index ca40a5258c87..f1a820d49e53 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -1,14 +1,9 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-TARGET=$1
-ARCH=$2
-SMP=$3
-PREEMPT=$4
-PREEMPT_DYNAMIC=$5
-PREEMPT_RT=$6
-CC_VERSION="$7"
-LD=$8
+UTS_MACHINE=$1
+CC_VERSION="$2"
+LD=$3
 
 # Do not expand names
 set -f
@@ -17,17 +12,6 @@ set -f
 LC_ALL=C
 export LC_ALL
 
-if [ -z "$KBUILD_BUILD_VERSION" ]; then
-	VERSION=$(cat .version 2>/dev/null || echo 1)
-else
-	VERSION=$KBUILD_BUILD_VERSION
-fi
-
-if [ -z "$KBUILD_BUILD_TIMESTAMP" ]; then
-	TIMESTAMP=`date`
-else
-	TIMESTAMP=$KBUILD_BUILD_TIMESTAMP
-fi
 if test -z "$KBUILD_BUILD_USER"; then
 	LINUX_COMPILE_BY=$(whoami | sed 's/\\/\\\\/')
 else
@@ -39,63 +23,12 @@ else
 	LINUX_COMPILE_HOST=$KBUILD_BUILD_HOST
 fi
 
-UTS_VERSION="#$VERSION"
-CONFIG_FLAGS=""
-if [ -n "$SMP" ] ; then CONFIG_FLAGS="SMP"; fi
-
-if [ -n "$PREEMPT_RT" ] ; then
-	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_RT"
-elif [ -n "$PREEMPT_DYNAMIC" ] ; then
-	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT_DYNAMIC"
-elif [ -n "$PREEMPT" ] ; then
-	CONFIG_FLAGS="$CONFIG_FLAGS PREEMPT"
-fi
-
-# Truncate to maximum length
-UTS_LEN=64
-UTS_VERSION="$(echo $UTS_VERSION $CONFIG_FLAGS $TIMESTAMP | cut -b -$UTS_LEN)"
-
-# Generate a temporary compile.h
-
-{ echo /\* This file is auto generated, version $VERSION \*/
-  if [ -n "$CONFIG_FLAGS" ] ; then echo "/* $CONFIG_FLAGS */"; fi
+LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
+	      | sed 's/[[:space:]]*$//')
 
-  echo \#define UTS_MACHINE \"$ARCH\"
-
-  echo \#define UTS_VERSION \"$UTS_VERSION\"
-
-  printf '#define LINUX_COMPILE_BY "%s"\n' "$LINUX_COMPILE_BY"
-  echo \#define LINUX_COMPILE_HOST \"$LINUX_COMPILE_HOST\"
-
-  LD_VERSION=$($LD -v | head -n1 | sed 's/(compatible with [^)]*)//' \
-		      | sed 's/[[:space:]]*$//')
-  printf '#define LINUX_COMPILER "%s"\n' "$CC_VERSION, $LD_VERSION"
-} > .tmpcompile
-
-# Only replace the real compile.h if the new one is different,
-# in order to preserve the timestamp and avoid unnecessary
-# recompilations.
-# We don't consider the file changed if only the date/time changed,
-# unless KBUILD_BUILD_TIMESTAMP was explicitly set (e.g. for
-# reproducible builds with that value referring to a commit timestamp).
-# A kernel config change will increase the generation number, thus
-# causing compile.h to be updated (including date/time) due to the
-# changed comment in the
-# first line.
-
-if [ -z "$KBUILD_BUILD_TIMESTAMP" ]; then
-   IGNORE_PATTERN="UTS_VERSION"
-else
-   IGNORE_PATTERN="NOT_A_PATTERN_TO_BE_MATCHED"
-fi
-
-if [ -r $TARGET ] && \
-      grep -v $IGNORE_PATTERN $TARGET > .tmpver.1 && \
-      grep -v $IGNORE_PATTERN .tmpcompile > .tmpver.2 && \
-      cmp -s .tmpver.1 .tmpver.2; then
-   rm -f .tmpcompile
-else
-   echo "  UPD     $TARGET"
-   mv -f .tmpcompile $TARGET
-fi
-rm -f .tmpver.1 .tmpver.2
+cat <<EOF
+#define UTS_MACHINE		"${UTS_MACHINE}"
+#define LINUX_COMPILE_BY	"${LINUX_COMPILE_BY}"
+#define LINUX_COMPILE_HOST	"${LINUX_COMPILE_HOST}"
+#define LINUX_COMPILER		"${CC_VERSION}, ${LD_VERSION}"
+EOF
-- 
2.34.1

