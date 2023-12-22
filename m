Return-Path: <linux-arch+bounces-1168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4213C81CF22
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 21:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77161F24062
	for <lists+linux-arch@lfdr.de>; Fri, 22 Dec 2023 20:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAC02E831;
	Fri, 22 Dec 2023 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fjgsUbrN"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE912E827;
	Fri, 22 Dec 2023 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ik/EZUdgP2DhN410LRrAbu8L6e2if21o1xJdu5U2IDY=; b=fjgsUbrNleVqq6PpdYLb4aJ8wg
	rI6DmwWF2hL5IOWwGq7HxgUPkEkjA9wCBnWfyi7UVuKODilJBimP5kM8cdghKW+9OqG/aF1CyOHTc
	wzz0+XpGzNBFqbF62j4DWBQ0csBH4saJCTSNTCPw6NJHTeSchsaud+jlHNG/4XdG63lvM/nTMzD4c
	LKgHm5HrNDXmp/6d3kPag8tyEYZlD2WRcdz0I3kM/0AW/Ysn4/Co6kZW8jniiZWzT5xN07Ok2f5Wx
	Jq3VuuIYUjEpMUOGVjE5q6thCISOZ+Yex3PggsgcrxUKbHdPr1q1BYt7s9k9s20tuVptsOHptoz/z
	pKx9TuAQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlqu-006nfI-1D;
	Fri, 22 Dec 2023 20:10:36 +0000
Date: Fri, 22 Dec 2023 12:10:36 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/4] modules: Ensure 64-bit alignment on __ksymtab_*
 sections
Message-ID: <ZYXtPL7Ds1SUKPLT@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <20231122221814.139916-3-deller@kernel.org>
 <ZYUlpxlg/WooxGWZ@bombadil.infradead.org>
 <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b73bc5a-1948-4e67-9ec5-b238723b3a48@gmx.de>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Dec 22, 2023 at 01:13:26PM +0100, Helge Deller wrote:
> Hi Luis,
> 
> On 12/22/23 06:59, Luis Chamberlain wrote:
> > On Wed, Nov 22, 2023 at 11:18:12PM +0100, deller@kernel.org wrote:
> > > From: Helge Deller <deller@gmx.de>
> > > 
> > > On 64-bit architectures without CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> > > (e.g. ppc64, ppc64le, parisc, s390x,...) the __KSYM_REF() macro stores
> > > 64-bit pointers into the __ksymtab* sections.
> > > Make sure that those sections will be correctly aligned at module link time,
> > > otherwise unaligned memory accesses may happen at runtime.
> > 
> > The ramifications are not explained there.
> 
> What do you mean exactly by this?

You don't explain the impact of not applying this patch.

> > You keep sending me patches with this and we keep doing a nose dive
> > on this. It means I have to do more work.
> Sorry about that. Since you are mentioned as maintainer for modules I
> thought you are the right contact.

I am certaintly the right person to send this patch to, however, I am
saying that given our previous dialog I would like the commit log to
describe a bit more detail of a few things:

 * how you found this
 * what are the impact of not applying it

Specially if you are going to be sending patches right before the
holidays with a Cc stable fix annotation. This gets me on hight alert
and I have to put things down to see how really critical this is so to
decide to fast track this to Linus or not.

> Furthermore, this patch is pretty small and trivial.

Many patches can be but some can break things and some can be small but
also improve things critically, for example if we are aware of broken
exception handlers.

> And I had the impression that people understand that having unaligned
> structures is generally a bad idea as it usually always impacts performance
> (although the performance penalty in this case isn't critical at all,
> as we are not on hot paths).

There are two aspects to this, one is the critical nature which is
implied by your patch which pegs it as a stable fix, given you prior
patches about this it leaves me wondering if it is fixing some crashes
on some systems given faulty exception handlers.

The performance thing is also subjective, but it could not be subjective
by doing some very trivial tests as I suggested. Such a test would also
help as we lack specific selftsts for this case and we can grow it later
with other things. I figured I'd ask you to try it, since *you* keep
sending patches about misalignments on module sections so I figured
you must be seeing something others are not, and so you must care.

> > Thoughts?
> 
> I really appreciate your thoughts here!
> 
> But given the triviality of this patch, I personally think you are
> proposing a huge academic investment in time and resources with no real benefit.
> On which architecture would you suggest to test this?
> What would be the effective (really new) outcome?
> If the performance penalty is zero or close to zero, will that imply
> that such a patch isn't useful?
> Please also keep in mind that not everyone gets paid to work on the kernel,
> so I have neither the time nor the various architectures to test on.

I think you make this seem so difficult, but I understand it could seem
that way. I've attached at the end of this email a patch that does just
this then to help.

> So, honestly I don't see a real reason why it shouldn't be applied...

Like I said, you Cc'd stable as a fix, as a maintainer it is my job to
verify how critical this is and ask for more details about how you found
it and evaluate the real impact. Even if it was not a stable fix I tend
to ask this for patches, even if they are trivial.

> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Cc: <stable@vger.kernel.org> # v6.0+
> > 
> > That's a stretch without any data, don't you think?
> 
> Yes. No need to push such a patch to stable series.

OK, can you extend the patch below with something like:

perf stat --repeat 100 --pre 'modprobe -r b a b c' -- ./tools/testing/selftests/module/find_symbol.sh

And test before and after?

I ran a simple test as-is and the data I get is within noise, and so
I think we need the --repeat 100 thing.

-----------------------------------------------------------------------------------
before:
sudo ./tools/testing/selftests/module/find_symbol.sh 

 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        81,956,206 ns   duration_time                                                         
        81,883,000 ns   system_time                                                           
               210      page-faults                                                           

       0.081956206 seconds time elapsed

       0.000000000 seconds user
       0.081883000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        85,960,863 ns   duration_time                                                         
        84,679,000 ns   system_time                                                           
               212      page-faults                                                           

       0.085960863 seconds time elapsed

       0.000000000 seconds user
       0.084679000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        86,484,868 ns   duration_time                                                         
        86,541,000 ns   system_time                                                           
               213      page-faults                                                           

       0.086484868 seconds time elapsed

       0.000000000 seconds user
       0.086541000 seconds sys

-----------------------------------------------------------------------------------
After your modules alignement fix:
sudo ./tools/testing/selftests/module/find_symbol.sh 
 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        83,579,980 ns   duration_time                                                         
        83,530,000 ns   system_time                                                           
               212      page-faults                                                           

       0.083579980 seconds time elapsed

       0.000000000 seconds user
       0.083530000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        70,721,786 ns   duration_time                                                         
        69,289,000 ns   system_time                                                           
               211      page-faults                                                           

       0.070721786 seconds time elapsed

       0.000000000 seconds user
       0.069289000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        76,513,219 ns   duration_time                                                         
        76,381,000 ns   system_time                                                           
               214      page-faults                                                           

       0.076513219 seconds time elapsed

       0.000000000 seconds user
       0.076381000 seconds sys

After your modules alignement fix:
sudo ./tools/testing/selftests/module/find_symbol.sh 
 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        83,579,980 ns   duration_time                                                         
        83,530,000 ns   system_time                                                           
               212      page-faults                                                           

       0.083579980 seconds time elapsed

       0.000000000 seconds user
       0.083530000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        70,721,786 ns   duration_time                                                         
        69,289,000 ns   system_time                                                           
               211      page-faults                                                           

       0.070721786 seconds time elapsed

       0.000000000 seconds user
       0.069289000 seconds sys



 Performance counter stats for '/sbin/modprobe test_kallsyms_b':

        76,513,219 ns   duration_time                                                         
        76,381,000 ns   system_time                                                           
               214      page-faults                                                           

       0.076513219 seconds time elapsed

       0.000000000 seconds user
       0.076381000 seconds sys
-----------------------------------------------------------------------------------

From efe903f7a1e5917405f9555e9c00b1da2ac4b830 Mon Sep 17 00:00:00 2001
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Fri, 22 Dec 2023 11:22:08 -0800
Subject: [PATCH] selftests: add new kallsyms selftests

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/Kconfig.debug                             |  95 +++++++++++++
 lib/Makefile                                  |   1 +
 lib/tests/Makefile                            |   1 +
 lib/tests/module/.gitignore                   |   4 +
 lib/tests/module/Makefile                     |  15 ++
 lib/tests/module/gen_test_kallsyms.sh         | 128 ++++++++++++++++++
 tools/testing/selftests/module/Makefile       |  12 ++
 tools/testing/selftests/module/config         |   7 +
 tools/testing/selftests/module/find_symbol.sh |  65 +++++++++
 9 files changed, 328 insertions(+)
 create mode 100644 lib/tests/Makefile
 create mode 100644 lib/tests/module/.gitignore
 create mode 100644 lib/tests/module/Makefile
 create mode 100755 lib/tests/module/gen_test_kallsyms.sh
 create mode 100644 tools/testing/selftests/module/Makefile
 create mode 100644 tools/testing/selftests/module/config
 create mode 100755 tools/testing/selftests/module/find_symbol.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 97ce28f4d154..4f5fbaceaf88 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2835,6 +2835,101 @@ config TEST_KMOD
 
 	  If unsure, say N.
 
+config TEST_RUNTIME
+	bool
+
+config TEST_RUNTIME_MODULE
+	bool
+
+config TEST_KALLSYMS
+	tristate "module kallsyms find_symbol() test"
+	depends on m
+	select TEST_RUNTIME
+	select TEST_RUNTIME_MODULE
+	select TEST_KALLSYMS_A
+	select TEST_KALLSYMS_B
+	select TEST_KALLSYMS_C
+	select TEST_KALLSYMS_D
+	help
+	  This allows us to stress test find_symbol() through the kallsyms
+	  used to place symbols on the kernel ELF kallsyms and modules kallsyms
+	  where we place kernel symbols such as exported symbols.
+
+	  We have four test modules:
+
+	  A: has KALLSYSMS_NUMSYMS exported symbols
+	  B: uses one of A's symbols
+	  C: adds KALLSYMS_SCALE_FACTOR * KALLSYSMS_NUMSYMS exported
+	  D: adds 2 * the symbols than C
+
+	  We stress test find_symbol() through two means:
+
+	  1) Upon load of B it will trigger simplify_symbols() to look for the
+	  one symbol it uses from the module A with tons of symbols. This is an
+	  indirect way for us to have B call resolve_symbol_wait() upon module
+	  load. This will eventually call find_symbol() which will eventually
+	  try to find the symbols used with find_exported_symbol_in_section().
+	  find_exported_symbol_in_section() uses bsearch() so a binary search
+	  for each symbol. Binary search will at worst be O(log(n)) so the
+	  larger TEST_MODULE_KALLSYSMS the worse the search.
+
+	  2) The selftests should load C first, before B. Upon B's load towards
+	  the end right before we call module B's init routine we get
+	  complete_formation() called on the module. That will first check
+	  for duplicate symbols with the call to verify_exported_symbols().
+	  That is when we'll force iteration on module C's insane symbol list.
+	  Since it has 10 * KALLSYMS_NUMSYMS it means we can first test
+	  just loading B without C. The amount of time it takes to load C Vs
+	  B can give us an idea of the impact growth of the symbol space and
+	  give us projection. Module A only uses one symbol from B so to allow
+	  this scaling in module C to be proportional, if it used more symbols
+	  then the first test would be doing more and increasing just the
+	  search space would be slightly different. The last module, module D
+	  will just increase the search space by twice the number of symbols in
+	  C so to allow for full projects.
+
+	  tools/testing/selftests/module/find_symbol.sh
+
+	  If unsure, say N.
+
+if TEST_KALLSYMS
+
+config TEST_KALLSYMS_A
+	tristate
+	depends on m
+
+config TEST_KALLSYMS_B
+	tristate
+	depends on m
+
+config TEST_KALLSYMS_C
+	tristate
+	depends on m
+
+config TEST_KALLSYMS_D
+	tristate
+	depends on m
+
+config TEST_KALLSYMS_NUMSYMS
+	int "test kallsyms number of symbols"
+	default 10000
+	help
+	  The number of symbols to create on TEST_KALLSYMS_A, only one of which
+	  module TEST_KALLSYMS_B will use. This also will be used
+	  for how many symbols TEST_KALLSYMS_C will have, scaled up by
+	  TEST_KALLSYMS_SCALE_FACTOR.
+
+config TEST_KALLSYMS_SCALE_FACTOR
+	int "test kallsyms scale factor"
+	default 4
+	help
+	  How many more unusued symbols will TEST_KALLSYSMS_C have than
+	  TEST_KALLSYMS_A. If 4, then module C will have 4 * syms
+	  than module A. Then TEST_KALLSYMS_D will have double the amount
+	  of symbols than C so to allow projections.
+
+endif # TEST_KALLSYMS
+
 config TEST_DEBUG_VIRTUAL
 	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
 	depends on DEBUG_VIRTUAL
diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..48e69a61cd85 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_TEST_XARRAY) += test_xarray.o
 obj-$(CONFIG_TEST_MAPLE_TREE) += test_maple_tree.o
 obj-$(CONFIG_TEST_PARMAN) += test_parman.o
 obj-$(CONFIG_TEST_KMOD) += test_kmod.o
+obj-$(CONFIG_TEST_RUNTIME) += tests/
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
new file mode 100644
index 000000000000..8e4f42cb9c54
--- /dev/null
+++ b/lib/tests/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/module/.gitignore b/lib/tests/module/.gitignore
new file mode 100644
index 000000000000..8be7891b250f
--- /dev/null
+++ b/lib/tests/module/.gitignore
@@ -0,0 +1,4 @@
+test_kallsyms_a.c
+test_kallsyms_b.c
+test_kallsyms_c.c
+test_kallsyms_d.c
diff --git a/lib/tests/module/Makefile b/lib/tests/module/Makefile
new file mode 100644
index 000000000000..af5c27b996cb
--- /dev/null
+++ b/lib/tests/module/Makefile
@@ -0,0 +1,15 @@
+obj-$(CONFIG_TEST_KALLSYMS_A) += test_kallsyms_a.o
+obj-$(CONFIG_TEST_KALLSYMS_B) += test_kallsyms_b.o
+obj-$(CONFIG_TEST_KALLSYMS_C) += test_kallsyms_c.o
+obj-$(CONFIG_TEST_KALLSYMS_D) += test_kallsyms_d.o
+
+$(obj)/%.c: FORCE
+	@$(kecho) "  GEN     $@"
+	$(Q)$(srctree)/lib/tests/module/gen_test_kallsyms.sh $@\
+		$(CONFIG_TEST_KALLSYMS_NUMSYMS) \
+		$(CONFIG_TEST_KALLSYMS_SCALE_FACTOR)
+
+clean-files += test_kallsyms_a.c
+clean-files += test_kallsyms_b.c
+clean-files += test_kallsyms_c.c
+clean-files += test_kallsyms_d.c
diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
new file mode 100755
index 000000000000..e85f10dc11bd
--- /dev/null
+++ b/lib/tests/module/gen_test_kallsyms.sh
@@ -0,0 +1,128 @@
+#!/bin/bash
+
+TARGET=$(basename $1)
+DIR=lib/tests/module
+TARGET="$DIR/$TARGET"
+NUM_SYMS=$2
+SCALE_FACTOR=$3
+TEST_TYPE=$(echo $TARGET | sed -e 's|lib/tests/module/test_kallsyms_||g')
+TEST_TYPE=$(echo $TEST_TYPE | sed -e 's|.c||g')
+
+gen_template_module_header()
+{
+	cat <<____END_MODULE
+// SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
+/*
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ *
+ * Automatically generated code for testing, do not edit manually.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+____END_MODULE
+}
+
+gen_num_syms()
+{
+	PREFIX=$1
+	NUM=$2
+	for i in $(seq 1 $NUM); do
+		printf "int auto_test_%s_%010d = 0xff;\n" $PREFIX $i
+		printf "EXPORT_SYMBOL_GPL(auto_test_%s_%010d);\n" $PREFIX $i
+	done
+	echo
+}
+
+gen_template_module_data_a()
+{
+	gen_num_syms a $1
+	cat <<____END_MODULE
+static int auto_runtime_test(void)
+{
+	return 0;
+}
+
+____END_MODULE
+}
+
+gen_template_module_data_b()
+{
+	printf "\nextern int auto_test_a_%010d;\n\n" 28
+	echo "static int auto_runtime_test(void)"
+	echo "{"
+	printf "\nreturn auto_test_a_%010d;\n" 28
+	echo "}"
+}
+
+gen_template_module_data_c()
+{
+	gen_num_syms c $1
+	cat <<____END_MODULE
+static int auto_runtime_test(void)
+{
+	return 0;
+}
+
+____END_MODULE
+}
+
+gen_template_module_data_d()
+{
+	gen_num_syms d $1
+	cat <<____END_MODULE
+static int auto_runtime_test(void)
+{
+	return 0;
+}
+
+____END_MODULE
+}
+
+gen_template_module_exit()
+{
+	cat <<____END_MODULE
+static int __init auto_test_module_init(void)
+{
+	return auto_runtime_test();
+}
+module_init(auto_test_module_init);
+
+static void __exit auto_test_module_exit(void)
+{
+}
+module_exit(auto_test_module_exit);
+
+MODULE_AUTHOR("Luis Chamberlain <mcgrof@kernel.org>");
+MODULE_LICENSE("GPL");
+____END_MODULE
+}
+
+case $TEST_TYPE in
+	a)
+		gen_template_module_header > $TARGET
+		gen_template_module_data_a $NUM_SYMS >> $TARGET
+		gen_template_module_exit >> $TARGET
+		;;
+	b)
+		gen_template_module_header > $TARGET
+		gen_template_module_data_b >> $TARGET
+		gen_template_module_exit >> $TARGET
+		;;
+	c)
+		gen_template_module_header > $TARGET
+		gen_template_module_data_c $((NUM_SYMS * SCALE_FACTOR)) >> $TARGET
+		gen_template_module_exit >> $TARGET
+		;;
+	d)
+		gen_template_module_header > $TARGET
+		gen_template_module_data_d $((NUM_SYMS * SCALE_FACTOR * 2)) >> $TARGET
+		gen_template_module_exit >> $TARGET
+		;;
+	*)
+		;;
+esac
diff --git a/tools/testing/selftests/module/Makefile b/tools/testing/selftests/module/Makefile
new file mode 100644
index 000000000000..6132d7ddb08b
--- /dev/null
+++ b/tools/testing/selftests/module/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for module loading selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := find_symbol.sh
+
+include ../lib.mk
+
+# Nothing to clean up.
+clean:
diff --git a/tools/testing/selftests/module/config b/tools/testing/selftests/module/config
new file mode 100644
index 000000000000..259f4fd6b5e2
--- /dev/null
+++ b/tools/testing/selftests/module/config
@@ -0,0 +1,7 @@
+CONFIG_TEST_KMOD=m
+CONFIG_TEST_LKM=m
+CONFIG_XFS_FS=m
+
+# For the module parameter force_init_test is used
+CONFIG_TUN=m
+CONFIG_BTRFS_FS=m
diff --git a/tools/testing/selftests/module/find_symbol.sh b/tools/testing/selftests/module/find_symbol.sh
new file mode 100755
index 000000000000..c206b42525f1
--- /dev/null
+++ b/tools/testing/selftests/module/find_symbol.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later OR copyleft-next-0.3.1
+# Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+#
+# This is a stress test script for kallsyms through find_symbol()
+
+set -e
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+test_reqs()
+{
+	if ! which modprobe 2> /dev/null > /dev/null; then
+		echo "$0: You need modprobe installed" >&2
+		exit $ksft_skip
+	fi
+
+	if ! which kmod 2> /dev/null > /dev/null; then
+		echo "$0: You need kmod installed" >&2
+		exit $ksft_skip
+	fi
+
+	if ! which perf 2> /dev/null > /dev/null; then
+		echo "$0: You need perf installed" >&2
+		exit $ksft_skip
+	fi
+
+	uid=$(id -u)
+	if [ $uid -ne 0 ]; then
+		echo $msg must be run as root >&2
+		exit $ksft_skip
+	fi
+}
+
+remove_all()
+{
+	$MODPROBE -r test_kallsyms_b
+	for i in a b c d; do
+		$MODPROBE -r test_kallsyms_$i
+	done
+}
+test_reqs
+
+MODPROBE=$(</proc/sys/kernel/modprobe)
+STATS="-e duration_time"
+STATS="$STATS -e user_time"
+STATS="$STATS -e system_time"
+STATS="$STATS -e page-faults"
+
+remove_all
+perf stat $STATS $MODPROBE test_kallsyms_b
+remove_all
+
+# Now pollute the namespace
+$MODPROBE test_kallsyms_c
+perf stat $STATS $MODPROBE test_kallsyms_b
+
+# Now pollute the namespace with twice the number of symbols than the last time
+remove_all
+$MODPROBE test_kallsyms_c
+$MODPROBE test_kallsyms_d
+perf stat $STATS $MODPROBE test_kallsyms_b
+
+exit 0
-- 
2.42.0


