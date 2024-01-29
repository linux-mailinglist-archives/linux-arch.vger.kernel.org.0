Return-Path: <linux-arch+bounces-1803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC084136E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 20:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8341A288731
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FC15697F;
	Mon, 29 Jan 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8OtOZGg"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C8E6F08D;
	Mon, 29 Jan 2024 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556413; cv=none; b=B/TmmMHtxWOeeXTFg33yHw+47nvFjQxwmIdjGyz1njbfGgAykRivJTbElU6U9FXXmp7Lis7Vxr3ZQxv5SYEgy3AmtmWiJCv+Txmlm+iOArJgIkX0jQ41LcrOWOcSAPAbQoST6p13xPR+wR24an4L8YVl1malq9xsYDwQqj0BJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556413; c=relaxed/simple;
	bh=0/yWl1fe0xWRxLKVVk6xILHeoo9y5fCUeC1NgWsAiFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkQtQRb0dGwHJcf3nXMaeX5Rt998E6fiq+5Y7blMN7RwAy8nYldDEDvuTVZwFg68+zuhbGeX+DDTd9QzGF1hnd7Yuo45sbRVYpefbFRLyMGKsdFjOwqNjO++Us9fPGKAMN9TSEucnuTj8c88hOtEME7GawjaDA0hYnu8DsirZnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8OtOZGg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZSxPVgNVTpkcL/sAEcETcCA4DLaETzOsGhfqh32OXeQ=; b=h8OtOZGgpJZJFl3tK0Q7EH/FhH
	gg0winVTuMuQ3lZ5SWanyp6ZHYgS70iDaktAOUlvcT4vg1ERXxh7+W88TwIkii/cJ1r6ZmBdHRrr3
	mriDe/WOgRavb11tYgwCJlRONoeTbIwHAp647b4N3XgySiBk+66NukQyK2u4/RTMYD9f7IWztRr/C
	cmDtjGp+af5NmuL0YdFjPVY4zeojNKliDACr+fvY2TCwWnScbyOg/txr7m111/d4ObAWn3mwu4IlF
	7v23T5dhv5/cJ7jXbJ1/8U1dL+U2FKa3X/MQvQo5KuFbTfe98ByXvkQXfsL+JkuBVt77eI+5L5Lam
	Xaf/modw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXHN-0000000E67g-2QTT;
	Mon, 29 Jan 2024 19:26:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: masahiroy@kernel.org,
	deller@gmx.de
Cc: mcgrof@kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] selftests: add new kallsyms selftests
Date: Mon, 29 Jan 2024 11:26:40 -0800
Message-ID: <20240129192644.3359978-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129192644.3359978-1-mcgrof@kernel.org>
References: <20240129192644.3359978-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We lack find_symbol() selftests, so add one. This let's us stress test
improvements easily on find_symbol() or optimizations. It also inherently
allows us to test the limits of kallsyms on Linux today.

We test a pathalogical use case for kallsyms by introducing modules
which are automatically written for us with a larger number of symbols.
We have 4 kallsyms test modules:

A: has KALLSYSMS_NUMSYMS exported symbols
B: uses one of A's symbols
C: adds KALLSYMS_SCALE_FACTOR * KALLSYSMS_NUMSYMS exported
D: adds 2 * the symbols than C

By using anything much larger than KALLSYSMS_NUMSYMS as 10,000 and
KALLSYMS_SCALE_FACTOR of 8 we segfault today. So we're capped at
around 160000 symbols somehow today. We can inpsect that issue at
our leasure later, but for now the real value to this test is that
this will easily allow us to test improvements on find_symbol().

On x86_64 we can use perf, for other architectures we just use 'time'
and allow for customizations. For example a future enhancements could
be done for parisc to check for unaligned accesses which triggers a
special special exception handler assembler code inside the kernel.
The negative impact on performance is so large on parisc that it
keeps track of its accesses on /proc/cpuinfo as UAH:

IRQ:       CPU0       CPU1
3:       1332          0         SuperIO  ttyS0
7:    1270013          0         SuperIO  pata_ns87415
64:  320023012  320021431             CPU  timer
65:   17080507   20624423             CPU  IPI
UAH:   10948640      58104   Unaligned access handler traps

While at it, this tidies up lib/ test modules to allow us to have
a new directory for them. The amount of test modules under lib/
is insane.

This should also hopefully showcase how to start doing basic
self module writing code, which may be more useful for more complex
cases later in the future.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/Kconfig.debug                             | 103 ++++++++++++++
 lib/Makefile                                  |   1 +
 lib/tests/Makefile                            |   1 +
 lib/tests/module/.gitignore                   |   4 +
 lib/tests/module/Makefile                     |  15 ++
 lib/tests/module/gen_test_kallsyms.sh         | 128 ++++++++++++++++++
 tools/testing/selftests/module/Makefile       |  12 ++
 tools/testing/selftests/module/config         |   3 +
 tools/testing/selftests/module/find_symbol.sh |  81 +++++++++++
 9 files changed, 348 insertions(+)
 create mode 100644 lib/tests/Makefile
 create mode 100644 lib/tests/module/.gitignore
 create mode 100644 lib/tests/module/Makefile
 create mode 100755 lib/tests/module/gen_test_kallsyms.sh
 create mode 100644 tools/testing/selftests/module/Makefile
 create mode 100644 tools/testing/selftests/module/config
 create mode 100755 tools/testing/selftests/module/find_symbol.sh

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 97ce28f4d154..29db47ca251f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2835,6 +2835,109 @@ config TEST_KMOD
 
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
+	  The current defaults will incur a build delay of about 7 minutes
+	  on an x86_64 with only 8 cores. Enable this only if you want to
+	  stress test find_symbol() with thousands of symbols. At the same
+	  time this is also useful to test building modules with thousands of
+	  symbols, and if BTF is enabled this also stress tests adding BTF
+	  information for each module. Currently enabling many more symbols
+	  will segfault the build system.
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
+	default 8
+	help
+	  How many more unusued symbols will TEST_KALLSYSMS_C have than
+	  TEST_KALLSYMS_A. If 8, then module C will have 8 * syms
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
index 000000000000..b0c206b1ad47
--- /dev/null
+++ b/tools/testing/selftests/module/config
@@ -0,0 +1,3 @@
+CONFIG_TEST_RUNTIME=y
+CONFIG_TEST_RUNTIME_MODULE=y
+CONFIG_TEST_KALLSYMS=m
diff --git a/tools/testing/selftests/module/find_symbol.sh b/tools/testing/selftests/module/find_symbol.sh
new file mode 100755
index 000000000000..140364d3c49f
--- /dev/null
+++ b/tools/testing/selftests/module/find_symbol.sh
@@ -0,0 +1,81 @@
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
+load_mod()
+{
+	local STATS="-e duration_time"
+	STATS="$STATS -e user_time"
+	STATS="$STATS -e system_time"
+	STATS="$STATS -e page-faults"
+	local MOD=$1
+
+	local ARCH="$(uname -m)"
+	case "${ARCH}" in
+	x86_64)
+		perf stat $STATS $MODPROBE test_kallsyms_b
+		;;
+	*)
+		time $MODPROBE test_kallsyms_b
+		exit 1
+		;;
+	esac
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
+
+remove_all
+load_mod test_kallsyms_b
+remove_all
+
+# Now pollute the namespace
+$MODPROBE test_kallsyms_c
+load_mod test_kallsyms_b
+
+# Now pollute the namespace with twice the number of symbols than the last time
+remove_all
+$MODPROBE test_kallsyms_c
+$MODPROBE test_kallsyms_d
+load_mod test_kallsyms_b
+
+exit 0
-- 
2.42.0


