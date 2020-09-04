Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0310F25D663
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIDKey (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbgIDKbY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:24 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF31820BED;
        Fri,  4 Sep 2020 10:31:21 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 21/29] arm64: mte: Allow {set,get}_tagged_addr_ctrl() on non-current tasks
Date:   Fri,  4 Sep 2020 11:30:21 +0100
Message-Id: <20200904103029.32083-22-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for ptrace() access to the prctl() value, allow calling
these functions on non-current tasks.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---

Notes:
    New in v7.

 arch/arm64/include/asm/mte.h       |  8 ++++----
 arch/arm64/include/asm/processor.h |  8 ++++----
 arch/arm64/kernel/mte.c            | 18 ++++++++++++------
 arch/arm64/kernel/process.c        | 18 ++++++++++--------
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index c93047eff9fe..1a919905295b 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -23,8 +23,8 @@ void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
 void mte_thread_switch(struct task_struct *next);
 void mte_suspend_exit(void);
-long set_mte_ctrl(unsigned long arg);
-long get_mte_ctrl(void);
+long set_mte_ctrl(struct task_struct *task, unsigned long arg);
+long get_mte_ctrl(struct task_struct *task);
 
 #else
 
@@ -46,11 +46,11 @@ static inline void mte_thread_switch(struct task_struct *next)
 static inline void mte_suspend_exit(void)
 {
 }
-static inline long set_mte_ctrl(unsigned long arg)
+static inline long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
 	return 0;
 }
-static inline long get_mte_ctrl(void)
+static inline long get_mte_ctrl(struct task_struct *task)
 {
 	return 0;
 }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index e1b1c2a6086e..fec204d28fce 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -319,10 +319,10 @@ extern void __init minsigstksz_setup(void);
 
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 /* PR_{SET,GET}_TAGGED_ADDR_CTRL prctl */
-long set_tagged_addr_ctrl(unsigned long arg);
-long get_tagged_addr_ctrl(void);
-#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(arg)
-#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl()
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
+long get_tagged_addr_ctrl(struct task_struct *task);
+#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
+#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
 #endif
 
 /*
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 09cf76fc1090..e80c49af74af 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -124,9 +124,10 @@ void mte_suspend_exit(void)
 	update_gcr_el1_excl(current->thread.gcr_user_incl);
 }
 
-long set_mte_ctrl(unsigned long arg)
+long set_mte_ctrl(struct task_struct *task, unsigned long arg)
 {
 	u64 tcf0;
+	u64 gcr_incl = (arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT;
 
 	if (!system_supports_mte())
 		return 0;
@@ -145,22 +146,27 @@ long set_mte_ctrl(unsigned long arg)
 		return -EINVAL;
 	}
 
-	set_sctlr_el1_tcf0(tcf0);
-	set_gcr_el1_excl((arg & PR_MTE_TAG_MASK) >> PR_MTE_TAG_SHIFT);
+	if (task != current) {
+		task->thread.sctlr_tcf0 = tcf0;
+		task->thread.gcr_user_incl = gcr_incl;
+	} else {
+		set_sctlr_el1_tcf0(tcf0);
+		set_gcr_el1_excl(gcr_incl);
+	}
 
 	return 0;
 }
 
-long get_mte_ctrl(void)
+long get_mte_ctrl(struct task_struct *task)
 {
 	unsigned long ret;
 
 	if (!system_supports_mte())
 		return 0;
 
-	ret = current->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
+	ret = task->thread.gcr_user_incl << PR_MTE_TAG_SHIFT;
 
-	switch (current->thread.sctlr_tcf0) {
+	switch (task->thread.sctlr_tcf0) {
 	case SCTLR_EL1_TCF0_NONE:
 		return PR_MTE_TCF_NONE;
 	case SCTLR_EL1_TCF0_SYNC:
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c80383f30d6a..05a9cdd0b471 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -641,11 +641,12 @@ void arch_setup_new_exec(void)
  */
 static unsigned int tagged_addr_disabled;
 
-long set_tagged_addr_ctrl(unsigned long arg)
+long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 {
 	unsigned long valid_mask = PR_TAGGED_ADDR_ENABLE;
+	struct thread_info *ti = task_thread_info(task);
 
-	if (is_compat_task())
+	if (is_compat_thread(ti))
 		return -EINVAL;
 
 	if (system_supports_mte())
@@ -661,25 +662,26 @@ long set_tagged_addr_ctrl(unsigned long arg)
 	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
 		return -EINVAL;
 
-	if (set_mte_ctrl(arg) != 0)
+	if (set_mte_ctrl(task, arg) != 0)
 		return -EINVAL;
 
-	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
+	update_ti_thread_flag(ti, TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
 
 	return 0;
 }
 
-long get_tagged_addr_ctrl(void)
+long get_tagged_addr_ctrl(struct task_struct *task)
 {
 	long ret = 0;
+	struct thread_info *ti = task_thread_info(task);
 
-	if (is_compat_task())
+	if (is_compat_thread(ti))
 		return -EINVAL;
 
-	if (test_thread_flag(TIF_TAGGED_ADDR))
+	if (test_ti_thread_flag(ti, TIF_TAGGED_ADDR))
 		ret = PR_TAGGED_ADDR_ENABLE;
 
-	ret |= get_mte_ctrl();
+	ret |= get_mte_ctrl(task);
 
 	return ret;
 }
