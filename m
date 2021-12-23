Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2031F47DBC9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345564AbhLWAXj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:39 -0500
Received: from mga18.intel.com ([134.134.136.126]:24836 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345531AbhLWAXb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219011; x=1671755011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ZKioNI98dzYjZhoWodWGrSrTmXJR0JsKnk/05ECZhY=;
  b=dR4wvOPLareKjC8G7ixxP9EeptH0t70pxFpKmDTpkUcGtjf2q8Ewao1P
   5K29YqHcBIgWwmEWxZG5DjK34WnjadKTe6KYmaXajQyONl178UqpCGkfk
   rT8mHXMq+vHL04h3WPtQ3VNAlUnbj0alwZ9o0wTXRRlYs8SOmI3pzWC5P
   ha0vxf7k0tpfvLrMvlV/1LT0oGXl7E2WVDEdCycuAo1+wnxJdFPN4U6Wk
   JJOx3toC39Pw4YoqwkD5oQ6E8xzLBSu6nXeTbkbjyQjm/TbVbf0t/Vx+o
   xjwmmdLvyKh0IXmiKP/tjtXtBdkNvcuReRcR74cfwzuk1LmyoGVUhS+Wh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227574757"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="227574757"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="617312120"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2021 16:23:22 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79B032467;
        Thu, 23 Dec 2021 00:23:19 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 06/15] x86: decouple ORC table sorting into a separate file
Date:   Thu, 23 Dec 2021 01:22:00 +0100
Message-Id: <20211223002209.1092165-7-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to be able to sort ORC entries from both the kernel and
the pre-boot compressed environment, place ORC sorting function
into the new file arch/x86/lib/orc.c.
It can be then included directly by the pre-boot code, and
ORC_COMPRESSED_BOOT definition guards out the sort_mutex which
is unavailable and unneeded in that environment.

Placing orc_ip() into `include/asm/orc_types.h` wipes out
sorttable.h's little code dup.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/include/asm/orc_types.h       |  7 +++
 arch/x86/kernel/unwind_orc.c           | 63 +--------------------
 arch/x86/lib/Makefile                  |  1 +
 arch/x86/lib/orc.c                     | 76 ++++++++++++++++++++++++++
 scripts/sorttable.h                    |  5 --
 tools/arch/x86/include/asm/orc_types.h |  7 +++
 6 files changed, 92 insertions(+), 67 deletions(-)
 create mode 100644 arch/x86/lib/orc.c

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 5a2baf28a1dc..7708548713c4 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -67,6 +67,13 @@ struct orc_entry {
 #endif
 } __packed;
 
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+void orc_sort(int *ip_table, struct orc_entry *orc_table, u32 num_orcs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..e5748bf15966 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -25,11 +25,6 @@ extern struct orc_entry __stop_orc_unwind[];
 static bool orc_init __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
 static struct orc_entry *__orc_find(int *ip_table, struct orc_entry *u_table,
 				    unsigned int num_entries, unsigned long ip)
 {
@@ -188,53 +183,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 }
 
 #ifdef CONFIG_MODULES
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
 void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 			void *_orc, size_t orc_size)
 {
@@ -246,16 +194,7 @@ void unwind_module_init(struct module *mod, void *_orc_ip, size_t orc_ip_size,
 		     orc_size % sizeof(*orc) != 0 ||
 		     num_entries != orc_size / sizeof(*orc));
 
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
+	orc_sort(orc_ip, orc, num_entries);
 
 	mod->arch.orc_unwind_ip = orc_ip;
 	mod->arch.orc_unwind = orc;
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index c6506c6a7092..4335518adcaf 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -50,6 +50,7 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
+lib-$(CONFIG_UNWINDER_ORC) += orc.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
diff --git a/arch/x86/lib/orc.c b/arch/x86/lib/orc.c
new file mode 100644
index 000000000000..5c37494bbbb5
--- /dev/null
+++ b/arch/x86/lib/orc.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ORC sorting shared by the compressed boot code and ORC module
+ * support.
+ */
+
+#include <asm/orc_types.h>
+#include <linux/mutex.h>
+#include <linux/sort.h>
+
+#ifndef ORC_COMPRESSED_BOOT
+static DEFINE_MUTEX(sort_mutex);
+
+#define sort_mutex_lock()	mutex_lock(&sort_mutex)
+#define sort_mutex_unlock()	mutex_unlock(&sort_mutex)
+#else /* ORC_COMPRESSED_BOOT */
+#define sort_mutex_lock()
+#define sort_mutex_unlock()
+#endif /* ORC_COMPRESSED_BOOT */
+
+static int *cur_orc_ip_table;
+static struct orc_entry *cur_orc_table;
+
+static void orc_sort_swap(void *_a, void *_b, int size)
+{
+	struct orc_entry *orc_a, *orc_b;
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
+	swap(*orc_a, *orc_b);
+}
+
+static int orc_sort_cmp(const void *_a, const void *_b)
+{
+	const int *a = _a, *b = _b;
+	unsigned long a_val = orc_ip(a);
+	unsigned long b_val = orc_ip(b);
+	struct orc_entry *orc_a;
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
+void orc_sort(int *ip_table, struct orc_entry *orc_table, u32 num_orcs)
+{
+	/*
+	 * The 'cur_orc_*' globals allow the orc_sort_swap() callback to
+	 * associate an .orc_unwind_ip table entry with its corresponding
+	 * .orc_unwind entry so they can both be swapped.
+	 */
+	sort_mutex_lock();
+	cur_orc_ip_table = ip_table;
+	cur_orc_table = orc_table;
+	sort(ip_table, num_orcs, sizeof(int), orc_sort_cmp,
+	     orc_sort_swap);
+	sort_mutex_unlock();
+}
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index a2baa2fefb13..44f8d7d654ff 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -96,11 +96,6 @@ struct orc_entry *g_orc_table;
 
 pthread_t orc_sort_thread;
 
-static inline unsigned long orc_ip(const int *ip)
-{
-	return (unsigned long)ip + *ip;
-}
-
 static int orc_sort_cmp(const void *_a, const void *_b)
 {
 	struct orc_entry *orc_a;
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 5a2baf28a1dc..7708548713c4 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -67,6 +67,13 @@ struct orc_entry {
 #endif
 } __packed;
 
+static inline unsigned long orc_ip(const int *ip)
+{
+	return (unsigned long)ip + *ip;
+}
+
+void orc_sort(int *ip_table, struct orc_entry *orc_table, u32 num_orcs);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
-- 
2.33.1

