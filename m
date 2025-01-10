Return-Path: <linux-arch+bounces-9673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58443A0956A
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F2A188EAE0
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1A2135B0;
	Fri, 10 Jan 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbkMHbyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A2tB2pGV"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A3212F98;
	Fri, 10 Jan 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522644; cv=none; b=Hz9C1tUmcOlCU7RGsXiSWp6B0BUbl1hkguDIh47yp4XZ7MhK8ynKZtPcNgPZDRAkYT17faqcS2ncjMVYtpua+U+XzvLCKEzkeaWoil7os/0hddwXxBu7raEqJ5PdIJoAD+tSDSPi00kZwrJumTfDZqsCIrqdCRarUQ8hfN+L91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522644; c=relaxed/simple;
	bh=qLYZD+MZ9YA9ANUAocNqjGFeQSgbienNgQBkNBg9IuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJ4oaZi9GS7NQD7tMfsYnVkHi9n5YvwtlCDx7njiKllTaPyWgEKIi4fTye1JHYf+xtLApzmUd2rhXkTbVe9karqU8A5RD5SXC57PWkIBvD5IPBi8+JvjhW5Cv5g+2ouuoImAGQp5BG7Tt88oBntkCXCBnEkW3CfY6Grr5EWcHbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbkMHbyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A2tB2pGV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sggG3AQ9GwvYZofXxIg0veoW1k7hDA9T14o6idfxz60=;
	b=dbkMHbynIpRF2I8U1wQhP4smjpgBHsyBvCK2rd72l0ZAV0u9714jQCjxs2ACqcw3PDOWvK
	CrYKnHlInDrRdGgPtmJzc15f3LEgYVMtlw94clAvkcnbQRBKowLFsgLIGKVQATua7x4Kby
	CPhPjdqh/1U1zRkBCVa+K5vSR/82H5G15mtzHqkj433kWSzhyHsqH2BUVweVetbeeQOqI2
	JT+mKQah3qfUTW7MWhVINz0v/16IR9Y928vUuRlSXEd9bXZ56RobnlUGll3gfXMoViW9DC
	FalYXPG9ns2cvWNaNQfmx0cdG63UkO0oDlyMGWSoWtbimc6FYBlHilHoxI8gxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sggG3AQ9GwvYZofXxIg0veoW1k7hDA9T14o6idfxz60=;
	b=A2tB2pGVwa+CHIs/opLubHNvGdg5lT55BSQrFEZ7PkswgvtgdFqiC4mQgDiJPautPgzOgE
	Tnxj+6bbO5qTbxBg==
Date: Fri, 10 Jan 2025 16:23:52 +0100
Subject: [PATCH v2 13/18] MIPS: vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-13-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=9616;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qLYZD+MZ9YA9ANUAocNqjGFeQSgbienNgQBkNBg9IuY=;
 b=hW8g3SwsJYsVtugToiixYlcbQKLz6KqoZ+6sODYQ7pUAcRLdMsDJHrLGgpd3SopHgeggDWjzl
 Qq0GkQDqPsYD6rp7uNgrO3iaLKYhPYAY9K86oQMaGyU6xjlHtCSdLto
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/mips/Kconfig                         |  1 +
 arch/mips/include/asm/vdso/gettimeofday.h |  9 +++---
 arch/mips/include/asm/vdso/vdso.h         | 19 ++++++-------
 arch/mips/include/asm/vdso/vsyscall.h     | 14 ++-------
 arch/mips/kernel/vdso.c                   | 47 ++++++++++++-------------------
 arch/mips/vdso/vdso.lds.S                 |  5 +++-
 6 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 467b10f4361aeb7aad0121f334eaa5d23351010c..94fae59589ae80d590ac250b52ba30e9dd6eda32 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -49,6 +49,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index 44a45f3fa4b01026e39efb7f8f51051ec464340c..fd32baa30e172cbabe2657d9debe67a5b9061f90 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -167,7 +167,7 @@ static __always_inline u64 read_r4k_count(void)
 
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 
-static __always_inline u64 read_gic_count(const struct vdso_data *data)
+static __always_inline u64 read_gic_count(const struct vdso_time_data *data)
 {
 	void __iomem *gic = get_gic(data);
 	u32 hi, hi2, lo;
@@ -184,7 +184,7 @@ static __always_inline u64 read_gic_count(const struct vdso_data *data)
 #endif
 
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_CSRC_R4K
 	if (clock_mode == VDSO_CLOCKMODE_R4K)
@@ -209,10 +209,11 @@ static inline bool mips_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable mips_vdso_hres_capable
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
 {
-	return get_vdso_data();
+	return get_vdso_time_data();
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
index 6cd88191fefa9ce6d8323dd70d45aa9a198ac9d0..acd0efcd3d93ef7e71107302a40d24b4b51aae99 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -5,16 +5,18 @@
  */
 
 #include <asm/sgidefs.h>
+#include <vdso/page.h>
+
+#define __VDSO_PAGES 4
 
 #ifndef __ASSEMBLY__
 
 #include <asm/asm.h>
-#include <asm/page.h>
 #include <asm/vdso.h>
 
-static inline unsigned long get_vdso_base(void)
+static inline const struct vdso_time_data *get_vdso_time_data(void)
 {
-	unsigned long addr;
+	const struct vdso_time_data *addr;
 
 	/*
 	 * We can't use cpu_has_mips_r6 since it needs the cpu_data[]
@@ -27,7 +29,7 @@ static inline unsigned long get_vdso_base(void)
 	 * We can't use addiupc because there is no label-label
 	 * support for the addiupc reloc
 	 */
-	__asm__("lapc	%0, _start			\n"
+	__asm__("lapc	%0, vdso_u_time_data		\n"
 		: "=r" (addr) : :);
 #else
 	/*
@@ -46,7 +48,7 @@ static inline unsigned long get_vdso_base(void)
 	"	.set noreorder				\n"
 	"	bal	1f				\n"
 	"	 nop					\n"
-	"	.word	_start - .			\n"
+	"	.word	vdso_u_time_data - .		\n"
 	"1:	lw	%0, 0($31)			\n"
 	"	" STR(PTR_ADDU) " %0, $31, %0		\n"
 	"	.set pop				\n"
@@ -58,14 +60,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
 
-static inline const struct vdso_data *get_vdso_data(void)
-{
-	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
-}
-
 #ifdef CONFIG_CLKSRC_MIPS_GIC
 
-static inline void __iomem *get_gic(const struct vdso_data *data)
+static inline void __iomem *get_gic(const struct vdso_time_data *data)
 {
 	return (void __iomem *)((unsigned long)data & PAGE_MASK) - PAGE_SIZE;
 }
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
index a4582870aaea49ac288d62ec4fa1338a98621918..2b1debb62dee07bb49ab64f755ff9120d512458a 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -2,22 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
+#include <asm/page.h>
+
 #ifndef __ASSEMBLY__
 
 #include <vdso/datapage.h>
 
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__mips_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __mips_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 4c8e3c0aa210476d7b8cb349b99e9a5a453aa7ce..470bf52970c9fc17b275e4e051378f8f08ebf986 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/vdso_datastore.h>
 
 #include <asm/abi.h>
 #include <asm/mips-cps.h>
@@ -22,20 +23,7 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store mips_vdso_data __page_aligned_data;
-struct vdso_data *vdso_data = mips_vdso_data.data;
-
-/*
- * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, as
- * what we map and where within the area they are mapped is determined at
- * runtime.
- */
-static struct page *no_pages[] = { NULL };
-static struct vm_special_mapping vdso_vvar_mapping = {
-	.name = "[vvar]",
-	.pages = no_pages,
-};
+static_assert(VDSO_NR_PAGES == __VDSO_PAGES);
 
 static void __init init_vdso_image(struct mips_vdso_image *image)
 {
@@ -89,7 +77,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn, gic_base;
+	unsigned long gic_size, size, base, data_addr, vdso_addr, gic_pfn, gic_base;
 	struct vm_area_struct *vma;
 	int ret;
 
@@ -117,8 +105,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 * the counter registers at the start.
 	 */
 	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
-	vvar_size = gic_size + PAGE_SIZE;
-	size = vvar_size + image->size;
+	size = gic_size + VDSO_NR_PAGES * PAGE_SIZE + image->size;
 
 	/*
 	 * Find a region that's large enough for us to perform the
@@ -141,15 +128,13 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	 */
 	if (cpu_has_dc_aliases) {
 		base = __ALIGN_MASK(base, shm_align_mask);
-		base += ((unsigned long)vdso_data - gic_size) & shm_align_mask;
+		base += ((unsigned long)vdso_k_time_data - gic_size) & shm_align_mask;
 	}
 
 	data_addr = base + gic_size;
-	vdso_addr = data_addr + PAGE_SIZE;
+	vdso_addr = data_addr + VDSO_NR_PAGES * PAGE_SIZE;
 
-	vma = _install_special_mapping(mm, base, vvar_size,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_vvar_mapping);
+	vma = vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
@@ -159,6 +144,17 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (gic_size) {
 		gic_base = (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
 		gic_pfn = PFN_DOWN(__pa(gic_base));
+		static const struct vm_special_mapping gic_mapping = {
+			.name	= "[gic]",
+			.pages	= (struct page **) { NULL },
+		};
+
+		vma = _install_special_mapping(mm, base, gic_size, VM_READ | VM_MAYREAD,
+					       &gic_mapping);
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			goto out;
+		}
 
 		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(vma->vm_page_prot));
@@ -166,13 +162,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 			goto out;
 	}
 
-	/* Map data page. */
-	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
-			      PAGE_SIZE, vma->vm_page_prot);
-	if (ret)
-		goto out;
-
 	/* Map VDSO image. */
 	vma = _install_special_mapping(mm, vdso_addr, image->size,
 				       VM_READ | VM_EXEC |
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 836465e3bcb8a15cb3f0f96d852d2b252c9d5e2a..c8bbe56d89cb095da21ac1f56d9999914defc305 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -5,6 +5,8 @@
  */
 
 #include <asm/sgidefs.h>
+#include <asm/vdso/vdso.h>
+#include <vdso/datapage.h>
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 OUTPUT_FORMAT("elf64-tradlittlemips", "elf64-tradbigmips", "elf64-tradlittlemips")
@@ -18,7 +20,8 @@ OUTPUT_ARCH(mips)
 
 SECTIONS
 {
-	PROVIDE(_start = .);
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	/*

-- 
2.47.1


