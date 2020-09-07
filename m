Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0A26041A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgIGSEp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 14:04:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728846AbgIGSEm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 14:04:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087I10sF168501;
        Mon, 7 Sep 2020 14:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=lPGa6fWKfg3zay7vzZC1yMSTVM3fph9XzvKCzbKMAZ4=;
 b=ojRtU0WpNelqlWdKuuRj7EZ3Ew91FliVqZBfL28XZLl3kgc9xTy2w9eKrt0T7dq5OIaV
 ajZiW2c+dVJOb9tzdbDRN72evoPel8Q9pT4Dtn2nvtcN1zLXjctC2mbkoPGlL7NxEs8/
 2+aVYxDB8qwwqkvJn83ix+3pJaA0OVzwbX0opLJ+gNnXILNtb2sPQPNIYJU9s+UKoFig
 5eiWrEyF8s1TjHP5kQ0Q5gYxfnAvCnqm54EufHj5iZH0p55iyNR810bWXzT3+V5YkSz/
 CI91o8Fs1+McSHLmyKsyesWHI54UteZg6V7rgjFTCnLkMIu0dz80C6qFm10FMVtdKG0p 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dp6gdmkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:12 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087I3B3x174820;
        Mon, 7 Sep 2020 14:03:11 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33dp6gdmjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 14:03:11 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087I28ep016507;
        Mon, 7 Sep 2020 18:03:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 33cyq51cw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:03:09 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087I36be26542470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Sep 2020 18:03:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B9C42047;
        Mon,  7 Sep 2020 18:03:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E2C42041;
        Mon,  7 Sep 2020 18:03:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Sep 2020 18:03:05 +0000 (GMT)
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
Subject: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table folding
Date:   Mon,  7 Sep 2020 20:00:56 +0200
Message-Id: <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009070168
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
code") introduced a subtle but severe bug on s390 with gup_fast, due to
dynamic page table folding.

The question "What would it require for the generic code to work for s390"
has already been discussed here
https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
and ended with a promising approach here
https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
which in the end unfortunately didn't quite work completely.

We tried to mimic static level folding by changing pgd_offset to always
calculate top level page table offset, and do nothing in folded pXd_offset.
What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end do
not reflect this dynamic behaviour, and still act like static 5-level
page tables.

Here is an example of what happens with gup_fast on s390, for a task with
3-levels paging, crossing a 2 GB pud boundary:

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

pud_addr_end = 0x10080000000 is correct, but the previous pgd/p4d_addr_end
should also have returned that limit, instead of the 5-level static
pgd/p4d limits with PUD_SIZE/MASK != PGDIR_SIZE/MASK. Then the "end"
parameter for gup_pud_range would also have been 0x10080000000, and we
would not iterate further in gup_pud_range, but rather go back and
(correctly) do it in gup_pgd_range.

So, for the second iteration in gup_pud_range, we will increase pudp,
which pointed to a stack value and not the real pud table. This new pudp
will then point to whatever lies behind the p4d stack value. In general,
this happens to be the previously read pgd, but it probably could also
be something different, depending on compiler decisions.

Most unfortunately, if it happens to be the pgd value, which is the
same as the p4d / pud due to folding, it is a valid and present entry.
So after the increment, we would still point to the same pud entry.
The addr however has been increased in the second iteration, so that we
now have different pmd/pte_index values, which will result in very wrong
behaviour for the remaining gup_pmd/pte_range calls. We will effectively
operate on an address minus 2 GB, due to missing pudp increase.

In the "good case", if nothing is mapped there, we will fall back to
the slow gup path. But if something is mapped there, and valid
for gup_fast, we will end up (silently) getting references on the wrong
pages and also add the wrong pages to the **pages result array. This
can cause data corruption.

Fix this by introducing new pXd_addr_end_folded helpers, which take an
additional pXd entry value parameter, that can be used on s390
to determine the correct page table level and return corresponding
end / boundary. With that, the pointer iteration will always
happen in gup_pgd_range for s390. No change for other architectures
introduced.

Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
Cc: <stable@vger.kernel.org> # 5.2+
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++++++
 include/linux/pgtable.h         | 16 +++++++++++++
 mm/gup.c                        |  8 +++----
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7eb01a5459cd..027206e4959d 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -512,6 +512,48 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
 }
 #define mm_pmd_folded(mm) mm_pmd_folded(mm)
 
+/*
+ * With dynamic page table levels on s390, the static pXd_addr_end() functions
+ * will not return corresponding dynamic boundaries. This is no problem as long
+ * as only pXd pointers are passed down during page table walk, because
+ * pXd_offset() will simply return the given pointer for folded levels, and the
+ * pointer iteration over a range simply happens at the correct page table
+ * level.
+ * It is however a problem with gup_fast, or other places walking the page
+ * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
+ * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
+ * a stack variable, which cannot be used for pointer iteration at the correct
+ * level. Instead, the iteration then has to happen by going up to pgd level
+ * again. To allow this, provide pXd_addr_end_folded() functions with an
+ * additional pXd value parameter, which can be used on s390 to determine the
+ * folding level and return the corresponding boundary.
+ */
+static inline unsigned long rste_addr_end_folded(unsigned long rste, unsigned long addr, unsigned long end)
+{
+	unsigned long type = (rste & _REGION_ENTRY_TYPE_MASK) >> 2;
+	unsigned long size = 1UL << (_SEGMENT_SHIFT + type * 11);
+	unsigned long boundary = (addr + size) & ~(size - 1);
+
+	/*
+	 * FIXME The below check is for internal testing only, to be removed
+	 */
+	VM_BUG_ON(type < (_REGION_ENTRY_TYPE_R3 >> 2));
+
+	return (boundary - 1) < (end - 1) ? boundary : end;
+}
+
+#define pgd_addr_end_folded pgd_addr_end_folded
+static inline unsigned long pgd_addr_end_folded(pgd_t pgd, unsigned long addr, unsigned long end)
+{
+	return rste_addr_end_folded(pgd_val(pgd), addr, end);
+}
+
+#define p4d_addr_end_folded p4d_addr_end_folded
+static inline unsigned long p4d_addr_end_folded(p4d_t p4d, unsigned long addr, unsigned long end)
+{
+	return rste_addr_end_folded(p4d_val(p4d), addr, end);
+}
+
 static inline int mm_has_pgste(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8cbc2e795d5..981c4c2a31fe 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -681,6 +681,22 @@ static inline int arch_unmap_one(struct mm_struct *mm,
 })
 #endif
 
+#ifndef pgd_addr_end_folded
+#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
+#endif
+
+#ifndef p4d_addr_end_folded
+#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
+#endif
+
+#ifndef pud_addr_end_folded
+#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
+#endif
+
+#ifndef pmd_addr_end_folded
+#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
+#endif
+
 /*
  * When walking page tables, we usually want to skip any p?d_none entries;
  * and any p?d_bad entries - reporting the error before resetting to none.
diff --git a/mm/gup.c b/mm/gup.c
index bd883a112724..ba4aace5d0f4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
 	do {
 		pmd_t pmd = READ_ONCE(*pmdp);
 
-		next = pmd_addr_end(addr, end);
+		next = pmd_addr_end_folded(pmd, addr, end);
 		if (!pmd_present(pmd))
 			return 0;
 
@@ -2564,7 +2564,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
 	do {
 		pud_t pud = READ_ONCE(*pudp);
 
-		next = pud_addr_end(addr, end);
+		next = pud_addr_end_folded(pud, addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
 		if (unlikely(pud_huge(pud))) {
@@ -2592,7 +2592,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
 	do {
 		p4d_t p4d = READ_ONCE(*p4dp);
 
-		next = p4d_addr_end(addr, end);
+		next = p4d_addr_end_folded(p4d, addr, end);
 		if (p4d_none(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
@@ -2617,7 +2617,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		pgd_t pgd = READ_ONCE(*pgdp);
 
-		next = pgd_addr_end(addr, end);
+		next = pgd_addr_end_folded(pgd, addr, end);
 		if (pgd_none(pgd))
 			return;
 		if (unlikely(pgd_huge(pgd))) {
-- 
2.17.1

