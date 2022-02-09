Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D04AFCBA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 20:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241621AbiBITBx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 14:01:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiBITAn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 14:00:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEAC03E92B;
        Wed,  9 Feb 2022 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644433219; x=1675969219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yg+C8F7oXSf3fHkZtcL9h1OHdH9KdRrch9oP4ovQrw4=;
  b=XNaeLeE+ioMo+5afgu+d4ex7beBD1Gr1Xfo1B2Jdz1gWM6oaITRmHK13
   yE/aEmkaOClB9GC+nYKkxqGSmvnwaUXpRhASE8bu5Ay92/VvXjt1rVWpJ
   9IbX6cxMpaaaucZSzqpiqP4XsTrxImbogTDOmN2rTJP21f5pqnhRvcO6l
   0ccJvDr9joYmyY1apAU/QBWwUsFjcXq9tgPZyoBOc52gkEKDw/LY2GyoE
   Kg0DyTQiSxMOWyq6BFdrOUNcca57hSdxQwBorRAPzw3T0BLcUH+voYy/l
   ytbV010PzL/8JoI1c4eGlmgsEneqCRMKCYG1J+DijhOJ9lxiuDRbn8UzJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="273850090"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="273850090"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:59:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="585681729"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 10:59:01 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 219IwjQT031082;
        Wed, 9 Feb 2022 18:58:58 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v10 06/15] x86: decouple ORC table sorting into a separate file
Date:   Wed,  9 Feb 2022 19:57:43 +0100
Message-Id: <20220209185752.1226407-7-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
References: <20220209185752.1226407-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/x86/lib/Makefile                  |  3 +
 arch/x86/lib/orc.c                     | 78 ++++++++++++++++++++++++++
 scripts/sorttable.h                    |  5 --
 tools/arch/x86/include/asm/orc_types.h |  7 +++
 6 files changed, 96 insertions(+), 67 deletions(-)
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
index f76747862bd2..ff094cecebc4 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -50,6 +50,9 @@ lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
 lib-$(CONFIG_RETPOLINE) += retpoline.o
+ifdef CONFIG_MODULES
+lib-$(CONFIG_UNWINDER_ORC) += orc.o
+endif
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
diff --git a/arch/x86/lib/orc.c b/arch/x86/lib/orc.c
new file mode 100644
index 000000000000..6a42842bf4ef
--- /dev/null
+++ b/arch/x86/lib/orc.c
@@ -0,0 +1,78 @@
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
+
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
+
+	cur_orc_ip_table = ip_table;
+	cur_orc_table = orc_table;
+	sort(ip_table, num_orcs, sizeof(int), orc_sort_cmp, orc_sort_swap);
+
+	sort_mutex_unlock();
+}
diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index deb7c1d3e979..a6bb46f36854 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -103,11 +103,6 @@ struct orc_entry *g_orc_table;
 
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
2.34.1

