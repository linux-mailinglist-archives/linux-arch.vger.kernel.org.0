Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D5204160
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgFVUJb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:09:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:60223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgFVUJ1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 16:09:27 -0400
IronPort-SDR: iI4A0e5rAWHJ25MXUqEnZAVvNupTBZA8NsYdkojiySycLja43bwRycOZqXxL/dJi/FN/FZobMy
 EcX6FPHj1wTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123527792"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123527792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:09:24 -0700
IronPort-SDR: S0AGKdxaV2/u+N+F3lumX5TRjKNFIoPRxUgSeSIzcKckYitlAsdbJF0VyW/tYg1r44XXN6fKSC
 wZHJ3ehoWXkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318877138"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 13:09:23 -0700
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
Subject: [PATCH v2 21/21] KVM: MIPS: Use common KVM implementation of MMU memory caches
Date:   Mon, 22 Jun 2020 13:08:22 -0700
Message-Id: <20200622200822.4426-22-sean.j.christopherson@intel.com>
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
code and MIPS's existing code are semantically compatible.

No functional change intended.

Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/include/asm/Kbuild      |  1 -
 arch/mips/include/asm/kvm_host.h  | 11 ---------
 arch/mips/include/asm/kvm_types.h |  7 ++++++
 arch/mips/kvm/mmu.c               | 40 ++++---------------------------
 4 files changed, 12 insertions(+), 47 deletions(-)
 create mode 100644 arch/mips/include/asm/kvm_types.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 397e6d24d2ab..8643d313890e 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -5,7 +5,6 @@ generated-y += syscall_table_64_n32.h
 generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
 generic-y += export.h
-generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 363e7a89d173..f49617175f60 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -335,17 +335,6 @@ struct kvm_mips_tlb {
 	long tlb_lo[2];
 };
 
-#define KVM_NR_MEM_OBJS     4
-
-/*
- * We don't want allocation failures within the mmu code, so we preallocate
- * enough memory for a single page fault in a cache.
- */
-struct kvm_mmu_memory_cache {
-	int nobjs;
-	void *objects[KVM_NR_MEM_OBJS];
-};
-
 #define KVM_MIPS_AUX_FPU	0x1
 #define KVM_MIPS_AUX_MSA	0x2
 
diff --git a/arch/mips/include/asm/kvm_types.h b/arch/mips/include/asm/kvm_types.h
new file mode 100644
index 000000000000..213754d9ef6b
--- /dev/null
+++ b/arch/mips/include/asm/kvm_types.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_MIPS_KVM_TYPES_H
+#define _ASM_MIPS_KVM_TYPES_H
+
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE     4
+
+#endif /* _ASM_MIPS_KVM_TYPES_H */
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 41a4a063a730..d6acd88c0c46 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -25,39 +25,9 @@
 #define KVM_MMU_CACHE_MIN_PAGES 2
 #endif
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
-{
-	void *page;
-
-	if (cache->nobjs >= min)
-		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
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
 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
-	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 }
 
 /**
@@ -151,7 +121,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 
 		if (!cache)
 			return NULL;
-		new_pmd = mmu_memory_cache_alloc(cache);
+		new_pmd = kvm_mmu_memory_cache_alloc(cache);
 		pmd_init((unsigned long)new_pmd,
 			 (unsigned long)invalid_pte_table);
 		pud_populate(NULL, pud, new_pmd);
@@ -162,7 +132,7 @@ static pte_t *kvm_mips_walk_pgd(pgd_t *pgd, struct kvm_mmu_memory_cache *cache,
 
 		if (!cache)
 			return NULL;
-		new_pte = mmu_memory_cache_alloc(cache);
+		new_pte = kvm_mmu_memory_cache_alloc(cache);
 		clear_page(new_pte);
 		pmd_populate_kernel(NULL, pmd, new_pte);
 	}
@@ -709,7 +679,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 		goto out;
 
 	/* We need a minimum of cached pages ready for page table creation */
-	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
+	err = kvm_mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
 	if (err)
 		goto out;
 
@@ -793,7 +763,7 @@ static pte_t *kvm_trap_emul_pte_for_gva(struct kvm_vcpu *vcpu,
 	int ret;
 
 	/* We need a minimum of cached pages ready for page table creation */
-	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
+	ret = kvm_mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
 	if (ret)
 		return NULL;
 
-- 
2.26.0

