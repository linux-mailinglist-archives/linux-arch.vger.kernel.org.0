Return-Path: <linux-arch+bounces-4777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7363F9016CC
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747491C20FAD
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70C4655F;
	Sun,  9 Jun 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PjaEdDgN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F446522;
	Sun,  9 Jun 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948626; cv=none; b=nZ4Ytuylu36DXu5zO9Mt1W5ygDqcLfJ+YC5CtlpPKzFn3UW0xLNG4k1yX9l8P+9Mlu0ugK6uPzm0jKJ7ipGMFa8nnkPJkDAPtNi35xDPO/1LcwgTv7DfDZ1EOTx6GHXBm/4HVwWhM9w1W+RhVCAPUZID3S2WBTxla88tHKqameI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948626; c=relaxed/simple;
	bh=vepqPlzQj204UkjPtHtl8uZ7TaVJFhx2ifbXgltVjjs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lej2X/2BRphypIs0jRwW/CF31DWip9SXV7/GG6mNkqlxkUpdY4HzRs55S2Tuo6N1/jpkdhwsNZbc0qUwK9xTdqcKcHveFpFo+mQPnMer5BrHxW1du8d+rvb8RnOxQGWJrDDpDsjqX5r2l9ESfJnNtdY4IDn6Lih0gNbKcT9psnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PjaEdDgN; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948624; x=1749484624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svtivqIKM5jIa+6jjwD2ez7xIbQu16Sv0pYWZNeRRHo=;
  b=PjaEdDgNKuqf5rNQMeyLRI7Afb9Gf0lzKIz90wexHKjU/e6ygJ5ckoG4
   4YHj6HKnCoovT9DXHMp0+z6+Q/QAvlt7j55sVO+h+d7jd1ZEHFzbAuWXi
   buDDPp4s7CsZMemTImKLEeLuiPNT8J+Y/ZC/1bydizgYhWphBpVoGM0qh
   k=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="210678007"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:57:03 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:62225]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.14.23:2525] with esmtp (Farcaster)
 id dfe34c22-171a-4682-9b85-d6989c6f0cab; Sun, 9 Jun 2024 15:57:02 +0000 (UTC)
X-Farcaster-Flow-ID: dfe34c22-171a-4682-9b85-d6989c6f0cab
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:57:02 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:56:55 +0000
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
Subject: [PATCH 12/18] KVM: x86/mmu: Introduce infrastructure to handle non-executable mappings
Date: Sun, 9 Jun 2024 15:49:41 +0000
Message-ID: <20240609154945.55332-13-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

The upcoming access restriction KVM memory attributes open the door to
installing non-executable mappings. Introduce a new attribute in struct
kvm_page_fault, map_executable, to control whether the gfn range should
be mapped as executable and make sure it's taken into account when
generating new sptes.

No functional change intended.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c          | 6 +++++-
 arch/x86/kvm/mmu/mmu_internal.h | 2 ++
 arch/x86/kvm/mmu/tdp_mmu.c      | 8 ++++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 39b113afefdfc..b0c210b96419f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3197,6 +3197,7 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_shadow_walk_iterator it;
+	unsigned int access = ACC_ALL;
 	struct kvm_mmu_page *sp;
 	int ret;
 	gfn_t base_gfn = fault->gfn;
@@ -3229,7 +3230,10 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (WARN_ON_ONCE(it.level != fault->goal_level))
 		return -EFAULT;
 
-	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, ACC_ALL,
+	if (!fault->map_executable)
+		access &= ~ACC_EXEC_MASK;
+
+	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
 			   base_gfn, fault->pfn, fault);
 	if (ret == RET_PF_SPURIOUS)
 		return ret;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 4f5c4c8af9941..af0c3a154ed89 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -241,6 +241,7 @@ struct kvm_page_fault {
 	kvm_pfn_t pfn;
 	hva_t hva;
 	bool map_writable;
+	bool map_executable;
 
 	/*
 	 * Indicates the guest is trying to write a gfn that contains one or
@@ -313,6 +314,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 		.pfn = KVM_PFN_ERR_FAULT,
 		.hva = KVM_HVA_ERR_BAD,
+		.map_executable = true,
 	};
 	int r;
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 36539c1b36cd6..344781981999a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1018,6 +1018,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 					  struct tdp_iter *iter)
 {
 	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
+	unsigned int access = ACC_ALL;
 	u64 new_spte;
 	int ret = RET_PF_FIXED;
 	bool wrprot = false;
@@ -1025,10 +1026,13 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
 		return RET_PF_RETRY;
 
+	if (!fault->map_executable)
+		access &= ~ACC_EXEC_MASK;
+
 	if (unlikely(!fault->slot))
-		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
+		new_spte = make_mmio_spte(vcpu, iter->gfn, access);
 	else
-		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
+		wrprot = make_spte(vcpu, sp, fault->slot, access, iter->gfn,
 					 fault->pfn, iter->old_spte, fault->prefetch, true,
 					 fault->map_writable, &new_spte);
 
-- 
2.40.1


