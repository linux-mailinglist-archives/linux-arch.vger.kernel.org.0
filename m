Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA6BD440
	for <lists+linux-arch@lfdr.de>; Tue, 24 Sep 2019 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395526AbfIXV0J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Sep 2019 17:26:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633532AbfIXV0I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Sep 2019 17:26:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8OLMOUG051360;
        Tue, 24 Sep 2019 17:25:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v7r436fp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 17:25:27 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8OLMhWg052136;
        Tue, 24 Sep 2019 17:25:27 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v7r436fnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 17:25:26 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8OLJsq5013762;
        Tue, 24 Sep 2019 21:25:26 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 2v5bg77yja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 21:25:26 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8OLPOx536700490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Sep 2019 21:25:24 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84BF1C6059;
        Tue, 24 Sep 2019 21:25:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA88FC6057;
        Tue, 24 Sep 2019 21:25:19 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.184])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Sep 2019 21:25:19 +0000 (GMT)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v3 08/11] powerpc/kvm/book3s_hv: Applies counting method to monitor lockless pgtbl walks
Date:   Tue, 24 Sep 2019 18:24:25 -0300
Message-Id: <20190924212427.7734-9-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924212427.7734-1-leonardo@linux.ibm.com>
References: <20190924212427.7734-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=924 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909240173
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Applies the counting-based method for monitoring all book3s_hv related
functions that do lockless pagetable walks.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_nested.c | 8 ++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 9 ++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index 735e0ac6f5b2..ed68e57af3a3 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -804,6 +804,7 @@ static void kvmhv_update_nest_rmap_rc(struct kvm *kvm, u64 n_rmap,
 		return;
 
 	/* Find the pte */
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	/*
 	 * If the pte is present and the pfn is still the same, update the pte.
@@ -815,6 +816,7 @@ static void kvmhv_update_nest_rmap_rc(struct kvm *kvm, u64 n_rmap,
 		__radix_pte_update(ptep, clr, set);
 		kvmppc_radix_tlbie_page(kvm, gpa, shift, lpid);
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 }
 
 /*
@@ -854,10 +856,12 @@ static void kvmhv_remove_nest_rmap(struct kvm *kvm, u64 n_rmap,
 		return;
 
 	/* Find and invalidate the pte */
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	/* Don't spuriously invalidate ptes if the pfn has changed */
 	if (ptep && pte_present(*ptep) && ((pte_val(*ptep) & mask) == hpa))
 		kvmppc_unmap_pte(kvm, ptep, gpa, shift, NULL, gp->shadow_lpid);
+	end_lockless_pgtbl_walk(kvm->mm);
 }
 
 static void kvmhv_remove_nest_rmap_list(struct kvm *kvm, unsigned long *rmapp,
@@ -921,6 +925,7 @@ static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
 	int shift;
 
 	spin_lock(&kvm->mmu_lock);
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(gp->shadow_pgtable, gpa, NULL, &shift);
 	if (!shift)
 		shift = PAGE_SHIFT;
@@ -928,6 +933,7 @@ static bool kvmhv_invalidate_shadow_pte(struct kvm_vcpu *vcpu,
 		kvmppc_unmap_pte(kvm, ptep, gpa, shift, NULL, gp->shadow_lpid);
 		ret = true;
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 	spin_unlock(&kvm->mmu_lock);
 
 	if (shift_ret)
@@ -1362,11 +1368,13 @@ static long int __kvmhv_nested_page_fault(struct kvm_run *run,
 	/* See if can find translation in our partition scoped tables for L1 */
 	pte = __pte(0);
 	spin_lock(&kvm->mmu_lock);
+	start_lockless_pgtbl_walk(kvm->mm);
 	pte_p = __find_linux_pte(kvm->arch.pgtable, gpa, NULL, &shift);
 	if (!shift)
 		shift = PAGE_SHIFT;
 	if (pte_p)
 		pte = *pte_p;
+	end_lockless_pgtbl_walk(kvm->mm);
 	spin_unlock(&kvm->mmu_lock);
 
 	if (!pte_present(pte) || (writing && !(pte_val(pte) & _PAGE_WRITE))) {
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 63e0ce91e29d..53ca67492211 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -258,6 +258,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	 * If called in real mode we have MSR_EE = 0. Otherwise
 	 * we disable irq above.
 	 */
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(pgdir, hva, NULL, &hpage_shift);
 	if (ptep) {
 		pte_t pte;
@@ -311,6 +312,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		ptel &= ~(HPTE_R_W|HPTE_R_I|HPTE_R_G);
 		ptel |= HPTE_R_M;
 	}
+	end_lockless_pgtbl_walk(kvm->mm);
 
 	/* Find and lock the HPTEG slot to use */
  do_insert:
@@ -886,10 +888,15 @@ static int kvmppc_get_hpa(struct kvm_vcpu *vcpu, unsigned long gpa,
 	hva = __gfn_to_hva_memslot(memslot, gfn);
 
 	/* Try to find the host pte for that virtual address */
+	start_lockless_pgtbl_walk(kvm->mm);
 	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
-	if (!ptep)
+	if (!ptep) {
+		end_lockless_pgtbl_walk(kvm->mm);
 		return H_TOO_HARD;
+	}
 	pte = kvmppc_read_update_linux_pte(ptep, writing);
+	end_lockless_pgtbl_walk(kvm->mm);
+
 	if (!pte_present(pte))
 		return H_TOO_HARD;
 
-- 
2.20.1

