Return-Path: <linux-arch+bounces-9552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619AD9FFAB6
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 16:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8B1881ED2
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6381B4253;
	Thu,  2 Jan 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StxHrsmm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D546E1B4120;
	Thu,  2 Jan 2025 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830138; cv=none; b=D8lU+5NLTi+DxIh1NZEfISHrzASz47zxYSQ5pn2OuDTZlv9fwV8p+fVtAq6SYsIikR2AJbJDlju92wlyATy0iHeFZEkIh2VgzlJvgUQiTmXmxZYYHgCvM9j/FWSd23wu2pax/d6uDdnY1F5FAHJEFkKRB3n7wvE+0sTqu7jhJ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830138; c=relaxed/simple;
	bh=F1FmzVp6iCOT8qiM1kjCr6AQCFvi69gi8t0iIwn4s5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElFTOrIUP+6o+iC9j7q+rMhvf+w00w+Uz/i+x6k/GhkwcgUvrLbuCYEdO0xbfqcls5NgZB5tWU9cOJu+RdkqcKrFgMzIteoF+SymZhLPUzqS6svM+nMoB07Mp3C7vZhmlGcX89lKPxouQiYCM+xL4/YVAoADsmh1ER9ufDYjtik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StxHrsmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74A6C4CEDD;
	Thu,  2 Jan 2025 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830138;
	bh=F1FmzVp6iCOT8qiM1kjCr6AQCFvi69gi8t0iIwn4s5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StxHrsmmFW/2gj6R3DymlKgYReiQApi2t3zi3CclCNOiILo4eEg/vU4OKWXuPvo67
	 W6qBi5R1cL28xjBz6dWLY/oCJvJf+2erTsE3GYnQINohLp6oHuJ/rmYVUei1NPTyYL
	 B74GNMHBj+rH6TEPEYB5fRrQ/MQlXabbGDVrhluoWAM7PcooKFdhfL19p+z12ksR1G
	 Qk+hc6C4byaPyg2g3H6JFjB6x84gpPCsodZJzzfXY+uHK14IqCaG0Sp0NjsSAcx23N
	 T6AvpdeOyx/iN4B8Y7U/Q8bd5D5U8R/5Hi34pQ8sgiDiMJiV1G4Y44xFcJR/75711u
	 rRfmZP72UYpZA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Len Brown <lenb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 3/6] x86/cpuidle: Move buggy mwait implementations away from CPUIDLE_FLAG_MWAIT
Date: Thu,  2 Jan 2025 16:01:57 +0100
Message-ID: <20250102150201.21639-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250102150201.21639-1-frederic@kernel.org>
References: <20250102150201.21639-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Buggy MWAIT implementations can't carry the CPUIDLE_FLAG_MWAIT flag
because they require IPIs to wake up. Therefore they shouldn't be
called with TIF_NR_POLLING.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/arm/include/asm/cpuidle.h     |  2 ++
 arch/arm64/include/asm/cpuidle.h   |  3 +++
 arch/powerpc/include/asm/cpuidle.h |  4 ++++
 arch/riscv/include/asm/cpuidle.h   |  2 ++
 arch/x86/include/asm/cpuidle.h     | 12 ++++++++++++
 drivers/acpi/processor_idle.c      |  4 +++-
 drivers/idle/intel_idle.c          |  9 +++++++--
 include/asm-generic/Kbuild         |  1 +
 include/asm-generic/cpuidle.h      | 10 ++++++++++
 9 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuidle.h
 create mode 100644 include/asm-generic/cpuidle.h

diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
index 397be5ed30e7..0ea1d2ec837d 100644
--- a/arch/arm/include/asm/cpuidle.h
+++ b/arch/arm/include/asm/cpuidle.h
@@ -55,4 +55,6 @@ struct arm_cpuidle_irq_context { };
 #define arm_cpuidle_save_irq_context(c)		(void)c
 #define arm_cpuidle_restore_irq_context(c)	(void)c
 
+#include <asm-generic/cpuidle.h>
+
 #endif
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 2047713e097d..ef49124135a7 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -38,4 +38,7 @@ struct arm_cpuidle_irq_context { };
 #define arm_cpuidle_save_irq_context(c)		(void)c
 #define arm_cpuidle_restore_irq_context(c)	(void)c
 #endif
+
+#include <asm-generic/cpuidle.h>
+
 #endif
diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 0cce5dc7fb1c..788706bc04ec 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -102,4 +102,8 @@ static inline void report_invalid_psscr_val(u64 psscr_val, int err)
 
 #endif
 
+#ifndef __ASSEMBLY__
+#include <asm-generic/cpuidle.h>
+#endif
+
 #endif
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
index 71fdc607d4bc..1f1b24901d86 100644
--- a/arch/riscv/include/asm/cpuidle.h
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -21,4 +21,6 @@ static inline void cpu_do_idle(void)
 	wait_for_interrupt();
 }
 
+#include <asm-generic/cpuidle.h>
+
 #endif
diff --git a/arch/x86/include/asm/cpuidle.h b/arch/x86/include/asm/cpuidle.h
new file mode 100644
index 000000000000..a59db1a3314a
--- /dev/null
+++ b/arch/x86/include/asm/cpuidle.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CPUIDLE_H
+#define _ASM_X86_CPUIDLE_H
+
+#include <asm/cpufeature.h>
+
+static inline bool arch_cpuidle_mwait_needs_ipi(void)
+{
+	return boot_cpu_has_bug(X86_BUG_MONITOR);
+}
+
+#endif /* _ASM_X86_CPUIDLE_H */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 66cb5536d91e..0f29dd92b346 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -23,6 +23,7 @@
 #include <linux/perf_event.h>
 #include <acpi/processor.h>
 #include <linux/context_tracking.h>
+#include <asm/cpuidle.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -806,7 +807,8 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
 			drv->safe_state_index = count;
 
-		if (cx->entry_method == ACPI_CSTATE_FFH)
+		if (cx->entry_method == ACPI_CSTATE_FFH &&
+		    !arch_cpuidle_mwait_needs_ipi())
 			state->flags |= CPUIDLE_FLAG_MWAIT;
 
 		/*
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d52723fbeb04..b2f494effd4a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/cpuidle.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -1787,7 +1788,10 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (cx->type > ACPI_STATE_C1)
 			state->target_residency *= 3;
 
-		state->flags = MWAIT2flg(cx->address) | CPUIDLE_FLAG_MWAIT;
+		state->flags = MWAIT2flg(cx->address);
+
+		if (!arch_cpuidle_mwait_needs_ipi())
+			state->flags |= CPUIDLE_FLAG_MWAIT;
 
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
@@ -2073,7 +2077,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
-	state->flags |= CPUIDLE_FLAG_MWAIT;
+	if (!arch_cpuidle_mwait_needs_ipi())
+		state->flags |= CPUIDLE_FLAG_MWAIT;
 
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 1b43c3a77012..7754da499d16 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -13,6 +13,7 @@ mandatory-y += cacheflush.h
 mandatory-y += cfi.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
+mandatory-y += cpuidle.h
 mandatory-y += current.h
 mandatory-y += delay.h
 mandatory-y += device.h
diff --git a/include/asm-generic/cpuidle.h b/include/asm-generic/cpuidle.h
new file mode 100644
index 000000000000..748a2022ed2a
--- /dev/null
+++ b/include/asm-generic/cpuidle.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_CPUIDLE_H
+#define __ASM_CPUIDLE_H
+
+static inline bool arch_cpuidle_mwait_needs_ipi(void)
+{
+	return true;
+}
+
+#endif /* __ASM_CPUIDLE_H */
-- 
2.46.0


