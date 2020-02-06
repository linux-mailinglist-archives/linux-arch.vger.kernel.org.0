Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF8153D60
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 04:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBFDME (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 22:12:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727703AbgBFDMD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 22:12:03 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0163A8vm081052;
        Wed, 5 Feb 2020 22:11:32 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmnq7ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:32 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0163BVmo087245;
        Wed, 5 Feb 2020 22:11:31 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xyhmnq7xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:31 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01637kEB016717;
        Thu, 6 Feb 2020 03:11:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 2xykc9hses-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 03:11:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0163BSNf63898042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Feb 2020 03:11:28 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 873E5BE054;
        Thu,  6 Feb 2020 03:11:28 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA34BE051;
        Thu,  6 Feb 2020 03:11:09 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.163.250])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Feb 2020 03:11:08 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v6 06/11] powerpc/mm/book3s64/hash: Use functions to track lockless pgtbl walks
Date:   Thu,  6 Feb 2020 00:08:55 -0300
Message-Id: <20200206030900.147032-7-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206030900.147032-1-leonardo@linux.ibm.com>
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=749
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002060022
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Applies the new tracking functions to all hash-related functions that do
lockless pagetable walks.

hash_page_mm: Adds comment that explain that there is no need to
local_int_disable/save given that it is only called from DataAccess
interrupt, so interrupts are already disabled.

local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
so there is no need to repeat it here.

Variable that saves the	irq mask was renamed from flags to irq_mask so it
doesn't lose meaning now it's not directly passed to local_irq_* functions.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c   |  6 +++---
 arch/powerpc/mm/book3s64/hash_utils.c | 27 +++++++++++++++++----------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 4a70d8dd39cd..86547c4151f6 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -194,7 +194,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 {
 	bool is_thp;
 	int hugepage_shift;
-	unsigned long flags;
+	unsigned long irq_mask;
 
 	start = _ALIGN_DOWN(start, PAGE_SIZE);
 	end = _ALIGN_UP(end, PAGE_SIZE);
@@ -209,7 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	 * to being hashed). This is not the most performance oriented
 	 * way to do things but is fine for our needs here.
 	 */
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk();
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
 		pte_t *ptep = find_current_mm_pte(mm->pgd, start, &is_thp,
@@ -229,7 +229,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 			hpte_need_flush(mm, start, ptep, pte, hugepage_shift);
 	}
 	arch_leave_lazy_mmu_mode();
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(irq_mask);
 }
 
 void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 523d4d39d11e..e6d4ab42173b 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1341,12 +1341,16 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	/* Get PTE and page size from page tables */
+	/* Get PTE and page size from page tables :
+	 * Called in from DataAccess interrupt (data_access_common: 0x300),
+	 * interrupts are disabled here.
+	 */
+	__begin_lockless_pgtbl_walk(false);
 	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
 		rc = 1;
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 	/* Add _PAGE_PRESENT to the required access perm */
@@ -1359,7 +1363,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	if (!check_pte_access(access, pte_val(*ptep))) {
 		DBG_LOW(" no access !\n");
 		rc = 1;
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 	if (hugeshift) {
@@ -1383,7 +1387,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		if (current->mm == mm)
 			check_paca_psize(ea, mm, psize, user_region);
 
-		goto bail;
+		goto bail_pgtbl_walk;
 	}
 
 #ifndef CONFIG_PPC_64K_PAGES
@@ -1457,6 +1461,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 #endif
 	DBG_LOW(" -> rc=%d\n", rc);
 
+bail_pgtbl_walk:
+	__end_lockless_pgtbl_walk(0, false);
 bail:
 	exception_exit(prev_state);
 	return rc;
@@ -1545,7 +1551,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 	unsigned long vsid;
 	pgd_t *pgdir;
 	pte_t *ptep;
-	unsigned long flags;
+	unsigned long irq_mask;
 	int rc, ssize, update_flags = 0;
 	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
 
@@ -1567,11 +1573,12 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
+
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
 	 */
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk();
 
 	/*
 	 * THP pages use update_mmu_cache_pmd. We don't do
@@ -1616,7 +1623,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   mm_ctx_user_psize(&mm->context),
 				   pte_val(*ptep));
 out_exit:
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(irq_mask);
 }
 
 /*
@@ -1679,16 +1686,16 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *ptep;
 	u16 pkey = 0;
-	unsigned long flags;
+	unsigned long irq_mask;
 
 	if (!mm || !mm->pgd)
 		return 0;
 
-	local_irq_save(flags);
+	irq_mask = begin_lockless_pgtbl_walk();
 	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
 	if (ptep)
 		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
-	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(irq_mask);
 
 	return pkey;
 }
-- 
2.24.1

