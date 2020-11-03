Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC72A4DD7
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgKCSHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:07:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55890 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgKCSHU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Nov 2020 13:07:20 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CQd6C2zTrz9v1YS;
        Tue,  3 Nov 2020 19:07:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3uG_-u5PwW6N; Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CQd6C1hvtz9v1Ym;
        Tue,  3 Nov 2020 19:07:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAD588B7D9;
        Tue,  3 Nov 2020 19:07:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y2ya8Xp9zltL; Tue,  3 Nov 2020 19:07:16 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EADA8B7DB;
        Tue,  3 Nov 2020 19:07:16 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 446CB66860; Tue,  3 Nov 2020 18:07:16 +0000 (UTC)
Message-Id: <b734c0bd0b65a538e8d2ab2367a46184d097fc55.1604426550.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1604426550.git.christophe.leroy@csgroup.eu>
References: <cover.1604426550.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v13 5/8] powerpc/vdso: Prepare for switching VDSO to generic C
 implementation.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue,  3 Nov 2020 18:07:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Prepare for switching VDSO to generic C implementation in following
patch. Here, we:
- Prepare the helpers to call the C VDSO functions
- Prepare the required callbacks for the C VDSO functions
- Prepare the clocksource.h files to define VDSO_ARCH_CLOCKMODES
- Add the C trampolines to the generic C VDSO functions

powerpc is a bit special for VDSO as well as system calls in the
way that it requires setting CR SO bit which cannot be done in C.
Therefore, entry/exit needs to be performed in ASM.

Implementing __arch_get_vdso_data() would clobber the link register,
requiring the caller to save it. As the ASM calling function already
has to set a stack frame and saves the link register before calling
the C vdso function, retriving the vdso data pointer there is lighter.

Implement __arch_vdso_capable() and always return true.

Provide vdso_shift_ns(), as the generic x >> s gives the following
bad result:

  18:	35 25 ff e0 	addic.  r9,r5,-32
  1c:	41 80 00 10 	blt     2c <shift+0x14>
  20:	7c 64 4c 30 	srw     r4,r3,r9
  24:	38 60 00 00 	li      r3,0
...
  2c:	54 69 08 3c 	rlwinm  r9,r3,1,0,30
  30:	21 45 00 1f 	subfic  r10,r5,31
  34:	7c 84 2c 30 	srw     r4,r4,r5
  38:	7d 29 50 30 	slw     r9,r9,r10
  3c:	7c 63 2c 30 	srw     r3,r3,r5
  40:	7d 24 23 78 	or      r4,r9,r4

In our case the shift is always <= 32. In addition,  the upper 32 bits
of the result are likely nul. Lets GCC know it, it also optimises the
following calculations.

With the patch, we get:
   0:	21 25 00 20 	subfic  r9,r5,32
   4:	7c 69 48 30 	slw     r9,r3,r9
   8:	7c 84 2c 30 	srw     r4,r4,r5
   c:	7d 24 23 78 	or      r4,r9,r4
  10:	7c 63 2c 30 	srw     r3,r3,r5

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v13:
- Using PPC_MIN_STKFRM instead of STACK_FRAME_OVERHEAD to avoid including ptrace.h
- Reworked header inclusion to avoid build failure when building VDSO32 on PPC64
- __arch_vdso_capable() now returns always true after the removal of ppc601
- Using DOTSYM() to call the function directly.

v11:
- Changed of __arch_get_hw_counter() to adapt to 4c5a116ada95
("vdso/treewide: Add vdso_data pointer argument to __arch_get_hw_counter()")

v10:
- Added a comment to explain the reason for the two stack frames.
- Moved back the .cfi_register next to mflr

v9:
- No more modification of __get_datapage(). Offset is added after.
- Adding a second stack frame because the PPC VDSO ABI doesn't force
the caller to set one.

v8:
- New, splitted out of last patch of the series

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/clocksource.h       |   7 +
 arch/powerpc/include/asm/ppc_asm.h           |   2 +
 arch/powerpc/include/asm/vdso/clocksource.h  |   7 +
 arch/powerpc/include/asm/vdso/gettimeofday.h | 187 +++++++++++++++++++
 arch/powerpc/kernel/vdso32/vgettimeofday.c   |  28 +++
 arch/powerpc/kernel/vdso64/vgettimeofday.c   |  29 +++
 6 files changed, 260 insertions(+)
 create mode 100644 arch/powerpc/include/asm/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/powerpc/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/powerpc/kernel/vdso64/vgettimeofday.c

diff --git a/arch/powerpc/include/asm/clocksource.h b/arch/powerpc/include/asm/clocksource.h
new file mode 100644
index 000000000000..482185566b0c
--- /dev/null
+++ b/arch/powerpc/include/asm/clocksource.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_CLOCKSOURCE_H
+#define _ASM_CLOCKSOURCE_H
+
+#include <asm/vdso/clocksource.h>
+
+#endif
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 511786f0e40d..db158accb63e 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -251,6 +251,8 @@ GLUE(.,name):
 
 #define _GLOBAL_TOC(name) _GLOBAL(name)
 
+#define DOTSYM(a)	a
+
 #endif
 
 /*
diff --git a/arch/powerpc/include/asm/vdso/clocksource.h b/arch/powerpc/include/asm/vdso/clocksource.h
new file mode 100644
index 000000000000..ec5d672d2569
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/clocksource.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSOCLOCKSOURCE_H
+#define __ASM_VDSOCLOCKSOURCE_H
+
+#define VDSO_ARCH_CLOCKMODES	VDSO_CLOCKMODE_ARCHTIMER
+
+#endif
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..7a8eb9dfd06b
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifdef __ASSEMBLY__
+
+#include <asm/ppc_asm.h>
+
+/*
+ * The macros sets two stack frames, one for the caller and one for the callee
+ * because there are no requirement for the caller to set a stack frame when
+ * calling VDSO so it may have omitted to set one, especially on PPC64
+ */
+
+.macro cvdso_call funct
+  .cfi_startproc
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+	mflr		r0
+  .cfi_register lr, r0
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+	get_datapage	r5, r0
+	addi		r5, r5, VDSO_DATA_OFFSET
+	bl		DOTSYM(\funct)
+	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+	cmpwi		r3, 0
+	mtlr		r0
+  .cfi_restore lr
+	addi		r1, r1, 2 * PPC_MIN_STKFRM
+	crclr		so
+	beqlr+
+	crset		so
+	neg		r3, r3
+	blr
+  .cfi_endproc
+.endm
+
+.macro cvdso_call_time funct
+  .cfi_startproc
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+	mflr		r0
+  .cfi_register lr, r0
+	PPC_STLU	r1, -PPC_MIN_STKFRM(r1)
+	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+	get_datapage	r4, r0
+	addi		r4, r4, VDSO_DATA_OFFSET
+	bl		DOTSYM(\funct)
+	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
+	crclr		so
+	mtlr		r0
+  .cfi_restore lr
+	addi		r1, r1, 2 * PPC_MIN_STKFRM
+	blr
+  .cfi_endproc
+.endm
+
+#else
+
+#include <asm/timebase.h>
+#include <asm/barrier.h>
+#include <asm/unistd.h>
+#include <uapi/linux/time.h>
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+#define VDSO_HAS_TIME			1
+
+static __always_inline int do_syscall_2(const unsigned long _r0, const unsigned long _r3,
+					const unsigned long _r4)
+{
+	register long r0 asm("r0") = _r0;
+	register unsigned long r3 asm("r3") = _r3;
+	register unsigned long r4 asm("r4") = _r4;
+	register int ret asm ("r3");
+
+	asm volatile(
+		"       sc\n"
+		"	bns+	1f\n"
+		"	neg	%0, %0\n"
+		"1:\n"
+	: "=r" (ret), "+r" (r4), "+r" (r0)
+	: "r" (r3)
+	: "memory", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "cr0", "ctr");
+
+	return ret;
+}
+
+static __always_inline
+int gettimeofday_fallback(struct __kernel_old_timeval *_tv, struct timezone *_tz)
+{
+	return do_syscall_2(__NR_gettimeofday, (unsigned long)_tv, (unsigned long)_tz);
+}
+
+static __always_inline
+int clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
+}
+
+static __always_inline
+int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
+{
+	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
+}
+
+#ifdef CONFIG_VDSO32
+
+#define BUILD_VDSO32		1
+
+static __always_inline
+int clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	return do_syscall_2(__NR_clock_gettime, _clkid, (unsigned long)_ts);
+}
+
+static __always_inline
+int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+{
+	return do_syscall_2(__NR_clock_getres, _clkid, (unsigned long)_ts);
+}
+#endif
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
+{
+	return get_tb();
+}
+
+const struct vdso_data *__arch_get_vdso_data(void);
+
+static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+{
+	return true;
+}
+#define vdso_clocksource_ok vdso_clocksource_ok
+
+/*
+ * powerpc specific delta calculation.
+ *
+ * This variant removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+{
+	return (cycles - last) * mult;
+}
+#define vdso_calc_delta vdso_calc_delta
+
+#ifndef __powerpc64__
+static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
+{
+	u32 hi = ns >> 32;
+	u32 lo = ns;
+
+	lo >>= shift;
+	lo |= hi << (32 - shift);
+	hi >>= shift;
+
+	if (likely(hi == 0))
+		return lo;
+
+	return ((u64)hi << 32) | lo;
+}
+#define vdso_shift_ns vdso_shift_ns
+#endif
+
+#ifdef __powerpc64__
+int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
+			     const struct vdso_data *vd);
+int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
+			    const struct vdso_data *vd);
+#else
+int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
+			     const struct vdso_data *vd);
+int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
+			    const struct vdso_data *vd);
+#endif
+int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
+			    const struct vdso_data *vd);
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time,
+				    const struct vdso_data *vd);
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/powerpc/kernel/vdso32/vgettimeofday.c b/arch/powerpc/kernel/vdso32/vgettimeofday.c
new file mode 100644
index 000000000000..0d4bc217529e
--- /dev/null
+++ b/arch/powerpc/kernel/vdso32/vgettimeofday.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Powerpc userspace implementations of gettimeofday() and similar.
+ */
+#include <linux/types.h>
+
+int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
+			     const struct vdso_data *vd)
+{
+	return __cvdso_clock_gettime32_data(vd, clock, ts);
+}
+
+int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
+			    const struct vdso_data *vd)
+{
+	return __cvdso_gettimeofday_data(vd, tv, tz);
+}
+
+int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
+			    const struct vdso_data *vd)
+{
+	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
+}
+
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso_data *vd)
+{
+	return __cvdso_time_data(vd, time);
+}
diff --git a/arch/powerpc/kernel/vdso64/vgettimeofday.c b/arch/powerpc/kernel/vdso64/vgettimeofday.c
new file mode 100644
index 000000000000..5b5500058344
--- /dev/null
+++ b/arch/powerpc/kernel/vdso64/vgettimeofday.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Powerpc userspace implementations of gettimeofday() and similar.
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
+			     const struct vdso_data *vd)
+{
+	return __cvdso_clock_gettime_data(vd, clock, ts);
+}
+
+int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
+			    const struct vdso_data *vd)
+{
+	return __cvdso_gettimeofday_data(vd, tv, tz);
+}
+
+int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
+			    const struct vdso_data *vd)
+{
+	return __cvdso_clock_getres_data(vd, clock_id, res);
+}
+
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso_data *vd)
+{
+	return __cvdso_time_data(vd, time);
+}
-- 
2.25.0

