Return-Path: <linux-arch+bounces-9999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9FAA27198
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9443A9162
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9BA215198;
	Tue,  4 Feb 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="piEx+mm/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E3PhIhB4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E920214A99;
	Tue,  4 Feb 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670781; cv=none; b=MRYqRJujVL/emcJbaz76wJM4lzGNkveWw/B28OQlARFYB424VWlf30CJ1WKRs/nE1FcnKUlze6kAkDenD3DavO6NGdENwl/5DPjgmywIckVwaMpVmfvN+FjUahCtz9uaL9VR3Ab7M0fQHTkmtjrC2zXGRsDcD9LxCComMDO2oEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670781; c=relaxed/simple;
	bh=uPb5EOMI9B5PVplGdHCxV+O3UQZDhxzF3mR+6Lj2E7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrZR3nL2Q4o3DunFwm9RDI2vXJLZxhRj/8Mffh2uy8360DrRxSYAqu1T/9SpnOmXlDG5bqKiVbWdtR8DtNoibpVtk2xwrIZr+KjFP5KbG5rH5sEEWlTsXDxLye+0eRRF+FAEStnnX/nVARvIZp6atAXcjHPFpN+mdHchsjHLQPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=piEx+mm/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E3PhIhB4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plgLBc6K5/o8n4xVUVZvo4/P4wPTYhxUY1/CdcU7B+Y=;
	b=piEx+mm/1ZYBAhxZzgYzeJa8uxDXDJFUUfQbHr7IEssFjqHHN9qjNJSCQ0Y0sN7+QWgjvL
	ll+Be78PtSEwImXL/Oq5ARCO2BO6I+X+I+wdY6jUZL/3tnLDyUnHz93faxVxf1gnObhiGU
	iB5jpEqVMGzK5wuvEpguO/dW6EdDMdidQaHqUMlhtVE1g1KLBGSHL8u7W7KWAkJpgf4wCi
	nuiiRPgvWjTo2jywRm3B0RuFtXnGrS6aii5Pv8KEGpoLq9JmwNoJzijYg112VIjDJhp353
	V9ruRWsOv+dq8SL4yPpOazs6g4AUgXeOSnbg32QBbLhCXoOeI6d0iiK3yZHeCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plgLBc6K5/o8n4xVUVZvo4/P4wPTYhxUY1/CdcU7B+Y=;
	b=E3PhIhB4uSLXFtIsxQ730PT/bYu9BlLoVFo7b5NJYamWPufmb3JI28m0P2d9eNNTZtux4m
	6UYhluotPYuBfoBg==
Date: Tue, 04 Feb 2025 13:05:46 +0100
Subject: [PATCH v3 14/18] powerpc/vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-14-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
In-Reply-To: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
 Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-csky@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=22881;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=uPb5EOMI9B5PVplGdHCxV+O3UQZDhxzF3mR+6Lj2E7U=;
 b=IXJ4j8vbREg95QKWca1/2ubF8tsPu8+8XNUZ/H29NsnJnw9ezFUOMmGC2YAwch1rHK5yMY0P3
 vzPrHIeIGTWALDsVxcgP8gD3SrYnGcOggCoUCO6/TIBobvW7wahGH9g
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/vdso.h              |   1 +
 arch/powerpc/include/asm/vdso/arch_data.h    |  37 +++++++++
 arch/powerpc/include/asm/vdso/getrandom.h    |  11 +--
 arch/powerpc/include/asm/vdso/gettimeofday.h |  29 +++----
 arch/powerpc/include/asm/vdso/vsyscall.h     |  13 ---
 arch/powerpc/include/asm/vdso_datapage.h     |  44 +---------
 arch/powerpc/kernel/asm-offsets.c            |   1 -
 arch/powerpc/kernel/time.c                   |   2 +-
 arch/powerpc/kernel/vdso.c                   | 115 +++------------------------
 arch/powerpc/kernel/vdso/cacheflush.S        |   2 +-
 arch/powerpc/kernel/vdso/datapage.S          |   4 +-
 arch/powerpc/kernel/vdso/gettimeofday.S      |   4 +-
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   4 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S        |   4 +-
 arch/powerpc/kernel/vdso/vgettimeofday.c     |  14 ++--
 16 files changed, 89 insertions(+), 198 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 424f188e62d9886ee7f6d2531547f09a0606747d..8a2a6e403eb1e654254100cb7347477a3a82e3f7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -159,6 +159,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
 	select ARCH_KEEP_MEMBLOCK
@@ -209,6 +210,7 @@ config PPC
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 8d972bc98b55fe916f23488ca9e2a5918046b9aa..1ca23fbfe087ae90b90c4286335f86d9f8121078 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_VDSO_H
 
 #define VDSO_VERSION_STRING	LINUX_2.6.15
+#define __VDSO_PAGES		4
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/vdso/arch_data.h b/arch/powerpc/include/asm/vdso/arch_data.h
new file mode 100644
index 0000000000000000000000000000000000000000..c240a6b875181ac4159f2e80b11f9bf214e22808
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/arch_data.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * 		      IBM Corp.
+ */
+#ifndef _ASM_POWERPC_VDSO_ARCH_DATA_H
+#define _ASM_POWERPC_VDSO_ARCH_DATA_H
+
+#include <linux/unistd.h>
+#include <linux/types.h>
+
+#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
+
+#ifdef CONFIG_PPC64
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
+	__u32 dcache_block_size;		/* L1 d-cache block size     */
+	__u32 icache_block_size;		/* L1 i-cache block size     */
+	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
+	__u32 icache_log_block_size;		/* L1 i-cache log block size */
+	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
+	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
+};
+
+#else /* CONFIG_PPC64 */
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
+	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
+	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
+};
+
+#endif /* CONFIG_PPC64 */
+
+#endif /* _ASM_POWERPC_VDSO_ARCH_DATA_H */
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
index 80ce0709725eb89c1f3b69e0733038b458fbf24f..067a5396aac6e99c1a96f730459ec684bc7785d7 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -43,20 +43,21 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 			    (unsigned long)len, (unsigned long)flags);
 }
 
-static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
 {
-	struct vdso_arch_data *data;
+	struct vdso_rng_data *data;
 
 	asm (
 		"	bcl	20, 31, .+4 ;"
 		"0:	mflr	%0 ;"
-		"	addis	%0, %0, (_vdso_datapage - 0b)@ha ;"
-		"	addi	%0, %0, (_vdso_datapage - 0b)@l  ;"
+		"	addis	%0, %0, (vdso_u_rng_data - 0b)@ha ;"
+		"	addi	%0, %0, (vdso_u_rng_data - 0b)@l  ;"
 		: "=r" (data) : : "lr"
 	);
 
-	return &data->rng_data;
+	return data;
 }
+#define __arch_get_vdso_u_rng_data __arch_get_vdso_u_rng_data
 
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
 			     size_t opaque_len);
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index c6390890a60c2fdcb608bf321b2945c3fb372f54..dc955f2e0cc51f44d46f488a292aa0dbee3dc16c 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -94,22 +94,12 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 #endif
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	return get_tb();
 }
 
-const struct vdso_data *__arch_get_vdso_data(void);
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
-{
-	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return true;
 }
@@ -135,21 +125,22 @@ static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
 
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd);
+			       const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #endif
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time,
-				    const struct vdso_data *vd);
+				    const struct vdso_time_data *vd);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/asm/vdso/vsyscall.h
index 48560a11955956b8fbb59360334a81972723bd57..c2c9ae1b22e71a3f87e5a1a351699c7ab42b2f95 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -6,19 +6,6 @@
 
 #include <asm/vdso_datapage.h>
 
-static __always_inline
-struct vdso_data *__arch_get_k_vdso_data(void)
-{
-	return vdso_data->data;
-}
-#define __arch_get_k_vdso_data __arch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
-{
-	return &vdso_data->rng_data;
-}
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index a202f5b63479533a7f45a74df015feb59f3d7c87..95d45a50355d269454dd3e175a5b3844181536b5 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -11,56 +11,18 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/unistd.h>
-#include <linux/time.h>
 #include <vdso/datapage.h>
 
-#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
-
-#ifdef CONFIG_PPC64
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
-	__u32 dcache_block_size;		/* L1 d-cache block size     */
-	__u32 icache_block_size;		/* L1 i-cache block size     */
-	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
-	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
-	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
-
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#else /* CONFIG_PPC64 */
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
-	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
-	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#endif /* CONFIG_PPC64 */
-
-extern struct vdso_arch_data *vdso_data;
-
 #else /* __ASSEMBLY__ */
 
-.macro get_datapage ptr offset=0
+.macro get_datapage ptr symbol
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
-	addis	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@ha
-	addi	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@l
+	addis	\ptr, \ptr, (\symbol - 999b)@ha
+	addi	\ptr, \ptr, (\symbol - 999b)@l
 .endm
 
-#include <asm/asm-offsets.h>
-#include <asm/page.h>
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 7a390bd4f4af3c7408b3e3c5ef6d43b95b3b6463..b3048f6d3822c0c457f4aa2ccb5dc870495ba79b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -334,7 +334,6 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
 
 	/* datapage offsets for use by vdso */
-	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0727332ad86fbcfcf8ca18b344ba04381e827c79..15784c5c95c77f1eccfa948a36ba69386a2c175b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -950,7 +950,7 @@ void __init time_init(void)
 		sys_tz.tz_dsttime = 0;
 	}
 
-	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
+	vdso_k_arch_data->tb_ticks_per_sec = tb_ticks_per_sec;
 #ifdef CONFIG_PPC64_PROC_SYSTEMCFG
 	systemcfg->tb_ticks_per_sec = tb_ticks_per_sec;
 #endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 43379365ce1b37cfba662ea58feca5e73dd5f700..219d67bcf747e79f48d09a50f5cb9624bcc0f7b1 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,7 +17,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 
 #include <asm/syscall.h>
@@ -32,6 +32,8 @@
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
 
+static_assert(__VDSO_PAGES == VDSO_NR_PAGES);
+
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
 
@@ -40,24 +42,6 @@ extern char vdso64_start, vdso64_end;
 
 long sys_ni_syscall(void);
 
-/*
- * The vdso data page (aka. systemcfg for old ppc64 fans) is here.
- * Once the early boot kernel code no longer needs to muck around
- * with it, it will become dynamically allocated
- */
-static union {
-	struct vdso_arch_data	data;
-	u8			page[2 * PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_arch_data *vdso_data = &vdso_data_store.data;
-
-enum vvar_pages {
-	VVAR_BASE_PAGE_OFFSET,
-	VVAR_TIME_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma,
 		       unsigned long text_size)
 {
@@ -96,14 +80,6 @@ static void vdso_close(const struct vm_special_mapping *sm, struct vm_area_struc
 	mm->context.vdso = NULL;
 }
 
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf);
-
-static struct vm_special_mapping vvar_spec __ro_after_init = {
-	.name = "[vvar]",
-	.fault = vvar_fault,
-};
-
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso32_mremap,
@@ -116,73 +92,6 @@ static struct vm_special_mapping vdso64_spec __ro_after_init = {
 	.close = vdso_close,
 };
 
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return vvar_page;
-}
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a task
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm = task->mm;
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_spec))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page = find_timens_vvar_page(vma);
-	unsigned long pfn;
-
-	switch (vmf->pgoff) {
-	case VVAR_BASE_PAGE_OFFSET:
-		pfn = virt_to_pfn(vdso_data);
-		break;
-	case VVAR_TIME_PAGE_OFFSET:
-		if (timens_page)
-			pfn = page_to_pfn(timens_page);
-		else
-			pfn = virt_to_pfn(vdso_data->data);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn = virt_to_pfn(vdso_data->data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 /*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
@@ -191,7 +100,7 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 {
 	unsigned long vdso_size, vdso_base, mappings_size;
 	struct vm_special_mapping *vdso_spec;
-	unsigned long vvar_size = VVAR_NR_PAGES * PAGE_SIZE;
+	unsigned long vvar_size = VDSO_NR_PAGES * PAGE_SIZE;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 
@@ -217,9 +126,7 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	/* Add required alignment. */
 	vdso_base = ALIGN(vdso_base, VDSO_ALIGNMENT);
 
-	vma = _install_special_mapping(mm, vdso_base, vvar_size,
-				       VM_READ | VM_MAYREAD | VM_IO |
-				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
+	vma = vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
@@ -299,10 +206,10 @@ static void __init vdso_setup_syscall_map(void)
 
 	for (i = 0; i < NR_syscalls; i++) {
 		if (sys_call_table[i] != (void *)&sys_ni_syscall)
-			vdso_data->syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
 		if (IS_ENABLED(CONFIG_COMPAT) &&
 		    compat_sys_call_table[i] != (void *)&sys_ni_syscall)
-			vdso_data->compat_syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->compat_syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
 	}
 }
 
@@ -352,10 +259,10 @@ static struct page ** __init vdso_setup_pages(void *start, void *end)
 static int __init vdso_init(void)
 {
 #ifdef CONFIG_PPC64
-	vdso_data->dcache_block_size = ppc64_caches.l1d.block_size;
-	vdso_data->icache_block_size = ppc64_caches.l1i.block_size;
-	vdso_data->dcache_log_block_size = ppc64_caches.l1d.log_block_size;
-	vdso_data->icache_log_block_size = ppc64_caches.l1i.log_block_size;
+	vdso_k_arch_data->dcache_block_size = ppc64_caches.l1d.block_size;
+	vdso_k_arch_data->icache_block_size = ppc64_caches.l1i.block_size;
+	vdso_k_arch_data->dcache_log_block_size = ppc64_caches.l1d.log_block_size;
+	vdso_k_arch_data->icache_log_block_size = ppc64_caches.l1i.log_block_size;
 #endif /* CONFIG_PPC64 */
 
 	vdso_setup_syscall_map();
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index 0085ae464dac9c32381625a6969a4e422ad34eb7..488d3ade11e64996b30f42777251df8499eda92c 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_datapage	r10 vdso_u_arch_data
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
index db8e167f01667eb95b3dc74f6771e610411bba90..d23b2e8e2a34ca9b142231eb3a492716a49b2248 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 5333848322ca6105018d501952e3bf42475f49df..79c967212444732da50805fd086c6f2a3c75b0cc 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -33,9 +33,9 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	.ifeq	\call_time
-		get_datapage	r5 VDSO_DATA_OFFSET
+		get_datapage	r5 vdso_u_time_data
 	.else
-		get_datapage	r4 VDSO_DATA_OFFSET
+		get_datapage	r4 vdso_u_time_data
 	.endif
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso/vdso32.lds.S
index 1a1b0b6d681a9977e4ef8042e52d8d33da61887e..72a1012b8a205c6357cecb4b53d2d8e1ff59b051 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
 
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common)
 
 SECTIONS
 {
-	PROVIDE(_vdso_datapage = . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash          	: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
index e21b5506cad62b16e677be74fda7921ec917141a..32102a05eaa7e015e0f89e4a94a3c5e31da7d460 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
 
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common64)
 
 SECTIONS
 {
-	PROVIDE(_vdso_datapage = . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/vdso/vgettimeofday.c
index 55a287c9a7366aa59ab4af1e760a8995f588a4d5..6f5167d81af5f3e6e755dbda4307769e45a28421 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -7,43 +7,43 @@
 
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
 
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_data(vd, clock_id, res);
 }
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
 
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd)
+			       const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
 
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
 #endif
 
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_gettimeofday_data(vd, tv, tz);
 }
 
-__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso_data *vd)
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct vdso_time_data *vd)
 {
 	return __cvdso_time_data(vd, time);
 }

-- 
2.48.1


