Return-Path: <linux-arch+bounces-4781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C209016DF
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7560283129
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268446B91;
	Sun,  9 Jun 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rUs3BmRd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3D46557;
	Sun,  9 Jun 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948747; cv=none; b=ntk+dMz42+GkcPEX2JxEljKfv94j/fD8TI9Qt2+hCh8u0bjTLVnWAA93jpjgTM50tdpspvfs73pUkUJhjLES5f88uzPKsmdVsUbWdXe8iJOlRW89c2eCfWbzdht+HY69UyTWIyiy0HJKyaVy+PMm3RgcVxjMFQvH+y2DvFEbcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948747; c=relaxed/simple;
	bh=PRJrKhkvJDOLYcJ7SIYsi0T/NexcKWckwbmRKbCxesM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a67HSLVcnKjoHSVfZOlKYbtfoXHJNi5LALvnOYRvd8EMv8V24SAucdduLvzsYDl2dj7ou3zLYZ3v09IcvjqHNldIL/WsWbSct4DfdR/RrmoHojnMn+edph/eJsSzxAINhZNDC84rIbiEOP01SxR8ByVavzw84ZRQbaqaBeHbAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rUs3BmRd; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948746; x=1749484746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sR7xZHT3V8+jXkTU2bSicpBsqXv2xchKR7pQb26nxwM=;
  b=rUs3BmRduiP4bzYo3ldeRYgMkLe4cDxoRwUDkq7JmSbHlEG6SEiKOZX9
   HOZ++wmNEN7DISLr8cwtzqyh3C9bJTRz+t/q9KDbgZS9PqBazJvqn6nfG
   NQ/RcNVr4bSltIOzQ9RnzCDrKqFo316sX1rWEIx+EPIkyMVoOJNiG2VRw
   M=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="638289400"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:58:48 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:13872]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.168:2525] with esmtp (Farcaster)
 id 4fae357d-b286-44dc-8b59-813505dfb82d; Sun, 9 Jun 2024 15:58:45 +0000 (UTC)
X-Farcaster-Flow-ID: 4fae357d-b286-44dc-8b59-813505dfb82d
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:58:42 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:58:36 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw2@infradead.org>, <paul@amazon.com>,
	<nsaenz@amazon.com>, <mlevitsk@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <decui@microsoft.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <amoorthy@google.com>
Subject: [PATCH 16/18] KVM: x86: Take mem attributes into account when faulting memory
Date: Sun, 9 Jun 2024 15:49:45 +0000
Message-ID: <20240609154945.55332-17-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240609154945.55332-1-nsaenz@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Take into account access restrictions memory attributes when faulting
guest memory. Prohibited memory accesses will cause an user-space fault
exit.

Additionally, bypass a warning in the !tdp case. Access restrictions in
guest page tables might not necessarily match the host pte's when memory
attributes are in use.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c         | 64 ++++++++++++++++++++++++++++------
 arch/x86/kvm/mmu/mmutrace.h    | 29 +++++++++++++++
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 include/linux/kvm_host.h       |  4 +++
 4 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 91edd873dcdbc..dfe50c9c31f7b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -754,7 +754,8 @@ static u32 kvm_mmu_page_get_access(struct kvm_mmu_page *sp, int index)
 	return sp->role.access;
 }
 
-static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
+static void kvm_mmu_page_set_translation(struct kvm *kvm,
+					 struct kvm_mmu_page *sp, int index,
 					 gfn_t gfn, unsigned int access)
 {
 	if (sp_has_gptes(sp)) {
@@ -762,10 +763,17 @@ static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
 		return;
 	}
 
-	WARN_ONCE(access != kvm_mmu_page_get_access(sp, index),
-	          "access mismatch under %s page %llx (expected %u, got %u)\n",
-	          sp->role.passthrough ? "passthrough" : "direct",
-	          sp->gfn, kvm_mmu_page_get_access(sp, index), access);
+	/*
+	 * Userspace might have introduced memory attributes for this gfn,
+	 * breaking the assumption that the spte's access restrictions match
+	 * the guest's. Userspace is also responsible from taking care of
+	 * faults caused by these 'artificial' access restrictions.
+	 */
+	WARN_ONCE(access != kvm_mmu_page_get_access(sp, index) &&
+		  !kvm_get_memory_attributes(kvm, gfn),
+		  "access mismatch under %s page %llx (expected %u, got %u)\n",
+		  sp->role.passthrough ? "passthrough" : "direct", sp->gfn,
+		  kvm_mmu_page_get_access(sp, index), access);
 
 	WARN_ONCE(gfn != kvm_mmu_page_get_gfn(sp, index),
 	          "gfn mismatch under %s page %llx (expected %llx, got %llx)\n",
@@ -773,12 +781,12 @@ static void kvm_mmu_page_set_translation(struct kvm_mmu_page *sp, int index,
 	          sp->gfn, kvm_mmu_page_get_gfn(sp, index), gfn);
 }
 
-static void kvm_mmu_page_set_access(struct kvm_mmu_page *sp, int index,
-				    unsigned int access)
+static void kvm_mmu_page_set_access(struct kvm *kvm, struct kvm_mmu_page *sp,
+				    int index, unsigned int access)
 {
 	gfn_t gfn = kvm_mmu_page_get_gfn(sp, index);
 
-	kvm_mmu_page_set_translation(sp, index, gfn, access);
+	kvm_mmu_page_set_translation(kvm, sp, index, gfn, access);
 }
 
 /*
@@ -1607,7 +1615,7 @@ static void __rmap_add(struct kvm *kvm,
 	int rmap_count;
 
 	sp = sptep_to_sp(spte);
-	kvm_mmu_page_set_translation(sp, spte_index(spte), gfn, access);
+	kvm_mmu_page_set_translation(kvm, sp, spte_index(spte), gfn, access);
 	kvm_update_page_stats(kvm, sp->role.level, 1);
 
 	rmap_head = gfn_to_rmap(gfn, sp->role.level, slot);
@@ -2928,7 +2936,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 		rmap_add(vcpu, slot, sptep, gfn, pte_access);
 	} else {
 		/* Already rmapped but the pte_access bits may have changed. */
-		kvm_mmu_page_set_access(sp, spte_index(sptep), pte_access);
+		kvm_mmu_page_set_access(vcpu->kvm, sp, spte_index(sptep),
+					pte_access);
 	}
 
 	return ret;
@@ -4320,6 +4329,38 @@ static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
 	return RET_PF_CONTINUE;
 }
 
+static int kvm_mem_attributes_faultin_access_prots(struct kvm_vcpu *vcpu,
+						   struct kvm_page_fault *fault)
+{
+	bool may_read, may_write, may_exec;
+	unsigned long attrs;
+
+	attrs = kvm_get_memory_attributes(vcpu->kvm, fault->gfn);
+	if (!attrs)
+		return RET_PF_CONTINUE;
+
+	if (!kvm_mem_attributes_valid(vcpu->kvm, attrs)) {
+		kvm_err("Invalid mem attributes 0x%lx found for address 0x%016llx\n",
+			attrs, fault->addr);
+		return -EFAULT;
+	}
+
+	trace_kvm_mem_attributes_faultin_access_prots(vcpu, fault, attrs);
+
+	may_read = kvm_mem_attributes_may_read(attrs);
+	may_write = kvm_mem_attributes_may_write(attrs);
+	may_exec = kvm_mem_attributes_may_exec(attrs);
+
+	if ((fault->user && !may_read) || (fault->write && !may_write) ||
+	    (fault->exec && !may_exec))
+		return -EFAULT;
+
+	fault->map_writable = may_write;
+	fault->map_executable = may_exec;
+
+	return RET_PF_CONTINUE;
+}
+
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	bool async;
@@ -4375,7 +4416,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	 * Now that we have a snapshot of mmu_invalidate_seq we can check for a
 	 * private vs. shared mismatch.
 	 */
-	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
+	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn) ||
+	    kvm_mem_attributes_faultin_access_prots(vcpu, fault)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
 		return -EFAULT;
 	}
diff --git a/arch/x86/kvm/mmu/mmutrace.h b/arch/x86/kvm/mmu/mmutrace.h
index 195d98bc8de85..ddbdd7396e9fa 100644
--- a/arch/x86/kvm/mmu/mmutrace.h
+++ b/arch/x86/kvm/mmu/mmutrace.h
@@ -440,6 +440,35 @@ TRACE_EVENT(
 		  __entry->gfn, __entry->spte, __entry->level, __entry->errno)
 );
 
+TRACE_EVENT(kvm_mem_attributes_faultin_access_prots,
+	TP_PROTO(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
+		 u64 mem_attrs),
+	TP_ARGS(vcpu, fault, mem_attrs),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, vcpu_id)
+		__field(unsigned long, guest_rip)
+		__field(u64, fault_address)
+		__field(bool, write)
+		__field(bool, exec)
+		__field(u64, mem_attrs)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id = vcpu->vcpu_id;
+		__entry->guest_rip = kvm_rip_read(vcpu);
+		__entry->fault_address = fault->addr;
+		__entry->write = fault->write;
+		__entry->exec = fault->exec;
+		__entry->mem_attrs = mem_attrs;
+	),
+
+	TP_printk("vcpu %d rip 0x%lx gfn 0x%016llx access %s mem_attrs 0x%llx",
+		  __entry->vcpu_id, __entry->guest_rip, __entry->fault_address,
+		  __entry->exec ? "X" : (__entry->write ? "W" : "R"),
+		  __entry->mem_attrs)
+);
+
 #endif /* _TRACE_KVMMMU_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d3dbcf382ed2d..166f5f0e885e0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -954,7 +954,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 		return 0;
 
 	/* Update the shadowed access bits in case they changed. */
-	kvm_mmu_page_set_access(sp, i, pte_access);
+	kvm_mmu_page_set_access(vcpu->kvm, sp, i, pte_access);
 
 	sptep = &sp->spt[i];
 	spte = *sptep;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 85378345e8e77..9c26161d13dea 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2463,6 +2463,10 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
+static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return 0;
+}
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEM
-- 
2.40.1


