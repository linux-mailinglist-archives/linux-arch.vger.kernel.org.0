Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464D0213181
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 04:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGCCgc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 22:36:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:3196 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgGCCgO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:14 -0400
IronPort-SDR: KRJqDCC14ncIq41VYUZJHZpE381441AIXxkSq1U++7pJqKofC97vT5Lsq6voCIiZpJAlQJZVoI
 xaZ80k8ZZ+VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148599915"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="148599915"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 19:36:06 -0700
IronPort-SDR: 2tOPUByFntiw9s9LcXMs6Npl8r/77cSlUMJ7bBm6OtNmIqDlUjGwLFS+5mJWSCQdwDWpgyJyQ3
 eZ/RN8+Rm/Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; 
   d="scan'208";a="278295766"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 19:36:05 -0700
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
Subject: [PATCH v3 15/21] KVM: Move x86's MMU memory cache helpers to common KVM code
Date:   Thu,  2 Jul 2020 19:35:39 -0700
Message-Id: <20200703023545.8771-16-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move x86's memory cache helpers to common KVM code so that they can be
reused by arm64 and MIPS in future patches.

Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c   | 53 --------------------------------------
 include/linux/kvm_host.h |  7 +++++
 virt/kvm/kvm_main.c      | 55 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4c8dae476bb..5b7782d92faf 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1060,47 +1060,6 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
-static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
-					       gfp_t gfp_flags)
-{
-	gfp_flags |= mc->gfp_zero;
-
-	if (mc->kmem_cache)
-		return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
-	else
-		return (void *)__get_free_page(gfp_flags);
-}
-
-static int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
-{
-	void *obj;
-
-	if (mc->nobjs >= min)
-		return 0;
-	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
-		obj = mmu_memory_cache_alloc_obj(mc, GFP_KERNEL_ACCOUNT);
-		if (!obj)
-			return mc->nobjs >= min ? 0 : -ENOMEM;
-		mc->objects[mc->nobjs++] = obj;
-	}
-	return 0;
-}
-
-static int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc)
-{
-	return mc->nobjs;
-}
-
-static void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
-{
-	while (mc->nobjs) {
-		if (mc->kmem_cache)
-			kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
-		else
-			free_page((unsigned long)mc->objects[--mc->nobjs]);
-	}
-}
-
 static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 {
 	int r;
@@ -1132,18 +1091,6 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
-static void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
-{
-	void *p;
-
-	if (WARN_ON(!mc->nobjs))
-		p = mmu_memory_cache_alloc_obj(mc, GFP_ATOMIC | __GFP_ACCOUNT);
-	else
-		p = mc->objects[--mc->nobjs];
-	BUG_ON(!p);
-	return p;
-}
-
 static struct pte_list_desc *mmu_alloc_pte_list_desc(struct kvm_vcpu *vcpu)
 {
 	return kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_pte_list_desc_cache);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9edc6fc71a89..283df0fed4a8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -816,6 +816,13 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool usermode_vcpu_not_eligible);
 void kvm_flush_remote_tlbs(struct kvm *kvm);
 void kvm_reload_remote_mmus(struct kvm *kvm);
 
+#ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
+int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min);
+int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc);
+void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc);
+void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
+#endif
+
 bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
 				 struct kvm_vcpu *except,
 				 unsigned long *vcpu_bitmap, cpumask_var_t tmp);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a852af5c3214..e70d75de185d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -340,6 +340,61 @@ void kvm_reload_remote_mmus(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
 }
 
+#ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
+static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
+					       gfp_t gfp_flags)
+{
+	gfp_flags |= mc->gfp_zero;
+
+	if (mc->kmem_cache)
+		return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
+	else
+		return (void *)__get_free_page(gfp_flags);
+}
+
+int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
+{
+	void *obj;
+
+	if (mc->nobjs >= min)
+		return 0;
+	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
+		obj = mmu_memory_cache_alloc_obj(mc, GFP_KERNEL_ACCOUNT);
+		if (!obj)
+			return mc->nobjs >= min ? 0 : -ENOMEM;
+		mc->objects[mc->nobjs++] = obj;
+	}
+	return 0;
+}
+
+int kvm_mmu_memory_cache_nr_free_objects(struct kvm_mmu_memory_cache *mc)
+{
+	return mc->nobjs;
+}
+
+void kvm_mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
+{
+	while (mc->nobjs) {
+		if (mc->kmem_cache)
+			kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
+		else
+			free_page((unsigned long)mc->objects[--mc->nobjs]);
+	}
+}
+
+void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
+{
+	void *p;
+
+	if (WARN_ON(!mc->nobjs))
+		p = mmu_memory_cache_alloc_obj(mc, GFP_ATOMIC | __GFP_ACCOUNT);
+	else
+		p = mc->objects[--mc->nobjs];
+	BUG_ON(!p);
+	return p;
+}
+#endif
+
 static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 {
 	mutex_init(&vcpu->mutex);
-- 
2.26.0

