Return-Path: <linux-arch+bounces-9995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD3A2715D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D3E168161
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855D8215046;
	Tue,  4 Feb 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qTyQSrHQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="95FCaQvK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302F2147E3;
	Tue,  4 Feb 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670777; cv=none; b=PCY/LHY1u2x53VjUwTzunppeFe9lCq+CNY8/x9o1ZzzJ84ge55TVAuARS8yYD7+nZ4KBiRvNj75CA+6NVJ/fr/q7v5F5wgDcZ27apVZLbnY60o1IxhEtXx7PKfVsoMK5IpUZgFgoYBVcY/erVJmHFqkdYtyChXfF8FtfK277Usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670777; c=relaxed/simple;
	bh=wqiBzBXaGGOACSrQvxHVQ0MIbRklxcv5JXkxhfj+DSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/xgliJY/8mXHSDRR3Uke73UeWknPe1lovl5p2CjmMM6P85nlpsUlwZSkzsARn6SjeE5WqDjHN4H8RDcmvNgawGnv2+vpvnM8vUg41rD7sAAeIN9fAgS4SU9oDOglFAbmuZRmHUBbZj19r9d+bR8Y1kBtl0U5KHyLeTdFSIbYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qTyQSrHQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=95FCaQvK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqtdDp6Qq66eBFKUA7y5TxbW4ShVAJIk2ZI/uLfKU0Q=;
	b=qTyQSrHQWIyO/8VyAdGD2c2voepipVbziPgihfOY2/yRuIAHHuEyaEMkMl6MAQHwGphuZN
	l9VsHwHuc7u/x0Y0HpI8cRcokqkMBMk7ykhModmINJicHYjBYgV/xPeK/nlfqMXKV3rfgX
	uX4K+mKOG9+GoM68Lwvn1EKCOJ4N17tosxYlrf1d5nchmzjvNBp4DoAP9RInnL3KUiGio2
	ZepVsBrIH+B5F1ONub1MAaORfpi27rZIRsFD7wPZF50KmXCv0TSuR0FQ1TT/MLwb8MUvYA
	yrAh6tYNjPWahzQTkdVsOaNOyJTjBb/yir40Or5jOmryIeqfLXhVbIBtQaBlVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqtdDp6Qq66eBFKUA7y5TxbW4ShVAJIk2ZI/uLfKU0Q=;
	b=95FCaQvKPXCIzSqfRHPrcP5HxGywYmbRwyiHxIGMOKtl5eEB/rrteu4JQmWuG4aSnJvVHX
	/61tRZSesbKRjkDA==
Date: Tue, 04 Feb 2025 13:05:42 +0100
Subject: [PATCH v3 10/18] LoongArch: vDSO: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-10-13a4669dfc8c@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=14049;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=wqiBzBXaGGOACSrQvxHVQ0MIbRklxcv5JXkxhfj+DSw=;
 b=WLpAOicNJFBwO6/xYNoUwnxVUo4LwbM7xHKT/2q2WmWm9dkLV+F+C/y5AWSonKnTjVQM7kz54
 qwGG3OpolyGBo5UlwMDnEKqbc96nmzPwRjVzV9l7ouaKxw/JiySndk7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/loongarch/Kconfig                         |  2 +
 arch/loongarch/include/asm/vdso.h              |  1 -
 arch/loongarch/include/asm/vdso/arch_data.h    | 25 +++++++
 arch/loongarch/include/asm/vdso/getrandom.h    |  5 --
 arch/loongarch/include/asm/vdso/gettimeofday.h | 14 +---
 arch/loongarch/include/asm/vdso/vdso.h         | 38 +----------
 arch/loongarch/include/asm/vdso/vsyscall.h     | 17 -----
 arch/loongarch/kernel/asm-offsets.c            |  2 +-
 arch/loongarch/kernel/vdso.c                   | 92 +-------------------------
 arch/loongarch/vdso/vdso.lds.S                 |  8 +--
 arch/loongarch/vdso/vgetcpu.c                  | 12 +---
 11 files changed, 39 insertions(+), 177 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27a852fee1f4418c7b28133a85060bea26a..d7ddf2a43e63b290c23ca64c15e33e2af00fc6ae 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -30,6 +30,7 @@ config LOONGARCH
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
@@ -106,6 +107,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
index d3ba35eb23e77082ea8ed564fe7378ad80df81b2..f72ec79e2dde52f8888750a53c4af85d6ab77b45 100644
--- a/arch/loongarch/include/asm/vdso.h
+++ b/arch/loongarch/include/asm/vdso.h
@@ -31,7 +31,6 @@ struct loongarch_vdso_info {
 	unsigned long size;
 	unsigned long offset_sigreturn;
 	struct vm_special_mapping code_mapping;
-	struct vm_special_mapping data_mapping;
 };
 
 extern struct loongarch_vdso_info vdso_info;
diff --git a/arch/loongarch/include/asm/vdso/arch_data.h b/arch/loongarch/include/asm/vdso/arch_data.h
new file mode 100644
index 0000000000000000000000000000000000000000..322d0a5f1c844f02de9b074d6021e8e15116f8a2
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/arch_data.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _VDSO_ARCH_DATA_H
+#define _VDSO_ARCH_DATA_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/vdso.h>
+
+struct vdso_pcpu_data {
+	u32 node;
+} ____cacheline_aligned_in_smp;
+
+struct vdso_arch_data {
+	struct vdso_pcpu_data pdata[NR_CPUS];
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/include/asm/vdso/getrandom.h
index e80f3c4ac7481ba7f9f5d9210fefa78c3293243b..48c43f55b039b42168698614d0479b7a872d20f3 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -28,11 +28,6 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
 	return ret;
 }
 
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
-{
-	return &_loongarch_data.rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
index 7eb3f041af764d141b005f821593a358096874ba..88cfcf13311630ed5f1a734d23a2bc3f65d79a88 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -72,7 +72,7 @@ static __always_inline int clock_getres_fallback(
 }
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	uint64_t count;
 
@@ -89,18 +89,6 @@ static inline bool loongarch_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable loongarch_vdso_hres_capable
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
-{
-	return _timens_data;
-}
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 1c183a9b2115a29a997ec8db0e788d87fb191dce..50c65fb29dafb464f36615f49db8954ee0a775e3 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -12,43 +12,9 @@
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
 
-struct vdso_pcpu_data {
-	u32 node;
-} ____cacheline_aligned_in_smp;
-
-struct loongarch_vdso_data {
-	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_rng_data rng_data;
-};
-
-/*
- * The layout of vvar:
- *
- *                      high
- * +---------------------+--------------------------+
- * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
- * +---------------------+--------------------------+
- * |  time-ns vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- * |  generic vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- *                      low
- */
-#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_data))
-#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
-
-enum vvar_pages {
-	VVAR_GENERIC_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_LOONGARCH_PAGES_START,
-	VVAR_LOONGARCH_PAGES_END = VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DATA_PAGES - 1,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
-
-extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility("hidden")));
+#define VVAR_SIZE (VDSO_NR_PAGES << PAGE_SHIFT)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
index 8987e951d0a93c34ca75de676fb9c191ff4ef3c2..1140b54b4bc8278d7a322036cd9f84f71258f246 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -6,23 +6,6 @@
 
 #include <vdso/datapage.h>
 
-extern struct vdso_data *vdso_data;
-extern struct vdso_rng_data *vdso_rng_data;
-
-static __always_inline
-struct vdso_data *__loongarch_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __loongarch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__loongarch_get_k_vdso_rng_data(void)
-{
-	return vdso_rng_data;
-}
-#define __arch_get_k_vdso_rng_data __loongarch_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 8be1c38ad8eb26cc3d901c4a0c0b71bde715057a..6f1524bba957e0ef4760a1bd4d32a2d11bb3f11a 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -315,6 +315,6 @@ static void __used output_vdso_defines(void)
 {
 	COMMENT("LoongArch vDSO offsets.");
 
-	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	DEFINE(__VDSO_PAGES, VDSO_NR_PAGES);
 	BLANK();
 }
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 05e5fbac102a902016e633db75d9aff7ed550c50..10cf1608c7b32f8e03bc2c942b51413cf8b9c505 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,7 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 
 #include <asm/page.h>
 #include <asm/vdso.h>
@@ -25,18 +25,6 @@
 
 extern char vdso_start[], vdso_end[];
 
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store generic_vdso_data __page_aligned_data;
-
-static union {
-	u8 page[LOONGARCH_VDSO_DATA_SIZE];
-	struct loongarch_vdso_data vdata;
-} loongarch_vdso_data __page_aligned_data;
-
-struct vdso_data *vdso_data = generic_vdso_data.data;
-struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
-struct vdso_rng_data *vdso_rng_data = &loongarch_vdso_data.vdata.rng_data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)(new_vma->vm_start);
@@ -44,53 +32,12 @@ static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struc
 	return 0;
 }
 
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	unsigned long pfn;
-	struct page *timens_page = find_timens_vvar_page(vma);
-
-	switch (vmf->pgoff) {
-	case VVAR_GENERIC_PAGE_OFFSET:
-		if (!timens_page)
-			pfn = sym_to_pfn(vdso_data);
-		else
-			pfn = page_to_pfn(timens_page);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace specific
-		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
-		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		else
-			pfn = sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
-		pfn = sym_to_pfn(&loongarch_vdso_data) + vmf->pgoff - VVAR_LOONGARCH_PAGES_START;
-		break;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 struct loongarch_vdso_info vdso_info = {
 	.vdso = vdso_start,
 	.code_mapping = {
 		.name = "[vdso]",
 		.mremap = vdso_mremap,
 	},
-	.data_mapping = {
-		.name = "[vvar]",
-		.fault = vvar_fault,
-	},
 	.offset_sigreturn = vdso_offset_sigreturn,
 };
 
@@ -101,7 +48,7 @@ static int __init init_vdso(void)
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
 
 	for_each_possible_cpu(cpu)
-		vdso_pdata[cpu].node = cpu_to_node(cpu);
+		vdso_k_arch_data->pdata[cpu].node = cpu_to_node(cpu);
 
 	vdso_info.size = PAGE_ALIGN(vdso_end - vdso_start);
 	vdso_info.code_mapping.pages =
@@ -115,37 +62,6 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a
- * task changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm = task->mm;
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
 static unsigned long vdso_base(void)
 {
 	unsigned long base = STACK_TOP;
@@ -181,9 +97,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		goto out;
 	}
 
-	vma = _install_special_mapping(mm, data_addr, VVAR_SIZE,
-				       VM_READ | VM_MAYREAD | VM_PFNMAP,
-				       &info->data_mapping);
+	vma = vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 160cfaef2de45b1243502c7356f8a913658548fe..8ff98649994750e74b30a91270d9d9ea2ba751e8 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -5,6 +5,7 @@
  */
 #include <asm/page.h>
 #include <generated/asm-offsets.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
 
@@ -12,11 +13,8 @@ OUTPUT_ARCH(loongarch)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
-	PROVIDE(_loongarch_data = _vdso_data + 2 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 0db51258b2a7ca7e44d2eb68ea514face48393f7..5301cd9d0f839eb0fd7b73a1d36e80aaa75d5e76 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -19,27 +19,19 @@ static __always_inline int read_cpu_id(void)
 	return cpu_id;
 }
 
-static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
-{
-	return _loongarch_data.pdata;
-}
-
 extern
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
 {
 	int cpu_id;
-	const struct vdso_pcpu_data *data;
 
 	cpu_id = read_cpu_id();
 
 	if (cpu)
 		*cpu = cpu_id;
 
-	if (node) {
-		data = get_pcpu_data();
-		*node = data[cpu_id].node;
-	}
+	if (node)
+		*node = vdso_u_arch_data.pdata[cpu_id].node;
 
 	return 0;
 }

-- 
2.48.1


