Return-Path: <linux-arch+bounces-9669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E5A09554
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29248188EB3C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1773212FA4;
	Fri, 10 Jan 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0BRj7BW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yj9xN7vT"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE4212B15;
	Fri, 10 Jan 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522641; cv=none; b=hzKdhFto2ZObhA+BSCGnWG9IdcOM6SVXL1r9K1vctW9l6FuTt3tJU+lMgM2B1RmScPHeNg2+PNHoreJFomGaajWY/53Duqo2gFaU0qLEjZU+bfi/LVgsRxakvPrpGBWl1zcqXllx/NHXJ6VBbUAmQtRGm/ch4O+tO/yrIffAvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522641; c=relaxed/simple;
	bh=cvMgcixlDuP3XiKvj+66KxLG+bYyBoL2OvbORCE+UGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8KkOlePkUu4SvYkXYxpWKn0uq1x9DK/ZCaRmNHAXecTzzf1e17le2Q6KMdIl+Mm7FA/gfw5J12tPlpPf9VFvNumcYOI0UUUM+7u0mt91il2lnoFtzXP2l8Yx9WEH+4BuPuXCWFgCghkHKrDyW4Q+FtNpCzw8HU7hK16kt4SVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0BRj7BW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yj9xN7vT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn9bhehtIjze/npdkaeif1gj0Jy35iTOZfSPEnEaYB4=;
	b=i0BRj7BWYplh4t3Na35EwHkr9wPjCMjTLc66zoMM5iV1AxO9u5yDyGClrggvumb65E9JNN
	/T+BwsY0afjDAeYDrEGgqlcM6sWAUKqnUNwDMuIdl31NW3KxV/uhseMcLrweqpNh/aJOS7
	Vvad8/J0k2t3j5hweFS0EinbjN0cB9t/FL/IT3firw6OGLWXdoPUaQA42w9qXu8d7e5RQt
	NnC9BHYWzCO2Quin2yezM0UYGyAbckGFaL7RLmy2Kn+9WsNpvMdcHkhBS5iy/ZPaGs/3jB
	oL6uFwKk0HR0fMSmX/glEfnniCZGSoB3AWuJwQEENBnKugzx1gQqWi383y0HDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn9bhehtIjze/npdkaeif1gj0Jy35iTOZfSPEnEaYB4=;
	b=yj9xN7vTqTqXbQnMXNw+0d0MnrjBZrTlA1eoyJHMutDN1JydEAFG3B1Yy1T5rwcYsiDUL5
	+D2Q1CcuS7v17BCA==
Date: Fri, 10 Jan 2025 16:23:48 +0100
Subject: [PATCH v2 09/18] riscv: vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-9-350c9179bbf1@linutronix.de>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
In-Reply-To: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=11285;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cvMgcixlDuP3XiKvj+66KxLG+bYyBoL2OvbORCE+UGo=;
 b=HGjybzG3H/RMsGwhiuWDb/vp8eX4d+2LXH0TYgbNsmWCwtIrcz91znl30Mnz0U8SkqZJUX1ar
 6mVNQI8T48QBKSEQafL+4qjjqSPcks0Z845q9Ytvr1G2l5yOJylEawV
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/Kconfig                                 |  3 +-
 arch/riscv/include/asm/vdso.h                      |  2 +-
 .../include/asm/vdso/{time_data.h => arch_data.h}  |  8 +-
 arch/riscv/include/asm/vdso/gettimeofday.h         | 14 +---
 arch/riscv/include/asm/vdso/vsyscall.h             |  9 ---
 arch/riscv/kernel/sys_hwprobe.c                    |  3 +-
 arch/riscv/kernel/vdso.c                           | 90 +---------------------
 arch/riscv/kernel/vdso/hwprobe.c                   |  6 +-
 arch/riscv/kernel/vdso/vdso.lds.S                  |  7 +-
 9 files changed, 18 insertions(+), 124 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..335cbbd4dddb17e5ccaa2cddaefc298cb559dbc0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -115,6 +115,7 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index f891478829a52c41e06240f67611694cc28197d9..c130d8100232cbe50e52e35eb418e354bd114cb7 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -14,7 +14,7 @@
  */
 #ifdef CONFIG_MMU
 
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
 
 #ifndef __ASSEMBLY__
 #include <generated/vdso-offsets.h>
diff --git a/arch/riscv/include/asm/vdso/time_data.h b/arch/riscv/include/asm/vdso/arch_data.h
similarity index 71%
rename from arch/riscv/include/asm/vdso/time_data.h
rename to arch/riscv/include/asm/vdso/arch_data.h
index dfa65228999bed41dfd6c5e36cb678e1e055eec8..da57a3786f7a53c866fc00948826b4a2d839940f 100644
--- a/arch/riscv/include/asm/vdso/time_data.h
+++ b/arch/riscv/include/asm/vdso/arch_data.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
-#define __RISCV_ASM_VDSO_TIME_DATA_H
+#ifndef __RISCV_ASM_VDSO_ARCH_DATA_H
+#define __RISCV_ASM_VDSO_ARCH_DATA_H
 
 #include <linux/types.h>
 #include <vdso/datapage.h>
 #include <asm/hwprobe.h>
 
-struct arch_vdso_time_data {
+struct vdso_arch_data {
 	/* Stash static answers to the hwprobe queries when all CPUs are selected. */
 	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
 
@@ -14,4 +14,4 @@ struct arch_vdso_time_data {
 	__u8 homogeneous_cpus;
 };
 
-#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
+#endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index ba3283cf7accaa93a38512d2c17eda0eefde0612..29164f84f93cec6e28251e6a0adfbc341ac88241 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -69,7 +69,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	/*
 	 * The purpose of csr_read(CSR_TIME) is to trap the system into
@@ -79,18 +79,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return csr_read(CSR_TIME);
 }
 
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
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/vdso/vsyscall.h
index e8a9c4b53c0c9f4744196eed800b21f3918d1040..1140b54b4bc8278d7a322036cd9f84f71258f246 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -6,15 +6,6 @@
 
 #include <vdso/datapage.h>
 
-extern struct vdso_data *vdso_data;
-
-static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-
-#define __arch_get_k_vdso_data __riscv_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cb93adfffc486e710409fd3b8a8ab22525ac4093..37e155dd3ab26da7b6a03e0b11b467e5aac51091 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -445,8 +445,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
 
 static int __init init_hwprobe_vdso_data(void)
 {
-	struct vdso_data *vd = __arch_get_k_vdso_data();
-	struct arch_vdso_time_data *avd = &vd->arch_data;
+	struct vdso_arch_data *avd = vdso_k_arch_data;
 	u64 id_bitsmash = 0;
 	struct riscv_hwprobe pair;
 	int key;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3ca3ae4277e187e790a8bf513a9e80d8b6290bb2..cc2895d1fbc2fe752b3edc94f4e28a6a8fca7a3b 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -13,20 +13,11 @@
 #include <linux/err.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <vdso/vsyscall.h>
 
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = vdso_data_store.data;
+#define VVAR_SIZE  (VDSO_NR_PAGES << PAGE_SHIFT)
 
 struct __vdso_info {
 	const char *name;
@@ -79,78 +70,6 @@ static void __init __vdso_init(struct __vdso_info *vdso_info)
 	vdso_info->cm->pages = vdso_pagelist;
 }
 
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping rv_vvar_map;
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
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &rv_vvar_map))
-			zap_vma_pages(vma);
-	}
-
-	mmap_read_unlock(mm);
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
-	case VVAR_DATA_PAGE_OFFSET:
-		if (timens_page)
-			pfn = page_to_pfn(timens_page);
-		else
-			pfn = sym_to_pfn(vdso_data);
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
-		pfn = sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
-static const struct vm_special_mapping rv_vvar_map = {
-	.name   = "[vvar]",
-	.fault = vvar_fault,
-};
-
 static struct vm_special_mapping rv_vdso_map __ro_after_init = {
 	.name   = "[vdso]",
 	.mremap = vdso_mremap,
@@ -196,7 +115,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
 
-	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES != __VDSO_PAGES);
 
 	vdso_text_len = vdso_info->vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
@@ -208,8 +127,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 		goto up_fail;
 	}
 
-	ret = _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
+	ret = vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
 
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
index a158c029344f60c022e7565757ff44df7e3d89e5..2ddeba6c68dda09b0249117fd06a5d249f3b0abd 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -16,8 +16,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
 				 size_t cpusetsize, unsigned long *cpus,
 				 unsigned int flags)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd = &vd->arch_data;
+	const struct vdso_arch_data *avd = &vdso_u_arch_data;
 	bool all_cpus = !cpusetsize && !cpus;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
@@ -51,8 +50,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs, size_t pair_count,
 			       size_t cpusetsize, unsigned long *cpus,
 			       unsigned int flags)
 {
-	const struct vdso_data *vd = __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd = &vd->arch_data;
+	const struct vdso_arch_data *avd = &vdso_u_arch_data;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
 	unsigned char *c = (unsigned char *)cpus;
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index cbe2a179331d2511a8b4a26c06383e46131661b1..8e86965a8aae4d7c5a36d0f26026cd1c8680b339 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -4,15 +4,14 @@
  */
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
 
 OUTPUT_ARCH(riscv)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text

-- 
2.47.1


