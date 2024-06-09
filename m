Return-Path: <linux-arch+bounces-4766-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F86901691
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD61C20A81
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC046441;
	Sun,  9 Jun 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mDYNVB6G"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E28446DE;
	Sun,  9 Jun 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948267; cv=none; b=HNXfLrAf5TUM3mCWrZPjHxI3C6x0tBMv9UBeEAQaE3tE4Orsa1s7GXTGjxU4vzn44YB4fCA2Nu2g9PgLH3ayValV4GjVtS0pWIYsLfqlMce4So1CqXpXgMSanYc5tTSNJGiW/7w+gfi/guhXT6IKNOaLYsw9Kc97I8tC67KKDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948267; c=relaxed/simple;
	bh=cF25vajOKkfbhKDftt1MB4QKPKKFtwT/VnYRGJnzbM8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkuk+5hX1El5j2Pf9wc9KJzwca2qNBZ+KcrOsJjkCwxDqjCdRDTqctV1gJUruUJuKsqmSbzawyqQGOdi7ZhGTphkEtW6vJozeSFYAf5KvXTAI/7TP4XxQ7s0ju/22grHlKQkbw6NaxKvqBnO9ydAwuAW4WlXnqO9G4VuhQfEYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mDYNVB6G; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948265; x=1749484265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Kf/k8Ifp+IJgoAkFqq7BEZyoJRgq+MCrSwCJITAKBQ=;
  b=mDYNVB6GMK51cPoj5yLTHWLuHTFBzMY+72w0sG5vpqxVVdBMoj5csnlp
   j1ECqcrZOX+UW81VVq5WHNKK6Do1Ut6No9h4lcNnRdmgEp92JKELW7lLr
   s53DlKlD9M27utDGWwuNSaiajiYyq+yBV9wIi7pYQqSvrao8j3uquWGaX
   g=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="402162296"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:51:01 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:12461]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.236:2525] with esmtp (Farcaster)
 id d4395843-8a2c-4c0c-857a-37daf136215b; Sun, 9 Jun 2024 15:50:59 +0000 (UTC)
X-Farcaster-Flow-ID: d4395843-8a2c-4c0c-857a-37daf136215b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:50:59 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:50:53 +0000
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
Subject: [PATCH 01/18] KVM: x86: hyper-v: Introduce XMM output support
Date: Sun, 9 Jun 2024 15:49:29 +0000
Message-ID: <20240609154945.55332-2-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Prepare infrastructure to be able to return data through the XMM
registers when Hyper-V hypercalls are issues in fast mode. The XMM
registers are exposed to user-space through KVM_EXIT_HYPERV_HCALL and
restored on successful hypercall completion.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

---

There was some discussion in the RFC about whether growing 'struct
kvm_hyperv_exit' is ABI breakage. IMO it isn't:
- There is padding in 'struct kvm_run' that ensures that a bigger
  'struct kvm_hyperv_exit' doesn't alter the offsets within that struct.
- Adding a new field at the bottom of the 'hcall' field within the
  'struct kvm_hyperv_exit' should be fine as well, as it doesn't alter
  the offsets within that struct either.
- Ultimately, previous updates to 'struct kvm_hyperv_exit's hint that
  its size isn't part of the uABI. It already grew when syndbg was
  introduced.

 Documentation/virt/kvm/api.rst     | 19 ++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  2 +-
 arch/x86/kvm/hyperv.c              | 56 +++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h           |  6 ++++
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a71d91978d9ef..17893b330b76f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8893,3 +8893,22 @@ Ordering of KVM_GET_*/KVM_SET_* ioctls
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 TBD
+
+10. Hyper-V CPUIDs
+==================
+
+This section only applies to x86.
+
+New Hyper-V feature support is no longer being tracked through KVM
+capabilities.  Userspace can check if a particular version of KVM supports a
+feature using KMV_GET_SUPPORTED_HV_CPUID.  This section documents how Hyper-V
+CPUIDs map to KVM functionality.
+
+10.1 HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE
+------------------------------------------
+
+:Location: CPUID.40000003H:EDX[bit 15]
+
+This CPUID indicates that KVM supports retuning data to the guest in response
+to a hypercall using the XMM registers. It also extends ``struct
+kvm_hyperv_exit`` to allow passing the XMM data from userspace.
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 3787d26810c1c..6a18c9f77d5fe 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -49,7 +49,7 @@
 /* Support for physical CPU dynamic partitioning events is available*/
 #define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE	BIT(3)
 /*
- * Support for passing hypercall input parameter block via XMM
+ * Support for passing hypercall input and output parameter block via XMM
  * registers is available
  */
 #define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE		BIT(4)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8a47f8541eab7..42f44546fe79c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1865,6 +1865,7 @@ struct kvm_hv_hcall {
 	u16 rep_idx;
 	bool fast;
 	bool rep;
+	bool xmm_dirty;
 	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
 
 	/*
@@ -2396,9 +2397,49 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	return ret;
 }
 
+static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
+{
+	int reg;
+
+	kvm_fpu_get();
+	for (reg = 0; reg < HV_HYPERCALL_MAX_XMM_REGISTERS; reg++) {
+		const sse128_t data = sse128(xmm[reg].low, xmm[reg].high);
+		_kvm_write_sse_reg(reg, &data);
+	}
+	kvm_fpu_put();
+}
+
+static bool kvm_hv_is_xmm_output_hcall(u16 code)
+{
+	return false;
+}
+
+static bool kvm_hv_xmm_output_allowed(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	return !hv_vcpu->enforce_cpuid ||
+	       hv_vcpu->cpuid_cache.features_edx &
+		       HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
+}
+
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
-	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
+	bool fast = !!(vcpu->run->hyperv.u.hcall.input & HV_HYPERCALL_FAST_BIT);
+	u16 code = vcpu->run->hyperv.u.hcall.input & 0xffff;
+	u64 result = vcpu->run->hyperv.u.hcall.result;
+
+	if (hv_result_success(result) && fast &&
+	    kvm_hv_is_xmm_output_hcall(code)) {
+		if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
+			kvm_queue_exception(vcpu, UD_VECTOR);
+			return 1;
+		}
+
+		kvm_hv_write_xmm(vcpu->run->hyperv.u.hcall.xmm);
+	}
+
+	return kvm_hv_hypercall_complete(vcpu, result);
 }
 
 static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -2553,6 +2594,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	hc.rep_cnt = (hc.param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
 	hc.rep_idx = (hc.param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
 	hc.rep = !!(hc.rep_cnt || hc.rep_idx);
+	hc.xmm_dirty = false;
 
 	trace_kvm_hv_hypercall(hc.code, hc.fast, hc.var_cnt, hc.rep_cnt,
 			       hc.rep_idx, hc.ingpa, hc.outgpa);
@@ -2673,6 +2715,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		break;
 	}
 
+	if (hv_result_success(ret) && hc.xmm_dirty) {
+		if (unlikely(!kvm_hv_xmm_output_allowed(vcpu))) {
+			kvm_queue_exception(vcpu, UD_VECTOR);
+			return 1;
+		}
+
+		kvm_hv_write_xmm((struct kvm_hyperv_xmm_reg *)hc.xmm);
+	}
+
 hypercall_complete:
 	return kvm_hv_hypercall_complete(vcpu, ret);
 
@@ -2682,6 +2733,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->hyperv.u.hcall.input = hc.param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
+	if (hc.fast)
+		memcpy(vcpu->run->hyperv.u.hcall.xmm, hc.xmm, sizeof(hc.xmm));
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 	return 0;
 }
@@ -2830,6 +2883,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
+			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
 			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
 			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d03842abae578..fbdee8d754595 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -90,6 +90,11 @@ struct kvm_pit_config {
 
 #define KVM_PIT_SPEAKER_DUMMY     1
 
+struct kvm_hyperv_xmm_reg {
+	__u64 low;
+	__u64 high;
+};
+
 struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
@@ -108,6 +113,7 @@ struct kvm_hyperv_exit {
 			__u64 input;
 			__u64 result;
 			__u64 params[2];
+			struct kvm_hyperv_xmm_reg xmm[6];
 		} hcall;
 		struct {
 			__u32 msr;
-- 
2.40.1


