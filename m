Return-Path: <linux-arch+bounces-5712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D4940999
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 09:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A7A284B5F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 07:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD218FDA5;
	Tue, 30 Jul 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX1gqElX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12318EFF4;
	Tue, 30 Jul 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324175; cv=none; b=IQKj89tzOiRt/p4ZfsHLkp01GdU94fE3JeXyzr3Ows0As+C2B+pU1M65jiV9WmmxWTlkZ/D0F1b4yl8NfSvvTBHOQyvsrK1jFffPnd2JZA1tvSayXM2OqV4m7vohkN+ib+GLUk1c6q6cmxQ3pxjz2Wg9hGcsAiz3+6z2va5q0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324175; c=relaxed/simple;
	bh=0TbHGOJe6xjBQAxgBmZt5/6tHpzUCuFv7Fnp2SPF0/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+L48vj02aLjkJvp5oeKeGy2aSfbhIMv58J/Sy3yM8BJSUEpPz2q93gJShBWd6e8AxeELtQ1TFhKYTb2OCxALoHuysIvXgf+kllOzs76EpH+88CzcrVpkTSbZQ34Zu5t1jB0RcHrErqShKAO53jVWh1iG9wedZBvXLi5qPvpD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX1gqElX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02314C4AF18;
	Tue, 30 Jul 2024 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722324175;
	bh=0TbHGOJe6xjBQAxgBmZt5/6tHpzUCuFv7Fnp2SPF0/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VX1gqElX7WCCLiUWy2ntLa+Ucwphw4/QSxbhHNT0raPC4/UkeHmzo9W0nHE9Mpecx
	 GiufKIepmOHPcYPzSaWYuLKiSsVBbybFMQZ9B61DOBMKp6hANUQcKP3+nRBipeuwBf
	 ugpyKDaDVAkIMoeBe17I8tOhrD6R4mB8TeoZK7sFzVjOFfs948DRJNpd6K2obeDmkP
	 Jo8Bqwcsk9Y8AJMGzmYkRltiRneJQdQnfGXx+EqBl49hPEStt5gmDVcD28UqmIHves
	 ETiZ03dTkJdj+XtouaSH1+gTnn7AFo+OzJm5Opx0xYfz4rxDS0SAqH+YYi9e12gtZu
	 JdZQXBJ9yyREw==
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
	sparclinux@vger.kernel.org,
	Kinsey Ho <kinseyho@google.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [RFC PATCH 13/18] mm/pgtable: return ptdesc pointer in pgtable_trans_huge_withdraw
Date: Tue, 30 Jul 2024 15:27:14 +0800
Message-ID: <20240730072719.3715016-3-alexs@kernel.org>
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

Way to replace pgtable_t aka struct page in most of archs.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: sparclinux@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Barry Song <baohua@kernel.org>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Kinsey Ho <kinseyho@google.com>
Cc: Aneesh Kumar K.V  <aneesh.kumar@kernel.org>
Cc: Benjamin Gray <bgray@linux.ibm.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox  <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport  <rppt@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 +--
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  2 +-
 arch/powerpc/include/asm/book3s/64/radix.h    |  4 +--
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +--
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  4 +--
 arch/s390/include/asm/pgtable.h               |  2 +-
 arch/s390/mm/pgtable.c                        |  4 +--
 arch/sparc/include/asm/pgtable_64.h           |  2 +-
 arch/sparc/mm/tlb.c                           |  4 +--
 include/linux/pgtable.h                       |  2 +-
 mm/huge_memory.c                              | 35 ++++++++++---------
 mm/pgtable-generic.c                          |  4 +--
 13 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index c654c376ef8b..3a99a0229c37 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -133,8 +133,8 @@ extern unsigned long hash__pmd_hugepage_update(struct mm_struct *mm,
 extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
 				   unsigned long address, pmd_t *pmdp);
 extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-					 pgtable_t pgtable);
-extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+					 struct ptdesc *ptdesc);
+extern struct ptdesc *hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
 extern int hash__has_transparent_hugepage(void);
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 0bf6fd0bf42a..8f497e1617bd 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -274,8 +274,8 @@ extern unsigned long hash__pmd_hugepage_update(struct mm_struct *mm,
 extern pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma,
 				   unsigned long address, pmd_t *pmdp);
 extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-					 pgtable_t pgtable);
-extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+					     struct ptdesc *ptdesc);
+extern struct ptdesc *hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pmd_t *pmdp);
 extern int hash__has_transparent_hugepage(void);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 519b1743a0f4..0ee440b819d7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1373,7 +1373,7 @@ static inline void pgtable_trans_huge_deposit(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-static inline pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm,
+static inline struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm,
 						    pmd_t *pmdp)
 {
 	if (radix_enabled())
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 8f55ff74bb68..a8630b249f4c 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -291,8 +291,8 @@ extern unsigned long radix__pud_hugepage_update(struct mm_struct *mm, unsigned l
 extern pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma,
 				  unsigned long address, pmd_t *pmdp);
 extern void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
-					pgtable_t pgtable);
-extern pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+					struct ptdesc *ptdesc);
+extern struct ptdesc *radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 extern pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp);
 pud_t radix__pudp_huge_get_and_clear(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
index 988948d69bc1..35562d1f4267 100644
--- a/arch/powerpc/mm/book3s64/hash_pgtable.c
+++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
@@ -284,7 +284,7 @@ void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	smp_wmb();
 }
 
-pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+struct ptdesc *hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	pgtable_t pgtable;
 	pgtable_t *pgtable_slot;
@@ -302,7 +302,7 @@ pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	 * zero out the content on withdraw.
 	 */
 	memset(pgtable, 0, PTE_FRAG_SIZE);
-	return pgtable;
+	return (struct ptdesc *)pgtable;
 }
 
 /*
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index b0d927009af8..3b9bb19510e3 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1492,7 +1492,7 @@ void radix__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	pmd_huge_pte(mm, pmdp) = pgtable;
 }
 
-pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+struct ptdesc *radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	pte_t *ptep;
 	pgtable_t pgtable;
@@ -1513,7 +1513,7 @@ pgtable_t radix__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	*ptep = __pte(0);
 	ptep++;
 	*ptep = __pte(0);
-	return pgtable;
+	return (struct ptdesc *)pgtable;
 }
 
 pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3fa280d0672a..cf0baf4bfe5c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1738,7 +1738,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pgtable);
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 
 #define  __HAVE_ARCH_PMDP_SET_ACCESS_FLAGS
 static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 201d350abd1e..b9016ee145cb 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -577,7 +577,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
 }
 
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	struct list_head *lh;
 	pgtable_t pgtable;
@@ -598,7 +598,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	set_pte(ptep, __pte(_PAGE_INVALID));
 	ptep++;
 	set_pte(ptep, __pte(_PAGE_INVALID));
-	return pgtable;
+	return (struct ptdesc *)pgtable;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 3fe429d73a65..bfefd678e220 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -998,7 +998,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				pgtable_t pgtable);
 
 #define __HAVE_ARCH_PGTABLE_WITHDRAW
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
 /*
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 903825b4c997..bd2d3b1f6ba3 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -281,7 +281,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 	pmd_huge_pte(mm, pmdp) = (struct ptdesc *)pgtable;
 }
 
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	struct list_head *lh;
 	pgtable_t pgtable;
@@ -300,6 +300,6 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	pte_val(pgtable[0]) = 0;
 	pte_val(pgtable[1]) = 0;
 
-	return pgtable;
+	return (struct ptdesc *)pgtable;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..3fa7b93580a3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -929,7 +929,7 @@ extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 #endif
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
-extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
+extern struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
 #endif
 
 #ifndef arch_needs_pgtable_deposit
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1c121ec85447..4dc36910c8aa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1827,10 +1827,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 {
-	pgtable_t pgtable;
+	struct ptdesc *ptdesc;
 
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pte_free(mm, page_ptdesc(pgtable));
+	ptdesc = pgtable_trans_huge_withdraw(mm, pmd);
+	pte_free(mm, ptdesc);
 	mm_dec_nr_ptes(mm);
 }
 
@@ -1959,9 +1959,10 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		VM_BUG_ON(!pmd_none(*new_pmd));
 
 		if (pmd_move_must_withdraw(new_ptl, old_ptl, vma)) {
-			pgtable_t pgtable;
-			pgtable = pgtable_trans_huge_withdraw(mm, old_pmd);
-			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
+			struct ptdesc *ptdesc;
+
+			ptdesc = pgtable_trans_huge_withdraw(mm, old_pmd);
+			pgtable_trans_huge_deposit(mm, new_pmd, ptdesc_page(ptdesc));
 		}
 		pmd = move_soft_dirty_pmd(pmd);
 		set_pmd_at(mm, new_addr, new_pmd, pmd);
@@ -2130,7 +2131,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	struct folio *src_folio;
 	struct anon_vma *src_anon_vma;
 	spinlock_t *src_ptl, *dst_ptl;
-	pgtable_t src_pgtable;
+	struct ptdesc *src_ptdesc;
 	struct mmu_notifier_range range;
 	int err = 0;
 
@@ -2234,8 +2235,8 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	}
 	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
 
-	src_pgtable = pgtable_trans_huge_withdraw(mm, src_pmd);
-	pgtable_trans_huge_deposit(mm, dst_pmd, src_pgtable);
+	src_ptdesc = pgtable_trans_huge_withdraw(mm, src_pmd);
+	pgtable_trans_huge_deposit(mm, dst_pmd, ptdesc_page(src_ptdesc));
 unlock_ptls:
 	double_pt_unlock(src_ptl, dst_ptl);
 	if (src_anon_vma) {
@@ -2347,7 +2348,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 		unsigned long haddr, pmd_t *pmd)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgtable_t pgtable;
+	struct ptdesc *ptdesc;
 	pmd_t _pmd, old_pmd;
 	unsigned long addr;
 	pte_t *pte;
@@ -2363,8 +2364,8 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	 */
 	old_pmd = pmdp_huge_clear_flush(vma, haddr, pmd);
 
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pmd_populate(mm, &_pmd, pgtable);
+	ptdesc = pgtable_trans_huge_withdraw(mm, pmd);
+	pmd_populate(mm, &_pmd, ptdesc_page(ptdesc));
 
 	pte = pte_offset_map(&_pmd, haddr);
 	VM_BUG_ON(!pte);
@@ -2381,7 +2382,7 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
 	}
 	pte_unmap(pte - 1);
 	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(mm, pmd, pgtable);
+	pmd_populate(mm, pmd, ptdesc_page(ptdesc));
 }
 
 static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
@@ -2390,7 +2391,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	struct mm_struct *mm = vma->vm_mm;
 	struct folio *folio;
 	struct page *page;
-	pgtable_t pgtable;
+	struct ptdesc *ptdesc;
 	pmd_t old_pmd, _pmd;
 	bool young, write, soft_dirty, pmd_migration = false, uffd_wp = false;
 	bool anon_exclusive = false, dirty = false;
@@ -2535,8 +2536,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 	 * Withdraw the table only after we mark the pmd entry invalid.
 	 * This's critical for some architectures (Power).
 	 */
-	pgtable = pgtable_trans_huge_withdraw(mm, pmd);
-	pmd_populate(mm, &_pmd, pgtable);
+	ptdesc = pgtable_trans_huge_withdraw(mm, pmd);
+	pmd_populate(mm, &_pmd, ptdesc_page(ptdesc));
 
 	pte = pte_offset_map(&_pmd, haddr);
 	VM_BUG_ON(!pte);
@@ -2601,7 +2602,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		put_page(page);
 
 	smp_wmb(); /* make pte visible before pmd */
-	pmd_populate(mm, pmd, pgtable);
+	pmd_populate(mm, pmd, ptdesc_page(ptdesc));
 }
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 92245a32656b..de1ed30fea16 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -178,7 +178,7 @@ void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 
 #ifndef __HAVE_ARCH_PGTABLE_WITHDRAW
 /* no "address" argument so destroys page coloring of some arch */
-pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
+struct ptdesc *pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 {
 	struct ptdesc *ptdesc;
 
@@ -190,7 +190,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 							  struct ptdesc, pt_list);
 	if (pmd_huge_pte(mm, pmdp))
 		list_del(&ptdesc->pt_list);
-	return ptdesc_page(ptdesc);
+	return ptdesc;
 }
 #endif
 
-- 
2.43.0


