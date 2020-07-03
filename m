Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295021317F
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGCCgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:36:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:3199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgGCCgP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:15 -0400
IronPort-SDR: /gB6s91+gCWf9n1C5WQtfk7CDXHwLFX43hOsKChMkyIaP3ebBFo+/uMIKukOGqWHoVhqBhPB5r
 PgJEaEKPHPpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148599917"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148599917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:06 -0700
IronPort-SDR: gc+V4jelwd6cdgDX/gNAN+SSR2GE6Zg27AtHAEY7cnfQ0WEuRH0dbo014d86x55dkDeDQ0CoOi
 ASJavvqq280g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295778"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:06 -0700
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
Subject: [PATCH v3 17/21] KVM: arm64: Use common code's approach for __GFP_ZERO with memory caches
Date:   Thu,  2 Jul 2020 19:35:41 -0700
Message-Id: <20200703023545.8771-18-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a "gfp_zero" member to arm64's 'struct kvm_mmu_memory_cache' to make
the struct and its usage compatible with the common 'struct
kvm_mmu_memory_cache' in linux/kvm_host.h.  This will minimize code
churn when arm64 moves to the common implementation in a future patch, at
the cost of temporarily having somewhat silly code.

Note, GFP_PGTABLE_USER is equivalent to GFP_KERNEL_ACCOUNT | GFP_ZERO:

  #define GFP_PGTABLE_USER  (GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
  |
  -> #define GFP_PGTABLE_KERNEL        (GFP_KERNEL | __GFP_ZERO)

  == GFP_KERNEL | __GFP_ACCOUNT | __GFP_ZERO

versus

  #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)

    with __GFP_ZERO explicitly OR'd in

  == GFP_KERNEL | __GFP_ACCOUNT | __GFP_ZERO

No functional change intended.

Tested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 arch/arm64/kvm/arm.c              | 2 ++
 arch/arm64/kvm/mmu.c              | 5 +++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c3e6fcc664b1..335170b59899 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -105,6 +105,7 @@ struct kvm_arch {
  */
 struct kvm_mmu_memory_cache {
 	int nobjs;
+	gfp_t gfp_zero;
 	void *objects[KVM_NR_MEM_OBJS];
 };
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 90cb90561446..1016635b3782 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -270,6 +270,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.target = -1;
 	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);
 
+	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
+
 	/* Set up the timer */
 	kvm_timer_vcpu_init(vcpu);
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index f78aa3e269e9..5220623a4efb 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -131,7 +131,8 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_PGTABLE_USER);
+		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT |
+					       cache->gfp_zero);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
@@ -1467,7 +1468,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	phys_addr_t addr, end;
 	int ret = 0;
 	unsigned long pfn;
-	struct kvm_mmu_memory_cache cache = { 0, };
+	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, };
 
 	end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(pa);
-- 
2.26.0

