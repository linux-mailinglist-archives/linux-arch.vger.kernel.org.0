Return-Path: <linux-arch+bounces-9676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35774A09579
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50F616A5A2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DFC213E7B;
	Fri, 10 Jan 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33ZeDKHJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MH1asx6W"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85521324C;
	Fri, 10 Jan 2025 15:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522647; cv=none; b=cEV6rAJbgvvtb93K82DpafOEWFhT7AXLYVIMI/Ot6BC5p8tS0O5hmZrF8zkgU4hqxBtCb7vmiODuS6nKNCAjY3RoFcJ7e1LcubHYiIKvA1bTv7IGQkUKaGDrdAGL5nH197oRkz9B0Kd5UlImd+7OmlBsT3fK8L+r4B8Ebx8tP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522647; c=relaxed/simple;
	bh=qWI6R7rYegm9WXfu+16ksDyQlcl+91xmANzxxCe8I8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihwrCSJ1llTzPE4FgRyTxkz4S0NiEvFpq2XXbHws9Xxw65bhd96qIZc5J1wm6qMRY35E0CeyRGYIgBD6/kGCFUfcRsl6SU6ljBsCcrrBo7Cgmv0w0NleKGQEW1WzOC4Dljt4NXtIRoVL/M0apyN9yM5JblpL4ixuNRajpMDb8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33ZeDKHJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MH1asx6W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnnqMoYWzpUrzZ2AKK17fsRlW97Mjo1RryuvGYBkXb8=;
	b=33ZeDKHJ8PHT6C2n7n7pbSK5jZJmIzfdmO3O/8+cwj8SajvbFCjzBdi80awzvjcRFRjqEb
	SLpb3H54YaBcqHIxd9Patm+tJPtngg8eSvarT1nlRI3n6BMhg33Wz7MFiAHudZ225AAIpx
	3iw52bU+26p9kaxrdACtftlBA8lvAInNQ3y2dza7Tqc9a0rQ4wUTvPhEJ4C65f01h0/6AK
	EVGbJPJ8Tpwq/NrV35ThS1Lp0HlwMwuFptug3pl7dI44Lv3JXnCa9sm/CZJTcro2AKpn7X
	SImxtut7r2wut6z7YnHl5lYnd02pozpLEu3WDupE3mbWPUg53ZORECLeqpAi2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dnnqMoYWzpUrzZ2AKK17fsRlW97Mjo1RryuvGYBkXb8=;
	b=MH1asx6WtmXUdaW2R6TC4+YLZr5jhu4ZS9Nu/+KHRLkUtxhFjwqu5RgfWCfnygxU1rgHKa
	K3avcYNvAEcQxqDQ==
Date: Fri, 10 Jan 2025 16:23:54 +0100
Subject: [PATCH v2 15/18] x86/vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-15-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=13167;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qWI6R7rYegm9WXfu+16ksDyQlcl+91xmANzxxCe8I8g=;
 b=t1Ha1IrGTGM24VBs6HuvOhlxHXRWfZ75c9GhJUwgmbFwJsTJEl4VG6LDKK6N6Lv2L348vwUxn
 7Q7jcgkvfCjDSE9RuCm494juiuvE13Ii3pOcHSOYA22H0k+M/+2Gyrm
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
 arch/x86/Kconfig                         |   1 +
 arch/x86/entry/vdso/vdso-layout.lds.S    |  14 ++--
 arch/x86/entry/vdso/vma.c                | 123 ++-----------------------------
 arch/x86/include/asm/vdso/getrandom.h    |  10 ---
 arch/x86/include/asm/vdso/gettimeofday.h |  25 +------
 arch/x86/include/asm/vdso/vsyscall.h     |  24 +-----
 6 files changed, 19 insertions(+), 178 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d7bd0ae48c4260f4abb6dbedc696e3915c230ea..e3d7f17dc414ca93d6e746dbc7f02afd2bc043a8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -177,6 +177,7 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 918606ff92a988b14f5e64f984750ae04b3b6ede..e5cecdb0fedf000516bb789d6aca4c952c3035e5 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
 #include <asm/vdso/vsyscall.h>
+#include <vdso/datapage.h>
 
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
@@ -17,17 +18,16 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - __VVAR_PAGES * PAGE_SIZE;
-	vvar_page  = vvar_start;
+	VDSO_VVAR_SYMS
 
-	vdso_rng_data = vvar_page + __VDSO_RND_DATA_OFFSET;
-
-	timens_page  = vvar_start + PAGE_SIZE;
-
-	vclock_pages = VDSO_VCLOCK_PAGES_START(vvar_start);
+	vclock_pages = VDSO_VCLOCK_PAGES_START(vdso_u_data);
 	pvclock_page = vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page = vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
 
+	/* For compatibility with vdso2c */
+	vvar_page = vdso_u_data;
+	vvar_start = vdso_u_data;
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index aa62949335ecec3765d3b46eac7f7b83be5efdda..7245e95c573e1464d6eb744181d2306f17fc0329 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,7 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
@@ -27,13 +27,7 @@
 #include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
 
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)vvar_page;
-}
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data = vdso_data_store.data;
+static_assert(VDSO_NR_PAGES + VDSO_NR_VCLOCK_PAGES == __VDSO_PAGES);
 
 unsigned int vclocks_used __read_mostly;
 
@@ -54,7 +48,6 @@ int __init init_vdso_image(const struct vdso_image *image)
 	return 0;
 }
 
-static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -98,99 +91,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-#ifdef CONFIG_TIME_NS
-/*
- * The vvar page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm = task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-		      struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
-	unsigned long pfn;
-	long sym_offset;
-
-	if (!image)
-		return VM_FAULT_SIGBUS;
-
-	sym_offset = (long)(vmf->pgoff << PAGE_SHIFT) +
-		image->sym_vvar_start;
-
-	/*
-	 * Sanity check: a symbol offset of zero means that the page
-	 * does not exist for this vdso image, not that the page is at
-	 * offset zero relative to the text mapping.  This should be
-	 * impossible here, because sym_offset should only be zero for
-	 * the page past the end of the vvar mapping.
-	 */
-	if (sym_offset == 0)
-		return VM_FAULT_SIGBUS;
-
-	if (sym_offset == image->sym_vvar_page) {
-		struct page *timens_page = find_timens_vvar_page(vma);
-
-		pfn = __pa_symbol(vdso_data) >> PAGE_SHIFT;
-
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the sym_vvar_page offset and
-		 * the real VVAR page is mapped with the sym_timens_page
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (timens_page) {
-			unsigned long addr;
-			vm_fault_t err;
-
-			/*
-			 * Optimization: inside time namespace pre-fault
-			 * VVAR page too. As on timens page there are only
-			 * offsets for clocks on VVAR, it'll be faulted
-			 * shortly by VDSO code.
-			 */
-			addr = vmf->address + (image->sym_timens_page - sym_offset);
-			err = vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-
-			pfn = page_to_pfn(timens_page);
-		}
-
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-
-	} else if (sym_offset == image->sym_timens_page) {
-		struct page *timens_page = find_timens_vvar_page(vma);
-
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-
-		pfn = __pa_symbol(vdso_data) >> PAGE_SHIFT;
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-	}
-
-	return VM_FAULT_SIGBUS;
-}
-
 static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
 				    struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -212,7 +112,6 @@ static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
 	case VDSO_PAGE_HVCLOCK_OFFSET:
 	{
 		unsigned long pfn = hv_get_tsc_pfn();
-
 		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address, pfn);
 		break;
@@ -228,10 +127,6 @@ static const struct vm_special_mapping vdso_mapping = {
 	.fault = vdso_fault,
 	.mremap = vdso_mremap,
 };
-static const struct vm_special_mapping vvar_mapping = {
-	.name = "[vvar]",
-	.fault = vvar_fault,
-};
 static const struct vm_special_mapping vvar_vclock_mapping = {
 	.name = "[vvar_vclock]",
 	.fault = vvar_vclock_fault,
@@ -253,13 +148,13 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		return -EINTR;
 
 	addr = get_unmapped_area(NULL, addr,
-				 image->size - image->sym_vvar_start, 0, 0);
+				 image->size + __VDSO_PAGES * PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret = addr;
 		goto up_fail;
 	}
 
-	text_start = addr - image->sym_vvar_start;
+	text_start = addr + __VDSO_PAGES * PAGE_SIZE;
 
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
@@ -276,13 +171,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 		goto up_fail;
 	}
 
-	vma = _install_special_mapping(mm,
-				       addr,
-				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
-
+	vma = vdso_install_vvar_mapping(mm, addr);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
@@ -327,7 +216,7 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	 */
 	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
-				vma_is_special_mapping(vma, &vvar_mapping) ||
+				vma_is_special_mapping(vma, &vdso_vvar_mapping) ||
 				vma_is_special_mapping(vma, &vvar_vclock_mapping)) {
 			mmap_write_unlock(mm);
 			return -EEXIST;
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index 2bf9c0e970c3e7d2a2ddfcb1d007cb73da200494..af85539f6557b8e22f7c8fb142c5c83330219af1 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -27,16 +27,6 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 	return ret;
 }
 
-extern struct vdso_rng_data vdso_rng_data
-	__attribute__((visibility("hidden")));
-
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
-{
-	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		return (void *)&vdso_rng_data + ((void *)&timens_page - (void *)__arch_get_vdso_data());
-	return &vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 375a34b0f365792ec108381d7c7229f8351448f7..edec796832e08b73d6d58bda6408957048f4e80e 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -19,12 +19,6 @@
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
 
-extern struct vdso_data vvar_page
-	__attribute__((visibility("hidden")));
-
-extern struct vdso_data timens_page
-	__attribute__((visibility("hidden")));
-
 #define VDSO_HAS_TIME 1
 
 #define VDSO_HAS_CLOCK_GETRES 1
@@ -59,14 +53,6 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
-{
-	return &timens_page;
-}
-#endif
-
 #ifndef BUILD_VDSO32
 
 static __always_inline
@@ -250,7 +236,7 @@ static u64 vread_hvclock(void)
 #endif
 
 static inline u64 __arch_get_hw_counter(s32 clock_mode,
-					const struct vdso_data *vd)
+					const struct vdso_time_data *vd)
 {
 	if (likely(clock_mode == VDSO_CLOCKMODE_TSC))
 		return (u64)rdtsc_ordered() & S64_MAX;
@@ -275,12 +261,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return U64_MAX;
 }
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return &vvar_page;
-}
-
-static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool arch_vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return true;
 }
@@ -319,7 +300,7 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64 cycles, u64 base)
 {
 	u64 delta = cycles - vd->cycle_last;
 
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 88b31d4cdfaf331d2d597981d3f8ee0c5a339085..ebbf63420af03dd87349a390ed22655ebd6b5a54 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,11 +2,10 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#define __VDSO_RND_DATA_OFFSET  640
-#define __VVAR_PAGES	4
+#define __VDSO_PAGES	6
 
 #define VDSO_NR_VCLOCK_PAGES	2
-#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE)
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
 
@@ -15,25 +14,6 @@
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
 
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__x86_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __x86_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 

-- 
2.47.1


