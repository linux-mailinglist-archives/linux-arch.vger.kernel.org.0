Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DEC0E87
	for <lists+linux-arch@lfdr.de>; Sat, 28 Sep 2019 01:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfI0Xlb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Sep 2019 19:41:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728558AbfI0Xlb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Sep 2019 19:41:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8RNbS27135060;
        Fri, 27 Sep 2019 19:40:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9rkswep6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:50 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8RNbip9135898;
        Fri, 27 Sep 2019 19:40:49 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v9rkswens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 19:40:49 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8RNeQvu023941;
        Fri, 27 Sep 2019 23:40:49 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg7v7j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Sep 2019 23:40:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8RNel8e34603450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 23:40:47 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0B98112066;
        Fri, 27 Sep 2019 23:40:47 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E23F112063;
        Fri, 27 Sep 2019 23:40:44 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.58])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 Sep 2019 23:40:44 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v4 06/11] powerpc/mm/book3s64/hash: Applies counting method to monitor lockless pgtbl walks
Date:   Fri, 27 Sep 2019 20:40:03 -0300
Message-Id: <20190927234008.11513-7-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927234008.11513-1-leonardo@linux.ibm.com>
References: <20190927234008.11513-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=505 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909270205
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Applies the counting-based method for monitoring all hash-related functions
that do lockless pagetable walks.

hash_page_mm: Adds comment that explain that there is no need to
local_int_disable/save given that it is only called from DataAccess
interrupt, so interrupts are already disabled.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/hash_tlb.c   |  2 ++
 arch/powerpc/mm/book3s64/hash_utils.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
index 4a70d8dd39cd..5e5213c3f7c4 100644
--- a/arch/powerpc/mm/book3s64/hash_tlb.c
+++ b/arch/powerpc/mm/book3s64/hash_tlb.c
@@ -209,6 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	 * to being hashed). This is not the most performance oriented
 	 * way to do things but is fine for our needs here.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	arch_enter_lazy_mmu_mode();
 	for (; start < end; start += PAGE_SIZE) {
@@ -230,6 +231,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
 	}
 	arch_leave_lazy_mmu_mode();
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index b8ad14bb1170..8615fab87c43 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -1321,7 +1321,11 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
 #endif /* CONFIG_PPC_64K_PAGES */
 
-	/* Get PTE and page size from page tables */
+	/* Get PTE and page size from page tables :
+	 * Called in from DataAccess interrupt (data_access_common: 0x300),
+	 * interrupts are disabled here.
+	 */
+	start_lockless_pgtbl_walk(mm);
 	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
 	if (ptep == NULL || !pte_present(*ptep)) {
 		DBG_LOW(" no PTE !\n");
@@ -1438,6 +1442,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 	DBG_LOW(" -> rc=%d\n", rc);
 
 bail:
+	end_lockless_pgtbl_walk(mm);
 	exception_exit(prev_state);
 	return rc;
 }
@@ -1547,10 +1552,12 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
+
 	/*
 	 * Hash doesn't like irqs. Walking linux page table with irq disabled
 	 * saves us from holding multiple locks.
 	 */
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 
 	/*
@@ -1597,6 +1604,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 				   pte_val(*ptep));
 out_exit:
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
@@ -1613,11 +1621,13 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 	if (!mm || !mm->pgd)
 		return 0;
 
+	start_lockless_pgtbl_walk(mm);
 	local_irq_save(flags);
 	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
 	if (ptep)
 		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
 	local_irq_restore(flags);
+	end_lockless_pgtbl_walk(mm);
 
 	return pkey;
 }
-- 
2.20.1

