Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E1FD30C8
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfJJSqA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 14:46:00 -0400
Received: from foss.arm.com ([217.140.110.172]:38538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbfJJSp7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 14:45:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0A691000;
        Thu, 10 Oct 2019 11:45:58 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D40A3F703;
        Thu, 10 Oct 2019 11:45:56 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/12] arm64: traps: Shuffle code to eliminate forward declarations
Date:   Thu, 10 Oct 2019 19:44:38 +0100
Message-Id: <1570733080-21015-11-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hoist the IT state handling code earlier in traps.c, to avoid
accumulating forward declarations.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/traps.c | 101 ++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 44c91d4..3af2768 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -268,7 +268,55 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }
 
-static void advance_itstate(struct pt_regs *regs);
+#ifdef CONFIG_COMPAT
+#define PSTATE_IT_1_0_SHIFT	25
+#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
+#define PSTATE_IT_7_2_SHIFT	10
+#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
+
+static u32 compat_get_it_state(struct pt_regs *regs)
+{
+	u32 it, pstate = regs->pstate;
+
+	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
+	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
+
+	return it;
+}
+
+static void compat_set_it_state(struct pt_regs *regs, u32 it)
+{
+	u32 pstate_it;
+
+	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
+	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
+
+	regs->pstate &= ~PSR_AA32_IT_MASK;
+	regs->pstate |= pstate_it;
+}
+
+static void advance_itstate(struct pt_regs *regs)
+{
+	u32 it;
+
+	/* ARM mode */
+	if (!(regs->pstate & PSR_AA32_T_BIT) ||
+	    !(regs->pstate & PSR_AA32_IT_MASK))
+		return;
+
+	it  = compat_get_it_state(regs);
+
+	/*
+	 * If this is the last instruction of the block, wipe the IT
+	 * state. Otherwise advance it.
+	 */
+	if (!(it & 7))
+		it = 0;
+	else
+		it = (it & 0xe0) | ((it << 1) & 0x1f);
+
+	compat_set_it_state(regs, it);
+}
 
 void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 {
@@ -563,34 +611,6 @@ static const struct sys64_hook sys64_hooks[] = {
 	{},
 };
 
-
-#ifdef CONFIG_COMPAT
-#define PSTATE_IT_1_0_SHIFT	25
-#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
-#define PSTATE_IT_7_2_SHIFT	10
-#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
-
-static u32 compat_get_it_state(struct pt_regs *regs)
-{
-	u32 it, pstate = regs->pstate;
-
-	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
-	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
-
-	return it;
-}
-
-static void compat_set_it_state(struct pt_regs *regs, u32 it)
-{
-	u32 pstate_it;
-
-	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
-	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
-
-	regs->pstate &= ~PSR_AA32_IT_MASK;
-	regs->pstate |= pstate_it;
-}
-
 static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
 {
 	int cond;
@@ -611,29 +631,6 @@ static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
 	return aarch32_opcode_cond_checks[cond](regs->pstate);
 }
 
-static void advance_itstate(struct pt_regs *regs)
-{
-	u32 it;
-
-	/* ARM mode */
-	if (!(regs->pstate & PSR_AA32_T_BIT) ||
-	    !(regs->pstate & PSR_AA32_IT_MASK))
-		return;
-
-	it  = compat_get_it_state(regs);
-
-	/*
-	 * If this is the last instruction of the block, wipe the IT
-	 * state. Otherwise advance it.
-	 */
-	if (!(it & 7))
-		it = 0;
-	else
-		it = (it & 0xe0) | ((it << 1) & 0x1f);
-
-	compat_set_it_state(regs, it);
-}
-
 static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
-- 
2.1.4

