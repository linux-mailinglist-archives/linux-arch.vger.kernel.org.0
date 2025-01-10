Return-Path: <linux-arch+bounces-9671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF512A0955E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B652188DF18
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443A21322E;
	Fri, 10 Jan 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk4JLtSy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzaBVA0j"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5704211499;
	Fri, 10 Jan 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522642; cv=none; b=bVuqkT28AudWik/9WCFd4u53S4LuRHAK6UBfY1G3fjpaILIh++4khnKnaq8qcN1/leeZjI7v4sF1+bPFUS5vf0KnOMxeWgo2daIrywt0aXZtWhAbh1N/UUtsYRaWhUnrhd1VHDpJs3z8JjbYNIQX2ZUD1D5+K6zzXO2tpWoMYXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522642; c=relaxed/simple;
	bh=v+oJreHBVwMzJTzOd67A0DowhXuzsiluXVjts1LLQns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYx9noq/B767L5onatPmSKzzHNoUAWk23D6C50C40Pp0MZwUH3tTMMM7qdxQI6RU0HLs00T7mCZuYFG5VWZUS9F13b3jwVNqR3e+H1fEt1xBRCsMIyN1p092b/rZPA8MrMK9c3/9P4WlPr37+bYrOAip7TxcnTaBGbLkfcQP62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk4JLtSy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzaBVA0j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5d813KRX3neQp+AalCcq0cCXcqgrUXpVIuC9Va40bVs=;
	b=mk4JLtSyWQFb8giwRE3SHWaBDfrh6w008eoearfncJ7eYr1MzmlCYr/dzL2hnQJBBZDXqP
	fXMhIMJm3dAyGUjjRJkk+mzbn3nr4kh1w1bm6i7Ub82Tu+AnAOIYBFUBr9ufmu+bblw62H
	sHrwC5QnV0c12tiAwBR6/px5/2tJWcnv1RmWrmwPNs/tBko0WZiP8coWGxNNdQ6wSDrcdH
	7cHk/cx/OnzKiSeu9l/pkY1jRtFkUztTSoFsDVLIHpTLosAxOcju9zhLDKGsLNlyBTEMnp
	n1box7hZ/Qv/7Nj1kwlXIvkRc3XxqSeojVjFmO+YYrV6izQ++RFTCuTbsXn/eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5d813KRX3neQp+AalCcq0cCXcqgrUXpVIuC9Va40bVs=;
	b=VzaBVA0jEqDqosV/Ef0N3GDqZUnKxLePpbzHTg6eNJMZqwRzzxcmOvCUO4G0AQLOx54XPY
	C47Xd29s/dONdxDQ==
Date: Fri, 10 Jan 2025 16:23:50 +0100
Subject: [PATCH v2 11/18] arm: vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-11-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=7519;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=v+oJreHBVwMzJTzOd67A0DowhXuzsiluXVjts1LLQns=;
 b=icT/h7g5F4D5T1bGMgj2ONXMX1CvzdYroxTtzOs7CHk+myswOplZtA7Lf4Hd5MgnP2KR71Y3/
 m1x/xtyqr5cCnsWx4iEP8gY63YM6skMXhVHHSHvK4juNRsqU8xZHGQb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm/include/asm/vdso.h              |  2 ++
 arch/arm/include/asm/vdso/gettimeofday.h |  7 +------
 arch/arm/include/asm/vdso/vsyscall.h     | 12 ++---------
 arch/arm/kernel/asm-offsets.c            |  4 ----
 arch/arm/kernel/vdso.c                   | 34 +++++++-------------------------
 arch/arm/mm/Kconfig                      |  1 +
 arch/arm/vdso/vdso.lds.S                 |  4 ++--
 7 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 5b85889f82eeb422400c039e8b5e8a2a6d4553b3..88364a6727ffce224edd35dd62db1693ae5fcb1c 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -4,6 +4,8 @@
 
 #ifdef __KERNEL__
 
+#define __VDSO_PAGES	4
+
 #ifndef __ASSEMBLY__
 
 struct mm_struct;
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 592d3d015ca7298b3bc35871387dbb3e7f819827..1e9f81639c88cc23cae7cf267bf4674c6d6acec0 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -112,7 +112,7 @@ static inline bool arm_vdso_hres_capable(void)
 #define __arch_vdso_hres_capable arm_vdso_hres_capable
 
 static __always_inline u64 __arch_get_hw_counter(int clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
 	u64 cycle_now;
@@ -135,11 +135,6 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode,
 #endif
 }
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 705414710dcdbfa9a97c344806bd079c08368801..4e7226ad02ec4dcf88203c9046e1b320a10e7373 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,22 +7,14 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
 
-extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
 
 static __always_inline
-struct vdso_data *__arm_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm_get_k_vdso_data
-
-static __always_inline
-void __arm_sync_vdso_data(struct vdso_data *vdata)
+void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
 	flush_dcache_page(virt_to_page(vdata));
 }
-#define __arch_sync_vdso_data __arm_sync_vdso_data
+#define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
 
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875740d0fe61c6bbc32ddd9a16fa8d1fb530..123f4a8ef44660a39c4eff2a6e5fd86cb48fb572 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -153,10 +153,6 @@ int main(void)
   DEFINE(CACHE_WRITEBACK_ORDER, __CACHE_WRITEBACK_ORDER);
   DEFINE(CACHE_WRITEBACK_GRANULE, __CACHE_WRITEBACK_GRANULE);
   BLANK();
-#ifdef CONFIG_VDSO
-  DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
-#endif
-  BLANK();
 #ifdef CONFIG_ARM_MPU
   DEFINE(MPU_RNG_INFO_RNGS,	offsetof(struct mpu_rgn_info, rgns));
   DEFINE(MPU_RNG_INFO_USED,	offsetof(struct mpu_rgn_info, used));
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 29dd2f3c62fec64c7f290468421bfad1e739c667..325448ffbba0c29895ea5d97e60d6f51e552cb2e 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/cache.h>
+#include <linux/vdso_datastore.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -33,15 +34,6 @@ extern char vdso_start[], vdso_end[];
 /* Total number of pages needed for the data and text portions of the VDSO. */
 unsigned int vdso_total_pages __ro_after_init;
 
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = vdso_data_store.data;
-
-static struct page *vdso_data_page __ro_after_init;
-static const struct vm_special_mapping vdso_data_mapping = {
-	.name = "[vvar]",
-	.pages = &vdso_data_page,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -192,9 +184,6 @@ static int __init vdso_init(void)
 	if (vdso_text_pagelist == NULL)
 		return -ENOMEM;
 
-	/* Grab the VDSO data page. */
-	vdso_data_page = virt_to_page(vdso_data);
-
 	/* Grab the VDSO text pages. */
 	for (i = 0; i < text_pages; i++) {
 		struct page *page;
@@ -205,7 +194,7 @@ static int __init vdso_init(void)
 
 	vdso_text_mapping.pages = vdso_text_pagelist;
 
-	vdso_total_pages = 1; /* for the data/vvar page */
+	vdso_total_pages = VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages += text_pages;
 
 	cntvct_ok = cntvct_functional();
@@ -216,16 +205,7 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
 
-static int install_vvar(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma;
-
-	vma = _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_data_mapping);
-
-	return PTR_ERR_OR_ZERO(vma);
-}
+static_assert(__VDSO_PAGES == VDSO_NR_PAGES);
 
 /* assumes mmap_lock is write-locked */
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
@@ -238,12 +218,12 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 	if (vdso_text_pagelist == NULL)
 		return;
 
-	if (install_vvar(mm, addr))
+	if (IS_ERR(vdso_install_vvar_mapping(mm, addr)))
 		return;
 
-	/* Account for vvar page. */
-	addr += PAGE_SIZE;
-	len = (vdso_total_pages - 1) << PAGE_SHIFT;
+	/* Account for vvar pages. */
+	addr += VDSO_NR_PAGES * PAGE_SIZE;
+	len = (vdso_total_pages - VDSO_NR_PAGES) << PAGE_SHIFT;
 
 	vma = _install_special_mapping(mm, addr, len,
 		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2b6f50dd547840adecbe08e684ed8f1a032cd7c2..5c1023a6d78c1b4db67b2d62b71af5a79b7e701f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -928,6 +928,7 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 9bfa0f52923c851b6b9e96d4dbb51eb3d5d0960a..7c08371f440027f9a52e9fffae530d7db05b7c43 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -11,16 +11,16 @@
  */
 
 #include <linux/const.h>
-#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - VDSO_DATA_SIZE);
+	VDSO_VVAR_SYMS
 
 	. = SIZEOF_HEADERS;
 

-- 
2.47.1


