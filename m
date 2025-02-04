Return-Path: <linux-arch+bounces-9993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC7A2714D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90926166822
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C56214A77;
	Tue,  4 Feb 2025 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgg2tCZs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJA9K5CD"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BFA2144C0;
	Tue,  4 Feb 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670776; cv=none; b=GsUAn8XX4rsywodXJSNWFSdtMhEA3n4mMTwKc8IBNNtbNXZP5qjQ+Tp0VDpKFFsLc6s4+dmoZOYsx6nbVjnbewtbARNbQEpUPvCtbMfsNqqDE8ZdZUtSw28FHTTDfxiiSvbidDapfa4g/uwqpMwIdF8q0qhkNgTpYz4mzWOP/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670776; c=relaxed/simple;
	bh=IE4TepJaJR0PgXcR3dlsTHRrdvrJxfki/+ar51ILAxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBP4S/iCkE6y3PFgSL8w/u5jCiSOsZp1AWEbip+Ca7oDhkghWdYPmKFlc4CYDYhAA33ACZaTdF7fd85So37TAXFxD3+oGCRrcDOq4IhyxrnY+clJaMQ/uqRWuQn0ngXBV7YM2YoEPJKT0yM6LPp1/I9e71BdGj1Q1bEZth1ypCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgg2tCZs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJA9K5CD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1cuYjKhZaQ9IY5EqKrQDEGtEfDrjZzUPBjLmoOo6nk=;
	b=dgg2tCZs4+adQgzUiZuufhbcckaAGCPxTchf1X7K3VvUrcXFVSdP4TWhAVoP33Cm/Y8yYO
	F7iti+0X27PFXJuYdeWq33+KUT4myBmugmQ47i32OKDpYC+EgV6th52bwuzDDRmRHxU+pU
	cNhVgGN7/wHLyPOoDSf06ywWZDTwiGVjkNitBN2HeWcusWPVdo8H/bEz9FLllETydj1et3
	3PAFk6Gsb2PKVpccVwshvOYHze4Wg5kivGkazu048Z8G0+RkdQ0WSYuJIiVxhYKbl1p8G5
	JWgd7DiYkZNixWCLt86csvziDi1O6AXq2DxUiZKuUp6uhFR5rlt+RGtg4S0MSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1cuYjKhZaQ9IY5EqKrQDEGtEfDrjZzUPBjLmoOo6nk=;
	b=PJA9K5CDL+cTc4fvATqCy1+pgM5vKbmd0KS9NVqltCSIxZZBFv0Kbk2sCQxVff69BXcSVR
	xc0lqtsrRM4FKMCQ==
Date: Tue, 04 Feb 2025 13:05:40 +0100
Subject: [PATCH v3 08/18] arm64: vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-8-13a4669dfc8c@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=13796;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IE4TepJaJR0PgXcR3dlsTHRrdvrJxfki/+ar51ILAxs=;
 b=auqmrzfvcv9IbFhuqIqpkhJHUT0ZIxpv8eoYWjt7OAo/lLU5YfFrgRLlT/gj/256BtZzos5qh
 oTQ2ZZEkf1bBYY5Jj64BUbP1xZOuAvWuxu7ijjRkUe5XYNOp0WndFJi
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

This switch also moves the random state data out of the time data page.
The currently used hardcoded __VDSO_RND_DATA_OFFSET does not take into
account changes to the time data page layout.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/Kconfig                                |  1 +
 arch/arm64/include/asm/vdso.h                     |  2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 36 +++------
 arch/arm64/include/asm/vdso/getrandom.h           | 12 ---
 arch/arm64/include/asm/vdso/gettimeofday.h        | 16 +---
 arch/arm64/include/asm/vdso/vsyscall.h            | 25 +------
 arch/arm64/kernel/vdso.c                          | 90 ++---------------------
 arch/arm64/kernel/vdso/vdso.lds.S                 |  7 +-
 arch/arm64/kernel/vdso32/vdso.lds.S               |  7 +-
 9 files changed, 26 insertions(+), 170 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8909aee56bf7bcce5f8135254f0d7..3770b73f270bbf3e2f48d77e8dd231861ac4e8d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,7 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 3e3c3fdb184274abd20647335b19e81e709506db..61679070f595cd25fb2f516b5b077599a9570689 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
 
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 778c1202bbbf9f5db6bfced62a833d50e1675b08..957ee12fcc54bd7f978fbcd8945bce62327b037a 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -104,7 +104,7 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 }
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
 
@@ -131,43 +131,31 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return res;
 }
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
 {
-	const struct vdso_data *ret;
+	const struct vdso_time_data *ret;
 
 	/*
-	 * This simply puts &_vdso_data into ret. The reason why we don't use
-	 * `ret = _vdso_data` is that the compiler tends to optimise this in a
-	 * very suboptimal way: instead of keeping &_vdso_data in a register,
-	 * it goes through a relocation almost every time _vdso_data must be
+	 * This simply puts &_vdso_time_data into ret. The reason why we don't use
+	 * `ret = _vdso_time_data` is that the compiler tends to optimise this in a
+	 * very suboptimal way: instead of keeping &_vdso_time_data in a register,
+	 * it goes through a relocation almost every time _vdso_time_data must be
 	 * accessed (even in subfunctions). This is both time and space
 	 * consuming: each relocation uses a word in the code section, and it
 	 * has to be loaded at runtime.
 	 *
 	 * This trick hides the assignment from the compiler. Since it cannot
 	 * track where the pointer comes from, it will only use one relocation
-	 * where __arch_get_vdso_data() is called, and then keep the result in
-	 * a register.
+	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
+	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_vdso_data));
+	asm volatile("mov %0, %1" : "=r"(ret) : "r"(vdso_u_time_data));
 
 	return ret;
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
 
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
-{
-	const struct vdso_data *ret;
-
-	/* See __arch_get_vdso_data(). */
-	asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
-
-	return ret;
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return vd->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
 }
diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
index 342f807e204442c95cb9e9a849da38effbe50334..a2197da1951b021baff4eb08b3f1c314df2f5f23 100644
--- a/arch/arm64/include/asm/vdso/getrandom.h
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -33,18 +33,6 @@ static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, uns
 	return ret;
 }
 
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
-{
-	/*
-	 * The RNG data is in the real VVAR data page, but if a task belongs to a time namespace
-	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page and VVAR_TIMENS_
-	 * PAGE_OFFSET points to the real VVAR page.
-	 */
-	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * (1UL << CONFIG_PAGE_SHIFT);
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 764d13e2916c559bc8fd7efa032b6f468ac0d4a2..92a2b59a9f3df4d20feb483e6d8ebd1d813b7932 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -67,7 +67,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 }
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
 
@@ -99,20 +99,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return res;
 }
 
-static __always_inline
-const struct vdso_data *__arch_get_vdso_data(void)
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
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index eea51946d45a2f8c7eebfff971d74878be53a798..3f65cbd00635aab50a4e0c6058d38b39fd6d43a9 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,41 +2,18 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#define __VDSO_RND_DATA_OFFSET  480
-
 #ifndef __ASSEMBLY__
 
 #include <vdso/datapage.h>
 
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
 
-extern struct vdso_data *vdso_data;
 
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-struct vdso_data *__arm64_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm64_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
-
-static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata)
+void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
 	vdata[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
 	vdata[CS_RAW].mask		= VDSO_PRECISION_MASK;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5b713b525abac828b1a17ab9e6d974a3e9..887ac0b05961eb83afe649a0afcaf7deda4b186b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
@@ -57,12 +57,6 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
 #endif /* CONFIG_COMPAT_VDSO */
 };
 
-/*
- * The vDSO data page.
- */
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = vdso_data_store.data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -104,78 +98,6 @@ static int __init __vdso_init(enum vdso_abi abi)
 	return 0;
 }
 
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping vvar_map;
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
-		if (vma_is_special_mapping(vma, &vvar_map))
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
-static const struct vm_special_mapping vvar_map = {
-	.name   = "[vvar]",
-	.fault = vvar_fault,
-};
-
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -185,11 +107,11 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	unsigned long gp_flags = 0;
 	void *ret;
 
-	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES != __VDSO_PAGES);
 
 	vdso_text_len = vdso_info[abi].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_mapping_len = vdso_text_len + VDSO_NR_PAGES * PAGE_SIZE;
 
 	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -197,16 +119,14 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
 
-	ret = _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
-				       &vvar_map);
+	ret = vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
 
 	if (system_supports_bti_kernel())
 		gp_flags = VM_ARM64_BTI;
 
-	vdso_base += VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_base += VDSO_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 4ec32e86a8da22d5e2315e55ae2e86ec8e7f5f9a..2e20d0593f182bfefcf39aebb1400f32af0866dc 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -20,11 +20,8 @@ OUTPUT_ARCH(aarch64)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
index 732702a187e9e8b62972ee0aad75c23568e5e779..e02b27487ce80497663dd042357558fea201fcce 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -12,16 +12,15 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
 
 SECTIONS
 {
-	PROVIDE_HIDDEN(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE_HIDDEN(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text

-- 
2.48.1


