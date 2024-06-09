Return-Path: <linux-arch+bounces-4776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33DA9016C6
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50CC1C20CBC
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DC46556;
	Sun,  9 Jun 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HUP1+kcw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632146441;
	Sun,  9 Jun 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948604; cv=none; b=bQv/dhz7/ahhLMYSgiw8MVX+wptPOKt2Q52v5jtUGfvXiFqAH1LvgPtAu1LW6tPjfAl30eSd6fSepVKsCbqJiNeVscDSojtcOXcrDavDcEUAlJW4G0ocKiQO+C0jsRFDhdh34cys2a079TbpsRgpBk4nV/fkfWJcqp6J3Q2AdIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948604; c=relaxed/simple;
	bh=9ugFkrjOKDpd/cXxvCx9aOKKDZPmDfATT6lWxIdU1fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnGAmo4arAnS5hecE2XPMAvjQW+mj8ftlRS7ikepbIL+EFq4bU3F9clEHo71JLHYg5zeUOdvHXskYxt0jaYF1Hgu/jKaYWS/C2frf+HyTOIE1i1nXorScGfue5EMbqXQ3OKQj7NFZop/zA0SJa7+2gRB4Vqzo4w+KYawK4oMANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HUP1+kcw; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948602; x=1749484602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VWO+H62eiiATp2Ug3hC1JKOqeo3z4q/lB+9V1DAUw3Q=;
  b=HUP1+kcwp24CikbouSqTIvgLBnLZujGFMIctGlJlT37pU1fpyk6rwDDP
   Dzh7VGxfpkMB1nSr7RbZ9BHsTZSGh/V2TI7zvW59bwBmPwKm1b18euXHz
   VDjrYuuvpD6nxAM/AxQRwy9iGR44EWsQkBJZDG8mw4tYDZ8hfCwSmXgO+
   4=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="95498707"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:56:38 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:30248]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.35.119:2525] with esmtp (Farcaster)
 id a21984c0-fb14-4c45-8050-a7f53294da7f; Sun, 9 Jun 2024 15:56:37 +0000 (UTC)
X-Farcaster-Flow-ID: a21984c0-fb14-4c45-8050-a7f53294da7f
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:56:37 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:56:30 +0000
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
Subject: [PATCH 11/18] KVM: x86: Pass the instruction length on memory fault user-space exits
Date: Sun, 9 Jun 2024 15:49:40 +0000
Message-ID: <20240609154945.55332-12-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

In order to simplify Hyper-V VSM secure memory intercept generation in
user-space (it avoids the need of implementing an x86 instruction
decoder and the actual decoding). Pass the instruction length being run
at the time of the guest exit as part of the memory fault exit
information.

The presence of this additional information is indicated by a new
capability, KVM_CAP_FAULT_EXIT_INSN_LEN.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst  | 6 +++++-
 arch/x86/kvm/mmu/mmu_internal.h | 2 +-
 arch/x86/kvm/x86.c              | 1 +
 include/linux/kvm_host.h        | 3 ++-
 include/uapi/linux/kvm.h        | 2 ++
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 761b99987cf1a..18ddea9c4c58a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7021,11 +7021,15 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+                        __u8 insn_len;
 		} memory_fault;
 
 KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault that
 could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe the
-guest physical address range [gpa, gpa + size) of the fault.  The 'flags' field
+guest physical address range [gpa, gpa + size) of the fault.  The
+'insn_len' field describes the size (in bytes) of the instruction
+that caused the fault. It is only available if the underlying HW exposes that
+information on guest exit, otherwise it's set to 0.  The 'flags' field
 describes properties of the faulting access that are likely pertinent:
 
  - KVM_MEMORY_EXIT_FLAG_READ/WRITE/EXEC - When set, indicates that the memory
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index a0cde1a0e39b0..4f5c4c8af9941 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -285,7 +285,7 @@ static inline void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 {
 	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
 				      PAGE_SIZE, fault->write, fault->exec,
-				      fault->is_private);
+				      fault->is_private, fault->insn_len);
 }
 
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a6e2312ccb68f..d2b8b74cb48bf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4704,6 +4704,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VM_DISABLE_NX_HUGE_PAGES:
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_MEMORY_FAULT_INFO:
+	case KVM_CAP_FAULT_EXIT_INSN_LEN:
 		r = 1;
 		break;
 	case KVM_CAP_EXIT_HYPERCALL:
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 59f687985ba24..4fa16c4772269 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2391,11 +2391,12 @@ static inline void kvm_account_pgtable_pages(void *virt, int nr)
 static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 						 gpa_t gpa, gpa_t size,
 						 bool is_write, bool is_exec,
-						 bool is_private)
+						 bool is_private, u8 insn_len)
 {
 	vcpu->run->exit_reason = KVM_EXIT_MEMORY_FAULT;
 	vcpu->run->memory_fault.gpa = gpa;
 	vcpu->run->memory_fault.size = size;
+	vcpu->run->memory_fault.insn_len = insn_len;
 
 	vcpu->run->memory_fault.flags = 0;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d6d8b17bfa9a7..516d39910f9ab 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -441,6 +441,7 @@ struct kvm_run {
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+			__u8 insn_len;
 		} memory_fault;
 		/* Fix the size of the union. */
 		char padding[256];
@@ -927,6 +928,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_MEMORY_ATTRIBUTES 233
 #define KVM_CAP_GUEST_MEMFD 234
 #define KVM_CAP_VM_TYPES 235
+#define KVM_CAP_FAULT_EXIT_INSN_LEN 236
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.40.1


