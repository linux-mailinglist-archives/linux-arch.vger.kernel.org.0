Return-Path: <linux-arch+bounces-12796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3283EB06B22
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F947B5BB0
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 01:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0235233156;
	Wed, 16 Jul 2025 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LmzuQef3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CC22A1C5;
	Wed, 16 Jul 2025 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629222; cv=none; b=jh1yHcCbeEaYdWSRbM1S72XRtaA1QCoGCEDHqGWWZgMpY9+JPiV0LnLSuqa9OqFwDCRAbHBx6Vzj5EFVKSheIb0fL9aKJqkbEB6MTW9A0l4aG8Ov1LbXyoWTO7A33BMnR7oK37kGs8nH4UnpZhO5FimKRZsV8d6WFA3v+pMBrw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629222; c=relaxed/simple;
	bh=/vG7V9G5UBhmTWZ6sHT4OZdacBdPV9ht7I2UK0+p9aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCIV+SIsYLNWHD6/0eodTQQwO1RA65Eglg+hgXQI+a5nPeGuYFv3FMAipf16w4ijpMsK9FFANjo9WV5W69NztHjLWItrLgheTo0EzARFQfRdcwqaeQ9BJ29tJrY7VL1+qHiULtSErXBj5+NzZkXkH/V4553+terf1cUUbR3DJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LmzuQef3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0foEb012888;
	Wed, 16 Jul 2025 01:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9hPbq
	mtAMmLdLyUbDapemdQ6eylYnjm/J652cQBK1HM=; b=LmzuQef3mB6kdwanNW+5s
	yjZKOyjKu9vBbSuOSBKtkaOfMaJkxpZ0iMo2kOxOC1QiM3GPp3y6zPpBW8ttJU3t
	GRQtGrVpfX7JST/IL82Ye60YGaJ/y1d5fi4y+nd1SR+pwCZsLxDHrbWgHLALwYMg
	VPnAPZhYqrwS+CcqgWdChtE+6nM8F3/suvLqgmC6vKus1roQnJNzgyUiZFzjlFTd
	BOcVej+/GIyzCg89tpLBOsMK3220sYuK2wRgpR2xqV2m5G7z+uwMwZWTdcHow5qB
	Bhqv6wBv3+9/9qfrfbm8VbG/qD4D5wn5GvKbGguB4G+p+yUWcXqD1PRZjN/7h059
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66yp8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FN4FUP029730;
	Wed, 16 Jul 2025 01:26:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5afdr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 01:26:14 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56G1QCRa036586;
	Wed, 16 Jul 2025 01:26:14 GMT
Received: from localhost.localdomain (ca-dev60.us.oracle.com [10.129.136.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ue5afdph-2;
	Wed, 16 Jul 2025 01:26:14 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
To: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
        muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        agordeev@linux.ibm.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
Subject: [PATCH 1/3] sparc64: remove hugetlb_free_pgd_range()
Date: Tue, 15 Jul 2025 18:26:09 -0700
Message-ID: <20250716012611.10369-2-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716012611.10369-1-anthony.yznaga@oracle.com>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160010
X-Proofpoint-ORIG-GUID: hZBv49Z9kpCcM1k4QZPaXjwtY8RtQ-m0
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=6876ffb7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=oCSX7sssdzT6tVRM9uEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAxMSBTYWx0ZWRfX+Jlyb/pAzMAe BVa03bZxX71M1vvKHGj6bxcY7cOd2cuF7no8e5WNemj/GGCtotO0gEbZN0DYP9+MeG8QVOZvrC7 9Vt2uw/GL/Ak3nM8PGj8yprQbJcH17CSrWgZrchGEmrlhKFYg9lRdIv5RxlOicxkbM1n40z4q5x
 Vr8cOVM6SYeN8c51j08yQz842EToQCzwWQdQ9uJja/MQJFdpV5LL70AYdGW9rdwavKS+gC0byhQ yrF4Poh9luwAXXUZKMOO2QDhwGZDBnFYpkkKdXTZIyGypcuE9dEIilV8QspFeEIkqnH+ggD6z1P dd7XvCGzMMFwNbeFGQWoAu2jcg/UeQDsvuyy2Ud3zjAVMO5Rc8KpPfJYarCF+Qjy97GQncPGK4q
 aQg6RNX0WBqdTg//vmRhRpB/H8vAjIJlnUI2p0XOtfupyUd+6iWd+05efKXDamL8F17AFSN4
X-Proofpoint-GUID: hZBv49Z9kpCcM1k4QZPaXjwtY8RtQ-m0

The sparc implementation of hugetlb_free_pgd_range() is identical
to free_pgd_range() with the exception of checking for and skipping
possible leaf entries at the PUD and PMD levels. These checks are
unnecessary because any huge pages have been freed and their PTEs
cleared by the time page tables needed to map them are freed. While
some huge page sizes do populate the page table with multiple PTEs,
they are correctly cleared by huge_ptep_get_and_clear(). To verify
this, libhugetlbfs tests were run for 64K, 8M, and 256M page sizes
with an instrumented kernel on a qemu guest modified to support the
256M page size. The same tests were used to verify no regressions
after applying this patch and were also run on x86 for both 2M and
1G page sizes.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/sparc/include/asm/hugetlb.h |   5 --
 arch/sparc/mm/hugetlbpage.c      | 119 -------------------------------
 2 files changed, 124 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index e7a9cdd498dc..d3bc16fbcbbd 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -50,11 +50,6 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return changed;
 }
 
-#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
-void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
-			    unsigned long end, unsigned long floor,
-			    unsigned long ceiling);
-
 #include <asm-generic/hugetlb.h>
 
 #endif /* _ASM_SPARC64_HUGETLB_H */
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 2048b5c42ca8..4652e868663b 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -315,122 +315,3 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 	return entry;
 }
-
-static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-			   unsigned long addr)
-{
-	pgtable_t token = pmd_pgtable(*pmd);
-
-	pmd_clear(pmd);
-	pte_free_tlb(tlb, token, addr);
-	mm_dec_nr_ptes(tlb->mm);
-}
-
-static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
-				   unsigned long addr, unsigned long end,
-				   unsigned long floor, unsigned long ceiling)
-{
-	pmd_t *pmd;
-	unsigned long next;
-	unsigned long start;
-
-	start = addr;
-	pmd = pmd_offset(pud, addr);
-	do {
-		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd))
-			continue;
-		if (is_hugetlb_pmd(*pmd))
-			pmd_clear(pmd);
-		else
-			hugetlb_free_pte_range(tlb, pmd, addr);
-	} while (pmd++, addr = next, addr != end);
-
-	start &= PUD_MASK;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= PUD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
-		return;
-
-	pmd = pmd_offset(pud, start);
-	pud_clear(pud);
-	pmd_free_tlb(tlb, pmd, start);
-	mm_dec_nr_pmds(tlb->mm);
-}
-
-static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
-				   unsigned long addr, unsigned long end,
-				   unsigned long floor, unsigned long ceiling)
-{
-	pud_t *pud;
-	unsigned long next;
-	unsigned long start;
-
-	start = addr;
-	pud = pud_offset(p4d, addr);
-	do {
-		next = pud_addr_end(addr, end);
-		if (pud_none_or_clear_bad(pud))
-			continue;
-		if (is_hugetlb_pud(*pud))
-			pud_clear(pud);
-		else
-			hugetlb_free_pmd_range(tlb, pud, addr, next, floor,
-					       ceiling);
-	} while (pud++, addr = next, addr != end);
-
-	start &= PGDIR_MASK;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= PGDIR_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
-		return;
-
-	pud = pud_offset(p4d, start);
-	p4d_clear(p4d);
-	pud_free_tlb(tlb, pud, start);
-	mm_dec_nr_puds(tlb->mm);
-}
-
-void hugetlb_free_pgd_range(struct mmu_gather *tlb,
-			    unsigned long addr, unsigned long end,
-			    unsigned long floor, unsigned long ceiling)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	unsigned long next;
-
-	addr &= PMD_MASK;
-	if (addr < floor) {
-		addr += PMD_SIZE;
-		if (!addr)
-			return;
-	}
-	if (ceiling) {
-		ceiling &= PMD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
-		end -= PMD_SIZE;
-	if (addr > end - 1)
-		return;
-
-	pgd = pgd_offset(tlb->mm, addr);
-	p4d = p4d_offset(pgd, addr);
-	do {
-		next = p4d_addr_end(addr, end);
-		if (p4d_none_or_clear_bad(p4d))
-			continue;
-		hugetlb_free_pud_range(tlb, p4d, addr, next, floor, ceiling);
-	} while (p4d++, addr = next, addr != end);
-}
-- 
2.47.1


