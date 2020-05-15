Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B481D573F
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgEORQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:56 -0400
Received: from foss.arm.com ([217.140.110.172]:59522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEORQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67ADB1042;
        Fri, 15 May 2020 10:16:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D37A73F305;
        Fri, 15 May 2020 10:16:53 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v4 17/26] arm64: mte: Restore the GCR_EL1 register after a suspend
Date:   Fri, 15 May 2020 18:16:03 +0100
Message-Id: <20200515171612.1020-18-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
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
index c79dbffd30c4..7435f6619bf1 100644
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
index 999300e2110e..cda09bc8caf4 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -116,6 +116,14 @@ void mte_thread_switch(struct task_struct *next)
 	update_gcr_el1_excl(next->thread.gcr_incl);
 }
 
+void mte_suspend_exit(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	update_gcr_el1_excl(current->thread.gcr_incl);
+}
+
 long set_mte_ctrl(unsigned long arg)
 {
 	u64 tcf0;
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 9405d1b7f4b0..1d405b73d009 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -9,6 +9,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/exec.h>
+#include <asm/mte.h>
 #include <asm/pgtable.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
@@ -74,6 +75,9 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
 		arm64_set_ssbd_mitigation(false);
+
+	/* Restore additional MTE-specific configuration */
+	mte_suspend_exit();
 }
 
 /*
