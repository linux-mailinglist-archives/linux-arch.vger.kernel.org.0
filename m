Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CA2131C5
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGCCiB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:38:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:52028 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgGCCgG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:06 -0400
IronPort-SDR: dLHdkoScc/SUNO/7Ij7gcozOvpgTy5KLJGHtPGU5M23ilncKoJFkGESLmCsmDlY97E/NJc/fbL
 7dga66vNlUCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145213961"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="145213961"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:05 -0700
IronPort-SDR: lq5xZUJFLbh93fPrxLG2HJCQFj4oIO5T+45h0TGZZxmJ+ksUWk2qwMwBdEwk9ZCIUVHF7gL3lU
 8NZduWuw+fAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295725"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:04 -0700
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
Subject: [PATCH v3 03/21] KVM: x86/mmu: Use consistent "mc" name for kvm_mmu_memory_cache locals
Date:   Thu,  2 Jul 2020 19:35:27 -0700
Message-Id: <20200703023545.8771-4-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use "mc" for local variables to shorten line lengths and provide
consistent names, which will be especially helpful when some of the
helpers are moved to common KVM code in future patches.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d6612af6c056..b6df4525e86c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1060,27 +1060,27 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 {
 	void *obj;
 
-	if (cache->nobjs >= min)
+	if (mc->nobjs >= min)
 		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		if (cache->kmem_cache)
-			obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
+	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
+		if (mc->kmem_cache)
+			obj = kmem_cache_zalloc(mc->kmem_cache, GFP_KERNEL_ACCOUNT);
 		else
 			obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!obj)
-			return cache->nobjs >= min ? 0 : -ENOMEM;
-		cache->objects[cache->nobjs++] = obj;
+			return mc->nobjs >= min ? 0 : -ENOMEM;
+		mc->objects[mc->nobjs++] = obj;
 	}
 	return 0;
 }
 
-static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
+static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *mc)
 {
-	return cache->nobjs;
+	return mc->nobjs;
 }
 
 static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
@@ -1395,10 +1395,10 @@ static struct kvm_rmap_head *gfn_to_rmap(struct kvm *kvm, gfn_t gfn,
 
 static bool rmap_can_add(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu_memory_cache *cache;
+	struct kvm_mmu_memory_cache *mc;
 
-	cache = &vcpu->arch.mmu_pte_list_desc_cache;
-	return mmu_memory_cache_free_objects(cache);
+	mc = &vcpu->arch.mmu_pte_list_desc_cache;
+	return mmu_memory_cache_free_objects(mc);
 }
 
 static int rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
-- 
2.26.0

