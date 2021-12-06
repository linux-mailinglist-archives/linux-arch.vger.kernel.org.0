Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910BF46946E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Dec 2021 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbhLFK54 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Dec 2021 05:57:56 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45942
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241900AbhLFK54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Dec 2021 05:57:56 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F13C3F1F3
        for <linux-arch@vger.kernel.org>; Mon,  6 Dec 2021 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788066;
        bh=RfnZLpCrESekFFsD9sFyHjy0w4Q3coXm7KE4i6fprXc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Xn1zcUPeDid+MWExFIfofdlTJfwwaTbSW4IEquFfdxTDMB99m/U4cseEwiGo3yBES
         OJki99ofVFjIG5PkXS94BJs6Nfa8Ru8ksMVZxyOoKt/iDfbV2pilhwjEeJuSStrUhg
         6+QLFTIK/Bu9t1O2purfKzNO+ibpLE7VymEi8KAFG26Ie8CmK19i8NCtcrWm0o1L4Z
         Q5P9kA0ExFqs7cl4QPN6EPwv9x98Aos0TnA+CMAwq5hFljaGd1t7a23yPnXwDGDsnO
         kh5TfckTYa2rXJTPOZPkxsQOgnNj08hHWNdYJrQ2Wq6L6D/1TADQ81SaHG67khxhXn
         YkJdm1yqH7ZbA==
Received: by mail-wr1-f69.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso1891967wrj.12
        for <linux-arch@vger.kernel.org>; Mon, 06 Dec 2021 02:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfnZLpCrESekFFsD9sFyHjy0w4Q3coXm7KE4i6fprXc=;
        b=Q3lKTIYWaHME1/fZNAnK2E5pj5xkVeZ6skQB4qsJIr6/86g21F1WSflre60V89vwQu
         2NXIPtLQl226eHAb795M2VIY1B7FMZgbzPIhtq38a9QMqkg3DkY53UMC3Qysnj1+Qydl
         79xH2ErUBbKqP+/LsrW8ur7MrYtqeAk22ilKuEh5BXPvuMwxnrltSbdmAxn+WUHNwY9O
         Wz6JvmoyKjkw/nEkldZ69TSGMTEZuRMVyguPNg6A8yg5ZsfpvvG19rdXElead1m0Aq8m
         Ajx+LYkpabJFC7e/7hXTEn/RtidGweRAKkLYi9QEWUD+7tt563aQppQ5m0Q0E4yUEfRQ
         JEHA==
X-Gm-Message-State: AOAM531rcKIAuYYgmYQWab1bsY6VlZSo62ZohXGoAdLdRHTLG2wNq4Nj
        l42iYFvxssTcn7P9vxS7M03SfijMBuKa3SaEYmv1ZMi7BMwQ5OCgMFftRjTdVTJjQDwYeLcbSXQ
        oHXER8rj20DzTNtfADlrFF0htOV78qIsSkS8tQ8Y=
X-Received: by 2002:a05:600c:358a:: with SMTP id p10mr37194118wmq.180.1638788065578;
        Mon, 06 Dec 2021 02:54:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIuosUnzyeNmSj0zhE+uE5ubhdB+Jty+whHapkBAyDfJVoYfMz/aHXzxujgqQtjgLYHLAg2g==
X-Received: by 2002:a05:600c:358a:: with SMTP id p10mr37194048wmq.180.1638788065074;
        Mon, 06 Dec 2021 02:54:25 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id g18sm11144815wrv.42.2021.12.06.02.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:54:24 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v3 07/13] riscv: Implement sv48 support
Date:   Mon,  6 Dec 2021 11:46:51 +0100
Message-Id: <20211206104657.433304-8-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

By adding a new 4th level of page table, give the possibility to 64bit
kernel to address 2^48 bytes of virtual address: in practice, that offers
128TB of virtual address space to userspace and allows up to 64TB of
physical memory.

If the underlying hardware does not support sv48, we will automatically
fallback to a standard 3-level page table by folding the new PUD level into
PGDIR level. In order to detect HW capabilities at runtime, we
use SATP feature that ignores writes with an unsupported mode.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/Kconfig                      |   4 +-
 arch/riscv/include/asm/csr.h            |   3 +-
 arch/riscv/include/asm/fixmap.h         |   1 +
 arch/riscv/include/asm/kasan.h          |   6 +-
 arch/riscv/include/asm/page.h           |  14 ++
 arch/riscv/include/asm/pgalloc.h        |  40 +++++
 arch/riscv/include/asm/pgtable-64.h     | 108 +++++++++++-
 arch/riscv/include/asm/pgtable.h        |  24 ++-
 arch/riscv/kernel/head.S                |   3 +-
 arch/riscv/mm/context.c                 |   4 +-
 arch/riscv/mm/init.c                    | 212 +++++++++++++++++++++---
 arch/riscv/mm/kasan_init.c              | 137 ++++++++++++++-
 drivers/firmware/efi/libstub/efi-stub.c |   2 +
 13 files changed, 514 insertions(+), 44 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ac6c0cd9bc29..d28fe0148e13 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -150,7 +150,7 @@ config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT
 	default 0x80000000 if 64BIT && !MMU
-	default 0xffffffd800000000 if 64BIT
+	default 0xffffaf8000000000 if 64BIT
 
 config KASAN_SHADOW_OFFSET
 	hex
@@ -201,7 +201,7 @@ config FIX_EARLYCON_MEM
 
 config PGTABLE_LEVELS
 	int
-	default 3 if 64BIT
+	default 4 if 64BIT
 	default 2
 
 config LOCKDEP_SUPPORT
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 87ac65696871..3fdb971c7896 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -40,14 +40,13 @@
 #ifndef CONFIG_64BIT
 #define SATP_PPN	_AC(0x003FFFFF, UL)
 #define SATP_MODE_32	_AC(0x80000000, UL)
-#define SATP_MODE	SATP_MODE_32
 #define SATP_ASID_BITS	9
 #define SATP_ASID_SHIFT	22
 #define SATP_ASID_MASK	_AC(0x1FF, UL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UL)
-#define SATP_MODE	SATP_MODE_39
+#define SATP_MODE_48	_AC(0x9000000000000000, UL)
 #define SATP_ASID_BITS	16
 #define SATP_ASID_SHIFT	44
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 54cbf07fb4e9..58a718573ad6 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -24,6 +24,7 @@ enum fixed_addresses {
 	FIX_HOLE,
 	FIX_PTE,
 	FIX_PMD,
+	FIX_PUD,
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index 743e6ff57996..0b85e363e778 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -28,7 +28,11 @@
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
 #define KASAN_SHADOW_SIZE	(UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
-#define KASAN_SHADOW_START	(KASAN_SHADOW_END - KASAN_SHADOW_SIZE)
+/*
+ * Depending on the size of the virtual address space, the region may not be
+ * aligned on PGDIR_SIZE, so force its alignment to ease its population.
+ */
+#define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
 #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index e03559f9b35e..d089fe46f7d8 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -31,7 +31,20 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
+#ifdef CONFIG_64BIT
+#ifdef CONFIG_MMU
+#define PAGE_OFFSET		kernel_map.page_offset
+#else
+#define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
+#endif
+/*
+ * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
+ * define the PAGE_OFFSET value for SV39.
+ */
+#define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
+#else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
+#endif /* CONFIG_64BIT */
 
 /*
  * Half of the kernel address space (half of the entries of the page global
@@ -90,6 +103,7 @@ extern unsigned long riscv_pfn_base;
 #endif /* CONFIG_MMU */
 
 struct kernel_mapping {
+	unsigned long page_offset;
 	unsigned long virt_addr;
 	uintptr_t phys_addr;
 	uintptr_t size;
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 0af6933a7100..11823004b87a 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -11,6 +11,8 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
+#define __HAVE_ARCH_PUD_ALLOC_ONE
+#define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -36,6 +38,44 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 
 	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
 }
+
+static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
+{
+	if (pgtable_l4_enabled) {
+		unsigned long pfn = virt_to_pfn(pud);
+
+		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	}
+}
+
+static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
+				     pud_t *pud)
+{
+	if (pgtable_l4_enabled) {
+		unsigned long pfn = virt_to_pfn(pud);
+
+		set_p4d_safe(p4d,
+			     __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
+	}
+}
+
+#define pud_alloc_one pud_alloc_one
+static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
+{
+	if (pgtable_l4_enabled)
+		return __pud_alloc_one(mm, addr);
+
+	return NULL;
+}
+
+#define pud_free pud_free
+static inline void pud_free(struct mm_struct *mm, pud_t *pud)
+{
+	if (pgtable_l4_enabled)
+		__pud_free(mm, pud);
+}
+
+#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 228261aa9628..bbbdd66e5e2f 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,16 +8,36 @@
 
 #include <linux/const.h>
 
-#define PGDIR_SHIFT     30
+extern bool pgtable_l4_enabled;
+
+#define PGDIR_SHIFT_L3  30
+#define PGDIR_SHIFT_L4  39
+#define PGDIR_SIZE_L3   (_AC(1, UL) << PGDIR_SHIFT_L3)
+
+#define PGDIR_SHIFT     (pgtable_l4_enabled ? PGDIR_SHIFT_L4 : PGDIR_SHIFT_L3)
 /* Size of region mapped by a page global directory */
 #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
 
+/* pud is folded into pgd in case of 3-level page table */
+#define PUD_SHIFT      30
+#define PUD_SIZE       (_AC(1, UL) << PUD_SHIFT)
+#define PUD_MASK       (~(PUD_SIZE - 1))
+
 #define PMD_SHIFT       21
 /* Size of region mapped by a page middle directory */
 #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE - 1))
 
+/* Page Upper Directory entry */
+typedef struct {
+	unsigned long pud;
+} pud_t;
+
+#define pud_val(x)      ((x).pud)
+#define __pud(x)        ((pud_t) { (x) })
+#define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
+
 /* Page Middle Directory entry */
 typedef struct {
 	unsigned long pmd;
@@ -59,6 +79,16 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
+static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
+{
+	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+}
+
+static inline unsigned long _pud_pfn(pud_t pud)
+{
+	return pud_val(pud) >> _PAGE_PFN_SHIFT;
+}
+
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
@@ -69,6 +99,17 @@ static inline struct page *pud_page(pud_t pud)
 	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
+#define mm_pud_folded  mm_pud_folded
+static inline bool mm_pud_folded(struct mm_struct *mm)
+{
+	if (pgtable_l4_enabled)
+		return false;
+
+	return true;
+}
+
+#define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
+
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
 	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
@@ -84,4 +125,69 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
 #define pmd_ERROR(e) \
 	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
 
+#define pud_ERROR(e)   \
+	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
+
+static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		*p4dp = p4d;
+	else
+		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
+}
+
+static inline int p4d_none(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (p4d_val(p4d) == 0);
+
+	return 0;
+}
+
+static inline int p4d_present(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (p4d_val(p4d) & _PAGE_PRESENT);
+
+	return 1;
+}
+
+static inline int p4d_bad(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return !p4d_present(p4d);
+
+	return 0;
+}
+
+static inline void p4d_clear(p4d_t *p4d)
+{
+	if (pgtable_l4_enabled)
+		set_p4d(p4d, __p4d(0));
+}
+
+static inline pud_t *p4d_pgtable(p4d_t p4d)
+{
+	if (pgtable_l4_enabled)
+		return (pud_t *)pfn_to_virt(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
+
+	return (pud_t *)pud_pgtable((pud_t) { p4d_val(p4d) });
+}
+
+static inline struct page *p4d_page(p4d_t p4d)
+{
+	return pfn_to_page(p4d_val(p4d) >> _PAGE_PFN_SHIFT);
+}
+
+#define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
+
+#define pud_offset pud_offset
+static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+{
+	if (pgtable_l4_enabled)
+		return p4d_pgtable(*p4d) + pud_index(address);
+
+	return (pud_t *)p4d;
+}
+
 #endif /* _ASM_RISCV_PGTABLE_64_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e1a52e22ad7e..e1c74ef4ead2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -51,7 +51,7 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
-#define VA_BITS		39
+#define VA_BITS		(pgtable_l4_enabled ? 48 : 39)
 #else
 #define VA_BITS		32
 #endif
@@ -90,8 +90,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Page Upper Directory not used in RISC-V */
-#include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable-nop4d.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 #include <linux/mm_types.h>
@@ -113,6 +112,17 @@
 #define XIP_FIXUP(addr)		(addr)
 #endif /* CONFIG_XIP_KERNEL */
 
+struct pt_alloc_ops {
+	pte_t *(*get_pte_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pte)(uintptr_t va);
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pmd)(uintptr_t va);
+	pud_t *(*get_pud_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pud)(uintptr_t va);
+#endif
+};
+
 #ifdef CONFIG_MMU
 /* Number of entries in the page global directory */
 #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
@@ -669,9 +679,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE      (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_MIN  (PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 #else
-#define TASK_SIZE FIXADDR_START
+#define TASK_SIZE	FIXADDR_START
+#define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
 #else /* CONFIG_MMU */
@@ -697,6 +709,8 @@ extern uintptr_t _dtb_early_pa;
 #define dtb_early_va	_dtb_early_va
 #define dtb_early_pa	_dtb_early_pa
 #endif /* CONFIG_XIP_KERNEL */
+extern u64 satp_mode;
+extern bool pgtable_l4_enabled;
 
 void paging_init(void);
 void misc_mem_init(void);
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 52c5ff9804c5..c3c0ed559770 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -95,7 +95,8 @@ relocate:
 
 	/* Compute satp for kernel page tables, but don't load it yet */
 	srl a2, a0, PAGE_SHIFT
-	li a1, SATP_MODE
+	la a1, satp_mode
+	REG_L a1, 0(a1)
 	or a2, a2, a1
 
 	/*
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index ee3459cb6750..a7246872bd30 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -192,7 +192,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 switch_mm_fast:
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
 		  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
-		  SATP_MODE);
+		  satp_mode);
 
 	if (need_flush_tlb)
 		local_flush_tlb_all();
@@ -201,7 +201,7 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 static void set_mm_noasid(struct mm_struct *mm)
 {
 	/* Switch the page table and blindly nuke entire local TLB */
-	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | SATP_MODE);
+	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
 	local_flush_tlb_all();
 }
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 1552226fb6bd..6a19a1b1caf8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -37,6 +37,17 @@ EXPORT_SYMBOL(kernel_map);
 #define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
 #endif
 
+#ifdef CONFIG_64BIT
+u64 satp_mode = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_48 : SATP_MODE_39;
+#else
+u64 satp_mode = SATP_MODE_32;
+#endif
+EXPORT_SYMBOL(satp_mode);
+
+bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL) ?
+				true : false;
+EXPORT_SYMBOL(pgtable_l4_enabled);
+
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
@@ -53,15 +64,6 @@ extern char _start[];
 void *_dtb_early_va __initdata;
 uintptr_t _dtb_early_pa __initdata;
 
-struct pt_alloc_ops {
-	pte_t *(*get_pte_virt)(phys_addr_t pa);
-	phys_addr_t (*alloc_pte)(uintptr_t va);
-#ifndef __PAGETABLE_PMD_FOLDED
-	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
-	phys_addr_t (*alloc_pmd)(uintptr_t va);
-#endif
-};
-
 static phys_addr_t dma32_phys_limit __initdata;
 
 static void __init zone_sizes_init(void)
@@ -222,7 +224,7 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops _pt_ops __initdata;
+struct pt_alloc_ops _pt_ops __initdata;
 
 #ifdef CONFIG_XIP_KERNEL
 #define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
@@ -238,6 +240,7 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+static pud_t __maybe_unused early_dtb_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
 static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
@@ -326,6 +329,16 @@ static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 #define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
 #endif /* CONFIG_XIP_KERNEL */
 
+static pud_t trampoline_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pud_t fixmap_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pud_t early_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
+
+#ifdef CONFIG_XIP_KERNEL
+#define trampoline_pud ((pud_t *)XIP_FIXUP(trampoline_pud))
+#define fixmap_pud     ((pud_t *)XIP_FIXUP(fixmap_pud))
+#define early_pud      ((pud_t *)XIP_FIXUP(early_pud))
+#endif /* CONFIG_XIP_KERNEL */
+
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
 {
 	/* Before MMU is enabled */
@@ -345,7 +358,7 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	BUG_ON((va - kernel_map.virt_addr) >> PGDIR_SHIFT);
+	BUG_ON((va - kernel_map.virt_addr) >> PUD_SHIFT);
 
 	return (uintptr_t)early_pmd;
 }
@@ -391,21 +404,97 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 	create_pte_mapping(ptep, va, pa, sz, prot);
 }
 
-#define pgd_next_t		pmd_t
-#define alloc_pgd_next(__va)	pt_ops.alloc_pmd(__va)
-#define get_pgd_next_virt(__pa)	pt_ops.get_pmd_virt(__pa)
+static pud_t *__init get_pud_virt_early(phys_addr_t pa)
+{
+	return (pud_t *)((uintptr_t)pa);
+}
+
+static pud_t *__init get_pud_virt_fixmap(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PUD);
+	return (pud_t *)set_fixmap_offset(FIX_PUD, pa);
+}
+
+static pud_t *__init get_pud_virt_late(phys_addr_t pa)
+{
+	return (pud_t *)__va(pa);
+}
+
+static phys_addr_t __init alloc_pud_early(uintptr_t va)
+{
+	/* Only one PUD is available for early mapping */
+	BUG_ON((va - kernel_map.virt_addr) >> PGDIR_SHIFT);
+
+	return (uintptr_t)early_pud;
+}
+
+static phys_addr_t __init alloc_pud_fixmap(uintptr_t va)
+{
+	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+static phys_addr_t alloc_pud_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	BUG_ON(!vaddr);
+	return __pa(vaddr);
+}
+
+static void __init create_pud_mapping(pud_t *pudp,
+				      uintptr_t va, phys_addr_t pa,
+				      phys_addr_t sz, pgprot_t prot)
+{
+	pmd_t *nextp;
+	phys_addr_t next_phys;
+	uintptr_t pud_index = pud_index(va);
+
+	if (sz == PUD_SIZE) {
+		if (pud_val(pudp[pud_index]) == 0)
+			pudp[pud_index] = pfn_pud(PFN_DOWN(pa), prot);
+		return;
+	}
+
+	if (pud_val(pudp[pud_index]) == 0) {
+		next_phys = pt_ops.alloc_pmd(va);
+		pudp[pud_index] = pfn_pud(PFN_DOWN(next_phys), PAGE_TABLE);
+		nextp = pt_ops.get_pmd_virt(next_phys);
+		memset(nextp, 0, PAGE_SIZE);
+	} else {
+		next_phys = PFN_PHYS(_pud_pfn(pudp[pud_index]));
+		nextp = pt_ops.get_pmd_virt(next_phys);
+	}
+
+	create_pmd_mapping(nextp, va, pa, sz, prot);
+}
+
+#define pgd_next_t		pud_t
+#define alloc_pgd_next(__va)	(pgtable_l4_enabled ?			\
+		pt_ops.alloc_pud(__va) : pt_ops.alloc_pmd(__va))
+#define get_pgd_next_virt(__pa)	(pgtable_l4_enabled ?			\
+		pt_ops.get_pud_virt(__pa) : (pgd_next_t *)pt_ops.get_pmd_virt(__pa))
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
-	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
-#define fixmap_pgd_next		fixmap_pmd
+				(pgtable_l4_enabled ?			\
+		create_pud_mapping(__nextp, __va, __pa, __sz, __prot) :	\
+		create_pmd_mapping((pmd_t *)__nextp, __va, __pa, __sz, __prot))
+#define fixmap_pgd_next		(pgtable_l4_enabled ?			\
+		(uintptr_t)fixmap_pud : (uintptr_t)fixmap_pmd)
+#define trampoline_pgd_next	(pgtable_l4_enabled ?			\
+		(uintptr_t)trampoline_pud : (uintptr_t)trampoline_pmd)
+#define early_dtb_pgd_next	(pgtable_l4_enabled ?			\
+		(uintptr_t)early_dtb_pud : (uintptr_t)early_dtb_pmd)
 #else
 #define pgd_next_t		pte_t
 #define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
 #define get_pgd_next_virt(__pa)	pt_ops.get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
-#define fixmap_pgd_next		fixmap_pte
+#define fixmap_pgd_next		((uintptr_t)fixmap_pte)
+#define early_dtb_pgd_next	((uintptr_t)early_dtb_pmd)
+#define create_pud_mapping(__pmdp, __va, __pa, __sz, __prot)
 #define create_pmd_mapping(__pmdp, __va, __pa, __sz, __prot)
-#endif
+#endif /* __PAGETABLE_PMD_FOLDED */
 
 void __init create_pgd_mapping(pgd_t *pgdp,
 				      uintptr_t va, phys_addr_t pa,
@@ -493,6 +582,57 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
+#ifdef CONFIG_64BIT
+static void __init disable_pgtable_l4(void)
+{
+	pgtable_l4_enabled = false;
+	kernel_map.page_offset = PAGE_OFFSET_L3;
+	satp_mode = SATP_MODE_39;
+}
+
+/*
+ * There is a simple way to determine if 4-level is supported by the
+ * underlying hardware: establish 1:1 mapping in 4-level page table mode
+ * then read SATP to see if the configuration was taken into account
+ * meaning sv48 is supported.
+ */
+static __init void set_satp_mode(void)
+{
+	u64 identity_satp, hw_satp;
+	uintptr_t set_satp_mode_pmd;
+
+	set_satp_mode_pmd = ((unsigned long)set_satp_mode) & PMD_MASK;
+	create_pgd_mapping(early_pg_dir,
+			   set_satp_mode_pmd, (uintptr_t)early_pud,
+			   PGDIR_SIZE, PAGE_TABLE);
+	create_pud_mapping(early_pud,
+			   set_satp_mode_pmd, (uintptr_t)early_pmd,
+			   PUD_SIZE, PAGE_TABLE);
+	/* Handle the case where set_satp_mode straddles 2 PMDs */
+	create_pmd_mapping(early_pmd,
+			   set_satp_mode_pmd, set_satp_mode_pmd,
+			   PMD_SIZE, PAGE_KERNEL_EXEC);
+	create_pmd_mapping(early_pmd,
+			   set_satp_mode_pmd + PMD_SIZE,
+			   set_satp_mode_pmd + PMD_SIZE,
+			   PMD_SIZE, PAGE_KERNEL_EXEC);
+
+	identity_satp = PFN_DOWN((uintptr_t)&early_pg_dir) | satp_mode;
+
+	local_flush_tlb_all();
+	csr_write(CSR_SATP, identity_satp);
+	hw_satp = csr_swap(CSR_SATP, 0ULL);
+	local_flush_tlb_all();
+
+	if (hw_satp != identity_satp)
+		disable_pgtable_l4();
+
+	memset(early_pg_dir, 0, PAGE_SIZE);
+	memset(early_pud, 0, PAGE_SIZE);
+	memset(early_pmd, 0, PAGE_SIZE);
+}
+#endif
+
 /*
  * setup_vm() is called from head.S with MMU-off.
  *
@@ -557,10 +697,15 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   IS_ENABLED(CONFIG_64BIT) ? (uintptr_t)early_dtb_pmd : pa,
+			   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
 			   PGDIR_SIZE,
 			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
 
+	if (pgtable_l4_enabled) {
+		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
+				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
+	}
+
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
 				   pa, PMD_SIZE, PAGE_KERNEL);
@@ -593,6 +738,8 @@ void pt_ops_set_early(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_early;
 	pt_ops.get_pmd_virt = get_pmd_virt_early;
+	pt_ops.alloc_pud = alloc_pud_early;
+	pt_ops.get_pud_virt = get_pud_virt_early;
 #endif
 }
 
@@ -611,6 +758,8 @@ void pt_ops_set_fixmap(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = kernel_mapping_pa_to_va((uintptr_t)alloc_pmd_fixmap);
 	pt_ops.get_pmd_virt = kernel_mapping_pa_to_va((uintptr_t)get_pmd_virt_fixmap);
+	pt_ops.alloc_pud = kernel_mapping_pa_to_va((uintptr_t)alloc_pud_fixmap);
+	pt_ops.get_pud_virt = kernel_mapping_pa_to_va((uintptr_t)get_pud_virt_fixmap);
 #endif
 }
 
@@ -625,6 +774,8 @@ void pt_ops_set_late(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_late;
 	pt_ops.get_pmd_virt = get_pmd_virt_late;
+	pt_ops.alloc_pud = alloc_pud_late;
+	pt_ops.get_pud_virt = get_pud_virt_late;
 #endif
 }
 
@@ -633,6 +784,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	pmd_t __maybe_unused fix_bmap_spmd, fix_bmap_epmd;
 
 	kernel_map.virt_addr = KERNEL_LINK_ADDR;
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
@@ -647,6 +799,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.phys_addr = (uintptr_t)(&_start);
 	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
 #endif
+
+#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
+	set_satp_mode();
+#endif
+
 	kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
@@ -676,15 +833,21 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 
 	/* Setup early PGD for fixmap */
 	create_pgd_mapping(early_pg_dir, FIXADDR_START,
-			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
+			   fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
 
 #ifndef __PAGETABLE_PMD_FOLDED
-	/* Setup fixmap PMD */
+	/* Setup fixmap PUD and PMD */
+	if (pgtable_l4_enabled)
+		create_pud_mapping(fixmap_pud, FIXADDR_START,
+				   (uintptr_t)fixmap_pmd, PUD_SIZE, PAGE_TABLE);
 	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
 			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
 	/* Setup trampoline PGD and PMD */
 	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
-			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
+			   trampoline_pgd_next, PGDIR_SIZE, PAGE_TABLE);
+	if (pgtable_l4_enabled)
+		create_pud_mapping(trampoline_pud, kernel_map.virt_addr,
+				   (uintptr_t)trampoline_pmd, PUD_SIZE, PAGE_TABLE);
 #ifdef CONFIG_XIP_KERNEL
 	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
 			   kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
@@ -712,7 +875,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
 	 * range can not span multiple pmds.
 	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+	BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -783,9 +946,10 @@ static void __init setup_vm_final(void)
 	/* Clear fixmap PTE and PMD mappings */
 	clear_fixmap(FIX_PTE);
 	clear_fixmap(FIX_PMD);
+	clear_fixmap(FIX_PUD);
 
 	/* Move to swapper page table */
-	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
+	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 
 	pt_ops_set_late();
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 1434a0225140..993f50571a3b 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -11,7 +11,29 @@
 #include <asm/fixmap.h>
 #include <asm/pgalloc.h>
 
+/*
+ * Kasan shadow region must lie at a fixed address across sv39, sv48 and sv57
+ * which is right before the kernel.
+ *
+ * For sv39, the region is aligned on PGDIR_SIZE so we only need to populate
+ * the page global directory with kasan_early_shadow_pmd.
+ *
+ * For sv48 and sv57, the region is not aligned on PGDIR_SIZE so the mapping
+ * must be divided as follows:
+ * - the first PGD entry, although incomplete, is populated with
+ *   kasan_early_shadow_pud/p4d
+ * - the PGD entries in the middle are populated with kasan_early_shadow_pud/p4d
+ * - the last PGD entry is shared with the kernel mapping so populated at the
+ *   lower levels pud/p4d
+ *
+ * In addition, when shallow populating a kasan region (for example vmalloc),
+ * this region may also not be aligned on PGDIR size, so we must go down to the
+ * pud level too.
+ */
+
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
+extern struct pt_alloc_ops _pt_ops __initdata;
+#define pt_ops	_pt_ops
 
 static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned long end)
 {
@@ -35,15 +57,19 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
 	set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(base_pte)), PAGE_TABLE));
 }
 
-static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned long end)
+static void __init kasan_populate_pmd(pud_t *pud, unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
 	pmd_t *pmdp, *base_pmd;
 	unsigned long next;
 
-	base_pmd = (pmd_t *)pgd_page_vaddr(*pgd);
-	if (base_pmd == lm_alias(kasan_early_shadow_pmd))
+	if (pud_none(*pud)) {
 		base_pmd = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
+	} else {
+		base_pmd = (pmd_t *)pud_pgtable(*pud);
+		if (base_pmd == lm_alias(kasan_early_shadow_pmd))
+			base_pmd = memblock_alloc(PTRS_PER_PMD * sizeof(pmd_t), PAGE_SIZE);
+	}
 
 	pmdp = base_pmd + pmd_index(vaddr);
 
@@ -67,9 +93,72 @@ static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
+	set_pud(pud, pfn_pud(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
+}
+
+static void __init kasan_populate_pud(pgd_t *pgd,
+				      unsigned long vaddr, unsigned long end,
+				      bool early)
+{
+	phys_addr_t phys_addr;
+	pud_t *pudp, *base_pud;
+	unsigned long next;
+
+	if (early) {
+		/*
+		 * We can't use pgd_page_vaddr here as it would return a linear
+		 * mapping address but it is not mapped yet, but when populating
+		 * early_pg_dir, we need the physical address and when populating
+		 * swapper_pg_dir, we need the kernel virtual address so use
+		 * pt_ops facility.
+		 */
+		base_pud = pt_ops.get_pud_virt(pfn_to_phys(_pgd_pfn(*pgd)));
+	} else {
+		base_pud = (pud_t *)pgd_page_vaddr(*pgd);
+		if (base_pud == lm_alias(kasan_early_shadow_pud))
+			base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
+	}
+
+	pudp = base_pud + pud_index(vaddr);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE) {
+			if (early) {
+				phys_addr = __pa(((uintptr_t)kasan_early_shadow_pmd));
+				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_TABLE));
+				continue;
+			} else {
+				phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
+				if (phys_addr) {
+					set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
+					continue;
+				}
+			}
+		}
+
+		kasan_populate_pmd(pudp, vaddr, next);
+	} while (pudp++, vaddr = next, vaddr != end);
+
+	/*
+	 * Wait for the whole PGD to be populated before setting the PGD in
+	 * the page table, otherwise, if we did set the PGD before populating
+	 * it entirely, memblock could allocate a page at a physical address
+	 * where KASAN is not populated yet and then we'd get a page fault.
+	 */
+	if (!early)
+		set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
 }
 
+#define kasan_early_shadow_pgd_next			(pgtable_l4_enabled ?	\
+				(uintptr_t)kasan_early_shadow_pud :		\
+				(uintptr_t)kasan_early_shadow_pmd)
+#define kasan_populate_pgd_next(pgdp, vaddr, next, early)			\
+		(pgtable_l4_enabled ?						\
+			kasan_populate_pud(pgdp, vaddr, next, early) :		\
+			kasan_populate_pmd((pud_t *)pgdp, vaddr, next))
+
 static void __init kasan_populate_pgd(pgd_t *pgdp,
 				      unsigned long vaddr, unsigned long end,
 				      bool early)
@@ -102,7 +191,7 @@ static void __init kasan_populate_pgd(pgd_t *pgdp,
 			}
 		}
 
-		kasan_populate_pmd(pgdp, vaddr, next);
+		kasan_populate_pgd_next(pgdp, vaddr, next, early);
 	} while (pgdp++, vaddr = next, vaddr != end);
 }
 
@@ -157,18 +246,54 @@ static void __init kasan_populate(void *start, void *end)
 	memset(start, KASAN_SHADOW_INIT, end - start);
 }
 
+static void __init kasan_shallow_populate_pud(pgd_t *pgdp,
+					      unsigned long vaddr, unsigned long end,
+					      bool kasan_populate)
+{
+	unsigned long next;
+	pud_t *pudp, *base_pud;
+	pmd_t *base_pmd;
+	bool is_kasan_pmd;
+
+	base_pud = (pud_t *)pgd_page_vaddr(*pgdp);
+	pudp = base_pud + pud_index(vaddr);
+
+	if (kasan_populate)
+		memcpy(base_pud, (void *)kasan_early_shadow_pgd_next,
+		       sizeof(pud_t) * PTRS_PER_PUD);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+		is_kasan_pmd = (pud_pgtable(*pudp) == lm_alias(kasan_early_shadow_pmd));
+
+		if (is_kasan_pmd) {
+			base_pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+			set_pud(pudp, pfn_pud(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
+		}
+	} while (pudp++, vaddr = next, vaddr != end);
+}
+
 static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
 {
 	unsigned long next;
 	void *p;
 	pgd_t *pgd_k = pgd_offset_k(vaddr);
+	bool is_kasan_pgd_next;
 
 	do {
 		next = pgd_addr_end(vaddr, end);
-		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
+		is_kasan_pgd_next = (pgd_page_vaddr(*pgd_k) ==
+				     (unsigned long)lm_alias(kasan_early_shadow_pgd_next));
+
+		if (is_kasan_pgd_next) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
 		}
+
+		if (IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE)
+			continue;
+
+		kasan_shallow_populate_pud(pgd_k, vaddr, next, is_kasan_pgd_next);
 	} while (pgd_k++, vaddr = next, vaddr != end);
 }
 
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..b3db5d91ed38 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -40,6 +40,8 @@
 
 #ifdef CONFIG_ARM64
 # define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
+#elif defined(CONFIG_RISCV)
+# define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE_MIN
 #else
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
 #endif
-- 
2.32.0

