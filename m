Return-Path: <linux-arch+bounces-4775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708C9016C2
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8E82817D8
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DFC4654D;
	Sun,  9 Jun 2024 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z0N6nJAe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F046525;
	Sun,  9 Jun 2024 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948578; cv=none; b=ruzUno8Zlwc5s35f0K++i6Mjs7g6k3B26/G+E/1xki5XCq6XWiBYYTeEwGsW+xgNMTnfec9lNFkd8mS8c1Whx3qdgyxye7nq6bY0yN+QOZbvNM2eFAC9IHArXmJNHWrEILS4sh4s+GeLAbekZjGBDxTpbtx56nuxmLr2yJgKIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948578; c=relaxed/simple;
	bh=nKicQm1fuxxmfMOtq9FjXlLMZ2bIMAyDM0roGI3NN6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0BLrxR8ZdXncF5fdMLf6m19DQipqea0bb1EdIIvoC9i/ytfhMCfcVYSSOGlv/R59dn6ENuqbQsQpcxcZkuFkC47LF2g/Wkis+8ufTg6KqnrOAA89eazntUSA82QAbTwmhc0bbOclIu8IHaLy9LgOxFD74d0Y6KliEhJjyNTn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z0N6nJAe; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948578; x=1749484578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qLfuMJ5kf1Vn28FgflcJ4xBnNXHKY1gso6hmxRR5Gmo=;
  b=Z0N6nJAe/JkVw9pniFRvp+SCxPNLf8byOmrr0kv7tyvv8GeBH4qcSALA
   jpooqQ0HFDC+M7ZwJrsSvjAeSnmM5y2EJNJx/5MIb26tRjH6Ooduhoi/H
   aK2k591zg3PceIVvjmhCBqYNtPIhXLBxYqJr2sUd8HXOhdH34l984iWGF
   c=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="638289185"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:56:14 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:18360]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.97:2525] with esmtp (Farcaster)
 id 0a5637ff-4a9c-4ada-8af3-798f672d6f63; Sun, 9 Jun 2024 15:56:12 +0000 (UTC)
X-Farcaster-Flow-ID: 0a5637ff-4a9c-4ada-8af3-798f672d6f63
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:56:11 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:56:05 +0000
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
Subject: [PATCH 10/18] KVM: x86: Keep track of instruction length during faults
Date: Sun, 9 Jun 2024 15:49:39 +0000
Message-ID: <20240609154945.55332-11-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Both VMX and SVM provide the length of the instruction
being run at the time of the page fault. Save it within 'struct
kvm_page_fault', as it'll become useful in the future.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c          | 11 ++++++++---
 arch/x86/kvm/mmu/mmu_internal.h |  5 ++++-
 arch/x86/kvm/vmx/vmx.c          | 16 ++++++++++++++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8d74bdef68c1d..39b113afefdfc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4271,7 +4271,8 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
-	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code, true, NULL);
+	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+			      true, NULL, 0);
 }
 
 static inline u8 kvm_max_level_for_order(int order)
@@ -5887,7 +5888,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 
 	if (r == RET_PF_INVALID) {
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
-					  &emulation_type);
+					  &emulation_type, insn_len);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
 	}
@@ -5924,8 +5925,12 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (!mmio_info_in_cache(vcpu, cr2_or_gpa, direct) && !is_guest_mode(vcpu))
 		emulation_type |= EMULTYPE_ALLOW_RETRY_PF;
 emulate:
+	/*
+	 * x86_emulate_instruction() expects insn to contain data if
+	 * insn_len > 0.
+	 */
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
-				       insn_len);
+				       insn ? insn_len : 0);
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_page_fault);
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index ce2fcd19ba6be..a0cde1a0e39b0 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -192,6 +192,7 @@ struct kvm_page_fault {
 	const gpa_t addr;
 	const u64 error_code;
 	const bool prefetch;
+	const u8 insn_len;
 
 	/* Derived from error_code.  */
 	const bool exec;
@@ -288,11 +289,13 @@ static inline void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 }
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-					u64 err, bool prefetch, int *emulation_type)
+					u64 err, bool prefetch,
+					int *emulation_type, u8 insn_len)
 {
 	struct kvm_page_fault fault = {
 		.addr = cr2_or_gpa,
 		.error_code = err,
+		.insn_len = insn_len,
 		.exec = err & PFERR_FETCH_MASK,
 		.write = err & PFERR_WRITE_MASK,
 		.present = err & PFERR_PRESENT_MASK,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ac0682fece604..9ba38e0b0c7a8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5807,11 +5807,13 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
 		return kvm_emulate_instruction(vcpu, 0);
 
-	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
+	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL,
+				  vmcs_read32(VM_EXIT_INSTRUCTION_LEN));
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 {
+	u8 insn_len = 0;
 	gpa_t gpa;
 
 	if (vmx_check_emulate_instruction(vcpu, EMULTYPE_PF, NULL, 0))
@@ -5828,7 +5830,17 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	return kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, 0);
+	/*
+	 * Using VMCS.VM_EXIT_INSTRUCTION_LEN on EPT misconfig depends on
+	 * undefined behavior: Intel's SDM doesn't mandate the VMCS field be
+	 * set when EPT misconfig occurs.  In practice, real hardware updates
+	 * VM_EXIT_INSTRUCTION_LEN on EPT misconfig, but other hypervisors
+	 * (namely Hyper-V) don't set it due to it being undefined behavior.
+	 */
+	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+		insn_len = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+
+	return kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, insn_len);
 }
 
 static int handle_nmi_window(struct kvm_vcpu *vcpu)
-- 
2.40.1


