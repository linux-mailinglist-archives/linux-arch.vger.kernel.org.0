Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891511BBED3
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD1NQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 09:16:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51161 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgD1NQz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 09:16:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49BMcN1gKDz9v0DB;
        Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=izZ8CdW4; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 95GQ4rCezUqh; Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49BMcM71mwz9v0D9;
        Tue, 28 Apr 2020 15:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588079812; bh=Bw3R6inhpUxnVfbVviD7dzEXeYtqQg7mLsd7lZT+Xbc=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=izZ8CdW4v3UqYNQ8CaIUl9BzC0oHXy3ArH1DU8b9x34kenI22CDZnt3D1zbphzTv4
         4itbkRppajkiRI8ogWTAgyMcuX1b+2+yjKThyJq0H01ezIaiWiBHwRbM9STIo1TVqP
         0sq+jojMUiJeckqJldVNGbgwabecyvTg+9yM/egU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 781448B828;
        Tue, 28 Apr 2020 15:16:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PfNxXN0MGamY; Tue, 28 Apr 2020 15:16:53 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA9ED8B82E;
        Tue, 28 Apr 2020 15:16:52 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 662BD658AD; Tue, 28 Apr 2020 13:16:52 +0000 (UTC)
Message-Id: <513e6c598dca076440b6f39bcf1268e1108a620b.1588079622.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1588079622.git.christophe.leroy@c-s.fr>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 6/8] powerpc/vdso: Switch VDSO to generic C implementation.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Tue, 28 Apr 2020 13:16:52 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For VDSO32 on PPC64, we create a fake 32 bits config, on the same
principle as MIPS architecture, in order to get the correct parts of
the different asm header files.

With the C VDSO, the performance is slightly lower, but it is worth
it as it will ease maintenance and evolution, and also brings clocks
that are not supported with the ASM VDSO.

On an 8xx at 132 MHz, vdsotest with the ASM VDSO:
gettimeofday:    vdso: 828 nsec/call
clock-getres-realtime-coarse:    vdso: 391 nsec/call
clock-gettime-realtime-coarse:    vdso: 614 nsec/call
clock-getres-realtime:    vdso: 460 nsec/call
clock-gettime-realtime:    vdso: 876 nsec/call
clock-getres-monotonic-coarse:    vdso: 399 nsec/call
clock-gettime-monotonic-coarse:    vdso: 691 nsec/call
clock-getres-monotonic:    vdso: 460 nsec/call
clock-gettime-monotonic:    vdso: 1026 nsec/call

On an 8xx at 132 MHz, vdsotest with the C VDSO:
gettimeofday:    vdso: 955 nsec/call
clock-getres-realtime-coarse:    vdso: 545 nsec/call
clock-gettime-realtime-coarse:    vdso: 592 nsec/call
clock-getres-realtime:    vdso: 545 nsec/call
clock-gettime-realtime:    vdso: 941 nsec/call
clock-getres-monotonic-coarse:    vdso: 545 nsec/call
clock-gettime-monotonic-coarse:    vdso: 591 nsec/call
clock-getres-monotonic:    vdso: 545 nsec/call
clock-gettime-monotonic:    vdso: 940 nsec/call

It is even better for gettime with monotonic clocks.

Unsupported clocks with ASM VDSO:
clock-gettime-boottime:    vdso: 3851 nsec/call
clock-gettime-tai:    vdso: 3852 nsec/call
clock-gettime-monotonic-raw:    vdso: 3396 nsec/call

Same clocks with C VDSO:
clock-gettime-tai:    vdso: 941 nsec/call
clock-gettime-monotonic-raw:    vdso: 1001 nsec/call
clock-gettime-monotonic-coarse:    vdso: 591 nsec/call

On an 8321E at 333 MHz, vdsotest with the ASM VDSO:
gettimeofday:    vdso: 220 nsec/call
clock-getres-realtime-coarse:    vdso: 102 nsec/call
clock-gettime-realtime-coarse:    vdso: 178 nsec/call
clock-getres-realtime:    vdso: 129 nsec/call
clock-gettime-realtime:    vdso: 235 nsec/call
clock-getres-monotonic-coarse:    vdso: 105 nsec/call
clock-gettime-monotonic-coarse:    vdso: 208 nsec/call
clock-getres-monotonic:    vdso: 129 nsec/call
clock-gettime-monotonic:    vdso: 274 nsec/call

On an 8321E at 333 MHz, vdsotest with the C VDSO:
gettimeofday:    vdso: 272 nsec/call
clock-getres-realtime-coarse:    vdso: 160 nsec/call
clock-gettime-realtime-coarse:    vdso: 184 nsec/call
clock-getres-realtime:    vdso: 166 nsec/call
clock-gettime-realtime:    vdso: 281 nsec/call
clock-getres-monotonic-coarse:    vdso: 160 nsec/call
clock-gettime-monotonic-coarse:    vdso: 184 nsec/call
clock-getres-monotonic:    vdso: 169 nsec/call
clock-gettime-monotonic:    vdso: 275 nsec/call

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v7:
- Split out preparatory changes in a new preceding patch
- Added -fasynchronous-unwind-tables to CC flags.

v6:
- Added missing prototypes in asm/vdso/gettimeofday.h for __c_kernel_ functions.
- Using STACK_FRAME_OVERHEAD instead of INT_FRAME_SIZE
- Rebased on powerpc/merge as of 7 Apr 2020
- Fixed build failure with gcc 9
- Added a patch to create asm/vdso/processor.h and more cpu_relax() in it

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                       |   2 +
 arch/powerpc/include/asm/vdso/vsyscall.h   |  25 ++
 arch/powerpc/include/asm/vdso_datapage.h   |  40 +--
 arch/powerpc/kernel/asm-offsets.c          |  49 +---
 arch/powerpc/kernel/time.c                 |  91 +------
 arch/powerpc/kernel/vdso.c                 |   5 +-
 arch/powerpc/kernel/vdso32/Makefile        |  32 ++-
 arch/powerpc/kernel/vdso32/config-fake32.h |  34 +++
 arch/powerpc/kernel/vdso32/gettimeofday.S  | 291 +--------------------
 arch/powerpc/kernel/vdso64/Makefile        |  23 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S  | 243 +----------------
 11 files changed, 144 insertions(+), 691 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/vsyscall.h
 create mode 100644 arch/powerpc/kernel/vdso32/config-fake32.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 924c541a9260..4e51454a3e7b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -166,6 +166,7 @@ config PPC
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_GETTIMEOFDAY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
 	select HAVE_ARCH_JUMP_LABEL
@@ -197,6 +198,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS			if GCC_VERSION >= 50200   # plugin support on gcc <= 5.1 is buggy on PPC
+	select HAVE_GENERIC_VDSO
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..c56a030c0623
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/timekeeper_internal.h>
+#include <asm/vdso_datapage.h>
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__arch_get_k_vdso_data(void)
+{
+	return vdso_data->data;
+}
+#define __arch_get_k_vdso_data __arch_get_k_vdso_data
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index 78b8f67e9873..de7221be8de4 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -36,6 +36,7 @@
 
 #include <linux/unistd.h>
 #include <linux/time.h>
+#include <vdso/datapage.h>
 
 #define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
 
@@ -45,7 +46,7 @@
 
 #ifdef CONFIG_PPC64
 
-struct vdso_data {
+struct vdso_arch_data {
 	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
 	struct {			/* Systemcfg version numbers	     */
 		__u32 major;		/* Major number			0x10 */
@@ -59,13 +60,13 @@ struct vdso_data {
 	__u32 processor;		/* Processor type		0x1C */
 	__u64 processorCount;		/* # of physical processors	0x20 */
 	__u64 physicalMemorySize;	/* Size of real memory(B)	0x28 */
-	__u64 tb_orig_stamp;		/* Timebase at boot		0x30 */
+	__u64 tb_orig_stamp;		/* (NU) Timebase at boot	0x30 */
 	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/*				0x48 */
-	__u64 tb_update_count;		/* Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
+	__u64 tb_to_xs;			/* (NU) Inverse of TB to 2^20	0x40 */
+	__u64 stamp_xsec;		/* (NU)				0x48 */
+	__u64 tb_update_count;		/* (NU) Timebase atomicity ctr	0x50 */
+	__u32 tz_minuteswest;		/* (NU) Min. west of Greenwich	0x58 */
+	__u32 tz_dsttime;		/* (NU) Type of dst correction	0x5C */
 	__u32 dcache_size;		/* L1 d-cache size		0x60 */
 	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
 	__u32 icache_size;		/* L1 i-cache size		0x68 */
@@ -78,14 +79,10 @@ struct vdso_data {
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
 	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__u32 stamp_sec_fraction;		/* fractional seconds of stamp_xtime */
-	__s32 wtom_clock_nsec;			/* Wall to monotonic clock nsec */
-	__s64 wtom_clock_sec;			/* Wall to monotonic clock sec */
-	__s64 stamp_xtime_sec;			/* xtime secs as at tb_orig_stamp */
-	__s64 stamp_xtime_nsec;			/* xtime nsecs as at tb_orig_stamp */
-	__u32 hrtimer_res;			/* hrtimer resolution */
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+
+	struct vdso_data data[CS_BASES];
 };
 
 #else /* CONFIG_PPC64 */
@@ -93,26 +90,15 @@ struct vdso_data {
 /*
  * And here is the simpler 32 bits version
  */
-struct vdso_data {
-	__u64 tb_orig_stamp;		/* Timebase at boot		0x30 */
+struct vdso_arch_data {
 	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-	__u64 tb_to_xs;			/* Inverse of TB to 2^20	0x40 */
-	__u64 stamp_xsec;		/*				0x48 */
-	__u32 tb_update_count;		/* Timebase atomicity ctr	0x50 */
-	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x58 */
-	__u32 tz_dsttime;		/* Type of dst correction	0x5C */
-	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
-	__s32 wtom_clock_nsec;
-	__s32 stamp_xtime_sec;		/* xtime seconds as at tb_orig_stamp */
-	__s32 stamp_xtime_nsec;		/* xtime nsecs as at tb_orig_stamp */
-	__u32 stamp_sec_fraction;	/* fractional seconds of stamp_xtime */
-	__u32 hrtimer_res;		/* hrtimer resolution */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+	struct vdso_data data[CS_BASES];
 };
 
 #endif /* CONFIG_PPC64 */
 
-extern struct vdso_data *vdso_data;
+extern struct vdso_arch_data *vdso_data;
 
 #else /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index fcf24a365fc0..9a9b4a9353ff 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -394,47 +394,16 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
 
 	/* datapage offsets for use by vdso */
-	OFFSET(CFG_TB_ORIG_STAMP, vdso_data, tb_orig_stamp);
-	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_data, tb_ticks_per_sec);
-	OFFSET(CFG_TB_TO_XS, vdso_data, tb_to_xs);
-	OFFSET(CFG_TB_UPDATE_COUNT, vdso_data, tb_update_count);
-	OFFSET(CFG_TZ_MINUTEWEST, vdso_data, tz_minuteswest);
-	OFFSET(CFG_TZ_DSTTIME, vdso_data, tz_dsttime);
-	OFFSET(CFG_SYSCALL_MAP32, vdso_data, syscall_map_32);
-	OFFSET(WTOM_CLOCK_SEC, vdso_data, wtom_clock_sec);
-	OFFSET(WTOM_CLOCK_NSEC, vdso_data, wtom_clock_nsec);
-	OFFSET(STAMP_XTIME_SEC, vdso_data, stamp_xtime_sec);
-	OFFSET(STAMP_XTIME_NSEC, vdso_data, stamp_xtime_nsec);
-	OFFSET(STAMP_SEC_FRAC, vdso_data, stamp_sec_fraction);
-	OFFSET(CLOCK_HRTIMER_RES, vdso_data, hrtimer_res);
+	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
+	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
+	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map_32);
 #ifdef CONFIG_PPC64
-	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_data, icache_block_size);
-	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_data, dcache_block_size);
-	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_data, icache_log_block_size);
-	OFFSET(CFG_DCACHE_LOGBLOCKSZ, vdso_data, dcache_log_block_size);
-	OFFSET(CFG_SYSCALL_MAP64, vdso_data, syscall_map_64);
-	OFFSET(TVAL64_TV_SEC, __kernel_old_timeval, tv_sec);
-	OFFSET(TVAL64_TV_USEC, __kernel_old_timeval, tv_usec);
-#endif
-	OFFSET(TSPC64_TV_SEC, __kernel_timespec, tv_sec);
-	OFFSET(TSPC64_TV_NSEC, __kernel_timespec, tv_nsec);
-	OFFSET(TVAL32_TV_SEC, old_timeval32, tv_sec);
-	OFFSET(TVAL32_TV_USEC, old_timeval32, tv_usec);
-	OFFSET(TSPC32_TV_SEC, old_timespec32, tv_sec);
-	OFFSET(TSPC32_TV_NSEC, old_timespec32, tv_nsec);
-	/* timeval/timezone offsets for use by vdso */
-	OFFSET(TZONE_TZ_MINWEST, timezone, tz_minuteswest);
-	OFFSET(TZONE_TZ_DSTTIME, timezone, tz_dsttime);
-
-	/* Other bits used by the vdso */
-	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
-	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
-	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
-	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
-	DEFINE(CLOCK_MAX, CLOCK_TAI);
-	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
-	DEFINE(EINVAL, EINVAL);
-	DEFINE(KTIME_LOW_RES, KTIME_LOW_RES);
+	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
+	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_arch_data, dcache_block_size);
+	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_arch_data, icache_log_block_size);
+	OFFSET(CFG_DCACHE_LOGBLOCKSZ, vdso_arch_data, dcache_log_block_size);
+	OFFSET(CFG_SYSCALL_MAP64, vdso_arch_data, syscall_map_64);
+#endif
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6fcae436ae51..b63b1f97a1b3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -91,6 +91,7 @@ static struct clocksource clocksource_timebase = {
 	.flags        = CLOCK_SOURCE_IS_CONTINUOUS,
 	.mask         = CLOCKSOURCE_MASK(64),
 	.read         = timebase_read,
+	.vdso_clock_mode	= VDSO_CLOCKMODE_ARCHTIMER,
 };
 
 #define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
@@ -855,95 +856,6 @@ static notrace u64 timebase_read(struct clocksource *cs)
 	return (u64)get_tb();
 }
 
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	struct timespec64 xt;
-	struct clocksource *clock = tk->tkr_mono.clock;
-	u32 mult = tk->tkr_mono.mult;
-	u32 shift = tk->tkr_mono.shift;
-	u64 cycle_last = tk->tkr_mono.cycle_last;
-	u64 new_tb_to_xs, new_stamp_xsec;
-	u64 frac_sec;
-
-	if (clock != &clocksource_timebase)
-		return;
-
-	xt.tv_sec = tk->xtime_sec;
-	xt.tv_nsec = (long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
-
-	/* Make userspace gettimeofday spin until we're done. */
-	++vdso_data->tb_update_count;
-	smp_mb();
-
-	/*
-	 * This computes ((2^20 / 1e9) * mult) >> shift as a
-	 * 0.64 fixed-point fraction.
-	 * The computation in the else clause below won't overflow
-	 * (as long as the timebase frequency is >= 1.049 MHz)
-	 * but loses precision because we lose the low bits of the constant
-	 * in the shift.  Note that 19342813113834067 ~= 2^(20+64) / 1e9.
-	 * For a shift of 24 the error is about 0.5e-9, or about 0.5ns
-	 * over a second.  (Shift values are usually 22, 23 or 24.)
-	 * For high frequency clocks such as the 512MHz timebase clock
-	 * on POWER[6789], the mult value is small (e.g. 32768000)
-	 * and so we can shift the constant by 16 initially
-	 * (295147905179 ~= 2^(20+64-16) / 1e9) and then do the
-	 * remaining shifts after the multiplication, which gives a
-	 * more accurate result (e.g. with mult = 32768000, shift = 24,
-	 * the error is only about 1.2e-12, or 0.7ns over 10 minutes).
-	 */
-	if (mult <= 62500000 && clock->shift >= 16)
-		new_tb_to_xs = ((u64) mult * 295147905179ULL) >> (clock->shift - 16);
-	else
-		new_tb_to_xs = (u64) mult * (19342813113834067ULL >> clock->shift);
-
-	/*
-	 * Compute the fractional second in units of 2^-32 seconds.
-	 * The fractional second is tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift
-	 * in nanoseconds, so multiplying that by 2^32 / 1e9 gives
-	 * it in units of 2^-32 seconds.
-	 * We assume shift <= 32 because clocks_calc_mult_shift()
-	 * generates shift values in the range 0 - 32.
-	 */
-	frac_sec = tk->tkr_mono.xtime_nsec << (32 - shift);
-	do_div(frac_sec, NSEC_PER_SEC);
-
-	/*
-	 * Work out new stamp_xsec value for any legacy users of systemcfg.
-	 * stamp_xsec is in units of 2^-20 seconds.
-	 */
-	new_stamp_xsec = frac_sec >> 12;
-	new_stamp_xsec += tk->xtime_sec * XSEC_PER_SEC;
-
-	/*
-	 * tb_update_count is used to allow the userspace gettimeofday code
-	 * to assure itself that it sees a consistent view of the tb_to_xs and
-	 * stamp_xsec variables.  It reads the tb_update_count, then reads
-	 * tb_to_xs and stamp_xsec and then reads tb_update_count again.  If
-	 * the two values of tb_update_count match and are even then the
-	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
-	 * loops back and reads them again until this criteria is met.
-	 */
-	vdso_data->tb_orig_stamp = cycle_last;
-	vdso_data->stamp_xsec = new_stamp_xsec;
-	vdso_data->tb_to_xs = new_tb_to_xs;
-	vdso_data->wtom_clock_sec = tk->wall_to_monotonic.tv_sec;
-	vdso_data->wtom_clock_nsec = tk->wall_to_monotonic.tv_nsec;
-	vdso_data->stamp_xtime_sec = xt.tv_sec;
-	vdso_data->stamp_xtime_nsec = xt.tv_nsec;
-	vdso_data->stamp_sec_fraction = frac_sec;
-	vdso_data->hrtimer_res = hrtimer_resolution;
-	smp_wmb();
-	++(vdso_data->tb_update_count);
-}
-
-void update_vsyscall_tz(void)
-{
-	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
-	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
-}
-
 static void __init clocksource_init(void)
 {
 	struct clocksource *clock;
@@ -1113,7 +1025,6 @@ void __init time_init(void)
 		sys_tz.tz_dsttime = 0;
 	}
 
-	vdso_data->tb_update_count = 0;
 	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
 
 	/* initialise and enable the large decrementer (if we have one) */
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index d33fa22ddbed..6642dbe92946 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,6 +17,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/memblock.h>
+#include <vdso/datapage.h>
 
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -71,10 +72,10 @@ static int vdso_ready;
  * with it, it will become dynamically allocated
  */
 static union {
-	struct vdso_data	data;
+	struct vdso_arch_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = &vdso_data_store.data;
+struct vdso_arch_data *vdso_data = &vdso_data_store.data;
 
 /* Format of the patch table */
 struct vdso_patch_def
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index e147bbdc12cd..b46c21ed9316 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -2,7 +2,23 @@
 
 # List of files in the vdso, has to be asm only for now
 
-obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
+ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso32 = sigtramp.o datapage.o cacheflush.o note.o getcpu.o $(obj-vdso32-y)
+obj-vdso32 += gettimeofday.o
+
+ifneq ($(c-gettimeofday-y),)
+  ifdef CONFIG_PPC64
+    CFLAGS_vgettimeofday.o += -include $(srctree)/$(src)/config-fake32.h
+  endif
+  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgettimeofday.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgettimeofday.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgettimeofday.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
+endif
 
 # Build rules
 
@@ -15,6 +31,7 @@ endif
 CC32FLAGS :=
 ifdef CONFIG_PPC64
 CC32FLAGS += -m32
+KBUILD_CFLAGS := $(filter-out -mcmodel=medium,$(KBUILD_CFLAGS))
 endif
 
 targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
@@ -23,6 +40,7 @@ obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
 	-Wl,-soname=linux-vdso32.so.1 -Wl,--hash-style=both
@@ -36,8 +54,8 @@ CPPFLAGS_vdso32.lds += -P -C -Upowerpc
 $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) FORCE
-	$(call if_changed,vdso32ld)
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday.o FORCE
+	$(call if_changed,vdso32ld_and_check)
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -47,12 +65,16 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 # assembly rules for the .S files
 $(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
+$(obj)/vgettimeofday.o: %.o: %.c FORCE
+	$(call if_changed_dep,vdso32cc)
 
 # actual build commands
-quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+quiet_cmd_vdso32ld_and_check = VDSO32L $@
+      cmd_vdso32ld_and_check = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
+quiet_cmd_vdso32cc = VDSO32C $@
+      cmd_vdso32cc = $(VDSOCC) $(c_flags) $(CC32FLAGS) -c -o $@ $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/powerpc/kernel/vdso32/config-fake32.h b/arch/powerpc/kernel/vdso32/config-fake32.h
new file mode 100644
index 000000000000..e16041fc15c9
--- /dev/null
+++ b/arch/powerpc/kernel/vdso32/config-fake32.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * In case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
+ * configuration.
+ */
+
+#undef CONFIG_PPC64
+#undef CONFIG_64BIT
+#define CONFIG_PPC32
+#define CONFIG_32BIT 1
+#define CONFIG_GENERIC_ATOMIC64 1
+
+#ifdef CONFIG_PPC_BOOK3S_64
+#undef CONFIG_PPC_BOOK3S_64
+#undef CONFIG_PPC_PSERIES
+#define CONFIG_PPC_BOOK3S_32
+#else
+#define CONFIG_PPC_MMU_NOHASH_32
+#define CONFIG_FSL_BOOKE
+#endif
+
+#define CONFIG_TASK_SIZE	0
+#undef CONFIG_MMIOWB
+#undef CONFIG_PPC_SPLPAR
+#undef CONFIG_SPARSEMEM
+#undef CONFIG_PGTABLE_LEVELS
+#define CONFIG_PGTABLE_LEVELS	2
+#undef CONFIG_TRANSPARENT_HUGEPAGE
+#undef CONFIG_SPARSEMEM_VMEMMAP
+#undef CONFIG_FLATMEM
+#define CONFIG_FLATMEM
+#undef CONFIG_PPC_INDIRECT_MMIO
+#undef CONFIG_PPC_INDIRECT_PIO
+#undef CONFIG_EEH
diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index 0bbdce0f2a9c..fd7b01c51281 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -12,13 +12,7 @@
 #include <asm/vdso_datapage.h>
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
-
-/* Offset for the low 32-bit part of a field of long type */
-#ifdef CONFIG_PPC64
-#define LOPART	4
-#else
-#define LOPART	0
-#endif
+#include <asm/vdso/gettimeofday.h>
 
 	.text
 /*
@@ -28,32 +22,7 @@
  *
  */
 V_FUNCTION_BEGIN(__kernel_gettimeofday)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-
-	mr.	r10,r3			/* r10 saves tv */
-	mr	r11,r4			/* r11 saves tz */
-	get_datapage	r9
-	beq	3f
-	LOAD_REG_IMMEDIATE(r7, 1000000)	/* load up USEC_PER_SEC */
-	bl	__do_get_tspec@local	/* get sec/usec from tb & kernel */
-	stw	r3,TVAL32_TV_SEC(r10)
-	stw	r4,TVAL32_TV_USEC(r10)
-
-3:	cmplwi	r11,0			/* check if tz is NULL */
-	mtlr	r12
-	crclr	cr0*4+so
-	li	r3,0
-	beqlr
-
-	lwz	r4,CFG_TZ_MINUTEWEST(r9)/* fill tz */
-	lwz	r5,CFG_TZ_DSTTIME(r9)
-	stw	r4,TZONE_TZ_MINWEST(r11)
-	stw	r5,TZONE_TZ_DSTTIME(r11)
-
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_gettimeofday
 V_FUNCTION_END(__kernel_gettimeofday)
 
 /*
@@ -63,127 +32,7 @@ V_FUNCTION_END(__kernel_gettimeofday)
  *
  */
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
-  .cfi_startproc
-	/* Check for supported clock IDs */
-	cmpli	cr0,r3,CLOCK_REALTIME
-	cmpli	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-
-	cmpli	cr5,r3,CLOCK_REALTIME_COARSE
-	cmpli	cr6,r3,CLOCK_MONOTONIC_COARSE
-	cror	cr5*4+eq,cr5*4+eq,cr6*4+eq
-
-	cror	cr0*4+eq,cr0*4+eq,cr5*4+eq
-	bne	cr0, .Lgettime_fallback
-
-	mflr	r12			/* r12 saves lr */
-  .cfi_register lr,r12
-	mr	r11,r4			/* r11 saves tp */
-	get_datapage	r9
-	LOAD_REG_IMMEDIATE(r7, NSEC_PER_SEC)	/* load up NSEC_PER_SEC */
-	beq	cr5, .Lcoarse_clocks
-.Lprecise_clocks:
-	bl	__do_get_tspec@local	/* get sec/nsec from tb & kernel */
-	bne	cr1, .Lfinish		/* not monotonic -> all done */
-
-	/*
-	 * CLOCK_MONOTONIC
-	 */
-
-	/* now we must fixup using wall to monotonic. We need to snapshot
-	 * that value and do the counter trick again. Fortunately, we still
-	 * have the counter value in r8 that was returned by __do_get_xsec.
-	 * At this point, r3,r4 contain our sec/nsec values, r5 and r6
-	 * can be used, r7 contains NSEC_PER_SEC.
-	 */
-
-	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
-	lwz	r6,WTOM_CLOCK_NSEC(r9)
-
-	/* We now have our offset in r5,r6. We create a fake dependency
-	 * on that value and re-check the counter
-	 */
-	or	r0,r6,r5
-	xor	r0,r0,r0
-	add	r9,r9,r0
-	lwz	r0,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-        cmpl    cr0,r8,r0		/* check if updated */
-	bne-	.Lprecise_clocks
-	b	.Lfinish_monotonic
-
-	/*
-	 * For coarse clocks we get data directly from the vdso data page, so
-	 * we don't need to call __do_get_tspec, but we still need to do the
-	 * counter trick.
-	 */
-.Lcoarse_clocks:
-	lwz	r8,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-	andi.	r0,r8,1                 /* pending update ? loop */
-	bne-	.Lcoarse_clocks
-	add	r9,r9,r0		/* r0 is already 0 */
-
-	/*
-	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
-	 * too
-	 */
-	lwz	r3,STAMP_XTIME_SEC+LOPART(r9)
-	lwz	r4,STAMP_XTIME_NSEC+LOPART(r9)
-	bne	cr6,1f
-
-	/* CLOCK_MONOTONIC_COARSE */
-	lwz	r5,(WTOM_CLOCK_SEC+LOPART)(r9)
-	lwz	r6,WTOM_CLOCK_NSEC(r9)
-
-	/* check if counter has updated */
-	or	r0,r6,r5
-1:	or	r0,r0,r3
-	or	r0,r0,r4
-	xor	r0,r0,r0
-	add	r3,r3,r0
-	lwz	r0,CFG_TB_UPDATE_COUNT+LOPART(r9)
-	cmpl	cr0,r0,r8               /* check if updated */
-	bne-	.Lcoarse_clocks
-
-	/* Counter has not updated, so continue calculating proper values for
-	 * sec and nsec if monotonic coarse, or just return with the proper
-	 * values for realtime.
-	 */
-	bne	cr6, .Lfinish
-
-	/* Calculate and store result. Note that this mimics the C code,
-	 * which may cause funny results if nsec goes negative... is that
-	 * possible at all ?
-	 */
-.Lfinish_monotonic:
-	add	r3,r3,r5
-	add	r4,r4,r6
-	cmpw	cr0,r4,r7
-	cmpwi	cr1,r4,0
-	blt	1f
-	subf	r4,r7,r4
-	addi	r3,r3,1
-1:	bge	cr1, .Lfinish
-	addi	r3,r3,-1
-	add	r4,r4,r7
-
-.Lfinish:
-	stw	r3,TSPC32_TV_SEC(r11)
-	stw	r4,TSPC32_TV_NSEC(r11)
-
-	mtlr	r12
-	crclr	cr0*4+so
-	li	r3,0
-	blr
-
-	/*
-	 * syscall fallback
-	 */
-.Lgettime_fallback:
-	li	r0,__NR_clock_gettime
-  .cfi_restore lr
-	sc
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
 
 
@@ -194,37 +43,7 @@ V_FUNCTION_END(__kernel_clock_gettime)
  *
  */
 V_FUNCTION_BEGIN(__kernel_clock_getres)
-  .cfi_startproc
-	/* Check for supported clock IDs */
-	cmplwi	cr0, r3, CLOCK_MAX
-	cmpwi	cr1, r3, CLOCK_REALTIME_COARSE
-	cmpwi	cr7, r3, CLOCK_MONOTONIC_COARSE
-	bgt	cr0, 99f
-	LOAD_REG_IMMEDIATE(r5, KTIME_LOW_RES)
-	beq	cr1, 1f
-	beq	cr7, 1f
-
-	mflr	r12
-  .cfi_register lr,r12
-	get_datapage	r3
-	lwz	r5, CLOCK_HRTIMER_RES(r3)
-	mtlr	r12
-1:	li	r3,0
-	cmpli	cr0,r4,0
-	crclr	cr0*4+so
-	beqlr
-	stw	r3,TSPC32_TV_SEC(r4)
-	stw	r5,TSPC32_TV_NSEC(r4)
-	blr
-
-	/*
-	 * invalid clock
-	 */
-99:
-	li	r3, EINVAL
-	crset	so
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_clock_getres
 V_FUNCTION_END(__kernel_clock_getres)
 
 
@@ -235,105 +54,5 @@ V_FUNCTION_END(__kernel_clock_getres)
  *
  */
 V_FUNCTION_BEGIN(__kernel_time)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-
-	mr	r11,r3			/* r11 holds t */
-	get_datapage	r9
-
-	lwz	r3,STAMP_XTIME_SEC+LOPART(r9)
-
-	cmplwi	r11,0			/* check if t is NULL */
-	mtlr	r12
-	crclr	cr0*4+so
-	beqlr
-	stw	r3,0(r11)		/* store result at *t */
-	blr
-  .cfi_endproc
+	cvdso_call_time __c_kernel_time
 V_FUNCTION_END(__kernel_time)
-
-/*
- * This is the core of clock_gettime() and gettimeofday(),
- * it returns the current time in r3 (seconds) and r4.
- * On entry, r7 gives the resolution of r4, either USEC_PER_SEC
- * or NSEC_PER_SEC, giving r4 in microseconds or nanoseconds.
- * It expects the datapage ptr in r9 and doesn't clobber it.
- * It clobbers r0, r5 and r6.
- * On return, r8 contains the counter value that can be reused.
- * This clobbers cr0 but not any other cr field.
- */
-__do_get_tspec:
-  .cfi_startproc
-	/* Check for update count & load values. We use the low
-	 * order 32 bits of the update count
-	 */
-1:	lwz	r8,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-	andi.	r0,r8,1			/* pending update ? loop */
-	bne-	1b
-	xor	r0,r8,r8		/* create dependency */
-	add	r9,r9,r0
-
-	/* Load orig stamp (offset to TB) */
-	lwz	r5,CFG_TB_ORIG_STAMP(r9)
-	lwz	r6,(CFG_TB_ORIG_STAMP+4)(r9)
-
-	/* Get a stable TB value */
-2:	MFTBU(r3)
-	MFTBL(r4)
-	MFTBU(r0)
-	cmplw	cr0,r3,r0
-	bne-	2b
-
-	/* Subtract tb orig stamp and shift left 12 bits.
-	 */
-	subfc	r4,r6,r4
-	subfe	r0,r5,r3
-	slwi	r0,r0,12
-	rlwimi.	r0,r4,12,20,31
-	slwi	r4,r4,12
-
-	/*
-	 * Load scale factor & do multiplication.
-	 * We only use the high 32 bits of the tb_to_xs value.
-	 * Even with a 1GHz timebase clock, the high 32 bits of
-	 * tb_to_xs will be at least 4 million, so the error from
-	 * ignoring the low 32 bits will be no more than 0.25ppm.
-	 * The error will just make the clock run very very slightly
-	 * slow until the next time the kernel updates the VDSO data,
-	 * at which point the clock will catch up to the kernel's value,
-	 * so there is no long-term error accumulation.
-	 */
-	lwz	r5,CFG_TB_TO_XS(r9)	/* load values */
-	mulhwu	r4,r4,r5
-	li	r3,0
-
-	beq+	4f			/* skip high part computation if 0 */
-	mulhwu	r3,r0,r5
-	mullw	r5,r0,r5
-	addc	r4,r4,r5
-	addze	r3,r3
-4:
-	/* At this point, we have seconds since the xtime stamp
-	 * as a 32.32 fixed-point number in r3 and r4.
-	 * Load & add the xtime stamp.
-	 */
-	lwz	r5,STAMP_XTIME_SEC+LOPART(r9)
-	lwz	r6,STAMP_SEC_FRAC(r9)
-	addc	r4,r4,r6
-	adde	r3,r3,r5
-
-	/* We create a fake dependency on the result in r3/r4
-	 * and re-check the counter
-	 */
-	or	r6,r4,r3
-	xor	r0,r6,r6
-	add	r9,r9,r0
-	lwz	r0,(CFG_TB_UPDATE_COUNT+LOPART)(r9)
-        cmplw	cr0,r8,r0		/* check if updated */
-	bne-	1b
-
-	mulhwu	r4,r4,r7		/* convert to micro or nanoseconds */
-
-	blr
-  .cfi_endproc
diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vdso64/Makefile
index 32ebb3522ea1..29bffd4863f2 100644
--- a/arch/powerpc/kernel/vdso64/Makefile
+++ b/arch/powerpc/kernel/vdso64/Makefile
@@ -1,8 +1,20 @@
 # SPDX-License-Identifier: GPL-2.0
 # List of files in the vdso, has to be asm only for now
 
+ARCH_REL_TYPE_ABS := R_PPC_JUMP_SLOT|R_PPC_GLOB_DAT|R_PPC_ADDR32|R_PPC_ADDR24|R_PPC_ADDR16|R_PPC_ADDR16_LO|R_PPC_ADDR16_HI|R_PPC_ADDR16_HA|R_PPC_ADDR14|R_PPC_ADDR14_BRTAKEN|R_PPC_ADDR14_BRNTAKEN
+include $(srctree)/lib/vdso/Makefile
+
 obj-vdso64 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o getcpu.o
 
+ifneq ($(c-gettimeofday-y),)
+  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
+  CFLAGS_vgettimeofday.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
+  CFLAGS_vgettimeofday.o += $(call cc-option, -fno-stack-protector)
+  CFLAGS_vgettimeofday.o += -DDISABLE_BRANCH_PROFILING
+  CFLAGS_vgettimeofday.o += -ffreestanding -fasynchronous-unwind-tables
+  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
+endif
+
 # Build rules
 
 targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
@@ -11,6 +23,7 @@ obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
 GCOV_PROFILE := n
 KCOV_INSTRUMENT := n
 UBSAN_SANITIZE := n
+KASAN_SANITIZE := n
 
 ccflags-y := -shared -fno-common -fno-builtin -nostdlib \
 	-Wl,-soname=linux-vdso64.so.1 -Wl,--hash-style=both
@@ -20,12 +33,14 @@ obj-y += vdso64_wrapper.o
 extra-y += vdso64.lds
 CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
 
+$(obj)/vgettimeofday.o: %.o: %.c FORCE
+
 # Force dependency (incbin is bad)
 $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
 
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) FORCE
-	$(call if_changed,vdso64ld)
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday.o FORCE
+	$(call if_changed,vdso64ld_and_check)
 
 # strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -33,8 +48,8 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 # actual build commands
-quiet_cmd_vdso64ld = VDSO64L $@
-      cmd_vdso64ld = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+quiet_cmd_vdso64ld_and_check = VDSO64L $@
+      cmd_vdso64ld_and_check = $(CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^) ; $(cmd_vdso_check)
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 275f031d0bf1..d7a7bfb51081 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -9,8 +9,10 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
 #include <asm/vdso.h>
+#include <asm/vdso_datapage.h>
 #include <asm/asm-offsets.h>
 #include <asm/unistd.h>
+#include <asm/vdso/gettimeofday.h>
 
 	.text
 /*
@@ -20,31 +22,7 @@
  *
  */
 V_FUNCTION_BEGIN(__kernel_gettimeofday)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-
-	mr	r11,r3			/* r11 holds tv */
-	mr	r10,r4			/* r10 holds tz */
-	get_datapage	r3
-	cmpldi	r11,0			/* check if tv is NULL */
-	beq	2f
-	lis	r7,1000000@ha		/* load up USEC_PER_SEC */
-	addi	r7,r7,1000000@l
-	bl	V_LOCAL_FUNC(__do_get_tspec) /* get sec/us from tb & kernel */
-	std	r4,TVAL64_TV_SEC(r11)	/* store sec in tv */
-	std	r5,TVAL64_TV_USEC(r11)	/* store usec in tv */
-2:	cmpldi	r10,0			/* check if tz is NULL */
-	beq	1f
-	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
-	lwz	r5,CFG_TZ_DSTTIME(r3)
-	stw	r4,TZONE_TZ_MINWEST(r10)
-	stw	r5,TZONE_TZ_DSTTIME(r10)
-1:	mtlr	r12
-	crclr	cr0*4+so
-	li	r3,0			/* always success */
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_gettimeofday
 V_FUNCTION_END(__kernel_gettimeofday)
 
 
@@ -55,120 +33,7 @@ V_FUNCTION_END(__kernel_gettimeofday)
  *
  */
 V_FUNCTION_BEGIN(__kernel_clock_gettime)
-  .cfi_startproc
-	/* Check for supported clock IDs */
-	cmpwi	cr0,r3,CLOCK_REALTIME
-	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-
-	cmpwi	cr5,r3,CLOCK_REALTIME_COARSE
-	cmpwi	cr6,r3,CLOCK_MONOTONIC_COARSE
-	cror	cr5*4+eq,cr5*4+eq,cr6*4+eq
-
-	cror	cr0*4+eq,cr0*4+eq,cr5*4+eq
-	bne	cr0,99f
-
-	mflr	r12			/* r12 saves lr */
-  .cfi_register lr,r12
-	mr	r11,r4			/* r11 saves tp */
-	get_datapage	r3
-	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
-	ori	r7,r7,NSEC_PER_SEC@l
-	beq	cr5,70f
-50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
-	bne	cr1,80f			/* if not monotonic, all done */
-
-	/*
-	 * CLOCK_MONOTONIC
-	 */
-
-	/* now we must fixup using wall to monotonic. We need to snapshot
-	 * that value and do the counter trick again. Fortunately, we still
-	 * have the counter value in r8 that was returned by __do_get_tspec.
-	 * At this point, r4,r5 contain our sec/nsec values.
-	 */
-
-	ld	r6,WTOM_CLOCK_SEC(r3)
-	lwa	r9,WTOM_CLOCK_NSEC(r3)
-
-	/* We now have our result in r6,r9. We create a fake dependency
-	 * on that result and re-check the counter
-	 */
-	or	r0,r6,r9
-	xor	r0,r0,r0
-	add	r3,r3,r0
-	ld	r0,CFG_TB_UPDATE_COUNT(r3)
-        cmpld   cr0,r0,r8		/* check if updated */
-	bne-	50b
-	b	78f
-
-	/*
-	 * For coarse clocks we get data directly from the vdso data page, so
-	 * we don't need to call __do_get_tspec, but we still need to do the
-	 * counter trick.
-	 */
-70:	ld      r8,CFG_TB_UPDATE_COUNT(r3)
-	andi.   r0,r8,1                 /* pending update ? loop */
-	bne-    70b
-	add     r3,r3,r0		/* r0 is already 0 */
-
-	/*
-	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
-	 * too
-	 */
-	ld      r4,STAMP_XTIME_SEC(r3)
-	ld      r5,STAMP_XTIME_NSEC(r3)
-	bne     cr6,75f
-
-	/* CLOCK_MONOTONIC_COARSE */
-	ld	r6,WTOM_CLOCK_SEC(r3)
-	lwa     r9,WTOM_CLOCK_NSEC(r3)
-
-	/* check if counter has updated */
-	or      r0,r6,r9
-75:	or	r0,r0,r4
-	or	r0,r0,r5
-	xor     r0,r0,r0
-	add     r3,r3,r0
-	ld      r0,CFG_TB_UPDATE_COUNT(r3)
-	cmpld   cr0,r0,r8               /* check if updated */
-	bne-    70b
-
-	/* Counter has not updated, so continue calculating proper values for
-	 * sec and nsec if monotonic coarse, or just return with the proper
-	 * values for realtime.
-	 */
-	bne     cr6,80f
-
-	/* Add wall->monotonic offset and check for overflow or underflow */
-78:	add     r4,r4,r6
-	add     r5,r5,r9
-	cmpd    cr0,r5,r7
-	cmpdi   cr1,r5,0
-	blt     79f
-	subf    r5,r7,r5
-	addi    r4,r4,1
-79:	bge     cr1,80f
-	addi    r4,r4,-1
-	add     r5,r5,r7
-
-80:	std	r4,TSPC64_TV_SEC(r11)
-	std	r5,TSPC64_TV_NSEC(r11)
-
-	mtlr	r12
-	crclr	cr0*4+so
-	li	r3,0
-	blr
-
-	/*
-	 * syscall fallback
-	 */
-99:
-	li	r0,__NR_clock_gettime
-  .cfi_restore lr
-	sc
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
 
 
@@ -179,34 +44,7 @@ V_FUNCTION_END(__kernel_clock_gettime)
  *
  */
 V_FUNCTION_BEGIN(__kernel_clock_getres)
-  .cfi_startproc
-	/* Check for supported clock IDs */
-	cmpwi	cr0,r3,CLOCK_REALTIME
-	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
-	bne	cr0,99f
-
-	mflr	r12
-  .cfi_register lr,r12
-	get_datapage	r3
-	lwz	r5, CLOCK_HRTIMER_RES(r3)
-	mtlr	r12
-	li	r3,0
-	cmpldi	cr0,r4,0
-	crclr	cr0*4+so
-	beqlr
-	std	r3,TSPC64_TV_SEC(r4)
-	std	r5,TSPC64_TV_NSEC(r4)
-	blr
-
-	/*
-	 * syscall fallback
-	 */
-99:
-	li	r0,__NR_clock_getres
-	sc
-	blr
-  .cfi_endproc
+	cvdso_call __c_kernel_clock_getres
 V_FUNCTION_END(__kernel_clock_getres)
 
 /*
@@ -216,74 +54,5 @@ V_FUNCTION_END(__kernel_clock_getres)
  *
  */
 V_FUNCTION_BEGIN(__kernel_time)
-  .cfi_startproc
-	mflr	r12
-  .cfi_register lr,r12
-
-	mr	r11,r3			/* r11 holds t */
-	get_datapage	r3
-
-	ld	r4,STAMP_XTIME_SEC(r3)
-
-	cmpldi	r11,0			/* check if t is NULL */
-	beq	2f
-	std	r4,0(r11)		/* store result at *t */
-2:	mtlr	r12
-	crclr	cr0*4+so
-	mr	r3,r4
-	blr
-  .cfi_endproc
+	cvdso_call_time __c_kernel_time
 V_FUNCTION_END(__kernel_time)
-
-
-/*
- * This is the core of clock_gettime() and gettimeofday(),
- * it returns the current time in r4 (seconds) and r5.
- * On entry, r7 gives the resolution of r5, either USEC_PER_SEC
- * or NSEC_PER_SEC, giving r5 in microseconds or nanoseconds.
- * It expects the datapage ptr in r3 and doesn't clobber it.
- * It clobbers r0, r6 and r9.
- * On return, r8 contains the counter value that can be reused.
- * This clobbers cr0 but not any other cr field.
- */
-V_FUNCTION_BEGIN(__do_get_tspec)
-  .cfi_startproc
-	/* check for update count & load values */
-1:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
-	andi.	r0,r8,1			/* pending update ? loop */
-	bne-	1b
-	xor	r0,r8,r8		/* create dependency */
-	add	r3,r3,r0
-
-	/* Get TB & offset it. We use the MFTB macro which will generate
-	 * workaround code for Cell.
-	 */
-	MFTB(r6)
-	ld	r9,CFG_TB_ORIG_STAMP(r3)
-	subf	r6,r9,r6
-
-	/* Scale result */
-	ld	r5,CFG_TB_TO_XS(r3)
-	sldi	r6,r6,12		/* compute time since stamp_xtime */
-	mulhdu	r6,r6,r5		/* in units of 2^-32 seconds */
-
-	/* Add stamp since epoch */
-	ld	r4,STAMP_XTIME_SEC(r3)
-	lwz	r5,STAMP_SEC_FRAC(r3)
-	or	r0,r4,r5
-	or	r0,r0,r6
-	xor	r0,r0,r0
-	add	r3,r3,r0
-	ld	r0,CFG_TB_UPDATE_COUNT(r3)
-	cmpld   r0,r8			/* check if updated */
-	bne-	1b			/* reload if so */
-
-	/* convert to seconds & nanoseconds and add to stamp */
-	add	r6,r6,r5		/* add on fractional seconds of xtime */
-	mulhwu	r5,r6,r7		/* compute micro or nanoseconds and */
-	srdi	r6,r6,32		/* seconds since stamp_xtime */
-	clrldi	r5,r5,32
-	add	r4,r4,r6
-	blr
-  .cfi_endproc
-V_FUNCTION_END(__do_get_tspec)
-- 
2.25.0



