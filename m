Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872B63FCA2D
	for <lists+linux-arch@lfdr.de>; Tue, 31 Aug 2021 16:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhHaOnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Aug 2021 10:43:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:36606 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238711AbhHaOnW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Aug 2021 10:43:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205617115"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205617115"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 07:42:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="466478304"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2021 07:42:21 -0700
Received: from alobakin-mobl.ger.corp.intel.com (psmrokox-mobl.ger.corp.intel.com [10.213.6.58])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 17VEfmff002209;
        Tue, 31 Aug 2021 15:42:18 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org
Cc:     "Kristen C Accardi" <kristen.c.accardi@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Lukasz Czapnik <lukasz.czapnik@intel.com>,
        "Marta A Plantykow" <marta.a.plantykow@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 kspp-next 15/22] kallsyms: Hide layout
Date:   Tue, 31 Aug 2021 16:41:07 +0200
Message-Id: <20210831144114.154-16-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210831144114.154-1-alexandr.lobakin@intel.com>
References: <20210831144114.154-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

This patch makes /proc/kallsyms display in a random order, rather
than sorted by address in order to hide the newly randomized address
layout.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reported-by: kernel test robot <lkp@intel.com> # swap.cocci
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 kernel/kallsyms.c | 158 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0ba87982d017..5ffdcc2fb88e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -563,6 +563,12 @@ struct kallsym_iter {
 	int show_value;
 };
 
+struct kallsyms_shuffled_iter {
+	struct kallsym_iter iter;
+	loff_t total_syms;
+	loff_t shuffled_index[];
+};
+
 int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
 			    char *type, char *name)
 {
@@ -810,7 +816,7 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int __kallsyms_open(struct inode *inode, struct file *file)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -831,6 +837,156 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/*
+ * When function granular kaslr is enabled, we need to print out the symbols
+ * at random so we don't reveal the new layout.
+ */
+#ifdef CONFIG_FG_KASLR
+static int update_random_pos(struct kallsyms_shuffled_iter *s_iter,
+			     loff_t pos, loff_t *new_pos)
+{
+	loff_t new;
+
+	if (pos >= s_iter->total_syms)
+		return 0;
+
+	new = s_iter->shuffled_index[pos];
+
+	/*
+	 * normally this would be done as part of update_iter, however,
+	 * we want to avoid triggering this in the event that new is
+	 * zero since we don't want to blow away our pos end indicators.
+	 */
+	if (new == 0) {
+		s_iter->iter.name[0] = '\0';
+		s_iter->iter.nameoff = get_symbol_offset(new);
+		s_iter->iter.pos = new;
+	}
+
+	*new_pos = new;
+	return 1;
+}
+
+static void *shuffled_start(struct seq_file *m, loff_t *pos)
+{
+	struct kallsyms_shuffled_iter *s_iter = m->private;
+	loff_t new_pos;
+
+	if (!update_random_pos(s_iter, *pos, &new_pos))
+		return NULL;
+
+	return s_start(m, &new_pos);
+}
+
+static void *shuffled_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct kallsyms_shuffled_iter *s_iter = m->private;
+	loff_t new_pos;
+
+	(*pos)++;
+
+	if (!update_random_pos(s_iter, *pos, &new_pos))
+		return NULL;
+
+	if (!update_iter(m->private, new_pos))
+		return NULL;
+
+	return p;
+}
+
+/*
+ * shuffle_index_list()
+ * Use a Fisher Yates algorithm to shuffle a list of text sections.
+ */
+static void shuffle_index_list(loff_t *indexes, loff_t size)
+{
+	u32 i, j;
+
+	for (i = size - 1; i > 0; i--) {
+		/* pick a random index from 0 to i */
+		j = get_random_u32() % (i + 1);
+
+		swap(indexes[i], indexes[j]);
+	}
+}
+
+static const struct seq_operations kallsyms_shuffled_op = {
+	.start = shuffled_start,
+	.next = shuffled_next,
+	.stop = s_stop,
+	.show = s_show
+};
+
+static int kallsyms_random_open(struct inode *inode, struct file *file)
+{
+	loff_t pos;
+	struct kallsyms_shuffled_iter *shuffled_iter;
+	struct kallsym_iter iter;
+	bool show_value;
+
+	/*
+	 * If privileged, go ahead and use the normal algorithm for
+	 * displaying symbols
+	 */
+	show_value = kallsyms_show_value(file->f_cred);
+	if (show_value)
+		return __kallsyms_open(inode, file);
+
+	/*
+	 * we need to figure out how many extra symbols there are
+	 * to print out past kallsyms_num_syms
+	 */
+	pos = kallsyms_num_syms;
+	reset_iter(&iter, 0);
+	do {
+		if (!update_iter(&iter, pos))
+			break;
+		pos++;
+	} while (1);
+
+	/*
+	 * add storage space for an array of loff_t equal to the size
+	 * of the total number of symbols we need to print
+	 */
+	shuffled_iter = __seq_open_private(file, &kallsyms_shuffled_op,
+					   sizeof(*shuffled_iter) +
+					   (sizeof(pos) * pos));
+	if (!shuffled_iter)
+		return -ENOMEM;
+
+	reset_iter(&shuffled_iter->iter, 0);
+	shuffled_iter->iter.show_value = show_value;
+	shuffled_iter->total_syms = pos;
+
+	/*
+	 * the existing update_iter algorithm requires that we
+	 * are either moving along increasing pos sequentially,
+	 * or that these values are correct. Since these values
+	 * were discovered above, initialize our new iter so we
+	 * can use update_iter non-sequentially.
+	 */
+	shuffled_iter->iter.pos_arch_end = iter.pos_arch_end;
+	shuffled_iter->iter.pos_mod_end = iter.pos_mod_end;
+	shuffled_iter->iter.pos_ftrace_mod_end = iter.pos_ftrace_mod_end;
+
+	/*
+	 * initialize the array with all possible pos values, then
+	 * shuffle the array so that the values will display in a random
+	 * order.
+	 */
+	for (pos = 0; pos < shuffled_iter->total_syms; pos++)
+		shuffled_iter->shuffled_index[pos] = pos;
+
+	shuffle_index_list(shuffled_iter->shuffled_index, shuffled_iter->total_syms);
+
+	return 0;
+}
+
+#define kallsyms_open kallsyms_random_open
+#else
+#define kallsyms_open __kallsyms_open
+#endif /* !CONFIG_FG_KASLR */
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
-- 
2.31.1

