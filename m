Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA487640065
	for <lists+linux-arch@lfdr.de>; Fri,  2 Dec 2022 07:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiLBGUw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 01:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiLBGTp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 01:19:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D2DFB4B;
        Thu,  1 Dec 2022 22:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669961965; x=1701497965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kvt2bx+9z1hqybtj0u/XMjFK2xqSu46ePlTuyoBers4=;
  b=Cpm2TP7jYw/EoD0P5EO9A634aPmJErp8Z9p+rvqv2ualJr4rgw3TCyqb
   Ljvi50uO2AGzeKH7gxMTYbSOKVqzyl6pRddaXS7ABpvM8w6GhAI+Xt2xc
   nzgNY1GmIMCWEkWLQJsbqSiiVi6n3kXYlP9hvQF5kRuM6qoaIe6X1JmUF
   IyNgCxvv6BrpCYnoD9bw4ERmTAgmyJGG0Ow7591AQZ8PbXahFwbE+QiLX
   t/EmZWGxHOoMzNqN/8DkdJNanggtKXFT6XI/QsPjrVm22vLlN3kN8ZZ/J
   s+qdzdAmFDm1OxnrO455gkLwQhDd3W0ynheq+R0fhMBtqprnsOL96Rdw/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380170593"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="380170593"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733698707"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733698707"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Dec 2022 22:19:13 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: [PATCH v10 6/9] KVM: Unmap existing mappings when change the memory attributes
Date:   Fri,  2 Dec 2022 14:13:44 +0800
Message-Id: <20221202061347.1070246-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Unmap the existing guest mappings when memory attribute is changed
between shared and private. This is needed because shared pages and
private pages are from different backends, unmapping existing ones
gives a chance for page fault handler to re-populate the mappings
according to the new attribute.

Only architecture has private memory support needs this and the
supported architecture is expected to rewrite the weak
kvm_arch_has_private_mem().

Also, during memory attribute changing and the unmapping time frame,
page fault handler may happen in the same memory range and can cause
incorrect page state, invoke kvm_mmu_invalidate_* helpers to let the
page fault handler retry during this time frame.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/linux/kvm_host.h |   7 +-
 virt/kvm/kvm_main.c      | 168 ++++++++++++++++++++++++++-------------
 2 files changed, 116 insertions(+), 59 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3d69484d2704..3331c0c92838 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -255,7 +255,6 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
 
-#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
 struct kvm_gfn_range {
 	struct kvm_memory_slot *slot;
 	gfn_t start;
@@ -264,6 +263,8 @@ struct kvm_gfn_range {
 	bool may_block;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
+
+#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
@@ -785,11 +786,12 @@ struct kvm {
 
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 	struct mmu_notifier mmu_notifier;
+#endif
 	unsigned long mmu_invalidate_seq;
 	long mmu_invalidate_in_progress;
 	gfn_t mmu_invalidate_range_start;
 	gfn_t mmu_invalidate_range_end;
-#endif
+
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
@@ -1480,6 +1482,7 @@ bool kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int kvm_arch_post_init_vm(struct kvm *kvm);
 void kvm_arch_pre_destroy_vm(struct kvm *kvm);
 int kvm_arch_create_vm_debugfs(struct kvm *kvm);
+bool kvm_arch_has_private_mem(struct kvm *kvm);
 
 #ifndef __KVM_HAVE_ARCH_VM_ALLOC
 /*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ad55dfbc75d7..4e1e1e113bf0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -520,6 +520,62 @@ void kvm_destroy_vcpus(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_destroy_vcpus);
 
+void kvm_mmu_invalidate_begin(struct kvm *kvm)
+{
+	/*
+	 * The count increase must become visible at unlock time as no
+	 * spte can be established without taking the mmu_lock and
+	 * count is also read inside the mmu_lock critical section.
+	 */
+	kvm->mmu_invalidate_in_progress++;
+
+	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
+		kvm->mmu_invalidate_range_start = INVALID_GPA;
+		kvm->mmu_invalidate_range_end = INVALID_GPA;
+	}
+}
+
+void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
+
+	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
+		kvm->mmu_invalidate_range_start = start;
+		kvm->mmu_invalidate_range_end = end;
+	} else {
+		/*
+		 * Fully tracking multiple concurrent ranges has diminishing
+		 * returns. Keep things simple and just find the minimal range
+		 * which includes the current and new ranges. As there won't be
+		 * enough information to subtract a range after its invalidate
+		 * completes, any ranges invalidated concurrently will
+		 * accumulate and persist until all outstanding invalidates
+		 * complete.
+		 */
+		kvm->mmu_invalidate_range_start =
+			min(kvm->mmu_invalidate_range_start, start);
+		kvm->mmu_invalidate_range_end =
+			max(kvm->mmu_invalidate_range_end, end);
+	}
+}
+
+void kvm_mmu_invalidate_end(struct kvm *kvm)
+{
+	/*
+	 * This sequence increase will notify the kvm page fault that
+	 * the page that is going to be mapped in the spte could have
+	 * been freed.
+	 */
+	kvm->mmu_invalidate_seq++;
+	smp_wmb();
+	/*
+	 * The above sequence increase must be visible before the
+	 * below count decrease, which is ensured by the smp_wmb above
+	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
+	 */
+	kvm->mmu_invalidate_in_progress--;
+}
+
 #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
 static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
 {
@@ -714,45 +770,6 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
 }
 
-void kvm_mmu_invalidate_begin(struct kvm *kvm)
-{
-	/*
-	 * The count increase must become visible at unlock time as no
-	 * spte can be established without taking the mmu_lock and
-	 * count is also read inside the mmu_lock critical section.
-	 */
-	kvm->mmu_invalidate_in_progress++;
-
-	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
-		kvm->mmu_invalidate_range_start = INVALID_GPA;
-		kvm->mmu_invalidate_range_end = INVALID_GPA;
-	}
-}
-
-void kvm_mmu_invalidate_range_add(struct kvm *kvm, gfn_t start, gfn_t end)
-{
-	WARN_ON_ONCE(!kvm->mmu_invalidate_in_progress);
-
-	if (likely(kvm->mmu_invalidate_in_progress == 1)) {
-		kvm->mmu_invalidate_range_start = start;
-		kvm->mmu_invalidate_range_end = end;
-	} else {
-		/*
-		 * Fully tracking multiple concurrent ranges has diminishing
-		 * returns. Keep things simple and just find the minimal range
-		 * which includes the current and new ranges. As there won't be
-		 * enough information to subtract a range after its invalidate
-		 * completes, any ranges invalidated concurrently will
-		 * accumulate and persist until all outstanding invalidates
-		 * complete.
-		 */
-		kvm->mmu_invalidate_range_start =
-			min(kvm->mmu_invalidate_range_start, start);
-		kvm->mmu_invalidate_range_end =
-			max(kvm->mmu_invalidate_range_end, end);
-	}
-}
-
 static bool kvm_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
@@ -806,23 +823,6 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	return 0;
 }
 
-void kvm_mmu_invalidate_end(struct kvm *kvm)
-{
-	/*
-	 * This sequence increase will notify the kvm page fault that
-	 * the page that is going to be mapped in the spte could have
-	 * been freed.
-	 */
-	kvm->mmu_invalidate_seq++;
-	smp_wmb();
-	/*
-	 * The above sequence increase must be visible before the
-	 * below count decrease, which is ensured by the smp_wmb above
-	 * in conjunction with the smp_rmb in mmu_invalidate_retry().
-	 */
-	kvm->mmu_invalidate_in_progress--;
-}
-
 static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 					const struct mmu_notifier_range *range)
 {
@@ -1140,6 +1140,11 @@ int __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
 	return 0;
 }
 
+bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
+{
+	return false;
+}
+
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 {
 	struct kvm *kvm = kvm_arch_alloc_vm();
@@ -2349,15 +2354,47 @@ static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 	return 0;
 }
 
+static void kvm_unmap_mem_range(struct kvm *kvm, gfn_t start, gfn_t end)
+{
+	struct kvm_gfn_range gfn_range;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	struct kvm_memslot_iter iter;
+	int i;
+	int r = 0;
+
+	gfn_range.pte = __pte(0);
+	gfn_range.may_block = true;
+
+	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
+			slot = iter.slot;
+			gfn_range.start = max(start, slot->base_gfn);
+			gfn_range.end = min(end, slot->base_gfn + slot->npages);
+			if (gfn_range.start >= gfn_range.end)
+				continue;
+			gfn_range.slot = slot;
+
+			r |= kvm_unmap_gfn_range(kvm, &gfn_range);
+		}
+	}
+
+	if (r)
+		kvm_flush_remote_tlbs(kvm);
+}
+
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 					   struct kvm_memory_attributes *attrs)
 {
 	gfn_t start, end;
 	unsigned long i;
 	void *entry;
+	int idx;
 	u64 supported_attrs = kvm_supported_mem_attributes(kvm);
 
-	/* flags is currently not used. */
+	/* 'flags' is currently not used. */
 	if (attrs->flags)
 		return -EINVAL;
 	if (attrs->attributes & ~supported_attrs)
@@ -2372,6 +2409,13 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 
 	entry = attrs->attributes ? xa_mk_value(attrs->attributes) : NULL;
 
+	if (kvm_arch_has_private_mem(kvm)) {
+		KVM_MMU_LOCK(kvm);
+		kvm_mmu_invalidate_begin(kvm);
+		kvm_mmu_invalidate_range_add(kvm, start, end);
+		KVM_MMU_UNLOCK(kvm);
+	}
+
 	mutex_lock(&kvm->lock);
 	for (i = start; i < end; i++)
 		if (xa_err(xa_store(&kvm->mem_attr_array, i, entry,
@@ -2379,6 +2423,16 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 			break;
 	mutex_unlock(&kvm->lock);
 
+	if (kvm_arch_has_private_mem(kvm)) {
+		idx = srcu_read_lock(&kvm->srcu);
+		KVM_MMU_LOCK(kvm);
+		if (i > start)
+			kvm_unmap_mem_range(kvm, start, i);
+		kvm_mmu_invalidate_end(kvm);
+		KVM_MMU_UNLOCK(kvm);
+		srcu_read_unlock(&kvm->srcu, idx);
+	}
+
 	attrs->address = i << PAGE_SHIFT;
 	attrs->size = (end - i) << PAGE_SHIFT;
 
-- 
2.25.1

