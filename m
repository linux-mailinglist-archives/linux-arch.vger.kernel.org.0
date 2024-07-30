Return-Path: <linux-arch+bounces-5714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3C9409AB
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DCB28557D
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3450190468;
	Tue, 30 Jul 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWXv2pEp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC818F2CA;
	Tue, 30 Jul 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324209; cv=none; b=cRbGG13HyjBlmlDs0Z7mAUSq+KbYnxgw5eGalRKQo4KG0CazdZTwa1AK5r0D4jQBP5mRckuBW5GG1zlAc7sA71SQBKioT/G2gF/hlx/9kpM+yhtw//kHnu4ypxcgqGSc5RHBb8pT47LJ9M8wOtEJXpvNyBnLJLR6UVG2gsRo4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324209; c=relaxed/simple;
	bh=pmAot7c13dNSFHJIzK3xlU5SqKtGMVMiLmncclf/DQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlST5XY621m/sCqTRK4TlRzN9D5mz7LSJk8gXe8LUjfDVOLf46ltzFP9uX+WvZzL0mLoXshCA0UzI8a9j958o4ca50qSOkAWXhF2aD6Tc2BwsGp216Wdn9npjwqsCzO5CUqog7yq+ftAmU7P4wTUWNdjbiClfc4oNqEnWtKgo0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWXv2pEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B845C4AF0C;
	Tue, 30 Jul 2024 07:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722324209;
	bh=pmAot7c13dNSFHJIzK3xlU5SqKtGMVMiLmncclf/DQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWXv2pEp/nNupQjdbP6hn5kUITNeBpHRDBazsYl2CUpADVig7M2J+omHoRHo3TFZb
	 +Hk/4ktC45EKRUaZWbMYrHYfA/pgKh8zhcILxOPrp0butWLZomt6kbTElUUEqnCvg+
	 SVxMSWauhY/FHuAmUmxcA33G+FwZWZcQuJbRclpvkV5vc68Za2RA5bPELHmpu6rlPH
	 N+kHuGSwuqg5k9oZXP5d+CBTW8Rt24mZVqRqc57EoCY2n8zfWwOCWH8dVd9qkRpU3K
	 tg4w7ehvyfwE6q5ygSgvHB/7psYaWDXrfQSximxaEI4rwD91P92gbo/uuZ9G3P/b2a
	 AxzNLLDhX3CvQ==
From: alexs@kernel.org
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linux-parisc@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-alpha@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Sam Creasey <sammy@sammy.net>,
	Huacai Chen <chenhuacai@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH 15/18] mm/pgtable: pass ptdesc to pmd_populate
Date: Tue, 30 Jul 2024 15:27:16 +0800
Message-ID: <20240730072719.3715016-5-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730072719.3715016-1-alexs@kernel.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
 <20240730072719.3715016-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Pass struct ptdesc to pmd_populate to further replace pgtable_t.
We use type casting instead of page_ptdesc() helper since different arch
has different type of pgtable_t.

Helper ptdesc_pfn used for arch openrisc and hexagon.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-openrisc@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: loongarch@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Sam Creasey <sammy@sammy.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: Vishal Moola  <vishal.moola@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
---
 arch/alpha/include/asm/pgalloc.h             | 4 ++--
 arch/arc/include/asm/pgalloc.h               | 4 ++--
 arch/arm/include/asm/pgalloc.h               | 4 ++--
 arch/arm64/include/asm/pgalloc.h             | 4 ++--
 arch/hexagon/include/asm/pgalloc.h           | 4 ++--
 arch/loongarch/include/asm/pgalloc.h         | 4 ++--
 arch/m68k/include/asm/motorola_pgalloc.h     | 4 ++--
 arch/m68k/include/asm/sun3_pgalloc.h         | 4 ++--
 arch/microblaze/include/asm/pgalloc.h        | 2 +-
 arch/mips/include/asm/pgalloc.h              | 4 ++--
 arch/nios2/include/asm/pgalloc.h             | 4 ++--
 arch/openrisc/include/asm/pgalloc.h          | 4 ++--
 arch/parisc/include/asm/pgalloc.h            | 2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 2 +-
 arch/sh/include/asm/pgalloc.h                | 4 ++--
 arch/sparc/include/asm/pgalloc_32.h          | 2 +-
 arch/x86/include/asm/pgalloc.h               | 4 ++--
 mm/debug_vm_pgtable.c                        | 2 +-
 mm/huge_memory.c                             | 8 ++++----
 mm/khugepaged.c                              | 4 ++--
 mm/memory.c                                  | 2 +-
 mm/mremap.c                                  | 2 +-
 22 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/alpha/include/asm/pgalloc.h b/arch/alpha/include/asm/pgalloc.h
index 68be7adbfe58..ad62056059ac 100644
--- a/arch/alpha/include/asm/pgalloc.h
+++ b/arch/alpha/include/asm/pgalloc.h
@@ -14,9 +14,9 @@
  */
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
+pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct ptdesc *pte)
 {
-	pmd_set(pmd, (pte_t *)(page_to_pa(pte) + PAGE_OFFSET));
+	pmd_set(pmd, (pte_t *)(page_to_pa(ptdesc_page(pte)) + PAGE_OFFSET));
 }
 
 static inline void
diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
index 096b8ef58edb..51233cfb1bad 100644
--- a/arch/arc/include/asm/pgalloc.h
+++ b/arch/arc/include/asm/pgalloc.h
@@ -46,9 +46,9 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte_page)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct ptdesc *pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte_page)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index e8501a6c3336..37a15220fce7 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -130,7 +130,7 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 }
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
+pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct ptdesc *ptep)
 {
 	extern pmdval_t user_pmd_table;
 	pmdval_t prot;
@@ -140,7 +140,7 @@ pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
 	else
 		prot = _PAGE_USER_TABLE;
 
-	__pmd_populate(pmdp, page_to_phys(ptep), prot);
+	__pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), prot);
 }
 
 #endif /* CONFIG_MMU */
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 8ff5f2a2579e..d9074b5f9dfe 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -131,10 +131,10 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep)
 }
 
 static inline void
-pmd_populate(struct mm_struct *mm, pmd_t *pmdp, pgtable_t ptep)
+pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct ptdesc *ptep)
 {
 	VM_BUG_ON(mm == &init_mm);
-	__pmd_populate(pmdp, page_to_phys(ptep), PMD_TYPE_TABLE | PMD_TABLE_PXN);
+	__pmd_populate(pmdp, page_to_phys(ptdesc_page(ptep)), PMD_TYPE_TABLE | PMD_TABLE_PXN);
 }
 
 #endif
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index a3e082e54b74..f34e9fcad066 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -42,13 +42,13 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte)
+				struct ptdesc *pte)
 {
 	/*
 	 * Conveniently, zero in 3 LSB means indirect 4K page table.
 	 * Not so convenient when you're trying to vary the page size.
 	 */
-	set_pmd(pmd, __pmd(((unsigned long)page_to_pfn(pte) << PAGE_SHIFT) |
+	set_pmd(pmd, __pmd(((unsigned long)ptdesc_pfn(pte) << PAGE_SHIFT) |
 		HEXAGON_L1_PTE_SIZE));
 }
 
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index c96d7160babc..3461da516ab9 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -18,9 +18,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm,
 	set_pmd(pmd, __pmd((unsigned long)pte));
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t pte)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct ptdesc *pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/m68k/include/asm/motorola_pgalloc.h b/arch/m68k/include/asm/motorola_pgalloc.h
index f9ee5ec4574d..a80c45b9d2a3 100644
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -84,9 +84,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *
 	pmd_set(pmd, pte);
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct ptdesc *page)
 {
-	pmd_set(pmd, page);
+	pmd_set(pmd, ptdesc_page(page));
 }
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 4a137eecb6fe..965f663a4797 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -28,9 +28,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *
 	pmd_val(*pmd) = __pa((unsigned long)pte);
 }
 
-static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page)
+static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, struct ptdesc *ptdesc)
 {
-	pmd_val(*pmd) = __pa((unsigned long)page_address(page));
+	pmd_val(*pmd) = __pa((unsigned long)ptdesc_address(ptdesc));
 }
 
 /*
diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/include/asm/pgalloc.h
index 6c33b05f730f..0f4a479e015e 100644
--- a/arch/microblaze/include/asm/pgalloc.h
+++ b/arch/microblaze/include/asm/pgalloc.h
@@ -33,7 +33,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, (pte))
 
 #define pmd_populate(mm, pmd, pte) \
-			(pmd_val(*(pmd)) = (unsigned long)page_address(pte))
+			(pmd_val(*(pmd)) = (unsigned long)page_address(ptdesc_page(pte)))
 
 #define pmd_populate_kernel(mm, pmd, pte) \
 		(pmd_val(*(pmd)) = (unsigned long) (pte))
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f4440edcd8fe..2ef868d93b6b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -25,9 +25,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-	pgtable_t pte)
+				struct ptdesc *pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 /*
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index ce6bb8e74271..420958d91a47 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -21,9 +21,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-	pgtable_t pte)
+				struct ptdesc *pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 2251d940c3d8..a9479d873dca 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -29,10 +29,10 @@ extern int mem_init_done;
 	set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)))
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				struct page *pte)
+				struct ptdesc *pte)
 {
 	set_pmd(pmd, __pmd(_KERNPG_TABLE +
-		     ((unsigned long)page_to_pfn(pte) <<
+		     ((unsigned long)ptdesc_pfn(pte) <<
 		     (unsigned long) PAGE_SHIFT)));
 }
 
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index e3e142b1c5c5..9fd06e2fef89 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -68,6 +68,6 @@ pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 }
 
 #define pmd_populate(mm, pmd, pte_page) \
-	pmd_populate_kernel(mm, pmd, page_address(pte_page))
+	pmd_populate_kernel(mm, pmd, page_address(ptdesc_page(pte_page)))
 
 #endif
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index a435c84d1f9a..9971703d0566 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -32,7 +32,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
-				pgtable_t pte_page)
+				struct ptdesc *pte_page)
 {
 	*pmdp = __pmd(__pa(pte_page) | _PMD_PRESENT);
 }
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 5d8577ab1591..095521089c20 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -27,9 +27,9 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				pgtable_t pte)
+				struct ptdesc *pte)
 {
-	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
+	set_pmd(pmd, __pmd((unsigned long)ptdesc_address(pte)));
 }
 
 #define __pte_free_tlb(tlb, pte, addr)				\
diff --git a/arch/sparc/include/asm/pgalloc_32.h b/arch/sparc/include/asm/pgalloc_32.h
index addaade56f21..6f0f661a380f 100644
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -50,7 +50,7 @@ static inline void free_pmd_fast(pmd_t * pmd)
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
 
-#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
+#define pmd_populate(mm, pmd, pte)	pmd_set(pmd, (pte_t *)pte)
 
 void pmd_set(pmd_t *pmdp, pte_t *ptep);
 #define pmd_populate_kernel		pmd_populate
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index 06a9a5867a86..5ca8ac568768 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -76,9 +76,9 @@ static inline void pmd_populate_kernel_safe(struct mm_struct *mm,
 }
 
 static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
-				struct page *pte)
+				struct ptdesc *pte)
 {
-	unsigned long pfn = page_to_pfn(pte);
+	unsigned long pfn = page_to_pfn(ptdesc_page(pte));
 
 	paravirt_alloc_pte(mm, pfn);
 	set_pmd(pmd, __pmd(((pteval_t)pfn << PAGE_SHIFT) | _PAGE_TABLE));
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 8550eec32aba..bf9dc9c0a9bf 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -645,7 +645,7 @@ static void __init pmd_populate_tests(struct pgtable_debug_args *args)
 	 * This entry points to next level page table page.
 	 * Hence this must not qualify as pmd_bad().
 	 */
-	pmd_populate(args->mm, args->pmdp, args->start_ptep);
+	pmd_populate(args->mm, args->pmdp, page_ptdesc(args->start_ptep));
 	pmd = READ_ONCE(*args->pmdp);
 	WARN_ON(pmd_bad(pmd));
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index aac67e8a8cc8..665445706491 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2365,7 +2365,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 
 	ptdesc = pgtable_trans_huge_withdraw(mm, pmd);
-	pmd_populate(mm, &_pmd, ptdesc_page(ptdesc));
+	pmd_populate(mm, &_pmd, ptdesc);
 
 	pte = pte_offset_map(&_pmd, haddr);
 	VM_BUG_ON(!pte);
@@ -2382,7 +2382,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	}
 	pte_unmap(pte - 1);
 	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(mm, pmd, ptdesc_page(ptdesc));
+	pmd_populate(mm, pmd, ptdesc);
 }
 
 static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
@@ -2537,7 +2537,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * This's critical for some architectures (Power).
 	 */
 	ptdesc = pgtable_trans_huge_withdraw(mm, pmd);
-	pmd_populate(mm, &_pmd, ptdesc_page(ptdesc));
+	pmd_populate(mm, &_pmd, ptdesc);
 
 	pte = pte_offset_map(&_pmd, haddr);
 	VM_BUG_ON(!pte);
@@ -2602,7 +2602,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		put_page(page);
 
 	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(mm, pmd, ptdesc_page(ptdesc));
+	pmd_populate(mm, pmd, ptdesc);
 }
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 48a54269472e..5b466a1c2136 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -769,7 +769,7 @@ static void __collapse_huge_page_copy_failed(pte_t *pte,
 	 * acquiring anon_vma_lock_write is unnecessary.
 	 */
 	pmd_ptl = pmd_lock(vma->vm_mm, pmd);
-	pmd_populate(vma->vm_mm, pmd, pmd_pgtable(orig_pmd));
+	pmd_populate(vma->vm_mm, pmd, (struct ptdesc *)pmd_pgtable(orig_pmd));
 	spin_unlock(pmd_ptl);
 	/*
 	 * Release both raw and compound pages isolated
@@ -1198,7 +1198,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 		 * hugepmds and never for establishing regular pmds that
 		 * points to regular pagetables. Use pmd_populate for that
 		 */
-		pmd_populate(mm, pmd, pmd_pgtable(_pmd));
+		pmd_populate(mm, pmd, (struct ptdesc *)pmd_pgtable(_pmd));
 		spin_unlock(pmd_ptl);
 		anon_vma_unlock_write(vma->anon_vma);
 		goto out_up_write;
diff --git a/mm/memory.c b/mm/memory.c
index 956cfe5f644d..cbed8824059f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -438,7 +438,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 * smp_rmb() barriers in page table walking code.
 		 */
 		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
-		pmd_populate(mm, pmd, *pte);
+		pmd_populate(mm, pmd, (struct ptdesc *)(*pte));
 		*pte = NULL;
 	}
 	spin_unlock(ptl);
diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc640..f32d35accd97 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -283,7 +283,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 
 	VM_BUG_ON(!pmd_none(*new_pmd));
 
-	pmd_populate(mm, new_pmd, pmd_pgtable(pmd));
+	pmd_populate(mm, new_pmd, (struct ptdesc *)pmd_pgtable(pmd));
 	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
-- 
2.43.0


