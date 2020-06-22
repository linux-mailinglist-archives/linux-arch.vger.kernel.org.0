Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5E20416C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgFVUJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:09:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:60223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbgFVUJW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 16:09:22 -0400
IronPort-SDR: 7q7dVraJ6yGCgDTE6BNC4MRrj0QM55S9W7w3ONCUNSDdXnyTxY9ze7Yv0j8D4iNaj27TzBwx0g
 Sjv2j7fQdyJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123527779"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123527779"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:09:21 -0700
IronPort-SDR: PmC9bN/CGwbZKqqRnUn03eoTbIgvRwgTSH3bhvh/g1q9xhtpw4Px370KcZ7lLDnJR8LHe1izVy
 gHeMuvDHq6gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318877126"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 13:09:20 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH v2 18/21] KVM: arm64: Use common KVM implementation of MMU memory caches
Date:   Mon, 22 Jun 2020 13:08:19 -0700
Message-Id: <20200622200822.4426-19-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move to the common MMU memory cache implementation now that the common
code and arm64's existing code are semantically compatible.

No functional change intended.

Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Tested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/arm64/include/asm/Kbuild      |  1 -
 arch/arm64/include/asm/kvm_host.h  | 12 -------
 arch/arm64/include/asm/kvm_types.h |  8 +++++
 arch/arm64/kvm/mmu.c               | 51 ++++++------------------------
 4 files changed, 18 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_types.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 35a68155cd0e..ff9cbb631212 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += early_ioremap.h
-generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 335170b59899..23d1f41548f5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -97,18 +97,6 @@ struct kvm_arch {
 	bool return_nisv_io_abort_to_user;
 };
 
-#define KVM_NR_MEM_OBJS     40
-
-/*
- * We don't want allocation failures within the mmu code, so we preallocate
- * enough memory for a single page fault in a cache.
- */
-struct kvm_mmu_memory_cache {
-	int nobjs;
-	gfp_t gfp_zero;
-	void *objects[KVM_NR_MEM_OBJS];
-};
-
 struct kvm_vcpu_fault_info {
 	u32 esr_el2;		/* Hyp Syndrom Register */
 	u64 far_el2;		/* Hyp Fault Address Register */
diff --git a/arch/arm64/include/asm/kvm_types.h b/arch/arm64/include/asm/kvm_types.h
new file mode 100644
index 000000000000..9a126b9e2d7c
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_types.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_KVM_TYPES_H
+#define _ASM_ARM64_KVM_TYPES_H
+
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
+
+#endif /* _ASM_ARM64_KVM_TYPES_H */
+
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 688213ef34f0..976405e2fbb2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -124,37 +124,6 @@ static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
 	put_page(virt_to_page(pudp));
 }
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
-{
-	void *page;
-
-	if (cache->nobjs >= min)
-		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT |
-					       cache->gfp_zero);
-		if (!page)
-			return -ENOMEM;
-		cache->objects[cache->nobjs++] = page;
-	}
-	return 0;
-}
-
-static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
-{
-	while (mc->nobjs)
-		free_page((unsigned long)mc->objects[--mc->nobjs]);
-}
-
-static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
-{
-	void *p;
-
-	BUG_ON(!mc || !mc->nobjs);
-	p = mc->objects[--mc->nobjs];
-	return p;
-}
-
 static void clear_stage2_pgd_entry(struct kvm *kvm, pgd_t *pgd, phys_addr_t addr)
 {
 	pud_t *pud_table __maybe_unused = stage2_pud_offset(kvm, pgd, 0UL);
@@ -1024,7 +993,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	if (stage2_pgd_none(kvm, *pgd)) {
 		if (!cache)
 			return NULL;
-		pud = mmu_memory_cache_alloc(cache);
+		pud = kvm_mmu_memory_cache_alloc(cache);
 		stage2_pgd_populate(kvm, pgd, pud);
 		get_page(virt_to_page(pgd));
 	}
@@ -1045,7 +1014,7 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 	if (stage2_pud_none(kvm, *pud)) {
 		if (!cache)
 			return NULL;
-		pmd = mmu_memory_cache_alloc(cache);
+		pmd = kvm_mmu_memory_cache_alloc(cache);
 		stage2_pud_populate(kvm, pud, pmd);
 		get_page(virt_to_page(pud));
 	}
@@ -1251,7 +1220,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	if (stage2_pud_none(kvm, *pud)) {
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
-		pmd = mmu_memory_cache_alloc(cache);
+		pmd = kvm_mmu_memory_cache_alloc(cache);
 		stage2_pud_populate(kvm, pud, pmd);
 		get_page(virt_to_page(pud));
 	}
@@ -1276,7 +1245,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 	if (pmd_none(*pmd)) {
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
-		pte = mmu_memory_cache_alloc(cache);
+		pte = kvm_mmu_memory_cache_alloc(cache);
 		kvm_pmd_populate(pmd, pte);
 		get_page(virt_to_page(pmd));
 	}
@@ -1343,7 +1312,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	phys_addr_t addr, end;
 	int ret = 0;
 	unsigned long pfn;
-	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, };
+	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, NULL, };
 
 	end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(pa);
@@ -1354,8 +1323,8 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 		if (writable)
 			pte = kvm_s2pte_mkwrite(pte);
 
-		ret = mmu_topup_memory_cache(&cache,
-					     kvm_mmu_cache_min_pages(kvm));
+		ret = kvm_mmu_topup_memory_cache(&cache,
+						 kvm_mmu_cache_min_pages(kvm));
 		if (ret)
 			goto out;
 		spin_lock(&kvm->mmu_lock);
@@ -1369,7 +1338,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	}
 
 out:
-	mmu_free_memory_cache(&cache);
+	kvm_mmu_free_memory_cache(&cache);
 	return ret;
 }
 
@@ -1735,7 +1704,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	up_read(&current->mm->mmap_sem);
 
 	/* We need minimum second+third level pages */
-	ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm));
+	ret = kvm_mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm));
 	if (ret)
 		return ret;
 
@@ -2158,7 +2127,7 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva)
 
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
-	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 }
 
 phys_addr_t kvm_mmu_get_httbr(void)
-- 
2.26.0

