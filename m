Return-Path: <linux-arch+bounces-4783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FA9016E9
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638532839B1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552774778B;
	Sun,  9 Jun 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ifS5c22+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6547773;
	Sun,  9 Jun 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948778; cv=none; b=atkusyu5NpocCa3iKj1XziDW8kGMPkjP5kw3kqYR9tiU9dqSLOeiqSvxXRqfv+EMHUsqABGctDo4ragGZHFmne2qpgZlG1R7vXLZnYygvXhVn6cKEKTce5mC3VwddvG3/5JB3pHSfEdjKivLJtkSp6h7CuSixgGVuqH2fdjoC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948778; c=relaxed/simple;
	bh=CCy4O8Rajex09opnQ3cvR+y3w5z+7/dgktja4ZDmCrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr1TsqD2ux+PAAcBWpPBEaFYY2JxiBDLenNRntzBn2Jqnk02RRQMEO/KMq097JmoESuQdmlQRGk2Upk+G1IVQhpHia0aEcZyMzrteKCTqFPvhWFcgUt9bzdemQqDy/IbqjxwQ/z6Q/crU9SowODLTFPgJdmHviF0kiLDDrtl7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ifS5c22+; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948776; x=1749484776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xpbGXjdiYfY57DmPTq+vnmg1VxAdFdiWMT93+NIDeg=;
  b=ifS5c22+s/cWFkPc1/QzMoMblBlavMUAK6bTzAa752YhXWJ6J2QCy7cl
   GUcNZh0svaPDpNRjTVgktgNvATAZPCY8x/wzQ5+HcgciLQqBy8GkR8wve
   wP+etzD/8j8IKnb9qCIpX9I5Qeoo1Om91FyFVFly40wUQ6u1e8Hy2mcsi
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="95498928"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:59:34 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:35948]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.236:2525] with esmtp (Farcaster)
 id b1c7cef1-ac9e-43a8-b2c2-8d9cfffadc0c; Sun, 9 Jun 2024 15:59:33 +0000 (UTC)
X-Farcaster-Flow-ID: b1c7cef1-ac9e-43a8-b2c2-8d9cfffadc0c
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:59:33 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:59:26 +0000
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
Subject: [PATCH 18/18] KVM: x86: hyper-v: Handle VSM hcalls in user-space
Date: Sun, 9 Jun 2024 15:49:47 +0000
Message-ID: <20240609154945.55332-19-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Let user-space handle all hypercalls that fall under the AccessVsm
partition privilege flag. That is:
 - HvCallModifyVtlProtectionMask
 - HvCallEnablePartitionVtl
 - HvCallEnableVpVtl
 - HvCallVtlCall
 - HvCallVtlReturn

All these are VTL aware and as such need to be handled in user-space.
Additionally, select KVM_GENERIC_MEMORY_ATTRIBUTES when
CONFIG_KVM_HYPERV is enabled, as it's necessary in order to implement
VTL memory protections.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst    | 23 +++++++++++++++++++++++
 arch/x86/kvm/Kconfig              |  1 +
 arch/x86/kvm/hyperv.c             | 29 +++++++++++++++++++++++++----
 include/asm-generic/hyperv-tlfs.h |  6 +++++-
 4 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6d3bc5092ea63..77af2ccf49a30 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8969,3 +8969,26 @@ HvCallGetVpIndexFromApicId. Currently, it is only used in conjunction with
 HV_ACCESS_VSM, and immediately exits to userspace with KVM_EXIT_HYPERV_HCALL as
 the reason. Userspace is expected to complete the hypercall before resuming
 execution.
+
+10.4 HV_ACCESS_VSM
+------------------
+
+:Location: CPUID.40000003H:EBX[bit 16]
+
+This CPUID indicates that KVM supports HvCallModifyVtlProtectionMask,
+HvCallEnablePartitionVtl, HvCallEnableVpVtl, HvCallVtlCall, and
+HvCallVtlReturn.  Additionally, as a prerequirsite to being able to implement
+Hyper-V VSM, it also identifies the availability of HvTranslateVirtualAddress,
+as well as the VTL-aware aspects of HvCallSendSyntheticClusterIpi and
+HvCallSendSyntheticClusterIpiEx.
+
+All these hypercalls immediately exit with KVM_EXIT_HYPERV_HCALL as the reason.
+Userspace is expected to complete the hypercall before resuming execution.
+Note that both IPI hypercalls will only exit to userspace if the request is
+VTL-aware, which will only happen if HV_ACCESS_VSM is exposed to the guest.
+
+Access restriction memory attributes (4.141) are available to simplify
+HvCallModifyVtlProtectionMask's implementation.
+
+Ultimately this CPUID also indicates that KVM_MP_STATE_HV_INACTIVE_VTL is
+available.
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index fec95a7702703..8d851fe3b8c25 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -157,6 +157,7 @@ config KVM_SMM
 config KVM_HYPERV
 	bool "Support for Microsoft Hyper-V emulation"
 	depends on KVM
+	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	default y
 	help
 	  Provides KVM support for emulating Microsoft Hyper-V.  This allows KVM
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index dd64f41dc835d..1158c59a92790 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2388,7 +2388,12 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 	}
 }
 
-static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
+static inline bool kvm_hv_is_vtl_call_return(u16 code)
+{
+	return code == HVCALL_VTL_CALL || code == HVCALL_VTL_RETURN;
+}
+
+static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u16 code, u64 result)
 {
 	u32 tlb_lock_count = 0;
 	int ret;
@@ -2400,9 +2405,12 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 		result = HV_STATUS_INVALID_HYPERCALL_INPUT;
 
 	trace_kvm_hv_hypercall_done(result);
-	kvm_hv_hypercall_set_result(vcpu, result);
 	++vcpu->stat.hypercalls;
 
+	/* VTL call and return don't set a hcall result */
+	if (!kvm_hv_is_vtl_call_return(code))
+		kvm_hv_hypercall_set_result(vcpu, result);
+
 	ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
@@ -2459,7 +2467,7 @@ static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 		kvm_hv_write_xmm(vcpu->run->hyperv.u.hcall.xmm);
 	}
 
-	return kvm_hv_hypercall_complete(vcpu, result);
+	return kvm_hv_hypercall_complete(vcpu, code, result);
 }
 
 static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -2513,6 +2521,7 @@ static bool is_xmm_fast_hypercall(struct kvm_hv_hcall *hc)
 	case HVCALL_SEND_IPI_EX:
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
+	case HVCALL_MODIFY_VTL_PROTECTION_MASK:
 	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
 		return true;
 	}
@@ -2552,6 +2561,12 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 		 */
 		return !kvm_hv_is_syndbg_enabled(hv_vcpu->vcpu) ||
 			hv_vcpu->cpuid_cache.features_ebx & HV_DEBUGGING;
+	case HVCALL_MODIFY_VTL_PROTECTION_MASK:
+	case HVCALL_ENABLE_PARTITION_VTL:
+	case HVCALL_ENABLE_VP_VTL:
+	case HVCALL_VTL_CALL:
+	case HVCALL_VTL_RETURN:
+		return hv_vcpu->cpuid_cache.features_ebx & HV_ACCESS_VSM;
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
 		return hv_vcpu->cpuid_cache.features_ebx &
@@ -2744,6 +2759,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		goto hypercall_userspace_exit;
+	case HVCALL_MODIFY_VTL_PROTECTION_MASK:
+	case HVCALL_ENABLE_PARTITION_VTL:
+	case HVCALL_ENABLE_VP_VTL:
+	case HVCALL_VTL_CALL:
+	case HVCALL_VTL_RETURN:
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
 	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
@@ -2765,7 +2785,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	}
 
 hypercall_complete:
-	return kvm_hv_hypercall_complete(vcpu, ret);
+	return kvm_hv_hypercall_complete(vcpu, hc.code, ret);
 
 hypercall_userspace_exit:
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
@@ -2921,6 +2941,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_POST_MESSAGES;
 			ent->ebx |= HV_SIGNAL_EVENTS;
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
+			ent->ebx |= HV_ACCESS_VSM;
 			ent->ebx |= HV_ACCESS_VP_REGISTERS;
 			ent->ebx |= HV_START_VIRTUAL_PROCESSOR;
 
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e24b88ec4ec00..6b12e5818292c 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -149,9 +149,13 @@ union hv_reference_tsc_msr {
 /* Declare the various hypercall operations. */
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
-#define HVCALL_ENABLE_VP_VTL			0x000f
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
 #define HVCALL_SEND_IPI				0x000b
+#define HVCALL_MODIFY_VTL_PROTECTION_MASK	0x000c
+#define HVCALL_ENABLE_PARTITION_VTL		0x000d
+#define HVCALL_ENABLE_VP_VTL			0x000f
+#define HVCALL_VTL_CALL				0x0011
+#define HVCALL_VTL_RETURN			0x0012
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
-- 
2.40.1


