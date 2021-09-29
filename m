Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577DE41C781
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbhI2O5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:57:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60270
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344846AbhI2O5Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Sep 2021 10:57:24 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8C7D9402E0
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632927342;
        bh=awWrnxw7XqyT87/sstWbSrTnivM2deqGka3w/js2sKc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CcCtvUB8dEgj33c9Oa0KLRka/AUFePsATpLm45CJC6OeyUQDbyFXt4y89jGXPj7Il
         EOeo7xa+JvuLKryqOBilT/zwC2JkMvS72swvM3fzAmRz76RDDpHJm9W9YCBg3z5RjN
         8XPIZ2pgNhUUVEWnaNdNac+xq6vMGr936j7uWt0NMlhQ3lw36sm9htSIWqwC6MdabT
         PyqTgcSCyTzzNJRdhTAhuCY7aW3/NYhLBK8EwzTgTDw/PwRNJWqO6Wiv7mnfHqp5GH
         B5dP7QB6Gk2pEArhpxKQOkMn5raneluM91qVz1Ya5df8UdmTiNC+xeRvqsOazh/CWk
         dYMz76lm0AX5w==
Received: by mail-wm1-f72.google.com with SMTP id n3-20020a7bcbc3000000b0030b68c4de38so944600wmi.8
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awWrnxw7XqyT87/sstWbSrTnivM2deqGka3w/js2sKc=;
        b=y5YoXlVPJbk9yIww31JoKckxck3Hi2jsQiuUQ1EZjO6eQQmXfx3dGT7rbUZWlBEH0A
         iNQ/5q57ZNcZnd7iJimm9crpTr8OEWtpQ0sBX6CvAjJKtIxElB6DvCAl1oMZ1eajHyWc
         Hrr4SU3yQJees01NNHIVm/KHuImumjPWC+X7GMJ1XrM06/3j+RBY5N69eDw7tRfNfWxT
         ROzZY4olxeJYNN2RCDGqc+baniORzKvHexcNs6d2uCPA8yRw4wwth8+xjUOGvcq45W6c
         NgXAt1JdtmPng2CX0BUjhUCwnCxtgqb+JLKz9pCO7ryqEdQU7qT/aTMd/G9LwN12w2Kj
         0bNg==
X-Gm-Message-State: AOAM5326xIBeZAfHwZNdE+ZIgv993PXiD/iGSZNXbiT8JCCnInGcI8HU
        tajOaEGt0reYBDlRm0AI9kfqCuG34qbCenIi+UJkkS7xO+ppqRkAc5DCtp0xV4YvkmIC2EKgFeR
        PWzk0cboXewLNKESE6WW+CfHJhexnCKVWJYYj9hs=
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr10894262wme.94.1632927339817;
        Wed, 29 Sep 2021 07:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8D5M/97J3v8XskkJPvumC0JS9zzuGgTmkHPq7+U8rVZpW/0Lx5A0C/aWwIxMy4QIxrTA6mA==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr10894235wme.94.1632927339436;
        Wed, 29 Sep 2021 07:55:39 -0700 (PDT)
Received: from alex.home (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id s24sm58063wmh.34.2021.09.29.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 07:55:39 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
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
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v2 04/10] riscv: Implement sv48 support
Date:   Wed, 29 Sep 2021 16:51:07 +0200
Message-Id: <20210929145113.1935778-5-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
References: <20210929145113.1935778-1-alexandre.ghiti@canonical.com>
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
 arch/riscv/include/asm/kasan.h          |   2 +-
 arch/riscv/include/asm/page.h           |  10 +
 arch/riscv/include/asm/pgalloc.h        |  40 ++++
 arch/riscv/include/asm/pgtable-64.h     | 108 ++++++++++-
 arch/riscv/include/asm/pgtable.h        |  13 +-
 arch/riscv/kernel/head.S                |   3 +-
 arch/riscv/mm/context.c                 |   4 +-
 arch/riscv/mm/init.c                    | 237 ++++++++++++++++++++----
 arch/riscv/mm/kasan_init.c              |  91 +++++++--
 drivers/firmware/efi/libstub/efi-stub.c |   2 +
 13 files changed, 453 insertions(+), 65 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 13e9c4298fbc..69c5533955ed 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -149,7 +149,7 @@ config PAGE_OFFSET
 	hex
 	default 0xC0000000 if 32BIT
 	default 0x80000000 if 64BIT && !MMU
-	default 0xffffffe000000000 if 64BIT
+	default 0xffffc00000000000 if 64BIT
 
 config ARCH_FLATMEM_ENABLE
 	def_bool !NUMA
@@ -197,7 +197,7 @@ config FIX_EARLYCON_MEM
 
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
index a2b3d9cdbc86..1dcf5fa93aa0 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -27,7 +27,7 @@
  */
 #define KASAN_SHADOW_SCALE_SHIFT	3
 
-#define KASAN_SHADOW_SIZE	(UL(1) << ((CONFIG_VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
+#define KASAN_SHADOW_SIZE	(UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
 #define KASAN_SHADOW_START	KERN_VIRT_START
 #define KASAN_SHADOW_END	(KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
 #define KASAN_SHADOW_OFFSET	(KASAN_SHADOW_END - (1ULL << \
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 109c97e991a6..6ff4d70d13a6 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -31,7 +31,16 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
+#ifdef CONFIG_64BIT
+#define PAGE_OFFSET		kernel_map.page_offset
+/*
+ * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address space so
+ * define the PAGE_OFFSET value for SV39.
+ */
+#define PAGE_OFFSET_L3		_AC(0xffffffe000000000, UL)
+#else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
+#endif /* CONFIG_64BIT */
 
 #define KERN_VIRT_SIZE (-PAGE_OFFSET)
 
@@ -86,6 +95,7 @@ extern unsigned long riscv_pfn_base;
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
index e3e03226a50a..2f92d61237b4 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -49,7 +49,7 @@
  * position vmemmap directly below the VMALLOC region.
  */
 #ifdef CONFIG_64BIT
-#define VA_BITS		39
+#define VA_BITS		(pgtable_l4_enabled ? 48 : 39)
 #else
 #define VA_BITS		32
 #endif
@@ -88,8 +88,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Page Upper Directory not used in RISC-V */
-#include <asm-generic/pgtable-nopud.h>
+#include <asm-generic/pgtable-nop4d.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
 #include <linux/mm_types.h>
@@ -667,9 +666,11 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
@@ -695,6 +696,8 @@ extern uintptr_t _dtb_early_pa;
 #define dtb_early_va	_dtb_early_va
 #define dtb_early_pa	_dtb_early_pa
 #endif /* CONFIG_XIP_KERNEL */
+extern u64 satp_mode;
+extern bool pgtable_l4_enabled;
 
 void paging_init(void);
 void misc_mem_init(void);
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index fce5184b22c3..8f21ef339c68 100644
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
index c0cddf0fc22d..d7de414c6500 100644
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
 
@@ -59,6 +70,8 @@ struct pt_alloc_ops {
 #ifndef __PAGETABLE_PMD_FOLDED
 	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
 	phys_addr_t (*alloc_pmd)(uintptr_t va);
+	pud_t *(*get_pud_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pud)(uintptr_t va);
 #endif
 };
 
@@ -130,18 +143,8 @@ void __init mem_init(void)
 	print_vm_layout();
 }
 
-/*
- * The default maximal physical memory size is -PAGE_OFFSET for 32-bit kernel,
- * whereas for 64-bit kernel, the end of the virtual address space is occupied
- * by the modules/BPF/kernel mappings which reduces the available size of the
- * linear mapping.
- * Limit the memory size via mem.
- */
-#ifdef CONFIG_64BIT
-static phys_addr_t memory_limit = -PAGE_OFFSET - SZ_4G;
-#else
-static phys_addr_t memory_limit = -PAGE_OFFSET;
-#endif
+/* Limit the memory size via mem. */
+static phys_addr_t memory_limit;
 
 static int __init early_mem(char *p)
 {
@@ -245,6 +248,7 @@ pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 
 pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
+static pud_t __maybe_unused early_dtb_pud[PTRS_PER_PUD] __initdata __aligned(PAGE_SIZE);
 static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_XIP_KERNEL
@@ -333,6 +337,16 @@ static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
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
@@ -352,7 +366,7 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	BUG_ON((va - kernel_map.virt_addr) >> PGDIR_SHIFT);
+	BUG_ON((va - kernel_map.virt_addr) >> PUD_SHIFT);
 
 	return (uintptr_t)early_pmd;
 }
@@ -398,21 +412,97 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
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
@@ -500,6 +590,57 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
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
@@ -564,10 +705,14 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
 	uintptr_t pa = dtb_pa & ~(PMD_SIZE - 1);
 
 	create_pgd_mapping(early_pg_dir, DTB_EARLY_BASE_VA,
-			   IS_ENABLED(CONFIG_64BIT) ? (uintptr_t)early_dtb_pmd : pa,
+			   IS_ENABLED(CONFIG_64BIT) ? early_dtb_pgd_next : pa,
 			   PGDIR_SIZE,
 			   IS_ENABLED(CONFIG_64BIT) ? PAGE_TABLE : PAGE_KERNEL);
 
+	if (pgtable_l4_enabled)
+		create_pud_mapping(early_dtb_pud, DTB_EARLY_BASE_VA,
+				   (uintptr_t)early_dtb_pmd, PUD_SIZE, PAGE_TABLE);
+
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA,
 				   pa, PMD_SIZE, PAGE_KERNEL);
@@ -593,7 +738,17 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 	pmd_t __maybe_unused fix_bmap_spmd, fix_bmap_epmd;
 
+	pt_ops.alloc_pte = alloc_pte_early;
+	pt_ops.get_pte_virt = get_pte_virt_early;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_early;
+	pt_ops.get_pmd_virt = get_pmd_virt_early;
+	pt_ops.alloc_pud = alloc_pud_early;
+	pt_ops.get_pud_virt = get_pud_virt_early;
+#endif
+
 	kernel_map.virt_addr = KERNEL_LINK_ADDR;
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
 
 #ifdef CONFIG_XIP_KERNEL
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
@@ -608,11 +763,24 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
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
 
 	riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
 
+	/*
+	 * The default maximal physical memory size is -PAGE_OFFSET for 32-bit kernel,
+	 * whereas for 64-bit kernel, the end of the virtual address space is occupied
+	 * by the modules/BPF/kernel mappings which reduces the available size of the
+	 * linear mapping.
+	 */
+	memory_limit = -PAGE_OFFSET - (IS_ENABLED(CONFIG_64BIT) ? SZ_4G : 0);
+
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
 	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
@@ -625,23 +793,23 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
 #endif
 
-	pt_ops.alloc_pte = alloc_pte_early;
-	pt_ops.get_pte_virt = get_pte_virt_early;
-#ifndef __PAGETABLE_PMD_FOLDED
-	pt_ops.alloc_pmd = alloc_pmd_early;
-	pt_ops.get_pmd_virt = get_pmd_virt_early;
-#endif
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
@@ -669,7 +837,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
 	 * range can not span multiple pmds.
 	 */
-	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+	BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
 		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
 
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -711,6 +879,8 @@ static void __init setup_vm_final(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_fixmap;
 	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
+	pt_ops.alloc_pud = alloc_pud_fixmap;
+	pt_ops.get_pud_virt = get_pud_virt_fixmap;
 #endif
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
@@ -744,9 +914,10 @@ static void __init setup_vm_final(void)
 	/* Clear fixmap PTE and PMD mappings */
 	clear_fixmap(FIX_PTE);
 	clear_fixmap(FIX_PMD);
+	clear_fixmap(FIX_PUD);
 
 	/* Move to swapper page table */
-	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
+	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 
 	/* generic page allocation functions must be used to setup page table */
@@ -755,6 +926,8 @@ static void __init setup_vm_final(void)
 #ifndef __PAGETABLE_PMD_FOLDED
 	pt_ops.alloc_pmd = alloc_pmd_late;
 	pt_ops.get_pmd_virt = get_pmd_virt_late;
+	pt_ops.alloc_pud = alloc_pud_late;
+	pt_ops.get_pud_virt = get_pud_virt_late;
 #endif
 }
 #else
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index d7189c8714a9..2573d77cbef6 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -14,7 +14,7 @@
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
 asmlinkage void __init kasan_early_init(void)
 {
-	uintptr_t i;
+	uintptr_t i, pfn_pgd_next;
 	pgd_t *pgd = early_pg_dir + pgd_index(KASAN_SHADOW_START);
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
@@ -25,25 +25,31 @@ asmlinkage void __init kasan_early_init(void)
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
 			pfn_pmd(PFN_DOWN
-				(__pa((uintptr_t) kasan_early_shadow_pte)),
-				__pgprot(_PAGE_TABLE)));
+				(__pa((uintptr_t)kasan_early_shadow_pte)),
+				PAGE_TABLE));
+
+	if (pgtable_l4_enabled) {
+		for (i = 0; i < PTRS_PER_PUD; ++i)
+			set_pud(kasan_early_shadow_pud + i,
+				pfn_pud(PFN_DOWN
+					(__pa(((uintptr_t)kasan_early_shadow_pmd))),
+					PAGE_TABLE));
+
+		pfn_pgd_next = PFN_DOWN(__pa((uintptr_t)kasan_early_shadow_pud));
+	} else {
+		pfn_pgd_next = PFN_DOWN(__pa((uintptr_t)kasan_early_shadow_pmd));
+	}
 
 	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
 	     i += PGDIR_SIZE, ++pgd)
-		set_pgd(pgd,
-			pfn_pgd(PFN_DOWN
-				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
-				__pgprot(_PAGE_TABLE)));
+		set_pgd(pgd, pfn_pgd(pfn_pgd_next, PAGE_TABLE));
 
 	/* init for swapper_pg_dir */
 	pgd = pgd_offset_k(KASAN_SHADOW_START);
 
 	for (i = KASAN_SHADOW_START; i < KASAN_SHADOW_END;
 	     i += PGDIR_SIZE, ++pgd)
-		set_pgd(pgd,
-			pfn_pgd(PFN_DOWN
-				(__pa(((uintptr_t) kasan_early_shadow_pmd))),
-				__pgprot(_PAGE_TABLE)));
+		set_pgd(pgd, pfn_pgd(pfn_pgd_next, PAGE_TABLE));
 
 	local_flush_tlb_all();
 }
@@ -70,15 +76,19 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
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
 
@@ -102,9 +112,51 @@ static void __init kasan_populate_pmd(pgd_t *pgd, unsigned long vaddr, unsigned
 	 * it entirely, memblock could allocate a page at a physical address
 	 * where KASAN is not populated yet and then we'd get a page fault.
 	 */
-	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
+	set_pud(pud, pfn_pud(PFN_DOWN(__pa(base_pmd)), PAGE_TABLE));
 }
 
+static void __init kasan_populate_pud(pgd_t *pgd, unsigned long vaddr, unsigned long end)
+{
+	phys_addr_t phys_addr;
+	pud_t *pudp, *base_pud;
+	unsigned long next;
+
+	base_pud = (pud_t *)pgd_page_vaddr(*pgd);
+	if (base_pud == lm_alias(kasan_early_shadow_pud))
+		base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
+
+	pudp = base_pud + pud_index(vaddr);
+
+	do {
+		next = pud_addr_end(vaddr, end);
+
+		if (pud_none(*pudp) && IS_ALIGNED(vaddr, PUD_SIZE) && (next - vaddr) >= PUD_SIZE) {
+			phys_addr = memblock_phys_alloc(PUD_SIZE, PUD_SIZE);
+			if (phys_addr) {
+				set_pud(pudp, pfn_pud(PFN_DOWN(phys_addr), PAGE_KERNEL));
+				continue;
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
+	set_pgd(pgd, pfn_pgd(PFN_DOWN(__pa(base_pud)), PAGE_TABLE));
+}
+
+#define kasan_early_shadow_pgd_next			(pgtable_l4_enabled ?	\
+				(uintptr_t)kasan_early_shadow_pud :		\
+				(uintptr_t)kasan_early_shadow_pmd)
+#define kasan_populate_pgd_next(pgdp, vaddr, next)	(pgtable_l4_enabled ?	\
+				kasan_populate_pud(pgdp, vaddr, next) :		\
+				kasan_populate_pmd((pud_t *)pgdp, vaddr, next))
+
 static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
 {
 	phys_addr_t phys_addr;
@@ -116,10 +168,10 @@ static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
 
 		/*
 		 * pgdp can't be none since kasan_early_init initialized all KASAN
-		 * shadow region with kasan_early_shadow_pmd: if this is stillthe case,
+		 * shadow region with kasan_early_shadow_pud: if this is still the case,
 		 * that means we can try to allocate a hugepage as a replacement.
 		 */
-		if (pgd_page_vaddr(*pgdp) == (unsigned long)lm_alias(kasan_early_shadow_pmd) &&
+		if (pgd_page_vaddr(*pgdp) == (unsigned long)lm_alias(kasan_early_shadow_pgd_next) &&
 		    IS_ALIGNED(vaddr, PGDIR_SIZE) && (next - vaddr) >= PGDIR_SIZE) {
 			phys_addr = memblock_phys_alloc(PGDIR_SIZE, PGDIR_SIZE);
 			if (phys_addr) {
@@ -128,7 +180,7 @@ static void __init kasan_populate_pgd(unsigned long vaddr, unsigned long end)
 			}
 		}
 
-		kasan_populate_pmd(pgdp, vaddr, next);
+		kasan_populate_pgd_next(pgdp, vaddr, next);
 	} while (pgdp++, vaddr = next, vaddr != end);
 }
 
@@ -151,7 +203,8 @@ static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long
 
 	do {
 		next = pgd_addr_end(vaddr, end);
-		if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
+		if (pgd_page_vaddr(*pgd_k) ==
+		    (unsigned long)lm_alias(kasan_early_shadow_pgd_next)) {
 			p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 			set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
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
2.30.2

