Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4845D266998
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 22:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgIKUho (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 16:37:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbgIKUhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Sep 2020 16:37:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BKWdvP170701;
        Fri, 11 Sep 2020 16:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=hOcVC6Va1COznQ0oD3ZHmavI0zSfYZBaHJyzu45rYTc=;
 b=cz3YsExB/lDwLPfrpKWbTdWb5Qzbr5rHXXf/uwggBSWxDSVGHw4DszUvmlUKbaJ1o5Ko
 TzxhoMu/K5Gf0zonK+k5Y8vnz5rB9fu90H1Nobz5XHKeaPkNmM3vBNK8py3MV/KXKyiD
 LPBS5/2S4QWDUBed8/p5N9fWoVqnK6U0OjxWZe6GI5Fd9pkYNvx1+FAu3vrbG1i2q76k
 +zPztI43rnQoxqfO+w71ZlU27pQ/sVlrWge7XwBoWSVLxemoml91gQzG1tf/sz7mtQ9B
 CuAisIeupIx84L/7BmCPhhWqeYo0efEyMvf2+rbGzFA4QFuIUzqlC3oPwLWNeapC3Ngh Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gdycv10x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 16:36:55 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BKXDuQ172749;
        Fri, 11 Sep 2020 16:36:54 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gdycv0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 16:36:54 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BKapqm003573;
        Fri, 11 Sep 2020 20:36:51 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8fn1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 20:36:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BKamlD33358238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 20:36:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 536EAAE051;
        Fri, 11 Sep 2020 20:36:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70537AE04D;
        Fri, 11 Sep 2020 20:36:46 +0000 (GMT)
Received: from localhost (unknown [9.145.43.16])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 11 Sep 2020 20:36:46 +0000 (GMT)
Date:   Fri, 11 Sep 2020 22:36:43 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <patch.git-943f1e5dcff2.your-ad-here.call-01599856292-ext-8676@work.hours>
References: <20200911200511.GC1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911200511.GC1221970@ziepe.ca>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_10:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110162
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently to make sure that every page table entry is read just once
gup_fast walks perform READ_ONCE and pass pXd value down to the next
gup_pXd_range function by value e.g.:

static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
                         unsigned int flags, struct page **pages, int *nr)
...
        pudp = pud_offset(&p4d, addr);

This function passes a reference on that local value copy to pXd_offset,
and might get the very same pointer in return. This happens when the
level is folded (on most arches), and that pointer should not be iterated.

On s390 due to the fact that each task might have different 5,4 or
3-level address translation and hence different levels folded the logic
is more complex and non-iteratable pointer to a local copy leads to
severe problems.

Here is an example of what happens with gup_fast on s390, for a task
with 3-levels paging, crossing a 2 GB pud boundary:

// addr = 0x1007ffff000, end = 0x10080001000
static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
                         unsigned int flags, struct page **pages, int *nr)
{
        unsigned long next;
        pud_t *pudp;

        // pud_offset returns &p4d itself (a pointer to a value on stack)
        pudp = pud_offset(&p4d, addr);
        do {
                // on second iteratation reading "random" stack value
                pud_t pud = READ_ONCE(*pudp);

                // next = 0x10080000000, due to PUD_SIZE/MASK != PGDIR_SIZE/MASK on s390
                next = pud_addr_end(addr, end);
                ...
        } while (pudp++, addr = next, addr != end); // pudp++ iterating over stack

        return 1;
}

This happens since s390 moved to common gup code with
commit d1874a0c2805 ("s390/mm: make the pxd_offset functions more robust")
and commit 1a42010cdc26 ("s390/mm: convert to the generic
get_user_pages_fast code"). s390 tried to mimic static level folding by
changing pXd_offset primitives to always calculate top level page table
offset in pgd_offset and just return the value passed when pXd_offset
has to act as folded.

What is crucial for gup_fast and what has been overlooked is
that PxD_SIZE/MASK and thus pXd_addr_end should also change
correspondingly. And the latter is not possible with dynamic folding.

To fix the issue in addition to pXd values pass original
pXdp pointers down to gup_pXd_range functions. And introduce
pXd_offset_lockless helpers, which take an additional pXd
entry value parameter. This has already been discussed in
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1

Cc: <stable@vger.kernel.org> # 5.2+
Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
v2: added brackets &pgd -> &(pgd)

 arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++----------
 include/linux/pgtable.h         | 10 ++++++++
 mm/gup.c                        | 18 +++++++-------
 3 files changed, 49 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..b55561cc8786 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1260,26 +1260,44 @@ static inline pgd_t *pgd_offset_raw(pgd_t *pgd, unsigned long address)
 
 #define pgd_offset(mm, address) pgd_offset_raw(READ_ONCE((mm)->pgd), address)
 
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static inline p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long address)
 {
-	if ((pgd_val(*pgd) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R1)
-		return (p4d_t *) pgd_deref(*pgd) + p4d_index(address);
-	return (p4d_t *) pgd;
+	if ((pgd_val(pgd) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R1)
+		return (p4d_t *) pgd_deref(pgd) + p4d_index(address);
+	return (p4d_t *) pgdp;
 }
+#define p4d_offset_lockless p4d_offset_lockless
 
-static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+static inline p4d_t *p4d_offset(pgd_t *pgdp, unsigned long address)
 {
-	if ((p4d_val(*p4d) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R2)
-		return (pud_t *) p4d_deref(*p4d) + pud_index(address);
-	return (pud_t *) p4d;
+	return p4d_offset_lockless(pgdp, *pgdp, address);
+}
+
+static inline pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d, unsigned long address)
+{
+	if ((p4d_val(p4d) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R2)
+		return (pud_t *) p4d_deref(p4d) + pud_index(address);
+	return (pud_t *) p4dp;
+}
+#define pud_offset_lockless pud_offset_lockless
+
+static inline pud_t *pud_offset(p4d_t *p4dp, unsigned long address)
+{
+	return pud_offset_lockless(p4dp, *p4dp, address);
 }
 #define pud_offset pud_offset
 
-static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
+static inline pmd_t *pmd_offset_lockless(pud_t *pudp, pud_t pud, unsigned long address)
+{
+	if ((pud_val(pud) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R3)
+		return (pmd_t *) pud_deref(pud) + pmd_index(address);
+	return (pmd_t *) pudp;
+}
+#define pmd_offset_lockless pmd_offset_lockless
+
+static inline pmd_t *pmd_offset(pud_t *pudp, unsigned long address)
 {
-	if ((pud_val(*pud) & _REGION_ENTRY_TYPE_MASK) >= _REGION_ENTRY_TYPE_R3)
-		return (pmd_t *) pud_deref(*pud) + pmd_index(address);
-	return (pmd_t *) pud;
+	return pmd_offset_lockless(pudp, *pudp, address);
 }
 #define pmd_offset pmd_offset
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..90654cb63e9e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1427,6 +1427,16 @@ typedef unsigned int pgtbl_mod_mask;
 #define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
 #endif
 
+#ifndef p4d_offset_lockless
+#define p4d_offset_lockless(pgdp, pgd, address) p4d_offset(&(pgd), address)
+#endif
+#ifndef pud_offset_lockless
+#define pud_offset_lockless(p4dp, p4d, address) pud_offset(&(p4d), address)
+#endif
+#ifndef pmd_offset_lockless
+#define pmd_offset_lockless(pudp, pud, address) pmd_offset(&(pud), address)
+#endif
+
 /*
  * p?d_leaf() - true if this entry is a final mapping to a physical address.
  * This differs from p?d_huge() by the fact that they are always available (if
diff --git a/mm/gup.c b/mm/gup.c
index e5739a1974d5..578bf5bd8bf8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2485,13 +2485,13 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	return 1;
 }
 
-static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
+static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned long end,
 		unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pmd_t *pmdp;
 
-	pmdp = pmd_offset(&pud, addr);
+	pmdp = pmd_offset_lockless(pudp, pud, addr);
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
@@ -2528,13 +2528,13 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	return 1;
 }
 
-static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
+static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	pud_t *pudp;
 
-	pudp = pud_offset(&p4d, addr);
+	pudp = pud_offset_lockless(p4dp, p4d, addr);
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
@@ -2549,20 +2549,20 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
 					 PUD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr))
+		} else if (!gup_pmd_range(pudp, pud, addr, next, flags, pages, nr))
 			return 0;
 	} while (pudp++, addr = next, addr != end);
 
 	return 1;
 }
 
-static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
+static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
 	unsigned long next;
 	p4d_t *p4dp;
 
-	p4dp = p4d_offset(&pgd, addr);
+	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
@@ -2574,7 +2574,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
 					 P4D_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr))
+		} else if (!gup_pud_range(p4dp, p4d, addr, next, flags, pages, nr))
 			return 0;
 	} while (p4dp++, addr = next, addr != end);
 
@@ -2602,7 +2602,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
 					 PGDIR_SHIFT, next, flags, pages, nr))
 				return;
-		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr))
+		} else if (!gup_p4d_range(pgdp, pgd, addr, next, flags, pages, nr))
 			return;
 	} while (pgdp++, addr = next, addr != end);
 }
-- 
⣿⣿⣿⣿⢋⡀⣀⠹⣿⣿⣿⣿
⣿⣿⣿⣿⠠⣶⡦⠀⣿⣿⣿⣿
⣿⣿⣿⠏⣴⣮⣴⣧⠈⢿⣿⣿
⣿⣿⡏⢰⣿⠖⣠⣿⡆⠈⣿⣿
⣿⢛⣵⣄⠙⣶⣶⡟⣅⣠⠹⣿
⣿⣜⣛⠻⢎⣉⣉⣀⠿⣫⣵⣿
