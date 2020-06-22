Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D8204184
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgFVUKn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:10:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:60195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbgFVUJR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jun 2020 16:09:17 -0400
IronPort-SDR: 39yNN25wFhGSKA8GCLiQbF9atlS9+P5ro7dpG57F7ll1xQe+lghR7+Bp8s3Q7hIeNvXCfYNjPf
 fGAJ9r3s5j5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123527755"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123527755"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 13:09:16 -0700
IronPort-SDR: Y4mN49RL3/bOGPxDXXvL4A7Bdez2DcpeOt1FfbrWwwtuYdLxL80S+C02W0LXXaJRtK4x6m99Gr
 MiwZAjctZGZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="318877097"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2020 13:09:16 -0700
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
Subject: [PATCH v2 12/21] KVM: x86/mmu: Skip filling the gfn cache for guaranteed direct MMU topups
Date:   Mon, 22 Jun 2020 13:08:13 -0700
Message-Id: <20200622200822.4426-13-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Don't bother filling the gfn array cache when the caller is a fully
direct MMU, i.e. won't need a gfn array for shadow pages.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 18 ++++++++++--------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a8f8eebf67df..8d66cf558f1b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1101,7 +1101,7 @@ static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
 	}
 }
 
-static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
+static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 {
 	int r;
 
@@ -1114,10 +1114,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 				   PT64_ROOT_MAX_LEVEL);
 	if (r)
 		return r;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
-				   PT64_ROOT_MAX_LEVEL);
-	if (r)
-		return r;
+	if (maybe_indirect) {
+		r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
+					   PT64_ROOT_MAX_LEVEL);
+		if (r)
+			return r;
+	}
 	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
 				      PT64_ROOT_MAX_LEVEL);
 }
@@ -4107,7 +4109,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (fast_page_fault(vcpu, gpa, error_code))
 		return RET_PF_RETRY;
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, false);
 	if (r)
 		return r;
 
@@ -5147,7 +5149,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 {
 	int r;
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
 	if (r)
 		goto out;
 	r = mmu_alloc_roots(vcpu);
@@ -5341,7 +5343,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 	 * or not since pte prefetch is skiped if it does not have
 	 * enough objects in the cache.
 	 */
-	mmu_topup_memory_caches(vcpu);
+	mmu_topup_memory_caches(vcpu, true);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 3de32122f601..ac39710d0594 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -818,7 +818,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 		return RET_PF_EMULATE;
 	}
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, true);
 	if (r)
 		return r;
 
@@ -905,7 +905,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 	 * No need to check return value here, rmap_can_add() can
 	 * help us to skip pte prefetch later.
 	 */
-	mmu_topup_memory_caches(vcpu);
+	mmu_topup_memory_caches(vcpu, true);
 
 	if (!VALID_PAGE(root_hpa)) {
 		WARN_ON(1);
-- 
2.26.0

