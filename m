Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1321411BBF8
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLKSlL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:41:11 -0500
Received: from foss.arm.com ([217.140.110.172]:43234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfLKSlL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:41:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB91314FF;
        Wed, 11 Dec 2019 10:41:10 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 729483F6CF;
        Wed, 11 Dec 2019 10:41:09 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 20/22] arm64: mte: Allow user control of the excluded tags via prctl()
Date:   Wed, 11 Dec 2019 18:40:25 +0000
Message-Id: <20191211184027.20130-21-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The IRG, ADDG and SUBG instructions insert a random tag in the resulting
address. Certain tags can be excluded via the GCR_EL1.Exclude bitmap
when, for example, the user wants a certain colour for freed buffers.
Since the GCR_EL1 register is not accessible at EL0, extend the
prctl(PR_SET_TAGGED_ADDR_CTRL) interface to include a 16-bit field in
the first argument for controlling the excluded tags. This setting is
pre-thread.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/include/asm/sysreg.h    |  7 +++++++
 arch/arm64/kernel/process.c        | 27 +++++++++++++++++++++++----
 include/uapi/linux/prctl.h         |  3 +++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 91aa270afc7d..5b6988035334 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -150,6 +150,7 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_ARM64_MTE
 	u64			sctlr_tcf0;
+	u64			gcr_excl;
 #endif
 };
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e5753272f4b..b6bb6d31f1cd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -901,6 +901,13 @@
 		write_sysreg(__scs_new, sysreg);			\
 } while (0)
 
+#define sysreg_clear_set_s(sysreg, clear, set) do {			\
+	u64 __scs_val = read_sysreg_s(sysreg);				\
+	u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);		\
+	if (__scs_new != __scs_val)					\
+		write_sysreg_s(__scs_new, sysreg);			\
+} while (0)
+
 #endif
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 47ce98f47253..5ec6889795fc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -502,6 +502,15 @@ static void update_sctlr_el1_tcf0(u64 tcf0)
 	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
 }
 
+static void update_gcr_el1_excl(u64 excl)
+{
+	/*
+	 * No need for ISB since this only affects EL0 currently, implicit
+	 * with ERET.
+	 */
+	sysreg_clear_set_s(SYS_GCR_EL1, SYS_GCR_EL1_EXCL_MASK, excl);
+}
+
 /* Handle MTE thread switch */
 static void mte_thread_switch(struct task_struct *next)
 {
@@ -511,6 +520,7 @@ static void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
+	update_gcr_el1_excl(next->thread.gcr_excl);
 }
 #else
 static void mte_thread_switch(struct task_struct *next)
@@ -641,22 +651,31 @@ static long set_mte_ctrl(unsigned long arg)
 	update_sctlr_el1_tcf0(tcf0);
 	preempt_enable();
 
+	current->thread.gcr_excl = (arg & PR_MTE_EXCL_MASK) >> PR_MTE_EXCL_SHIFT;
+	update_gcr_el1_excl(current->thread.gcr_excl);
+
 	return 0;
 }
 
 static long get_mte_ctrl(void)
 {
+	unsigned long ret;
+
 	if (!system_supports_mte())
 		return 0;
 
+	ret = current->thread.gcr_excl << PR_MTE_EXCL_SHIFT;
+
 	switch (current->thread.sctlr_tcf0) {
 	case SCTLR_EL1_TCF0_SYNC:
-		return PR_MTE_TCF_SYNC;
+		ret |= PR_MTE_TCF_SYNC;
+		break;
 	case SCTLR_EL1_TCF0_ASYNC:
-		return PR_MTE_TCF_ASYNC;
+		ret |= PR_MTE_TCF_ASYNC;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 #else
 static long set_mte_ctrl(unsigned long arg)
@@ -684,7 +703,7 @@ long set_tagged_addr_ctrl(unsigned long arg)
 		return -EINVAL;
 
 	if (system_supports_mte())
-		valid_mask |= PR_MTE_TCF_MASK;
+		valid_mask |= PR_MTE_TCF_MASK | PR_MTE_EXCL_MASK;
 
 	if (arg & ~valid_mask)
 		return -EINVAL;
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5e9323e66a38..749de5ab4f9f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -239,5 +239,8 @@ struct prctl_mm_map {
 # define PR_MTE_TCF_SYNC		(1UL << PR_MTE_TCF_SHIFT)
 # define PR_MTE_TCF_ASYNC		(2UL << PR_MTE_TCF_SHIFT)
 # define PR_MTE_TCF_MASK		(3UL << PR_MTE_TCF_SHIFT)
+/* MTE tag exclusion mask */
+# define PR_MTE_EXCL_SHIFT		3
+# define PR_MTE_EXCL_MASK		(0xffffUL << PR_MTE_EXCL_SHIFT)
 
 #endif /* _LINUX_PRCTL_H */
