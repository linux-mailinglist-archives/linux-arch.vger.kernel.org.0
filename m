Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633FC260422
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgIGSFL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 14:05:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728548AbgIGSEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 14:04:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087I0fCx063966;
        Mon, 7 Sep 2020 14:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=dXTde4ctrMDDsfUNDyt82xQ0xToEPos6JO+v3c9xlBw=;
 b=cxpBVla3bCQO/WCudhD1ERm4sSMxtGVeSPjLglPOV0D9GivfdgIWPJPvxq7DTUZXw6gR
 mJzEDiud+w1W1uGiFKIVgqN6FUSNndqecpTpx+FSaVomau7L/9aMBNm7253ZMtW9P7dU
 erFEaRWicVcQanUthor7kzGmdjpUSuVqexpuat+O49kV42NNcpvN9kgJFAwlc/2Vp7V1
 Sah7b7d49pExfEYW6VO2+HJygqK//RR4tW1oDcrv3VbiHMc1kjuiZ+Q3Co8moTlskS9/
 vZtOaS9iawh8BN4rAcA7bAoHqtouXBrPb+nYbI8rQlM8NWGgrRJHUgpIXVZ/bg4u+/Uy rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ds6h8qbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:15 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087I0gf3064127;
        Mon, 7 Sep 2020 14:03:14 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33ds6h8qaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:14 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087I1xqm002352;
        Mon, 7 Sep 2020 18:03:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 33c1xh9m60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:03:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087I39GL38076798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 18:03:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D777042042;
        Mon,  7 Sep 2020 18:03:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D2942049;
        Mon,  7 Sep 2020 18:03:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 18:03:07 +0000 (GMT)
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table entry aware
Date:   Mon,  7 Sep 2020 20:00:57 +0200
Message-Id: <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=2 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070168
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

Unlike all other page-table abstractions pXd_addr_end() do not take
into account a particular table entry in which context the functions
are called. On architectures with dynamic page-tables folding that
might lead to lack of necessary information that is difficult to
obtain other than from the table entry itself. That already led to
a subtle memory corruption issue on s390.

By letting pXd_addr_end() functions know about the page-table entry
we allow archs not only make extra checks, but also optimizations.

As result of this change the pXd_addr_end_folded() functions used
in gup_fast traversal code become unnecessary and get replaced with
universal pXd_addr_end() variants.

The arch-specific updates not only add dereferencing of page-table
entry pointers, but also small changes to the code flow to make those
dereferences possible, at least for x86 and powerpc. Also for arm64,
but in way that should not have any impact.

So, even though the dereferenced page-table entries are not used on
archs other than s390, and are optimized out by the compiler, there
is a small change in kernel size and this is what bloat-o-meter reports:

x86:
add/remove: 0/0 grow/shrink: 2/0 up/down: 10/0 (10)
Function                                     old     new   delta
vmemmap_populate                             587     592      +5
munlock_vma_pages_range                      556     561      +5
Total: Before=15534694, After=15534704, chg +0.00%

powerpc:
add/remove: 0/0 grow/shrink: 1/0 up/down: 4/0 (4)
Function                                     old     new   delta
.remove_pagetable                           1648    1652      +4
Total: Before=21478240, After=21478244, chg +0.00%

arm64:
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=20240851, After=20240851, chg +0.00%

sparc:
add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
Function                                     old     new   delta
Total: Before=4907262, After=4907262, chg +0.00%

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/arm/include/asm/pgtable-2level.h    |  2 +-
 arch/arm/mm/idmap.c                      |  6 ++--
 arch/arm/mm/mmu.c                        |  8 ++---
 arch/arm64/kernel/hibernate.c            | 16 ++++++----
 arch/arm64/kvm/mmu.c                     | 16 +++++-----
 arch/arm64/mm/kasan_init.c               |  8 ++---
 arch/arm64/mm/mmu.c                      | 25 +++++++--------
 arch/powerpc/mm/book3s64/radix_pgtable.c |  7 ++---
 arch/powerpc/mm/hugetlbpage.c            |  6 ++--
 arch/s390/include/asm/pgtable.h          |  8 ++---
 arch/s390/mm/page-states.c               |  8 ++---
 arch/s390/mm/pageattr.c                  |  8 ++---
 arch/s390/mm/vmem.c                      |  8 ++---
 arch/sparc/mm/hugetlbpage.c              |  6 ++--
 arch/um/kernel/tlb.c                     |  8 ++---
 arch/x86/mm/init_64.c                    | 15 ++++-----
 arch/x86/mm/kasan_init_64.c              | 16 +++++-----
 include/asm-generic/pgtable-nop4d.h      |  2 +-
 include/asm-generic/pgtable-nopmd.h      |  2 +-
 include/asm-generic/pgtable-nopud.h      |  2 +-
 include/linux/pgtable.h                  | 26 ++++-----------
 mm/gup.c                                 |  8 ++---
 mm/ioremap.c                             |  8 ++---
 mm/kasan/init.c                          | 17 +++++-----
 mm/madvise.c                             |  4 +--
 mm/memory.c                              | 40 ++++++++++++------------
 mm/mlock.c                               | 18 ++++++++---
 mm/mprotect.c                            |  8 ++---
 mm/pagewalk.c                            |  8 ++---
 mm/swapfile.c                            |  8 ++---
 mm/vmalloc.c                             | 16 +++++-----
 31 files changed, 165 insertions(+), 173 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 3502c2f746ca..5e6416b339f4 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -209,7 +209,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 	} while (0)
 
 /* we don't need complex calculations here as the pmd is folded into the pgd */
-#define pmd_addr_end(addr,end) (end)
+#define pmd_addr_end(pmd,addr,end) (end)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 448e57c6f653..5437f943ca8b 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -46,7 +46,7 @@ static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 		pmd = pmd_offset(pud, addr);
 
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		*pmd = __pmd((addr & PMD_MASK) | prot);
 		flush_pmd_entry(pmd);
 	} while (pmd++, addr = next, addr != end);
@@ -73,7 +73,7 @@ static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
 	unsigned long next;
 
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		idmap_add_pmd(pud, addr, next, prot);
 	} while (pud++, addr = next, addr != end);
 }
@@ -95,7 +95,7 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 
 	pgd += pgd_index(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		idmap_add_pud(pgd, addr, next, prot);
 	} while (pgd++, addr = next, addr != end);
 }
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 698cc740c6b8..4013746e4c75 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -777,7 +777,7 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
 		 * With LPAE, we must loop over to map
 		 * all the pmds for the given range.
 		 */
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		/*
 		 * Try a section mapping - addr, next and phys must all be
@@ -805,7 +805,7 @@ static void __init alloc_init_pud(p4d_t *p4d, unsigned long addr,
 	unsigned long next;
 
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		alloc_init_pmd(pud, addr, next, phys, type, alloc, ng);
 		phys += next - addr;
 	} while (pud++, addr = next, addr != end);
@@ -820,7 +820,7 @@ static void __init alloc_init_p4d(pgd_t *pgd, unsigned long addr,
 	unsigned long next;
 
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		alloc_init_pud(p4d, addr, next, phys, type, alloc, ng);
 		phys += next - addr;
 	} while (p4d++, addr = next, addr != end);
@@ -923,7 +923,7 @@ static void __init __create_mapping(struct mm_struct *mm, struct map_desc *md,
 	pgd = pgd_offset(mm, addr);
 	end = addr + length;
 	do {
-		unsigned long next = pgd_addr_end(addr, end);
+		unsigned long next = pgd_addr_end(*pgd, addr, end);
 
 		alloc_init_p4d(pgd, addr, next, phys, type, alloc, ng);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 68e14152d6e9..7be8c9cdc5c8 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -412,7 +412,7 @@ static int copy_pmd(pud_t *dst_pudp, pud_t *src_pudp, unsigned long start,
 	do {
 		pmd_t pmd = READ_ONCE(*src_pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(pmd, addr, end);
 		if (pmd_none(pmd))
 			continue;
 		if (pmd_table(pmd)) {
@@ -447,7 +447,7 @@ static int copy_pud(p4d_t *dst_p4dp, p4d_t *src_p4dp, unsigned long start,
 	do {
 		pud_t pud = READ_ONCE(*src_pudp);
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(pud, addr, end);
 		if (pud_none(pud))
 			continue;
 		if (pud_table(pud)) {
@@ -473,8 +473,10 @@ static int copy_p4d(pgd_t *dst_pgdp, pgd_t *src_pgdp, unsigned long start,
 	dst_p4dp = p4d_offset(dst_pgdp, start);
 	src_p4dp = p4d_offset(src_pgdp, start);
 	do {
-		next = p4d_addr_end(addr, end);
-		if (p4d_none(READ_ONCE(*src_p4dp)))
+		p4d_t p4d = READ_ONCE(*src_p4dp);
+
+		next = p4d_addr_end(p4d, addr, end);
+		if (p4d_none(p4d))
 			continue;
 		if (copy_pud(dst_p4dp, src_p4dp, addr, next))
 			return -ENOMEM;
@@ -492,8 +494,10 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 
 	dst_pgdp = pgd_offset_pgd(dst_pgdp, start);
 	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none(READ_ONCE(*src_pgdp)))
+		pgd_t pgd = READ_ONCE(*src_pgdp);
+
+		next = pgd_addr_end(pgd, addr, end);
+		if (pgd_none(pgd))
 			continue;
 		if (copy_p4d(dst_pgdp, src_pgdp, addr, next))
 			return -ENOMEM;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index ba00bcc0c884..8f470f93a8e9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -547,7 +547,7 @@ static void unmap_hyp_pmds(pud_t *pud, phys_addr_t addr, phys_addr_t end)
 
 	start_pmd = pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		/* Hyp doesn't use huge pmds */
 		if (!pmd_none(*pmd))
 			unmap_hyp_ptes(pmd, addr, next);
@@ -564,7 +564,7 @@ static void unmap_hyp_puds(p4d_t *p4d, phys_addr_t addr, phys_addr_t end)
 
 	start_pud = pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		/* Hyp doesn't use huge puds */
 		if (!pud_none(*pud))
 			unmap_hyp_pmds(pud, addr, next);
@@ -581,7 +581,7 @@ static void unmap_hyp_p4ds(pgd_t *pgd, phys_addr_t addr, phys_addr_t end)
 
 	start_p4d = p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		/* Hyp doesn't use huge p4ds */
 		if (!p4d_none(*p4d))
 			unmap_hyp_puds(p4d, addr, next);
@@ -609,7 +609,7 @@ static void __unmap_hyp_range(pgd_t *pgdp, unsigned long ptrs_per_pgd,
 	 */
 	pgd = pgdp + kvm_pgd_index(addr, ptrs_per_pgd);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!pgd_none(*pgd))
 			unmap_hyp_p4ds(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
@@ -712,7 +712,7 @@ static int create_hyp_pmd_mappings(pud_t *pud, unsigned long start,
 			get_page(virt_to_page(pmd));
 		}
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		create_hyp_pte_mappings(pmd, addr, next, pfn, prot);
 		pfn += (next - addr) >> PAGE_SHIFT;
@@ -744,7 +744,7 @@ static int create_hyp_pud_mappings(p4d_t *p4d, unsigned long start,
 			get_page(virt_to_page(pud));
 		}
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		ret = create_hyp_pmd_mappings(pud, addr, next, pfn, prot);
 		if (ret)
 			return ret;
@@ -777,7 +777,7 @@ static int create_hyp_p4d_mappings(pgd_t *pgd, unsigned long start,
 			get_page(virt_to_page(p4d));
 		}
 
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		ret = create_hyp_pud_mappings(p4d, addr, next, pfn, prot);
 		if (ret)
 			return ret;
@@ -813,7 +813,7 @@ static int __create_hyp_mappings(pgd_t *pgdp, unsigned long ptrs_per_pgd,
 			get_page(virt_to_page(pgd));
 		}
 
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		err = create_hyp_p4d_mappings(pgd, addr, next, pfn, prot);
 		if (err)
 			goto out;
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index b24e43d20667..8d1c811fd59e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -120,7 +120,7 @@ static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
 	pmd_t *pmdp = kasan_pmd_offset(pudp, addr, node, early);
 
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmdp, addr, end);
 		kasan_pte_populate(pmdp, addr, next, node, early);
 	} while (pmdp++, addr = next, addr != end && pmd_none(READ_ONCE(*pmdp)));
 }
@@ -132,7 +132,7 @@ static void __init kasan_pud_populate(p4d_t *p4dp, unsigned long addr,
 	pud_t *pudp = kasan_pud_offset(p4dp, addr, node, early);
 
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pudp, addr, end);
 		kasan_pmd_populate(pudp, addr, next, node, early);
 	} while (pudp++, addr = next, addr != end && pud_none(READ_ONCE(*pudp)));
 }
@@ -144,7 +144,7 @@ static void __init kasan_p4d_populate(pgd_t *pgdp, unsigned long addr,
 	p4d_t *p4dp = p4d_offset(pgdp, addr);
 
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4dp, addr, end);
 		kasan_pud_populate(p4dp, addr, next, node, early);
 	} while (p4dp++, addr = next, addr != end);
 }
@@ -157,7 +157,7 @@ static void __init kasan_pgd_populate(unsigned long addr, unsigned long end,
 
 	pgdp = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgdp, addr, end);
 		kasan_p4d_populate(pgdp, addr, next, node, early);
 	} while (pgdp++, addr = next, addr != end);
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 64211436629d..d679cf024bc8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -209,7 +209,7 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
 	do {
 		pmd_t old_pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(old_pmd, addr, end);
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
@@ -307,7 +307,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(old_pud, addr, end);
 
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
@@ -356,7 +356,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	end = PAGE_ALIGN(virt + size);
 
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgdp, addr, end);
 		alloc_init_pud(pgdp, addr, next, phys, prot, pgtable_alloc,
 			       flags);
 		phys += next - addr;
@@ -820,9 +820,9 @@ static void unmap_hotplug_pmd_range(pud_t *pudp, unsigned long addr,
 	pmd_t *pmdp, pmd;
 
 	do {
-		next = pmd_addr_end(addr, end);
 		pmdp = pmd_offset(pudp, addr);
 		pmd = READ_ONCE(*pmdp);
+		next = pmd_addr_end(pmd, addr, end);
 		if (pmd_none(pmd))
 			continue;
 
@@ -853,9 +853,9 @@ static void unmap_hotplug_pud_range(p4d_t *p4dp, unsigned long addr,
 	pud_t *pudp, pud;
 
 	do {
-		next = pud_addr_end(addr, end);
 		pudp = pud_offset(p4dp, addr);
 		pud = READ_ONCE(*pudp);
+		next = pud_addr_end(pud, addr, end);
 		if (pud_none(pud))
 			continue;
 
@@ -886,9 +886,9 @@ static void unmap_hotplug_p4d_range(pgd_t *pgdp, unsigned long addr,
 	p4d_t *p4dp, p4d;
 
 	do {
-		next = p4d_addr_end(addr, end);
 		p4dp = p4d_offset(pgdp, addr);
 		p4d = READ_ONCE(*p4dp);
+		next = p4d_addr_end(p4d, addr, end);
 		if (p4d_none(p4d))
 			continue;
 
@@ -912,9 +912,9 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 	WARN_ON(!free_mapped && altmap);
 
 	do {
-		next = pgd_addr_end(addr, end);
 		pgdp = pgd_offset_k(addr);
 		pgd = READ_ONCE(*pgdp);
+		next = pgd_addr_end(pgd, addr, end);
 		if (pgd_none(pgd))
 			continue;
 
@@ -968,9 +968,9 @@ static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
 	unsigned long i, next, start = addr;
 
 	do {
-		next = pmd_addr_end(addr, end);
 		pmdp = pmd_offset(pudp, addr);
 		pmd = READ_ONCE(*pmdp);
+		next = pmd_addr_end(pmd, addr, end);
 		if (pmd_none(pmd))
 			continue;
 
@@ -1008,9 +1008,9 @@ static void free_empty_pud_table(p4d_t *p4dp, unsigned long addr,
 	unsigned long i, next, start = addr;
 
 	do {
-		next = pud_addr_end(addr, end);
 		pudp = pud_offset(p4dp, addr);
 		pud = READ_ONCE(*pudp);
+		next = pud_addr_end(pud, addr, end);
 		if (pud_none(pud))
 			continue;
 
@@ -1048,9 +1048,9 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
 	p4d_t *p4dp, p4d;
 
 	do {
-		next = p4d_addr_end(addr, end);
 		p4dp = p4d_offset(pgdp, addr);
 		p4d = READ_ONCE(*p4dp);
+		next = p4d_addr_end(p4d, addr, end);
 		if (p4d_none(p4d))
 			continue;
 
@@ -1066,9 +1066,9 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 	pgd_t *pgdp, pgd;
 
 	do {
-		next = pgd_addr_end(addr, end);
 		pgdp = pgd_offset_k(addr);
 		pgd = READ_ONCE(*pgdp);
+		next = pgd_addr_end(pgd, addr, end);
 		if (pgd_none(pgd))
 			continue;
 
@@ -1097,8 +1097,6 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pmd_t *pmdp;
 
 	do {
-		next = pmd_addr_end(addr, end);
-
 		pgdp = vmemmap_pgd_populate(addr, node);
 		if (!pgdp)
 			return -ENOMEM;
@@ -1112,6 +1110,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 			return -ENOMEM;
 
 		pmdp = pmd_offset(pudp, addr);
+		next = pmd_addr_end(*pmdp, addr, end);
 		if (pmd_none(READ_ONCE(*pmdp))) {
 			void *p = NULL;
 
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index cc72666e891a..816e218df285 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -817,7 +817,7 @@ static void __meminit remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		if (!pmd_present(*pmd))
 			continue;
@@ -847,7 +847,7 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 
 	pud = pud_start + pud_index(addr);
 	for (; addr < end; addr = next, pud++) {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 
 		if (!pud_present(*pud))
 			continue;
@@ -878,10 +878,9 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 	spin_lock(&init_mm.page_table_lock);
 
 	for (addr = start; addr < end; addr = next) {
-		next = pgd_addr_end(addr, end);
-
 		pgd = pgd_offset_k(addr);
 		p4d = p4d_offset(pgd, addr);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!p4d_present(*p4d))
 			continue;
 
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 26292544630f..f0606d6774a4 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -352,7 +352,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 		unsigned long more;
 
 		pmd = pmd_offset(pud, addr);
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (!is_hugepd(__hugepd(pmd_val(*pmd)))) {
 			if (pmd_none_or_clear_bad(pmd))
 				continue;
@@ -409,7 +409,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 	start = addr;
 	do {
 		pud = pud_offset(p4d, addr);
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (!is_hugepd(__hugepd(pud_val(*pud)))) {
 			if (pud_none_or_clear_bad(pud))
 				continue;
@@ -478,9 +478,9 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	 */
 
 	do {
-		next = pgd_addr_end(addr, end);
 		pgd = pgd_offset(tlb->mm, addr);
 		p4d = p4d_offset(pgd, addr);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!is_hugepd(__hugepd(pgd_val(*pgd)))) {
 			if (p4d_none_or_clear_bad(p4d))
 				continue;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 027206e4959d..6fb17ac413be 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -542,14 +542,14 @@ static inline unsigned long rste_addr_end_folded(unsigned long rste, unsigned lo
 	return (boundary - 1) < (end - 1) ? boundary : end;
 }
 
-#define pgd_addr_end_folded pgd_addr_end_folded
-static inline unsigned long pgd_addr_end_folded(pgd_t pgd, unsigned long addr, unsigned long end)
+#define pgd_addr_end pgd_addr_end
+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
 {
 	return rste_addr_end_folded(pgd_val(pgd), addr, end);
 }
 
-#define p4d_addr_end_folded p4d_addr_end_folded
-static inline unsigned long p4d_addr_end_folded(p4d_t p4d, unsigned long addr, unsigned long end)
+#define p4d_addr_end p4d_addr_end
+static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
 {
 	return rste_addr_end_folded(p4d_val(p4d), addr, end);
 }
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 567c69f3069e..4aba634b4b26 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -109,7 +109,7 @@ static void mark_kernel_pmd(pud_t *pud, unsigned long addr, unsigned long end)
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none(*pmd) || pmd_large(*pmd))
 			continue;
 		page = virt_to_page(pmd_val(*pmd));
@@ -126,7 +126,7 @@ static void mark_kernel_pud(p4d_t *p4d, unsigned long addr, unsigned long end)
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none(*pud) || pud_large(*pud))
 			continue;
 		if (!pud_folded(*pud)) {
@@ -147,7 +147,7 @@ static void mark_kernel_p4d(pgd_t *pgd, unsigned long addr, unsigned long end)
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none(*p4d))
 			continue;
 		if (!p4d_folded(*p4d)) {
@@ -169,7 +169,7 @@ static void mark_kernel_pgd(void)
 	addr = 0;
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, MODULES_END);
+		next = pgd_addr_end(*pgd, addr, MODULES_END);
 		if (pgd_none(*pgd))
 			continue;
 		if (!pgd_folded(*pgd)) {
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index c5c52ec2b46f..b827d758a17a 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -162,7 +162,7 @@ static int walk_pmd_level(pud_t *pudp, unsigned long addr, unsigned long end,
 	do {
 		if (pmd_none(*pmdp))
 			return -EINVAL;
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmdp, addr, end);
 		if (pmd_large(*pmdp)) {
 			if (addr & ~PMD_MASK || addr + PMD_SIZE > next) {
 				rc = split_pmd_page(pmdp, addr);
@@ -239,7 +239,7 @@ static int walk_pud_level(p4d_t *p4d, unsigned long addr, unsigned long end,
 	do {
 		if (pud_none(*pudp))
 			return -EINVAL;
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pudp, addr, end);
 		if (pud_large(*pudp)) {
 			if (addr & ~PUD_MASK || addr + PUD_SIZE > next) {
 				rc = split_pud_page(pudp, addr);
@@ -269,7 +269,7 @@ static int walk_p4d_level(pgd_t *pgd, unsigned long addr, unsigned long end,
 	do {
 		if (p4d_none(*p4dp))
 			return -EINVAL;
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4dp, addr, end);
 		rc = walk_pud_level(p4dp, addr, next, flags);
 		p4dp++;
 		addr = next;
@@ -296,7 +296,7 @@ static int change_page_attr(unsigned long addr, unsigned long end,
 	do {
 		if (pgd_none(*pgdp))
 			break;
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgdp, addr, end);
 		rc = walk_p4d_level(pgdp, addr, next, flags);
 		if (rc)
 			break;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..672bc89f13e7 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -219,7 +219,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	for (; addr < end; addr = next, pmd++) {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (!add) {
 			if (pmd_none(*pmd))
 				continue;
@@ -320,7 +320,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		prot &= ~_REGION_ENTRY_NOEXEC;
 	pud = pud_offset(p4d, addr);
 	for (; addr < end; addr = next, pud++) {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (!add) {
 			if (pud_none(*pud))
 				continue;
@@ -394,7 +394,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 	p4d = p4d_offset(pgd, addr);
 	for (; addr < end; addr = next, p4d++) {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (!add) {
 			if (p4d_none(*p4d))
 				continue;
@@ -449,8 +449,8 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(start | end)))
 		return -EINVAL;
 	for (addr = start; addr < end; addr = next) {
-		next = pgd_addr_end(addr, end);
 		pgd = pgd_offset_k(addr);
+		next = pgd_addr_end(*pgd, addr, end);
 
 		if (!add) {
 			if (pgd_none(*pgd))
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ec423b5f17dd..341c2ff8d31a 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -428,7 +428,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	start = addr;
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none(*pmd))
 			continue;
 		if (is_hugetlb_pmd(*pmd))
@@ -465,7 +465,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 	start = addr;
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		if (is_hugetlb_pud(*pud))
@@ -519,7 +519,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	pgd = pgd_offset(tlb->mm, addr);
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		hugetlb_free_pud_range(tlb, p4d, addr, next, floor, ceiling);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 61776790cd67..7b4fe31c8df2 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -264,7 +264,7 @@ static inline int update_pmd_range(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (!pmd_present(*pmd)) {
 			if (hvc->force || pmd_newpage(*pmd)) {
 				ret = add_munmap(addr, next - addr, hvc);
@@ -286,7 +286,7 @@ static inline int update_pud_range(p4d_t *p4d, unsigned long addr,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (!pud_present(*pud)) {
 			if (hvc->force || pud_newpage(*pud)) {
 				ret = add_munmap(addr, next - addr, hvc);
@@ -308,7 +308,7 @@ static inline int update_p4d_range(pgd_t *pgd, unsigned long addr,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (!p4d_present(*p4d)) {
 			if (hvc->force || p4d_newpage(*p4d)) {
 				ret = add_munmap(addr, next - addr, hvc);
@@ -331,7 +331,7 @@ void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	hvc = INIT_HVC(mm, force, userspace);
 	pgd = pgd_offset(mm, addr);
 	do {
-		next = pgd_addr_end(addr, end_addr);
+		next = pgd_addr_end(*pgd, addr, end_addr);
 		if (!pgd_present(*pgd)) {
 			if (force || pgd_newpage(*pgd)) {
 				ret = add_munmap(addr, next - addr, &hvc);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a4ac13cc3fdc..e2cb9316a104 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1043,7 +1043,7 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
 
 	pmd = pmd_start + pmd_index(addr);
 	for (; addr < end; addr = next, pmd++) {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		if (!pmd_present(*pmd))
 			continue;
@@ -1099,7 +1099,7 @@ remove_pud_table(pud_t *pud_start, unsigned long addr, unsigned long end,
 
 	pud = pud_start + pud_index(addr);
 	for (; addr < end; addr = next, pud++) {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 
 		if (!pud_present(*pud))
 			continue;
@@ -1153,7 +1153,7 @@ remove_p4d_table(p4d_t *p4d_start, unsigned long addr, unsigned long end,
 
 	p4d = p4d_start + p4d_index(addr);
 	for (; addr < end; addr = next, p4d++) {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		if (!p4d_present(*p4d))
 			continue;
@@ -1186,9 +1186,8 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 	p4d_t *p4d;
 
 	for (addr = start; addr < end; addr = next) {
-		next = pgd_addr_end(addr, end);
-
 		pgd = pgd_offset_k(addr);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!pgd_present(*pgd))
 			continue;
 
@@ -1500,8 +1499,6 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 	pmd_t *pmd;
 
 	for (addr = start; addr < end; addr = next) {
-		next = pmd_addr_end(addr, end);
-
 		pgd = vmemmap_pgd_populate(addr, node);
 		if (!pgd)
 			return -ENOMEM;
@@ -1515,6 +1512,7 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 			return -ENOMEM;
 
 		pmd = pmd_offset(pud, addr);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none(*pmd)) {
 			void *p;
 
@@ -1623,9 +1621,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 			get_page_bootmem(section_nr, pte_page(*pte),
 					 SECTION_INFO);
 		} else {
-			next = pmd_addr_end(addr, end);
-
 			pmd = pmd_offset(pud, addr);
+			next = pmd_addr_end(*pmd, addr, end);
 			if (pmd_none(*pmd))
 				continue;
 
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 1a50434c8a4d..2c105b5154ba 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -96,7 +96,7 @@ static void __init kasan_populate_pud(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (!pmd_large(*pmd))
 			kasan_populate_pmd(pmd, addr, next, nid);
 	} while (pmd++, addr = next, addr != end);
@@ -116,7 +116,7 @@ static void __init kasan_populate_p4d(p4d_t *p4d, unsigned long addr,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (!pud_large(*pud))
 			kasan_populate_pud(pud, addr, next, nid);
 	} while (pud++, addr = next, addr != end);
@@ -136,7 +136,7 @@ static void __init kasan_populate_pgd(pgd_t *pgd, unsigned long addr,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		kasan_populate_p4d(p4d, addr, next, nid);
 	} while (p4d++, addr = next, addr != end);
 }
@@ -151,7 +151,7 @@ static void __init kasan_populate_shadow(unsigned long addr, unsigned long end,
 	end = round_up(end, PAGE_SIZE);
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		kasan_populate_pgd(pgd, addr, next, nid);
 	} while (pgd++, addr = next, addr != end);
 }
@@ -219,7 +219,7 @@ static void __init kasan_early_p4d_populate(pgd_t *pgd,
 
 	p4d = early_p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		if (!p4d_none(*p4d))
 			continue;
@@ -239,7 +239,7 @@ static void __init kasan_map_early_shadow(pgd_t *pgd)
 
 	pgd += pgd_index(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		kasan_early_p4d_populate(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
 }
@@ -254,7 +254,7 @@ static void __init kasan_shallow_populate_p4ds(pgd_t *pgd,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		if (p4d_none(*p4d)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
@@ -272,7 +272,7 @@ static void __init kasan_shallow_populate_pgds(void *start, void *end)
 	addr = (unsigned long)start;
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, (unsigned long)end);
+		next = pgd_addr_end(*pgd, addr, (unsigned long)end);
 
 		if (pgd_none(*pgd)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index ce2cbb3c380f..156b42e51424 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -53,7 +53,7 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 #define p4d_free_tlb(tlb, x, a)			do { } while (0)
 
 #undef  p4d_addr_end
-#define p4d_addr_end(addr, end)			(end)
+#define p4d_addr_end(p4d, addr, end)		(end)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _PGTABLE_NOP4D_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 3e13acd019ae..e988384de1c7 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -64,7 +64,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 #define pmd_free_tlb(tlb, x, a)		do { } while (0)
 
 #undef  pmd_addr_end
-#define pmd_addr_end(addr, end)			(end)
+#define pmd_addr_end(pmd, addr, end)		(end)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index a9d751fbda9e..57a28bade9f9 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -60,7 +60,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define pud_free_tlb(tlb, x, a)		        do { } while (0)
 
 #undef  pud_addr_end
-#define pud_addr_end(addr, end)			(end)
+#define pud_addr_end(pud, addr, end)		(end)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _PGTABLE_NOPUD_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 981c4c2a31fe..67ebc22cf83d 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -655,48 +655,34 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
  */
 
-#define pgd_addr_end(addr, end)						\
+#ifndef pgd_addr_end
+#define pgd_addr_end(pgd, addr, end)					\
 ({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
+#endif
 
 #ifndef p4d_addr_end
-#define p4d_addr_end(addr, end)						\
+#define p4d_addr_end(p4d, addr, end)					\
 ({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
 #endif
 
 #ifndef pud_addr_end
-#define pud_addr_end(addr, end)						\
+#define pud_addr_end(pud, addr, end)					\
 ({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
 #endif
 
 #ifndef pmd_addr_end
-#define pmd_addr_end(addr, end)						\
+#define pmd_addr_end(pmd, addr, end)					\
 ({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
 	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
 })
 #endif
 
-#ifndef pgd_addr_end_folded
-#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
-#endif
-
-#ifndef p4d_addr_end_folded
-#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
-#endif
-
-#ifndef pud_addr_end_folded
-#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
-#endif
-
-#ifndef pmd_addr_end_folded
-#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
-#endif
-
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/gup.c b/mm/gup.c
index ba4aace5d0f4..7826876ae7e0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end_folded(pmd, addr, end);
+		next = pmd_addr_end(pmd, addr, end);
 		if (!pmd_present(pmd))
 			return 0;
 
@@ -2564,7 +2564,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end_folded(pud, addr, end);
+		next = pud_addr_end(pud, addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
@@ -2592,7 +2592,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
-		next = p4d_addr_end_folded(p4d, addr, end);
+		next = p4d_addr_end(p4d, addr, end);
 		if (p4d_none(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
@@ -2617,7 +2617,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
 
-		next = pgd_addr_end_folded(pgd, addr, end);
+		next = pgd_addr_end(pgd, addr, end);
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..400fa119c09d 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -114,7 +114,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 	if (!pmd)
 		return -ENOMEM;
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PMD_MODIFIED;
@@ -160,7 +160,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 	if (!pud)
 		return -ENOMEM;
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 
 		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PUD_MODIFIED;
@@ -206,7 +206,7 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 	if (!p4d)
 		return -ENOMEM;
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_P4D_MODIFIED;
@@ -234,7 +234,7 @@ int ioremap_page_range(unsigned long addr,
 	start = addr;
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot,
 					&mask);
 		if (err)
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index fe6be0be1f76..829627a92763 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -117,7 +117,7 @@ static int __ref zero_pmd_populate(pud_t *pud, unsigned long addr,
 	unsigned long next;
 
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
 			pmd_populate_kernel(&init_mm, pmd,
@@ -150,7 +150,7 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
 	unsigned long next;
 
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (IS_ALIGNED(addr, PUD_SIZE) && end - addr >= PUD_SIZE) {
 			pmd_t *pmd;
 
@@ -187,7 +187,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 	unsigned long next;
 
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (IS_ALIGNED(addr, P4D_SIZE) && end - addr >= P4D_SIZE) {
 			pud_t *pud;
 			pmd_t *pmd;
@@ -236,7 +236,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 	unsigned long next;
 
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 
 		if (IS_ALIGNED(addr, PGDIR_SIZE) && end - addr >= PGDIR_SIZE) {
 			p4d_t *p4d;
@@ -370,7 +370,7 @@ static void kasan_remove_pmd_table(pmd_t *pmd, unsigned long addr,
 	for (; addr < end; addr = next, pmd++) {
 		pte_t *pte;
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		if (!pmd_present(*pmd))
 			continue;
@@ -395,7 +395,7 @@ static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
 	for (; addr < end; addr = next, pud++) {
 		pmd_t *pmd, *pmd_base;
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 
 		if (!pud_present(*pud))
 			continue;
@@ -421,7 +421,7 @@ static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
 	for (; addr < end; addr = next, p4d++) {
 		pud_t *pud;
 
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		if (!p4d_present(*p4d))
 			continue;
@@ -454,9 +454,8 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 	for (; addr < end; addr = next) {
 		p4d_t *p4d;
 
-		next = pgd_addr_end(addr, end);
-
 		pgd = pgd_offset_k(addr);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!pgd_present(*pgd))
 			continue;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e32e7efbba0f..acfb3441d97e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -326,7 +326,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
-		unsigned long next = pmd_addr_end(addr, end);
+		unsigned long next = pmd_addr_end(*pmd, addr, end);
 
 		tlb_change_page_size(tlb, HPAGE_PMD_SIZE);
 		ptl = pmd_trans_huge_lock(pmd, vma);
@@ -587,7 +587,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	int nr_swap = 0;
 	unsigned long next;
 
-	next = pmd_addr_end(addr, end);
+	next = pmd_addr_end(*pmd, addr, end);
 	if (pmd_trans_huge(*pmd))
 		if (madvise_free_huge_pmd(tlb, vma, pmd, addr, next))
 			goto next;
diff --git a/mm/memory.c b/mm/memory.c
index fb5463153351..f95424946b0d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -233,7 +233,7 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	start = addr;
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		free_pte_range(tlb, pmd, addr);
@@ -267,7 +267,7 @@ static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 	start = addr;
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		free_pmd_range(tlb, pud, addr, next, floor, ceiling);
@@ -301,7 +301,7 @@ static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
 	start = addr;
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		free_pud_range(tlb, p4d, addr, next, floor, ceiling);
@@ -381,7 +381,7 @@ void free_pgd_range(struct mmu_gather *tlb,
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		free_p4d_range(tlb, pgd, addr, next, floor, ceiling);
@@ -887,7 +887,7 @@ static inline int copy_pmd_range(struct mm_struct *dst_mm, struct mm_struct *src
 		return -ENOMEM;
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*src_pmd, addr, end);
 		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
 			|| pmd_devmap(*src_pmd)) {
 			int err;
@@ -921,7 +921,7 @@ static inline int copy_pud_range(struct mm_struct *dst_mm, struct mm_struct *src
 		return -ENOMEM;
 	src_pud = pud_offset(src_p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*src_pud, addr, end);
 		if (pud_trans_huge(*src_pud) || pud_devmap(*src_pud)) {
 			int err;
 
@@ -955,7 +955,7 @@ static inline int copy_p4d_range(struct mm_struct *dst_mm, struct mm_struct *src
 		return -ENOMEM;
 	src_p4d = p4d_offset(src_pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*src_p4d, addr, end);
 		if (p4d_none_or_clear_bad(src_p4d))
 			continue;
 		if (copy_pud_range(dst_mm, src_mm, dst_p4d, src_p4d,
@@ -1017,7 +1017,7 @@ int copy_page_range(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	dst_pgd = pgd_offset(dst_mm, addr);
 	src_pgd = pgd_offset(src_mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*src_pgd, addr, end);
 		if (pgd_none_or_clear_bad(src_pgd))
 			continue;
 		if (unlikely(copy_p4d_range(dst_mm, src_mm, dst_pgd, src_pgd,
@@ -1177,7 +1177,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
@@ -1212,7 +1212,7 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_trans_huge(*pud) || pud_devmap(*pud)) {
 			if (next - addr != HPAGE_PUD_SIZE) {
 				mmap_assert_locked(tlb->mm);
@@ -1241,7 +1241,7 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		next = zap_pud_range(tlb, vma, p4d, addr, next, details);
@@ -1262,7 +1262,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
@@ -2030,7 +2030,7 @@ static inline int remap_pmd_range(struct mm_struct *mm, pud_t *pud,
 		return -ENOMEM;
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		err = remap_pte_range(mm, pmd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2052,7 +2052,7 @@ static inline int remap_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	if (!pud)
 		return -ENOMEM;
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		err = remap_pmd_range(mm, pud, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2074,7 +2074,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	if (!p4d)
 		return -ENOMEM;
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		err = remap_pud_range(mm, p4d, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2143,7 +2143,7 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	pgd = pgd_offset(mm, addr);
 	flush_cache_range(vma, addr, end);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		err = remap_p4d_range(mm, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
@@ -2266,7 +2266,7 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 		pmd = pmd_offset(pud, addr);
 	}
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (create || !pmd_none_or_clear_bad(pmd)) {
 			err = apply_to_pte_range(mm, pmd, addr, next, fn, data,
 						 create, mask);
@@ -2294,7 +2294,7 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 		pud = pud_offset(p4d, addr);
 	}
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (create || !pud_none_or_clear_bad(pud)) {
 			err = apply_to_pmd_range(mm, pud, addr, next, fn, data,
 						 create, mask);
@@ -2322,7 +2322,7 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 		p4d = p4d_offset(pgd, addr);
 	}
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (create || !p4d_none_or_clear_bad(p4d)) {
 			err = apply_to_pud_range(mm, p4d, addr, next, fn, data,
 						 create, mask);
@@ -2348,7 +2348,7 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 
 	pgd = pgd_offset(mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (!create && pgd_none_or_clear_bad(pgd))
 			continue;
 		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, create, &mask);
diff --git a/mm/mlock.c b/mm/mlock.c
index 93ca2bf30b4f..5898e8fe2288 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -374,8 +374,12 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 			struct vm_area_struct *vma, struct zone *zone,
 			unsigned long start, unsigned long end)
 {
-	pte_t *pte;
 	spinlock_t *ptl;
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
 
 	/*
 	 * Initialize pte walk starting at the already pinned page where we
@@ -384,10 +388,14 @@ static unsigned long __munlock_pagevec_fill(struct pagevec *pvec,
 	 */
 	pte = get_locked_pte(vma->vm_mm, start,	&ptl);
 	/* Make sure we do not cross the page table boundary */
-	end = pgd_addr_end(start, end);
-	end = p4d_addr_end(start, end);
-	end = pud_addr_end(start, end);
-	end = pmd_addr_end(start, end);
+	pgd = pgd_offset(vma->vm_mm, start);
+	end = pgd_addr_end(*pgd, start, end);
+	p4d = p4d_offset(pgd, start);
+	end = p4d_addr_end(*p4d, start, end);
+	pud = pud_offset(p4d, start);
+	end = pud_addr_end(*pud, start, end);
+	pmd = pmd_offset(pud, start);
+	end = pmd_addr_end(*pmd, start, end);
 
 	/* The page next to the pinned page is the first we will try to get */
 	start += PAGE_SIZE;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..278f2dbd1f20 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -225,7 +225,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 	do {
 		unsigned long this_pages;
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		/*
 		 * Automatic NUMA balancing walks the tables with mmap_lock
@@ -291,7 +291,7 @@ static inline unsigned long change_pud_range(struct vm_area_struct *vma,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		pages += change_pmd_range(vma, pud, addr, next, newprot,
@@ -311,7 +311,7 @@ static inline unsigned long change_p4d_range(struct vm_area_struct *vma,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		pages += change_pud_range(vma, p4d, addr, next, newprot,
@@ -336,7 +336,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 	flush_cache_range(vma, addr, end);
 	inc_tlb_flush_pending(mm);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		pages += change_p4d_range(vma, pgd, addr, next, newprot,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d9f177..a5b9f61b5d45 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -70,7 +70,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd = pmd_offset(pud, addr);
 	do {
 again:
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -128,7 +128,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud = pud_offset(p4d, addr);
 	do {
  again:
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -176,7 +176,7 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
@@ -211,7 +211,7 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	else
 		pgd = pgd_offset(walk->mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
 			if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, 0, walk);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 20012c0c0252..b1dd815aee6b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2018,7 +2018,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		cond_resched();
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
 		ret = unuse_pte_range(vma, pmd, addr, next, type,
@@ -2040,7 +2040,7 @@ static inline int unuse_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		ret = unuse_pmd_range(vma, pud, addr, next, type,
@@ -2062,7 +2062,7 @@ static inline int unuse_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
 		ret = unuse_pud_range(vma, p4d, addr, next, type,
@@ -2085,7 +2085,7 @@ static int unuse_vma(struct vm_area_struct *vma, unsigned int type,
 
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		ret = unuse_p4d_range(vma, pgd, addr, next, type,
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..09ff0d5ecbc1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -93,7 +93,7 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 
 		cleared = pmd_clear_huge(pmd);
 		if (cleared || pmd_bad(*pmd))
@@ -118,7 +118,7 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 	pud = pud_offset(p4d, addr);
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 
 		cleared = pud_clear_huge(pud);
 		if (cleared || pud_bad(*pud))
@@ -141,7 +141,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 
 	p4d = p4d_offset(pgd, addr);
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 
 		cleared = p4d_clear_huge(p4d);
 		if (cleared || p4d_bad(*p4d))
@@ -179,7 +179,7 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
 		if (pgd_none_or_clear_bad(pgd))
@@ -230,7 +230,7 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 	if (!pmd)
 		return -ENOMEM;
 	do {
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end(*pmd, addr, end);
 		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
@@ -248,7 +248,7 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 	if (!pud)
 		return -ENOMEM;
 	do {
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end(*pud, addr, end);
 		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
@@ -266,7 +266,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 	if (!p4d)
 		return -ENOMEM;
 	do {
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end(*p4d, addr, end);
 		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
@@ -305,7 +305,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 	BUG_ON(addr >= end);
 	pgd = pgd_offset_k(addr);
 	do {
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end(*pgd, addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
-- 
2.17.1

