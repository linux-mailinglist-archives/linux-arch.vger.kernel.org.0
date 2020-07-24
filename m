Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6726E22C6E4
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGXNnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:43:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgGXNnj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 09:43:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B9BB6B6301DDE2BC00E;
        Fri, 24 Jul 2020 21:43:29 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.173) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 21:43:20 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <steven.price@arm.com>, <mark.rutland@arm.com>, <ascull@google.com>
CC:     <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <yezhenyu2@huawei.com>
Subject: [RESEND RFC PATCH v1] arm64: kvm: flush tlbs by range in unmap_stage2_range function
Date:   Fri, 24 Jul 2020 21:43:15 +0800
Message-ID: <20200724134315.805-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now in unmap_stage2_range(), we flush tlbs one by one just after the
corresponding pages cleared.  However, this may cause some performance
problems when the unmap range is very large (such as when the vm
migration rollback, this may cause vm downtime too loog).

This patch moves the kvm_tlb_flush_vmid_ipa() out of loop, and
flush tlbs by range after other operations completed.  Because we
do not make new mapping for the pages here, so this doesn't violate
the Break-Before-Make rules.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 arch/arm64/include/asm/kvm_asm.h |  2 ++
 arch/arm64/kvm/hyp/tlb.c         | 36 ++++++++++++++++++++++++++++++++
 arch/arm64/kvm/mmu.c             | 11 +++++++---
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 352aaebf4198..ef8203d3ca45 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -61,6 +61,8 @@ extern char __kvm_hyp_vector[];
 
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
+extern void __kvm_tlb_flush_vmid_range(struct kvm *kvm, phys_addr_t start,
+				       phys_addr_t end);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
 extern void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index d063a576d511..4f4737a7e588 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -189,6 +189,42 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	__tlb_switch_to_host(kvm, &cxt);
 }
 
+void __hyp_text __kvm_tlb_flush_vmid_range(struct kvm *kvm, phys_addr_t start,
+					   phys_addr_t end)
+{
+	struct tlb_inv_context cxt;
+	unsigned long addr;
+
+	start = __TLBI_VADDR(start, 0);
+	end = __TLBI_VADDR(end, 0);
+
+	dsb(ishst);
+
+	/* Switch to requested VMID */
+	kvm = kern_hyp_va(kvm);
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	if ((end - start) >= 512 << (PAGE_SHIFT - 12)) {
+		__tlbi(vmalls12e1is);
+		goto end;
+	}
+
+	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
+		__tlbi(ipas2e1is, addr);
+
+	dsb(ish);
+	__tlbi(vmalle1is);
+
+end:
+	dsb(ish);
+	isb();
+
+	if (!has_vhe() && icache_is_vpipt())
+		__flush_icache_all();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
 void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
 	struct tlb_inv_context cxt;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8c0035cab6b6..bcc719c32921 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -63,6 +63,12 @@ static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
 }
 
+static void kvm_tlb_flush_vmid_range(struct kvm *kvm, phys_addr_t start,
+				     phys_addr_t end)
+{
+	kvm_call_hyp(__kvm_tlb_flush_vmid_range, kvm, start, end);
+}
+
 /*
  * D-Cache management functions. They take the page table entries by
  * value, as they are flushing the cache using the kernel mapping (or
@@ -267,7 +273,6 @@ static void unmap_stage2_ptes(struct kvm *kvm, pmd_t *pmd,
 			pte_t old_pte = *pte;
 
 			kvm_set_pte(pte, __pte(0));
-			kvm_tlb_flush_vmid_ipa(kvm, addr);
 
 			/* No need to invalidate the cache for device mappings */
 			if (!kvm_is_device_pfn(pte_pfn(old_pte)))
@@ -295,7 +300,6 @@ static void unmap_stage2_pmds(struct kvm *kvm, pud_t *pud,
 				pmd_t old_pmd = *pmd;
 
 				pmd_clear(pmd);
-				kvm_tlb_flush_vmid_ipa(kvm, addr);
 
 				kvm_flush_dcache_pmd(old_pmd);
 
@@ -324,7 +328,6 @@ static void unmap_stage2_puds(struct kvm *kvm, p4d_t *p4d,
 				pud_t old_pud = *pud;
 
 				stage2_pud_clear(kvm, pud);
-				kvm_tlb_flush_vmid_ipa(kvm, addr);
 				kvm_flush_dcache_pud(old_pud);
 				put_page(virt_to_page(pud));
 			} else {
@@ -352,6 +355,8 @@ static void unmap_stage2_p4ds(struct kvm *kvm, pgd_t *pgd,
 
 	if (stage2_p4d_table_empty(kvm, start_p4d))
 		clear_stage2_pgd_entry(kvm, pgd, start_addr);
+
+	kvm_tlb_flush_vmid_range(kvm, start_addr, end);
 }
 
 /**
-- 
2.19.1


