Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E10A19AC
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfH2MN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 08:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfH2MN2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 08:13:28 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF5B2080F;
        Thu, 29 Aug 2019 12:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567080806;
        bh=AFQuEm5j/88hnPHuIBzauyUThuB0LpyoGrOwRmqq/UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNTXG/edNoXU8t/0AGmHHS/MbwWXy/p733THVI1wX6vUc2g4V91b9UU+NWDZrM3G5
         FUdElaGJ1/1w0yYJrYmtE5P3LcdmFJ7arOcsXQrzrO+Q10hzB2GGJJ56QXm+ftbV0s
         hRsXe40WnRTZtF0yu4v5kCaAlk/mv5zrBCHPw+M4=
Date:   Thu, 29 Aug 2019 14:13:17 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthias Maennich <maennich@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, joel@joelfernandes.org,
        kstewart@linuxfoundation.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com,
        maco@android.com, maco@google.com, michal.lkml@markovi.net,
        mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com,
        sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH v3 08/11] scripts: Coccinelle script for namespace
 dependencies.
Message-ID: <20190829121317.GA22914@linux-8ccs>
References: <20190813121733.52480-1-maennich@google.com>
 <20190821114955.12788-1-maennich@google.com>
 <20190821114955.12788-9-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190821114955.12788-9-maennich@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Matthias Maennich [21/08/19 12:49 +0100]:
>A script that uses the '<module>.ns_deps' files generated by modpost to
>automatically add the required symbol namespace dependencies to each
>module.
>
>Usage:
>1) Move some symbols to a namespace with EXPORT_SYMBOL_NS() or define
>   DEFAULT_SYMBOL_NAMESPACE
>2) Run 'make' (or 'make modules') and get warnings about modules not
>   importing that namespace.
>3) Run 'make nsdeps' to automatically add required import statements
>   to said modules.
>
>This makes it easer for subsystem maintainers to introduce and maintain
>symbol namespaces into their codebase.
>
>Co-developed-by: Martijn Coenen <maco@android.com>
>Signed-off-by: Martijn Coenen <maco@android.com>
>Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Matthias Maennich <maennich@google.com>
>---
> MAINTAINERS                                 |  5 ++
> Makefile                                    | 12 +++++
> scripts/Makefile.modpost                    |  4 +-
> scripts/coccinelle/misc/add_namespace.cocci | 23 +++++++++
> scripts/nsdeps                              | 56 +++++++++++++++++++++
> 5 files changed, 99 insertions(+), 1 deletion(-)
> create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
> create mode 100644 scripts/nsdeps
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 08176d64eed5..dd5b37b49a07 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -11428,6 +11428,11 @@ S:	Maintained
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> F:	tools/include/nolibc/
>
>+NSDEPS
>+M:	Matthias Maennich <maennich@google.com>
>+S:	Maintained
>+F:	scripts/nsdeps
>+
> NTB AMD DRIVER
> M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> L:	linux-ntb@googlegroups.com
>diff --git a/Makefile b/Makefile
>index a89870188c09..40311f583ee1 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -1500,6 +1500,9 @@ help:
> 	@echo  '  headerdep       - Detect inclusion cycles in headers'
> 	@echo  '  coccicheck      - Check with Coccinelle'
> 	@echo  ''
>+	@echo  'Tools:'
>+	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
>+	@echo  ''
> 	@echo  'Kernel selftest:'
> 	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
> 	@echo  '                    Build, install, and boot kernel before'
>@@ -1687,6 +1690,15 @@ quiet_cmd_tags = GEN     $@
> tags TAGS cscope gtags: FORCE
> 	$(call cmd,tags)
>
>+# Script to generate missing namespace dependencies
>+# ---------------------------------------------------------------------------
>+
>+PHONY += nsdeps
>+
>+nsdeps:
>+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
>+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
>+
> # Scripts to check various things for consistency
> # ---------------------------------------------------------------------------
>
>diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
>index 26e6574ecd08..743fe3a2e885 100644
>--- a/scripts/Makefile.modpost
>+++ b/scripts/Makefile.modpost
>@@ -56,7 +56,8 @@ MODPOST = scripts/mod/modpost						\
> 	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
> 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
> 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
>-	$(if $(KBUILD_MODPOST_WARN),-w)
>+	$(if $(KBUILD_MODPOST_WARN),-w)					\
>+	$(if $(filter nsdeps,$(MAKECMDGOALS)),-d)
>
> ifdef MODPOST_VMLINUX
>
>@@ -134,6 +135,7 @@ $(modules): %.ko :%.o %.mod.o FORCE
>
> targets += $(modules)
>
>+nsdeps: __modpost
>
> # Add FORCE to the prequisites of a target to force it to be always rebuilt.
> # ---------------------------------------------------------------------------
>diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
>new file mode 100644
>index 000000000000..c832bb6445a8
>--- /dev/null
>+++ b/scripts/coccinelle/misc/add_namespace.cocci
>@@ -0,0 +1,23 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+//
>+/// Adds missing MODULE_IMPORT_NS statements to source files
>+///
>+/// This script is usually called from scripts/nsdeps with -D ns=<namespace> to
>+/// add a missing namespace tag to a module source file.
>+///
>+
>+@has_ns_import@
>+declarer name MODULE_IMPORT_NS;
>+identifier virtual.ns;
>+@@
>+MODULE_IMPORT_NS(ns);
>+
>+// Add missing imports, but only adjacent to a MODULE_LICENSE statement.
>+// That ensures we are adding it only to the main module source file.
>+@do_import depends on !has_ns_import@
>+declarer name MODULE_LICENSE;
>+expression license;
>+identifier virtual.ns;
>+@@
>+MODULE_LICENSE(license);
>++ MODULE_IMPORT_NS(ns);
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>new file mode 100644
>index 000000000000..3b5995a61e65
>--- /dev/null
>+++ b/scripts/nsdeps
>@@ -0,0 +1,56 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-2.0
>+# Linux kernel symbol namespace import generator
>+#
>+# This script requires a minimum spatch version.
>+SPATCH_REQ_VERSION="1.0.4"
>+
>+DIR="$(dirname $(readlink -f $0))/.."
>+SPATCH="`which ${SPATCH:=spatch}`"
>+if [ ! -x "$SPATCH" ]; then
>+	echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
>+	exit 1
>+fi
>+
>+SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
>+SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
>+SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
>+
>+if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
>+	echo "spatch needs to be version $SPATCH_REQ_VERSION or higher"
>+	exit 1
>+fi
>+
>+generate_deps_for_ns() {
>+	$SPATCH --very-quiet --in-place --sp-file \
>+		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
>+}
>+
>+generate_deps() {
>+	local mod_name=`basename $@ .ko`
>+	local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
>+	local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
>+	if [ ! -f "$ns_deps_file" ]; then return; fi
>+	local mod_source_files=`cat $mod_file | sed -n 1p | sed -e 's/\.o/\.c/g'`
>+	for ns in `cat $ns_deps_file`; do
>+		echo "Adding namespace $ns to module $mod_name (if needed)."
>+		generate_deps_for_ns $ns $mod_source_files
>+		# sort the imports
>+		for source_file in $mod_source_files; do
>+			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>+			offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
>+			cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
>+			tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
>+			if ! diff -q ${source_file} ${source_file}.tmp; then
>+				mv ${source_file}.tmp ${source_file}
>+			else
>+				rm ${source_file}.tmp
>+			fi
>+		done
>+	done
>+}
>+
>+for f in `cat $srctree/modules.order`; do
>+	generate_deps $f
>+done

Hi Matthias!

I normally build outside of the source tree (make O=..) and I think
that choked up the nsdeps script a bit. For example when I run
'make nsdeps O=/tmp/linux' I get:

   cat: /home/jeyu/linux/modules.order: No such file or directory

I just changed $srctree/modules.order to $objtree/modules.order and
that fixed it for me. Also, I had to prefix $source_file in the script
with $srctree so that it'd find the right file to modify.

Thanks!

Jessica
