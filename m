Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28C184B3B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Mar 2020 16:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCMPpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Mar 2020 11:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:58978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgCMPpO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Mar 2020 11:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7232B31B;
        Fri, 13 Mar 2020 08:45:13 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0D73F67D;
        Fri, 13 Mar 2020 08:45:10 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
Date:   Fri, 13 Mar 2020 15:43:40 +0000
Message-Id: <20200313154345.56760-22-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313154345.56760-1-vincenzo.frascino@arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
code. This allows to replace the second isb() in __arch_get_hw_counter()
with a fake dependent stack read of the counter which improves the vdso
library peformances of ~4.5%. Below the results of vdsotest [1] ran for
100 iterations.

Before the patch:
=================
clock-gettime-monotonic: syscall: 771 nsec/call
clock-gettime-monotonic:    libc: 130 nsec/call
clock-gettime-monotonic:    vdso: 111 nsec/call
...
clock-gettime-realtime: syscall: 762 nsec/call
clock-gettime-realtime:    libc: 130 nsec/call
clock-gettime-realtime:    vdso: 111 nsec/call

After the patch:
================
clock-gettime-monotonic: syscall: 792 nsec/call
clock-gettime-monotonic:    libc: 124 nsec/call
clock-gettime-monotonic:    vdso: 106 nsec/call
...
clock-gettime-realtime: syscall: 776 nsec/call
clock-gettime-realtime:    libc: 124 nsec/call
clock-gettime-realtime:    vdso: 106 nsec/call

[1] https://github.com/nathanlynch/vdsotest

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/arch_timer.h        | 29 ++++---------------
 arch/arm64/include/asm/vdso/arch_timer.h   | 33 ++++++++++++++++++++++
 arch/arm64/include/asm/vdso/gettimeofday.h |  7 +++--
 3 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/include/asm/vdso/arch_timer.h

diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
index 7ae54d7d333a..7f22cd00ad45 100644
--- a/arch/arm64/include/asm/arch_timer.h
+++ b/arch/arm64/include/asm/arch_timer.h
@@ -164,24 +164,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
 	isb();
 }
 
-/*
- * Ensure that reads of the counter are treated the same as memory reads
- * for the purposes of ordering by subsequent memory barriers.
- *
- * This insanity brought to you by speculative system register reads,
- * out-of-order memory accesses, sequence locks and Thomas Gleixner.
- *
- * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
- */
-#define arch_counter_enforce_ordering(val) do {				\
-	u64 tmp, _val = (val);						\
-									\
-	asm volatile(							\
-	"	eor	%0, %1, %1\n"					\
-	"	add	%0, sp, %0\n"					\
-	"	ldr	xzr, [%0]"					\
-	: "=r" (tmp) : "r" (_val));					\
-} while (0)
+#include <asm/vdso/arch_timer.h>
 
 static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 {
@@ -189,7 +172,7 @@ static __always_inline u64 __arch_counter_get_cntpct_stable(void)
 
 	isb();
 	cnt = arch_timer_reg_read_stable(cntpct_el0);
-	arch_counter_enforce_ordering(cnt);
+	cnt = arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
 
@@ -199,7 +182,7 @@ static __always_inline u64 __arch_counter_get_cntpct(void)
 
 	isb();
 	cnt = read_sysreg(cntpct_el0);
-	arch_counter_enforce_ordering(cnt);
+	cnt = arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
 
@@ -209,7 +192,7 @@ static __always_inline u64 __arch_counter_get_cntvct_stable(void)
 
 	isb();
 	cnt = arch_timer_reg_read_stable(cntvct_el0);
-	arch_counter_enforce_ordering(cnt);
+	cnt = arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
 
@@ -219,12 +202,10 @@ static __always_inline u64 __arch_counter_get_cntvct(void)
 
 	isb();
 	cnt = read_sysreg(cntvct_el0);
-	arch_counter_enforce_ordering(cnt);
+	cnt = arch_counter_enforce_ordering(cnt);
 	return cnt;
 }
 
-#undef arch_counter_enforce_ordering
-
 static inline int arch_timer_arch_init(void)
 {
 	return 0;
diff --git a/arch/arm64/include/asm/vdso/arch_timer.h b/arch/arm64/include/asm/vdso/arch_timer.h
new file mode 100644
index 000000000000..a71bc83232f5
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/arch_timer.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_VDSO_ARCH_TIMER_H
+#define __ASM_VDSO_ARCH_TIMER_H
+
+#include <uapi/linux/types.h>
+
+/*
+ * Ensure that reads of the counter are treated the same as memory reads
+ * for the purposes of ordering by subsequent memory barriers.
+ *
+ * This insanity brought to you by speculative system register reads,
+ * out-of-order memory accesses, sequence locks and Thomas Gleixner.
+ *
+ * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
+ *
+ */
+static u64 arch_counter_enforce_ordering(u64 val)
+{
+	u64 tmp, _val = (val);
+
+	asm volatile(
+	"	eor	%0, %1, %1\n"
+	"	add	%0, sp, %0\n"
+	"	ldr	xzr, [%0]"
+	: "=r" (tmp) : "r" (_val));
+
+	return _val;
+}
+
+#endif /* __ASM_VDSO_ARCH_TIMER_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index afba6ba332f8..319808106625 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -8,6 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
+#include <asm/vdso/arch_timer.h>
 
 #define VDSO_HAS_CLOCK_GETRES		1
 
@@ -82,10 +83,10 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
 	isb();
 	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
 	/*
-	 * This isb() is required to prevent that the seq lock is
-	 * speculated.#
+	 * arch_counter_enforce_ordering() is required to prevent that
+	 * the seq lock is speculated.
 	 */
-	isb();
+	res = arch_counter_enforce_ordering(res);
 
 	return res;
 }
-- 
2.25.1

