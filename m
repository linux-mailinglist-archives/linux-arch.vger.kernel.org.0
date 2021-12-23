Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519C747DBE7
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345823AbhLWAYH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:24:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:59144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345655AbhLWAXm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219022; x=1671755022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJt4EQ6UCbCx+1z2FmP05zLBMZ/f/ExXF1JWdLFGisg=;
  b=SE+7DKFmwSRdr25NK5yt11XUFQoVl4z1QD0SwtWFHPgPv4ME2UZHvu9h
   E2NgChM9o3Hd9QibE9VuHGdNx9iL9SIOLi8Cec+eIdyxDS2+Xyc7RPlp+
   vwR9+mEZKxq1nI2i5eJCjRYLCd1zzZTvjlzm9q8Va1Jc92iMC7gP2cdhY
   ZCcqRx6cPnEfXiaZCWalYpzQS4o+PnWZube9VzCxpl8dz475EtPOvj+0R
   +el4qLjnXTv2tvGESmrmhk7IROUAk7yapAULfumAmOzTItuujsWSqeRTK
   lYjsD8TqmPqzDt4Yo4EPjt8nKMOwF8TniV6jqvj+9K9UV9/03sTZjbzbW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="221405030"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="221405030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="587169695"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga004.fm.intel.com with ESMTP; 22 Dec 2021 16:23:16 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N798032467;
        Thu, 23 Dec 2021 00:23:13 GMT
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
Subject: [PATCH v9 03/15] kallsyms: Hide layout
Date:   Thu, 23 Dec 2021 01:21:57 +0100
Message-Id: <20211223002209.1092165-4-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

This patch makes /proc/kallsyms display in a random order, rather
than sorted by address in order to hide the newly randomized address
layout.

alobakin:
Don't depend FG-KASLR and always do that for unpriviledged accesses
as suggested by several folks.
Also, introduce and use a shuffle_array() macro which shuffles an
array using Fisher-Yates. We'll make use of it several more times
later on.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reported-by: kernel test robot <lkp@intel.com> # swap.cocci
Suggested-by: Ard Biesheuvel <ardb@kernel.org> # always do that
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com> # always do that
Suggested-by: Peter Zijlstra <peterz@infradead.org> # always do that, macro
Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 include/linux/random.h | 16 ++++++++
 kernel/kallsyms.c      | 93 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index f45b8be3e3c4..c859a698089c 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -110,6 +110,22 @@ declare_get_random_var_wait(long)
 
 unsigned long randomize_page(unsigned long start, unsigned long range);
 
+/**
+ * shuffle_array - use a Fisher Yates algorithm to shuffle an array.
+ * @arr: pointer to the array
+ * @nents: the number of elements in the array
+ */
+#define shuffle_array(arr, nents) ({				\
+	typeof(&(arr)[0]) __arr = &(arr)[0];			\
+	size_t __i;						\
+								\
+	for (__i = (nents) - 1; __i > 0; __i--) {		\
+		size_t __j = get_random_long() % (__i + 1);	\
+								\
+		swap(__arr[__i], __arr[__j]);			\
+	}							\
+})
+
 /*
  * This is designed to be standalone for just prandom
  * users, but for now we include it from <linux/random.h>
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3011bc33a5ba..5d41b993113f 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -574,13 +574,15 @@ struct kallsym_iter {
 	loff_t pos_mod_end;
 	loff_t pos_ftrace_mod_end;
 	loff_t pos_bpf_end;
+	loff_t pos_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
 	int exported;
-	int show_value;
+	bool show_layout;
+	loff_t shuffled_pos[];
 };
 
 int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
@@ -660,11 +662,19 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
  */
 static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
+	int ret;
+
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
-	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
-				  &iter->value, &iter->type,
-				  iter->name) < 0 ? 0 : 1;
+	ret = kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
+				 &iter->value, &iter->type,
+				 iter->name);
+	if (ret < 0) {
+		iter->pos_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
 }
 
 /* Returns space to next name. */
@@ -687,11 +697,12 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
 	iter->name[0] = '\0';
 	iter->nameoff = get_symbol_offset(new_pos);
 	iter->pos = new_pos;
-	if (new_pos == 0) {
+	if (iter->show_layout && new_pos == 0) {
 		iter->pos_arch_end = 0;
 		iter->pos_mod_end = 0;
 		iter->pos_ftrace_mod_end = 0;
 		iter->pos_bpf_end = 0;
+		iter->pos_end = 0;
 	}
 }
 
@@ -720,13 +731,23 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 	    get_ksymbol_bpf(iter))
 		return 1;
 
-	return get_ksymbol_kprobe(iter);
+	if ((!iter->pos_end || iter->pos_end > pos) &&
+	    get_ksymbol_kprobe(iter))
+		return 1;
+
+	return 0;
 }
 
 /* Returns false if pos at or past end of file. */
 static int update_iter(struct kallsym_iter *iter, loff_t pos)
 {
-	/* Module symbols can be accessed randomly. */
+	if (!iter->show_layout) {
+		if (pos > iter->pos_end)
+			return 0;
+
+		pos = iter->shuffled_pos[pos];
+	}
+
 	if (pos >= kallsyms_num_syms)
 		return update_iter_mod(iter, pos);
 
@@ -769,7 +790,7 @@ static int s_show(struct seq_file *m, void *p)
 	if (!iter->name[0])
 		return 0;
 
-	value = iter->show_value ? (void *)iter->value : NULL;
+	value = iter->show_layout ? (void *)iter->value : NULL;
 
 	if (iter->module_name[0]) {
 		char type;
@@ -806,9 +827,10 @@ static inline int kallsyms_for_perf(void)
 }
 
 /*
- * We show kallsyms information even to normal users if we've enabled
- * kernel profiling and are explicitly not paranoid (so kptr_restrict
- * is clear, and sysctl_perf_event_paranoid isn't set).
+ * We show kallsyms information and display them sorted by address even
+ * to normal users if we've enabled kernel profiling and are explicitly
+ * not paranoid (so kptr_restrict is clear, and sysctl_perf_event_paranoid
+ * isn't set).
  *
  * Otherwise, require CAP_SYSLOG (assuming kptr_restrict isn't set to
  * block even that).
@@ -838,16 +860,54 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
-	if (!iter)
-		return -ENOMEM;
-	reset_iter(iter, 0);
+	/*
+	 * This fake iter is needed for the cases with unprivileged
+	 * access. We need to know the exact number of symbols to
+	 * randomize the display layout.
+	 */
+	struct kallsym_iter fake;
+	size_t size = sizeof(*iter);
+	loff_t pos;
+
+	fake.show_layout = true;
+	reset_iter(&fake, 0);
 
 	/*
 	 * Instead of checking this on every s_show() call, cache
 	 * the result here at open time.
 	 */
-	iter->show_value = kallsyms_show_value(file->f_cred);
+	fake.show_layout = kallsyms_show_value(file->f_cred);
+	if (fake.show_layout)
+		goto open;
+
+	for (pos = kallsyms_num_syms; update_iter_mod(&fake, pos); pos++)
+		;
+
+	size = struct_size(iter, shuffled_pos, fake.pos_end + 1);
+
+open:
+	iter = __seq_open_private(file, &kallsyms_op, size);
+	if (!iter)
+		return -ENOMEM;
+
+	iter->show_layout = fake.show_layout;
+	reset_iter(iter, 0);
+
+	if (iter->show_layout)
+		return 0;
+
+	/* Copy the bounds since they were already discovered above */
+	iter->pos_arch_end = fake.pos_arch_end;
+	iter->pos_mod_end = fake.pos_mod_end;
+	iter->pos_ftrace_mod_end = fake.pos_ftrace_mod_end;
+	iter->pos_bpf_end = fake.pos_bpf_end;
+	iter->pos_end = fake.pos_end;
+
+	for (pos = 0; pos <= iter->pos_end; pos++)
+		iter->shuffled_pos[pos] = pos;
+
+	shuffle_array(iter->shuffled_pos, iter->pos_end + 1);
+
 	return 0;
 }
 
@@ -858,6 +918,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 	if (*pos == 0) {
 		memset(&kdb_walk_kallsyms_iter, 0,
 		       sizeof(kdb_walk_kallsyms_iter));
+		kdb_walk_kallsyms_iter.show_layout = true;
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-- 
2.33.1

