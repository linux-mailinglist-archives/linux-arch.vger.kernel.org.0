Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5896920415C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgFVUJW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:09:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:60226 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730682AbgFVUJV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 16:09:21 -0400
IronPort-SDR: 3EnXSUfEgqNDNNT2wlpbzhCgDE23fd5bsEKiL6iHQTbjwHTCuMuE0kLeERjOEMRdrZIs0/qEAU
 ntOXg8tNNZfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123527775"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123527775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:09:20 -0700
IronPort-SDR: 9lb1mb9mxEscX1saY63XsGU3TxhVtNqdLqqSQ07jAHGDKrnhMT3aPfWkptn9OL0ez6NoddQ0V9
 KhJIP5dw8KPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318877121"
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
Subject: [PATCH v2 17/21] KVM: arm64: Use common code's approach for __GFP_ZERO with memory caches
Date:   Mon, 22 Jun 2020 13:08:18 -0700
Message-Id: <20200622200822.4426-18-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
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
index 9398b66f8a87..688213ef34f0 100644
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
@@ -1342,7 +1343,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	phys_addr_t addr, end;
 	int ret = 0;
 	unsigned long pfn;
-	struct kvm_mmu_memory_cache cache = { 0, };
+	struct kvm_mmu_memory_cache cache = { 0, __GFP_ZERO, };
 
 	end = (guest_ipa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(pa);
-- 
2.26.0

