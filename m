Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3425078D
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHXS2s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgHXS2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:46 -0400
Received: from localhost.localdomain (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA2F20738;
        Mon, 24 Aug 2020 18:28:44 +0000 (UTC)
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
Subject: [PATCH v8 19/28] arm64: mte: Restore the GCR_EL1 register after a suspend
Date:   Mon, 24 Aug 2020 19:27:49 +0100
Message-Id: <20200824182758.27267-20-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824182758.27267-1-catalin.marinas@arm.com>
References: <20200824182758.27267-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The CPU resume/suspend routines only take care of the common system
registers. Restore GCR_EL1 in addition via the __cpu_suspend_exit()
function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

Notes:
    New in v3.

 arch/arm64/include/asm/mte.h | 4 ++++
 arch/arm64/kernel/mte.c      | 8 ++++++++
 arch/arm64/kernel/suspend.c  | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index df2efbc9f8f1..c93047eff9fe 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -22,6 +22,7 @@ void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
 void mte_thread_switch(struct task_struct *next);
+void mte_suspend_exit(void);
 long set_mte_ctrl(unsigned long arg);
 long get_mte_ctrl(void);
 
@@ -42,6 +43,9 @@ static inline void flush_mte_state(void)
 static inline void mte_thread_switch(struct task_struct *next)
 {
 }
+static inline void mte_suspend_exit(void)
+{
+}
 static inline long set_mte_ctrl(unsigned long arg)
 {
 	return 0;
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 07798b8d5039..09cf76fc1090 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -116,6 +116,14 @@ void mte_thread_switch(struct task_struct *next)
 	update_gcr_el1_excl(next->thread.gcr_user_incl);
 }
 
+void mte_suspend_exit(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	update_gcr_el1_excl(current->thread.gcr_user_incl);
+}
+
 long set_mte_ctrl(unsigned long arg)
 {
 	u64 tcf0;
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index c1dee9066ff9..62c239cd60c2 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -10,6 +10,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/exec.h>
+#include <asm/mte.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
 #include <asm/smp_plat.h>
@@ -74,6 +75,9 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
 		arm64_set_ssbd_mitigation(false);
+
+	/* Restore additional MTE-specific configuration */
+	mte_suspend_exit();
 }
 
 /*
