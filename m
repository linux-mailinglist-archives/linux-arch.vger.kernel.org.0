Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D665389CE
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 04:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiEaCJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 May 2022 22:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiEaCJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2022 22:09:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05FF6FD38;
        Mon, 30 May 2022 19:09:45 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBwg730rmzjXG6;
        Tue, 31 May 2022 10:08:35 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:33 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 10:09:32 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
CC:     <jpoimboe@redhat.com>, <peterz@infradead.org>,
        <madvenka@linux.microsoft.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <andreyknvl@gmail.com>, <wangkefeng.wang@huawei.com>,
        <andrealmeid@collabora.com>, <mhiramat@kernel.org>,
        <mcgrof@kernel.org>, <christophe.leroy@csgroup.eu>,
        <dmitry.torokhov@gmail.com>, <yangtiezhu@loongson.cn>,
        <dave.hansen@linux.intel.com>
Subject: [PATCH 2/4] objtool: Make ORC init and lookup code arch-generic
Date:   Tue, 31 May 2022 10:07:42 +0800
Message-ID: <20220531020744.236970-3-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531020744.236970-1-chenzhongjin@huawei.com>
References: <20220531020744.236970-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

All of the ORC code in the kernel is currently under arch/x86. The
following parts of that code can be shared by other architectures that
wish to use ORC.

	(1) ORC lookup initialization for vmlinux

	(2) ORC lookup initialization for modules

	(3) ORC lookup functions

Move arch/x86/include/asm/orc_lookup.h to include/asm-generic/orc_lookup.h.

Move the ORC lookup code into kernel/orc_lookup.c.

Rename the following init functions:

	unwind_module_init	==> orc_lookup_module_init
	unwind_init		==> orc_lookup_init

since that is exactly what they do.

orc_find() is the function that locates the ORC entry for a given PC.
Currently, it contains an architecture-specific part to locate ftrace
entries. Introduce a new arch-specific function called arch_orc_find()
and move the ftrace-related lookup there. If orc_find() is unable to
locate the ORC entry for a given PC in vmlinux or in the modules, it can
call arch_orc_find() to find architecture-specific entries.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/x86/include/asm/unwind.h                 |   5 -
 arch/x86/kernel/module.c                      |   7 +-
 arch/x86/kernel/unwind_orc.c                  | 256 +----------------
 arch/x86/kernel/vmlinux.lds.S                 |   2 +-
 .../asm => include/asm-generic}/orc_lookup.h  |  42 +++
 kernel/Makefile                               |   2 +
 kernel/orc_lookup.c                           | 261 ++++++++++++++++++
 7 files changed, 316 insertions(+), 259 deletions(-)
 rename {arch/x86/include/asm => include/asm-generic}/orc_lookup.h (51%)
 create mode 100644 kernel/orc_lookup.c

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f0..71af8246c69e 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -94,13 +94,8 @@ static inline struct pt_regs *unwind_get_entry_regs(struct unwind_state *state,
 
 #ifdef CONFIG_UNWINDER_ORC
 void unwind_init(void);
-void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
-			void *orc, size_t orc_size);
 #else
 static inline void unwind_init(void) {}
-static inline
-void unwind_module_init(struct module *mod, void *orc_ip, size_t orc_ip_size,
-			void *orc, size_t orc_size) {}
 #endif
 
 static inline
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b98ffcf4d250..4ebc9eddcb6b 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -23,7 +23,7 @@
 #include <asm/text-patching.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-#include <asm/unwind.h>
+#include <asm-generic/orc_lookup.h>
 
 #if 0
 #define DEBUGP(fmt, ...)				\
@@ -308,8 +308,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 	jump_label_apply_nops(me);
 
 	if (orc && orc_ip)
-		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
-				   (void *)orc->sh_addr, orc->sh_size);
+		orc_lookup_module_init(me,
+				       (void *)orc_ip->sh_addr, orc_ip->sh_size,
+				       (void *)orc->sh_addr, orc->sh_size);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 38185aedf7d1..b7425855feda 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -6,80 +6,9 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
-#include <asm/orc_lookup.h>
-
-#define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
-
-#define orc_warn_current(args...)					\
-({									\
-	if (state->task == current && !state->error)			\
-		orc_warn(args);						\
-})
-
-extern int __start_orc_unwind_ip[];
-extern int __stop_orc_unwind_ip[];
-extern struct orc_entry __start_orc_unwind[];
-extern struct orc_entry __stop_orc_unwind[];
-
-static bool orc_init __ro_after_init;
-static unsigned int lookup_num_blocks __ro_after_init;
-
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
-static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
-				    unsigned int num_entries, unsigned long ip)
-{
-	int *first = ip_table;
-	int *last = ip_table + num_entries - 1;
-	int *mid = first, *found = first;
-
-	if (!num_entries)
-		return NULL;
-
-	/*
-	 * Do a binary range search to find the rightmost duplicate of a given
-	 * starting address.  Some entries are section terminators which are
-	 * "weak" entries for ensuring there are no gaps.  They should be
-	 * ignored when they conflict with a real entry.
-	 */
-	while (first <= last) {
-		mid = first + ((last - first) / 2);
-
-		if (orc_ip(mid) <= ip) {
-			found = mid;
-			first = mid + 1;
-		} else
-			last = mid - 1;
-	}
-
-	return u_table + (found - ip_table);
-}
-
-#ifdef CONFIG_MODULES
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	struct module *mod;
-
-	mod = __module_address(ip);
-	if (!mod || !mod->arch.orc_unwind || !mod->arch.orc_unwind_ip)
-		return NULL;
-	return __orc_find(mod->arch.orc_unwind_ip, mod->arch.orc_unwind,
-			  mod->arch.num_orcs, ip);
-}
-#else
-static struct orc_entry *orc_module_find(unsigned long ip)
-{
-	return NULL;
-}
-#endif
+#include <asm-generic/orc_lookup.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-static struct orc_entry *orc_find(unsigned long ip);
-
 /*
  * Ftrace dynamic trampolines do not have orc entries of their own.
  * But they are copies of the ftrace entries that are static and
@@ -117,19 +46,10 @@ static struct orc_entry *orc_ftrace_find(unsigned long ip)
 }
 #endif
 
-/*
- * If we crash with IP==0, the last successfully executed instruction
- * was probably an indirect function call with a NULL function pointer,
- * and we don't have unwind information for NULL.
- * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
- * pointer into its parent and then continue normally from there.
- */
-static struct orc_entry null_orc_entry = {
-	.sp_offset = sizeof(long),
-	.sp_reg = ORC_REG_SP,
-	.bp_reg = ORC_REG_UNDEFINED,
-	.type = UNWIND_HINT_TYPE_CALL
-};
+struct orc_entry *arch_orc_find(unsigned long ip)
+{
+	return orc_ftrace_find(ip);
+}
 
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
@@ -141,173 +61,9 @@ static struct orc_entry orc_fp_entry = {
 	.end		= 0,
 };
 
-static struct orc_entry *orc_find(unsigned long ip)
-{
-	static struct orc_entry *orc;
-
-	if (ip == 0)
-		return &null_orc_entry;
-
-	/* For non-init vmlinux addresses, use the fast lookup table: */
-	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
-		unsigned int idx, start, stop;
-
-		idx = (ip - LOOKUP_START_IP) / LOOKUP_BLOCK_SIZE;
-
-		if (unlikely((idx >= lookup_num_blocks-1))) {
-			orc_warn("WARNING: bad lookup idx: idx=%u num=%u ip=%pB\n",
-				 idx, lookup_num_blocks, (void *)ip);
-			return NULL;
-		}
-
-		start = orc_lookup[idx];
-		stop = orc_lookup[idx + 1] + 1;
-
-		if (unlikely((__start_orc_unwind + start >= __stop_orc_unwind) ||
-			     (__start_orc_unwind + stop > __stop_orc_unwind))) {
-			orc_warn("WARNING: bad lookup value: idx=%u num=%u start=%u stop=%u ip=%pB\n",
-				 idx, lookup_num_blocks, start, stop, (void *)ip);
-			return NULL;
-		}
-
-		return __orc_find(__start_orc_unwind_ip + start,
-				  __start_orc_unwind + start, stop - start, ip);
-	}
-
-	/* vmlinux .init slow lookup: */
-	if (is_kernel_inittext(ip))
-		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
-				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
-
-	/* Module lookup: */
-	orc = orc_module_find(ip);
-	if (orc)
-		return orc;
-
-	return orc_ftrace_find(ip);
-}
-
-#ifdef CONFIG_MODULES
-
-static DEFINE_MUTEX(sort_mutex);
-static int *cur_orc_ip_table = __start_orc_unwind_ip;
-static struct orc_entry *cur_orc_table = __start_orc_unwind;
-
-static void orc_sort_swap(void *_a, void *_b, int size)
-{
-	struct orc_entry *orc_a, *orc_b;
-	struct orc_entry orc_tmp;
-	int *a = _a, *b = _b, tmp;
-	int delta = _b - _a;
-
-	/* Swap the .orc_unwind_ip entries: */
-	tmp = *a;
-	*a = *b + delta;
-	*b = tmp - delta;
-
-	/* Swap the corresponding .orc_unwind entries: */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
-}
-
-static int orc_sort_cmp(const void *_a, const void *_b)
-{
-	struct orc_entry *orc_a;
-	const int *a = _a, *b = _b;
-	unsigned long a_val = orc_ip(a);
-	unsigned long b_val = orc_ip(b);
-
-	if (a_val > b_val)
-		return 1;
-	if (a_val < b_val)
-		return -1;
-
-	/*
-	 * The "weak" section terminator entries need to always be on the left
-	 * to ensure the lookup code skips them in favor of real entries.
-	 * These terminator entries exist to handle any gaps created by
-	 * whitelisted .o files which didn't get objtool generation.
-	 */
-	orc_a = cur_orc_table + (a - cur_orc_ip_table);
-	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
-}
-
-void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
-			void *_orc, size_t orc_size)
-{
-	int *orc_ip = _orc_ip;
-	struct orc_entry *orc = _orc;
-	unsigned int num_entries = orc_ip_size / sizeof(int);
-
-	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
-		     orc_size % sizeof(*orc) != 0 ||
-		     num_entries != orc_size / sizeof(*orc));
-
-	/*
-	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
-	 * associate an .orc_unwind_ip table entry with its corresponding
-	 * .orc_unwind entry so they can both be swapped.
-	 */
-	mutex_lock(&sort_mutex);
-	cur_orc_ip_table = orc_ip;
-	cur_orc_table = orc;
-	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
-	mutex_unlock(&sort_mutex);
-
-	mod->arch.orc_unwind_ip = orc_ip;
-	mod->arch.orc_unwind = orc;
-	mod->arch.num_orcs = num_entries;
-}
-#endif
-
 void __init unwind_init(void)
 {
-	size_t orc_ip_size = (void *)__stop_orc_unwind_ip - (void *)__start_orc_unwind_ip;
-	size_t orc_size = (void *)__stop_orc_unwind - (void *)__start_orc_unwind;
-	size_t num_entries = orc_ip_size / sizeof(int);
-	struct orc_entry *orc;
-	int i;
-
-	if (!num_entries || orc_ip_size % sizeof(int) != 0 ||
-	    orc_size % sizeof(struct orc_entry) != 0 ||
-	    num_entries != orc_size / sizeof(struct orc_entry)) {
-		orc_warn("WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.\n");
-		return;
-	}
-
-	/*
-	 * Note, the orc_unwind and orc_unwind_ip tables were already
-	 * sorted at build time via the 'sorttable' tool.
-	 * It's ready for binary search straight away, no need to sort it.
-	 */
-
-	/* Initialize the fast lookup table: */
-	lookup_num_blocks = orc_lookup_end - orc_lookup;
-	for (i = 0; i < lookup_num_blocks-1; i++) {
-		orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
-				 num_entries,
-				 LOOKUP_START_IP + (LOOKUP_BLOCK_SIZE * i));
-		if (!orc) {
-			orc_warn("WARNING: Corrupt .orc_unwind table.  Disabling unwinder.\n");
-			return;
-		}
-
-		orc_lookup[i] = orc - __start_orc_unwind;
-	}
-
-	/* Initialize the ending block: */
-	orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind, num_entries,
-			 LOOKUP_STOP_IP);
-	if (!orc) {
-		orc_warn("WARNING: Corrupt .orc_unwind table.  Disabling unwinder.\n");
-		return;
-	}
-	orc_lookup[lookup_num_blocks-1] = orc - __start_orc_unwind;
-
-	orc_init = true;
+	orc_lookup_init();
 }
 
 unsigned long unwind_get_return_address(struct unwind_state *state)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7fda7f27e762..1b0c6b4eafae 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -29,7 +29,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page_types.h>
-#include <asm/orc_lookup.h>
+#include <asm-generic/orc_lookup.h>
 #include <asm/cache.h>
 #include <asm/boot.h>
 
diff --git a/arch/x86/include/asm/orc_lookup.h b/include/asm-generic/orc_lookup.h
similarity index 51%
rename from arch/x86/include/asm/orc_lookup.h
rename to include/asm-generic/orc_lookup.h
index 241631282e43..4a476269d151 100644
--- a/arch/x86/include/asm/orc_lookup.h
+++ b/include/asm-generic/orc_lookup.h
@@ -23,6 +23,8 @@
 
 #ifndef LINKER_SCRIPT
 
+#include <asm-generic/sections.h>
+
 extern unsigned int orc_lookup[];
 extern unsigned int orc_lookup_end[];
 
@@ -31,4 +33,44 @@ extern unsigned int orc_lookup_end[];
 
 #endif /* LINKER_SCRIPT */
 
+#ifndef __ASSEMBLY__
+
+#include <asm/orc_types.h>
+
+#ifdef CONFIG_UNWINDER_ORC
+void orc_lookup_init(void);
+void orc_lookup_module_init(struct module *mod,
+			    void *orc_ip, size_t orc_ip_size,
+			    void *orc, size_t orc_size);
+#else
+static inline void orc_lookup_init(void) {}
+static inline
+void orc_lookup_module_init(struct module *mod,
+			    void *orc_ip, size_t orc_ip_size,
+			    void *orc, size_t orc_size)
+{
+}
+#endif
+
+struct orc_entry *arch_orc_find(unsigned long ip);
+
+#define orc_warn(fmt, ...) \
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(args...)					\
+({									\
+	if (state->task == current && !state->error)			\
+		orc_warn(args);						\
+})
+
+struct orc_entry *orc_find(unsigned long ip);
+
+extern bool orc_init;
+extern int __start_orc_unwind_ip[];
+extern int __stop_orc_unwind_ip[];
+extern struct orc_entry __start_orc_unwind[];
+extern struct orc_entry __stop_orc_unwind[];
+
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ORC_LOOKUP_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 847a82bfe0e3..e5330aacb5b4 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -134,6 +134,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_UNWINDER_ORC) += orc_lookup.o
+
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
diff --git a/kernel/orc_lookup.c b/kernel/orc_lookup.c
new file mode 100644
index 000000000000..2e04a5e2be45
--- /dev/null
+++ b/kernel/orc_lookup.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/objtool.h>
+#include <linux/module.h>
+#include <linux/sort.h>
+#include <asm/orc_types.h>
+#include <asm-generic/orc_lookup.h>
+
+bool orc_init __ro_after_init;
+static unsigned int lookup_num_blocks __ro_after_init;
+
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
+				    unsigned int num_entries, unsigned long ip)
+{
+	int *first = ip_table;
+	int *last = ip_table + num_entries - 1;
+	int *mid = first, *found = first;
+
+	if (!num_entries)
+		return NULL;
+
+	/*
+	 * Do a binary range search to find the rightmost duplicate of a given
+	 * starting address.  Some entries are section terminators which are
+	 * "weak" entries for ensuring there are no gaps.  They should be
+	 * ignored when they conflict with a real entry.
+	 */
+	while (first <= last) {
+		mid = first + ((last - first) / 2);
+
+		if (orc_ip(mid) <= ip) {
+			found = mid;
+			first = mid + 1;
+		} else
+			last = mid - 1;
+	}
+
+	return u_table + (found - ip_table);
+}
+
+#ifdef CONFIG_MODULES
+static struct orc_entry *orc_module_find(unsigned long ip)
+{
+	struct module *mod;
+
+	mod = __module_address(ip);
+	if (!mod || !mod->arch.orc_unwind || !mod->arch.orc_unwind_ip)
+		return NULL;
+	return __orc_find(mod->arch.orc_unwind_ip, mod->arch.orc_unwind,
+			  mod->arch.num_orcs, ip);
+}
+#else
+static struct orc_entry *orc_module_find(unsigned long ip)
+{
+	return NULL;
+}
+#endif
+
+/*
+ * If we crash with IP==0, the last successfully executed instruction
+ * was probably an indirect function call with a NULL function pointer,
+ * and we don't have unwind information for NULL.
+ * This hardcoded ORC entry for IP==0 allows us to unwind from a NULL function
+ * pointer into its parent and then continue normally from there.
+ */
+static struct orc_entry null_orc_entry = {
+	.sp_offset = sizeof(long),
+	.sp_reg = ORC_REG_SP,
+	.bp_reg = ORC_REG_UNDEFINED,
+	.type = UNWIND_HINT_TYPE_CALL
+};
+
+struct orc_entry *orc_find(unsigned long ip)
+{
+	static struct orc_entry *orc;
+
+	if (ip == 0)
+		return &null_orc_entry;
+
+	/* For non-init vmlinux addresses, use the fast lookup table: */
+	if (ip >= LOOKUP_START_IP && ip < LOOKUP_STOP_IP) {
+		unsigned int idx, start, stop;
+
+		if (!orc_init) {
+			/*
+			 * Take the slow path if the fast lookup tables have
+			 * not yet been initialized.
+			 */
+			return __orc_find(__start_orc_unwind_ip,
+					  __start_orc_unwind,
+					  __stop_orc_unwind_ip -
+					  __start_orc_unwind_ip, ip);
+		}
+
+		idx = (ip - LOOKUP_START_IP) / LOOKUP_BLOCK_SIZE;
+
+		if (unlikely((idx >= lookup_num_blocks-1))) {
+			orc_warn("WARNING: bad lookup idx: idx=%u num=%u ip=%pB\n",
+				 idx, lookup_num_blocks, (void *)ip);
+			return NULL;
+		}
+
+		start = orc_lookup[idx];
+		stop = orc_lookup[idx + 1] + 1;
+
+		if (unlikely((__start_orc_unwind + start >= __stop_orc_unwind) ||
+			     (__start_orc_unwind + stop > __stop_orc_unwind))) {
+			orc_warn("WARNING: bad lookup value: idx=%u num=%u start=%u stop=%u ip=%pB\n",
+				 idx, lookup_num_blocks, start, stop, (void *)ip);
+			return NULL;
+		}
+
+		return __orc_find(__start_orc_unwind_ip + start,
+				  __start_orc_unwind + start, stop - start, ip);
+	}
+
+	/* vmlinux .init slow lookup: */
+	if (is_kernel_inittext(ip))
+		return __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
+				  __stop_orc_unwind_ip - __start_orc_unwind_ip, ip);
+
+	/* Module lookup: */
+	orc = orc_module_find(ip);
+	if (orc)
+		return orc;
+
+	return arch_orc_find(ip);
+}
+
+#ifdef CONFIG_MODULES
+
+static DEFINE_MUTEX(sort_mutex);
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
+
+static void orc_sort_swap(void *_a, void *_b, int size)
+{
+	struct orc_entry *orc_a, *orc_b;
+	struct orc_entry orc_tmp;
+	int *a = _a, *b = _b, tmp;
+	int delta = _b - _a;
+
+	/* Swap the .orc_unwind_ip entries: */
+	tmp = *a;
+	*a = *b + delta;
+	*b = tmp - delta;
+
+	/* Swap the corresponding .orc_unwind entries: */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	orc_b = cur_orc_table + (b - cur_orc_ip_table);
+	orc_tmp = *orc_a;
+	*orc_a = *orc_b;
+	*orc_b = orc_tmp;
+}
+
+static int orc_sort_cmp(const void *_a, const void *_b)
+{
+	struct orc_entry *orc_a;
+	const int *a = _a, *b = _b;
+	unsigned long a_val = orc_ip(a);
+	unsigned long b_val = orc_ip(b);
+
+	if (a_val > b_val)
+		return 1;
+	if (a_val < b_val)
+		return -1;
+
+	/*
+	 * The "weak" section terminator entries need to always be on the left
+	 * to ensure the lookup code skips them in favor of real entries.
+	 * These terminator entries exist to handle any gaps created by
+	 * whitelisted .o files which didn't get objtool generation.
+	 */
+	orc_a = cur_orc_table + (a - cur_orc_ip_table);
+	return orc_a->sp_reg == ORC_REG_UNDEFINED && !orc_a->end ? -1 : 1;
+}
+
+void orc_lookup_module_init(struct module *mod,
+			    void *_orc_ip, size_t orc_ip_size,
+			    void *_orc, size_t orc_size)
+{
+	int *orc_ip = _orc_ip;
+	struct orc_entry *orc = _orc;
+	unsigned int num_entries = orc_ip_size / sizeof(int);
+
+	WARN_ON_ONCE(orc_ip_size % sizeof(int) != 0 ||
+		     orc_size % sizeof(*orc) != 0 ||
+		     num_entries != orc_size / sizeof(*orc));
+
+	/*
+	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
+	 * associate an .orc_unwind_ip table entry with its corresponding
+	 * .orc_unwind entry so they can both be swapped.
+	 */
+	mutex_lock(&sort_mutex);
+	cur_orc_ip_table = orc_ip;
+	cur_orc_table = orc;
+	sort(orc_ip, num_entries, sizeof(int), orc_sort_cmp, orc_sort_swap);
+	mutex_unlock(&sort_mutex);
+
+	mod->arch.orc_unwind_ip = orc_ip;
+	mod->arch.orc_unwind = orc;
+	mod->arch.num_orcs = num_entries;
+}
+#endif
+
+void __init orc_lookup_init(void)
+{
+	size_t orc_ip_size = (void *)__stop_orc_unwind_ip - (void *)__start_orc_unwind_ip;
+	size_t orc_size = (void *)__stop_orc_unwind - (void *)__start_orc_unwind;
+	size_t num_entries = orc_ip_size / sizeof(int);
+	struct orc_entry *orc;
+	int i;
+
+	if (!num_entries || orc_ip_size % sizeof(int) != 0 ||
+	    orc_size % sizeof(struct orc_entry) != 0 ||
+	    num_entries != orc_size / sizeof(struct orc_entry)) {
+		orc_warn("WARNING: Bad or missing .orc_unwind table.  Disabling unwinder.\n");
+		return;
+	}
+
+	/*
+	 * Note, the orc_unwind and orc_unwind_ip tables were already
+	 * sorted at build time via the 'sorttable' tool.
+	 * It's ready for binary search straight away, no need to sort it.
+	 */
+
+	/* Initialize the fast lookup table: */
+	lookup_num_blocks = orc_lookup_end - orc_lookup;
+	for (i = 0; i < lookup_num_blocks-1; i++) {
+		orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind,
+				 num_entries,
+				 LOOKUP_START_IP + (LOOKUP_BLOCK_SIZE * i));
+		if (!orc) {
+			orc_warn("WARNING: Corrupt .orc_unwind table.  Disabling unwinder.\n");
+			return;
+		}
+
+		orc_lookup[i] = orc - __start_orc_unwind;
+	}
+
+	/* Initialize the ending block: */
+	orc = __orc_find(__start_orc_unwind_ip, __start_orc_unwind, num_entries,
+			 LOOKUP_STOP_IP);
+	if (!orc) {
+		orc_warn("WARNING: Corrupt .orc_unwind table.  Disabling unwinder.\n");
+		return;
+	}
+	orc_lookup[lookup_num_blocks-1] = orc - __start_orc_unwind;
+
+	orc_init = true;
+}
+
+__weak struct orc_entry *arch_orc_find(unsigned long ip)
+{
+	return NULL;
+}
-- 
2.17.1

