Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A08B867
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 14:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfHMMT5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 08:19:57 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:45382 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfHMMTz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Aug 2019 08:19:55 -0400
Received: by mail-yw1-f74.google.com with SMTP id z201so11923172ywz.12
        for <linux-arch@vger.kernel.org>; Tue, 13 Aug 2019 05:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V8gq4FEcRvbLdxBlRa7vcpMivgfsfciaemI15mBExE8=;
        b=J1JvF9/Z2E6HEZY+TmZUofDtVpYqdI1Gnm5upd1bRhepBQzP/0MOpUPhjTBa0sK1bM
         yPiLYl6iRvUCayu7p3gxzbDp9sNZcaCx3ab05pTSvMrczZoI6YXlQ3U0IcDE+357J3RY
         X9C1DD66+0XqJtZL8LLihrPhx8E5Z+d6wM3Do8UJKi0SZcCvM/F15c3S9YTT9nnBHd8j
         7W2frWldzYDzmJ9mvUrVRWR0McsxOSpeRfhYE7aUsQh05GTfldzSRbCt9ZIKakJPt2rI
         y0ElaN01C1QUNthrkdCq3dRAle2h0mWBfFDiGrVl44lhapY7B2M2bn1Z11MjBOmKOpHc
         h36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V8gq4FEcRvbLdxBlRa7vcpMivgfsfciaemI15mBExE8=;
        b=Vzg//jVuJOKRG/b0AXWOI/LjS5iis3DYWMa/p2nFDvddBiEk11yXeMDmBsP2hL8IeL
         RxFzgekxlgN//aMwj8la/ymXn4Co2/54qhoIyr2o7JFiTx0UJXiJHxxgj8gk+eVFe9Wt
         kOwfCEuQo3IBt3lfwoz7OUPe/2xk8JgJPxbjyXRxRqWNcY9ftkFXhxJ/A/5BoqkLFM7k
         Ug1n6Q0jZxgxUAE1dV+6wlv8Uvy0EOK7E38dPOlPa8Gt5SwAuGLnIVuWchrIGEcNS4Zu
         w7TBQaW3cs9QsQYzgTNmETJKR/PoVXFRZCRjMvxKSP36oDg7u/6uUGXwrM+5bij4Gim+
         Vk7w==
X-Gm-Message-State: APjAAAX4J68wkyoUu7XRQCjIWvm1WgIDMnBENYmGAltp7hDE5beQ9GO5
        Is/2HRwmMfpd9vGJLs2ADrXRTX4RIOnRLg==
X-Google-Smtp-Source: APXvYqzr+R60HKCBq8zqAVf9WoLkTltvWJTiXGuyjp0hn9fOEPZm43SVcLRaZeRrtkZ9UoKqq+lU4fJ2FxAweA==
X-Received: by 2002:a25:dc49:: with SMTP id y70mr24281522ybe.334.1565698793774;
 Tue, 13 Aug 2019 05:19:53 -0700 (PDT)
Date:   Tue, 13 Aug 2019 13:17:05 +0100
In-Reply-To: <20190813121733.52480-1-maennich@google.com>
Message-Id: <20190813121733.52480-9-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v2 08/10] scripts: Coccinelle script for namespace dependencies.
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org, maco@android.com
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        jeyu@kernel.org, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@google.com, michal.lkml@markovi.net, mingo@redhat.com,
        oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org,
        sboyd@codeaurora.org, sspatil@google.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        cocci@systeme.lip6.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A script that uses the '<module>.ns_deps' file generated by modpost to
automatically add the required symbol namespace dependencies to each
module.

Usage:
1) Move some symbols to a namespace with EXPORT_SYMBOL_NS() or define
   DEFAULT_SYMBOL_NAMESPACE
2) Run 'make' (or 'make modules') and get warnings about modules not
   importing that namespace.
3) Run 'make nsdeps' to automatically add required import statements
   to said modules.

This makes it easer for subsystem maintainers to introduce and maintain
symbol namespaces into their codebase.

Co-developed-by: Martijn Coenen <maco@android.com>
Signed-off-by: Martijn Coenen <maco@android.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 MAINTAINERS                                 |  5 ++
 Makefile                                    | 12 +++++
 scripts/Makefile.modpost                    |  4 +-
 scripts/coccinelle/misc/add_namespace.cocci | 23 +++++++++
 scripts/nsdeps                              | 54 +++++++++++++++++++++
 5 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
 create mode 100644 scripts/nsdeps

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..aa169070a052 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11414,6 +11414,11 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
 F:	tools/include/nolibc/
 
+NSDEPS
+M:	Matthias Maennich <maennich@google.com>
+S:	Maintained
+F:	scripts/nsdeps
+
 NTB AMD DRIVER
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	linux-ntb@googlegroups.com
diff --git a/Makefile b/Makefile
index 1b23f95db176..c5c3356e133c 100644
--- a/Makefile
+++ b/Makefile
@@ -1500,6 +1500,9 @@ help:
 	@echo  '  headerdep       - Detect inclusion cycles in headers'
 	@echo  '  coccicheck      - Check with Coccinelle'
 	@echo  ''
+	@echo  'Tools:'
+	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
+	@echo  ''
 	@echo  'Kernel selftest:'
 	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
 	@echo  '                    Build, install, and boot kernel before'
@@ -1687,6 +1690,15 @@ quiet_cmd_tags = GEN     $@
 tags TAGS cscope gtags: FORCE
 	$(call cmd,tags)
 
+# Script to generate missing namespace dependencies
+# ---------------------------------------------------------------------------
+
+PHONY += nsdeps
+
+nsdeps:
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
+
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 26e6574ecd08..743fe3a2e885 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -56,7 +56,8 @@ MODPOST = scripts/mod/modpost						\
 	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
-	$(if $(KBUILD_MODPOST_WARN),-w)
+	$(if $(KBUILD_MODPOST_WARN),-w)					\
+	$(if $(filter nsdeps,$(MAKECMDGOALS)),-d)
 
 ifdef MODPOST_VMLINUX
 
@@ -134,6 +135,7 @@ $(modules): %.ko :%.o %.mod.o FORCE
 
 targets += $(modules)
 
+nsdeps: __modpost
 
 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
new file mode 100644
index 000000000000..c832bb6445a8
--- /dev/null
+++ b/scripts/coccinelle/misc/add_namespace.cocci
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+/// Adds missing MODULE_IMPORT_NS statements to source files
+///
+/// This script is usually called from scripts/nsdeps with -D ns=<namespace> to
+/// add a missing namespace tag to a module source file.
+///
+
+@has_ns_import@
+declarer name MODULE_IMPORT_NS;
+identifier virtual.ns;
+@@
+MODULE_IMPORT_NS(ns);
+
+// Add missing imports, but only adjacent to a MODULE_LICENSE statement.
+// That ensures we are adding it only to the main module source file.
+@do_import depends on !has_ns_import@
+declarer name MODULE_LICENSE;
+expression license;
+identifier virtual.ns;
+@@
+MODULE_LICENSE(license);
++ MODULE_IMPORT_NS(ns);
diff --git a/scripts/nsdeps b/scripts/nsdeps
new file mode 100644
index 000000000000..148db65a830f
--- /dev/null
+++ b/scripts/nsdeps
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Linux kernel symbol namespace import generator
+#
+# This script requires at least spatch
+# version 1.0.4.
+SPATCH_REQ_VERSION="1.0.4"
+
+DIR="$(dirname $(readlink -f $0))/.."
+SPATCH="`which ${SPATCH:=spatch}`"
+if [ ! -x "$SPATCH" ]; then
+    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
+    exit 1
+fi
+
+SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
+SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
+SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
+
+if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
+    echo 'spatch needs to be version 1.06 or higher'
+    exit 1
+fi
+
+generate_deps_for_ns() {
+    $SPATCH --very-quiet --in-place --sp-file \
+	    $srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
+}
+
+generate_deps() {
+    local mod_file=`echo $@ | sed -e 's/\.ns_deps/\.mod/'`
+    local mod_name=`cat $mod_file | sed -n 1p | sed -e 's/\/[^.]*$//'`
+    local mod_source_files=`cat $mod_file | sed -n 2p | sed -e 's/\.o/\.c/g'`
+    for ns in `cat $@`; do
+	echo "Adding namespace $ns to module $mod_name (if needed)."
+        generate_deps_for_ns $ns $mod_source_files
+	# sort the imports
+        for source_file in $mod_source_files; do
+            sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
+            offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
+            cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
+            tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
+            if ! diff -q ${source_file} ${source_file}.tmp; then
+                mv ${source_file}.tmp ${source_file}
+            else
+                rm ${source_file}.tmp
+            fi
+        done
+    done
+}
+
+for f in `find $srctree/.tmp_versions/ -name *.ns_deps`; do
+    generate_deps $f
+done
-- 
2.23.0.rc1.153.gdeed80330f-goog

