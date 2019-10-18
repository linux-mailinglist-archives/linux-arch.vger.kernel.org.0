Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC009DCCB5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505434AbfJRR1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 13:27:25 -0400
Received: from [217.140.110.172] ([217.140.110.172]:47180 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2502098AbfJRR1Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 13:27:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 712401476;
        Fri, 18 Oct 2019 10:27:02 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5F203F718;
        Fri, 18 Oct 2019 10:26:59 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 09/12] arm64: traps: Fix inconsistent faulting instruction skipping
Date:   Fri, 18 Oct 2019 18:25:42 +0100
Message-Id: <1571419545-20401-10-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
References: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Correct skipping of an instruction on AArch32 works a bit
differently from AArch64, mainly due to the different CPSR/PSTATE
semantics.

There have been various attempts to get this right.  Currenty
arm64_skip_faulting_instruction() mostly does the right thing, but
does not advance the IT state machine for the AArch32 case.

arm64_compat_skip_faulting_instruction() handles the IT state
machine but is local to traps.c, and porting other code to use it
will make a mess since there are some call sites that apply for
both the compat and native cases.

Since manual instruction skipping implies a trap, it's a relatively
slow path.

So, make arm64_skip_faulting_instruction() handle both compat and
native, and get rid of the arm64_compat_skip_faulting_instruction()
special case.

Fixes: 32a3e635fb0e ("arm64: compat: Add CNTFRQ trap handler")
Fixes: 1f1c014035a8 ("arm64: compat: Add condition code checks and IT advance")
Fixes: 6436beeee572 ("arm64: Fix single stepping in kernel traps")
Fixes: bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

**NOTE**

Despite discussions on the v2 series to the effect that the prior
behaviour is not broken, I'm now not so sure:

Taking another look, I now can't track down for example where SWP in an
IT block is specified to be UNPREDICTABLE.  I only see e.g., ARM DDI
0487E.a Section 1.8.2 ("F1.8.2 Partial deprecation of IT"), which only
deprecates the affected instructions.

The legacy AArch32 SWP{B} insn is obsoleted by ARMv8, but the whole
point of the armv8_deprecated stuff is to provide some backwards
compatiblity with v7.

So, this looks like it needs a closer look.

I'll leave the Fixes tags for now, so that the archaeology doesn't need
to be repeated if we conclude that this patch really is a fix.
---
 arch/arm64/kernel/traps.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 15e3c4f..44c91d4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -268,6 +268,8 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 	}
 }
 
+static void advance_itstate(struct pt_regs *regs);
+
 void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 {
 	regs->pc += size;
@@ -278,6 +280,9 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
 	 */
 	if (user_mode(regs))
 		user_fastforward_single_step(current);
+
+	if (regs->pstate & PSR_MODE32_BIT)
+		advance_itstate(regs);
 }
 
 static LIST_HEAD(undef_hook);
@@ -629,19 +634,12 @@ static void advance_itstate(struct pt_regs *regs)
 	compat_set_it_state(regs, it);
 }
 
-static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
-						   unsigned int sz)
-{
-	advance_itstate(regs);
-	arm64_skip_faulting_instruction(regs, sz);
-}
-
 static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
 
 	pt_regs_write_reg(regs, reg, arch_timer_get_rate());
-	arm64_compat_skip_faulting_instruction(regs, 4);
+	arm64_skip_faulting_instruction(regs, 4);
 }
 
 static const struct sys64_hook cp15_32_hooks[] = {
@@ -661,7 +659,7 @@ static void compat_cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
 
 	pt_regs_write_reg(regs, rt, lower_32_bits(val));
 	pt_regs_write_reg(regs, rt2, upper_32_bits(val));
-	arm64_compat_skip_faulting_instruction(regs, 4);
+	arm64_skip_faulting_instruction(regs, 4);
 }
 
 static const struct sys64_hook cp15_64_hooks[] = {
@@ -682,7 +680,7 @@ asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
 		 * There is no T16 variant of a CP access, so we
 		 * always advance PC by 4 bytes.
 		 */
-		arm64_compat_skip_faulting_instruction(regs, 4);
+		arm64_skip_faulting_instruction(regs, 4);
 		return;
 	}
 
-- 
2.1.4

