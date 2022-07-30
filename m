Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE30585AEE
	for <lists+linux-arch@lfdr.de>; Sat, 30 Jul 2022 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiG3PKj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Jul 2022 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiG3PKi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Jul 2022 11:10:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8C12AD9;
        Sat, 30 Jul 2022 08:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07B9AB800E2;
        Sat, 30 Jul 2022 15:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB6BC433C1;
        Sat, 30 Jul 2022 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659193834;
        bh=3GSGbnjxboDYBmenmjYXlTUKPvSgy9hoVCYPymp3jB8=;
        h=From:To:Cc:Subject:Date:From;
        b=YNt70xL7ySfcRu6h9Za5o/Ouwp0H+cPZoj60D+IbO3RiFru8PaQ/0RqeLNqUQdFzj
         2upf9pxIKB4dlSU5bH6tXU0DFm6O4Aq+xPqFwRWbWO/w0mBxr8wUulMz2bHp+OdMAg
         X8PoJc6qZPIKdKfqCjahx51Zbeh0/VT/mx53AugFpOFg0Jyq5tN/H2HxT5wBBC9qrb
         VAru0WTck2nh3zoZLBWI4P83oMzO6lWjQbtoRTfq9Ro9CCfmGVBqjHMY9Ka69PSmiW
         +miRb/3RB9+zYyhU07Ch9Zx8UoYZB5gZCeCUV2R8LIEvUPvbSxIU/rFLGFqrCuv1xp
         UBjqvbDfgmJfw==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Add jump-label implementation
Date:   Sat, 30 Jul 2022 11:10:20 -0400
Message-Id: <20220730151020.3175975-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add jump-label implementation for static branch

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                  |  2 ++
 arch/csky/include/asm/jump_label.h | 47 ++++++++++++++++++++++++++
 arch/csky/kernel/Makefile          |  1 +
 arch/csky/kernel/jump_label.c      | 54 ++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 arch/csky/include/asm/jump_label.h
 create mode 100644 arch/csky/kernel/jump_label.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 21d72b078eef..41d7d614f7a2 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -40,6 +40,8 @@ config CSKY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_JUMP_LABEL if !CPU_CK610
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_CONTEXT_TRACKING
diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/jump_label.h
new file mode 100644
index 000000000000..d488ba6084bc
--- /dev/null
+++ b/arch/csky/include/asm/jump_label.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_CSKY_JUMP_LABEL_H
+#define __ASM_CSKY_JUMP_LABEL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+#define JUMP_LABEL_NOP_SIZE 4
+
+static __always_inline bool arch_static_branch(struct static_key *key,
+					       bool branch)
+{
+	asm_volatile_goto(
+		"1:	nop32					\n"
+		"	.pushsection	__jump_table, \"aw\"	\n"
+		"	.align		2			\n"
+		"	.long		1b - ., %l[label] - .	\n"
+		"	.long		%0 - .			\n"
+		"	.popsection				\n"
+		:  :  "i"(&((char *)key)[branch]) :  : label);
+
+	return false;
+label:
+	return true;
+}
+
+static __always_inline bool arch_static_branch_jump(struct static_key *key,
+						    bool branch)
+{
+	asm_volatile_goto(
+		"1:	bsr32		%l[label]		\n"
+		"	.pushsection	__jump_table, \"aw\"	\n"
+		"	.align		2			\n"
+		"	.long		1b - ., %l[label] - .	\n"
+		"	.long		%0 - .			\n"
+		"	.popsection				\n"
+		:  :  "i"(&((char *)key)[branch]) :  : label);
+
+	return false;
+label:
+	return true;
+}
+
+#endif  /* __ASSEMBLY__ */
+#endif	/* __ASM_CSKY_JUMP_LABEL_H */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 4eb41421ca5b..6f14c924b20d 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_STACKTRACE)		+= stacktrace.o
 obj-$(CONFIG_CSKY_PMU_V1)		+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)            += perf_regs.o
+obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/csky/kernel/jump_label.c b/arch/csky/kernel/jump_label.c
new file mode 100644
index 000000000000..d0e8b21447e1
--- /dev/null
+++ b/arch/csky/kernel/jump_label.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/memory.h>
+#include <linux/mutex.h>
+#include <linux/uaccess.h>
+#include <asm/cacheflush.h>
+
+#define NOP32_HI	0xc400
+#define NOP32_LO	0x4820
+#define BSR_LINK	0xe000
+
+void arch_jump_label_transform(struct jump_entry *entry,
+			       enum jump_label_type type)
+{
+	unsigned long addr = jump_entry_code(entry);
+	u16 insn[2];
+	int ret = 0;
+
+	if (type == JUMP_LABEL_JMP) {
+		long offset = jump_entry_target(entry) - jump_entry_code(entry);
+
+		if (WARN_ON(offset & 1 || offset < -67108864 || offset >= 67108864))
+			return;
+
+		offset = offset >> 1;
+
+		insn[0] = BSR_LINK |
+			((uint16_t)((unsigned long) offset >> 16) & 0x3ff);
+		insn[1] = (uint16_t)((unsigned long) offset & 0xffff);
+	} else {
+		insn[0] = NOP32_HI;
+		insn[1] = NOP32_LO;
+	}
+
+	ret = copy_to_kernel_nofault((void *)addr, insn, 4);
+	WARN_ON(ret);
+
+	flush_icache_range(addr, addr + 4);
+}
+
+void arch_jump_label_transform_static(struct jump_entry *entry,
+				      enum jump_label_type type)
+{
+	/*
+	 * We use the same instructions in the arch_static_branch and
+	 * arch_static_branch_jump inline functions, so there's no
+	 * need to patch them up here.
+	 * The core will call arch_jump_label_transform  when those
+	 * instructions need to be replaced.
+	 */
+	arch_jump_label_transform(entry, type);
+}
-- 
2.36.1

