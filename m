Return-Path: <linux-arch+bounces-4771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A719016AB
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E201F21300
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDA46522;
	Sun,  9 Jun 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vpXAO5Zj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DC4436C;
	Sun,  9 Jun 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948482; cv=none; b=CjFk9IQ66NvDQRFZWQZkHtBFEBtZZJ8ccoUkULKNJPBeDQEzLmpHvmAKofImUx5n7tJ/scYNcsH55LRU8nk4L12nt4zQx9PRk9lYKU/bqYOPPEPsmY4ZL5j4CK/gqbK81SF5jOuAOTeUCKFWEkOZYTWyt5IqP2fEt8i91Cgurfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948482; c=relaxed/simple;
	bh=WduR8XdHm6uR2y8XSyRWO7oQaaI9sWPsC7OJmg88mL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0IKfzIVQnajIlUh68ShkS1sw7n83wK/SeUG5VirhDm1ffk/Hih8y/ur7nTMQHwAUudOYI3tkZ9RDXViHSjDpwGFPSpoqs0CYggKl7Fxf5JxZZM2DTxHVQAINq3OOKAD898/IirPigVukux+jSvSyy7y2C8c8HeaUE3/4mqojT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vpXAO5Zj; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948481; x=1749484481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tgT6eBQG8f7l9K75AtDFTl6Imilpnn0QiUasVVMPd8=;
  b=vpXAO5Zjhiv9xj7jQL7Rc7yG4DwLUMPTmeBcPRR0XARgur4NT+L2uiwk
   hXZ+UOlOUHoQxpwNOf2HGj+FvLzklmh2/YeuPQIsWNB9jAlybBTFBFgF8
   GRgD30ONMhna5rxk6VZ0/2xIXfdlfNj5yxqps+sNAD05ClV7jx+S+5sfV
   c=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="732303415"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:54:33 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:47647]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.97:2525] with esmtp (Farcaster)
 id b43a1426-8160-44b4-8b53-44db17c590ac; Sun, 9 Jun 2024 15:54:31 +0000 (UTC)
X-Farcaster-Flow-ID: b43a1426-8160-44b4-8b53-44db17c590ac
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:54:31 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:54:24 +0000
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
Subject: [PATCH 06/18] KVM: x86: hyper-v: Exit on Get/SetVpRegisters hcall
Date: Sun, 9 Jun 2024 15:49:35 +0000
Message-ID: <20240609154945.55332-7-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Let user-space handle HvGetVpRegisters and HvSetVpRegisters as they are
VTL aware hypercalls used solely in the context of VSM. Additionally,
expose the cpuid bit.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst    | 10 ++++++++++
 arch/x86/kvm/hyperv.c             | 15 +++++++++++++++
 include/asm-generic/hyperv-tlfs.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e664c54a13b04..05b01b00a395c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8931,3 +8931,13 @@ CPUIDs map to KVM functionality.
 This CPUID indicates that KVM supports retuning data to the guest in response
 to a hypercall using the XMM registers. It also extends ``struct
 kvm_hyperv_exit`` to allow passing the XMM data from userspace.
+
+10.2 HV_ACCESS_VP_REGISTERS
+---------------------------
+
+:Location: CPUID.40000003H:EBX[bit 17]
+
+This CPUID indicates that KVM supports HvGetVpRegisters and HvSetVpRegisters.
+Currently, it is only used in conjunction with HV_ACCESS_VSM, and immediately
+exits to userspace with KVM_EXIT_HYPERV_HCALL as the reason. Userspace is
+expected to complete the hypercall before resuming execution.
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d00baf3ffb165..d0edc2bec5a4f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2425,6 +2425,11 @@ static void kvm_hv_write_xmm(struct kvm_hyperv_xmm_reg *xmm)
 
 static bool kvm_hv_is_xmm_output_hcall(u16 code)
 {
+	switch (code) {
+	case HVCALL_GET_VP_REGISTERS:
+		return true;
+	}
+
 	return false;
 }
 
@@ -2505,6 +2510,8 @@ static bool is_xmm_fast_hypercall(struct kvm_hv_hcall *hc)
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
 	case HVCALL_SEND_IPI_EX:
+	case HVCALL_GET_VP_REGISTERS:
+	case HVCALL_SET_VP_REGISTERS:
 		return true;
 	}
 
@@ -2543,6 +2550,10 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 		 */
 		return !kvm_hv_is_syndbg_enabled(hv_vcpu->vcpu) ||
 			hv_vcpu->cpuid_cache.features_ebx & HV_DEBUGGING;
+	case HVCALL_GET_VP_REGISTERS:
+	case HVCALL_SET_VP_REGISTERS:
+		return hv_vcpu->cpuid_cache.features_ebx &
+			HV_ACCESS_VP_REGISTERS;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
 		if (!(hv_vcpu->cpuid_cache.enlightenments_eax &
@@ -2727,6 +2738,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		goto hypercall_userspace_exit;
+	case HVCALL_GET_VP_REGISTERS:
+	case HVCALL_SET_VP_REGISTERS:
+		goto hypercall_userspace_exit;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
@@ -2898,6 +2912,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_POST_MESSAGES;
 			ent->ebx |= HV_SIGNAL_EVENTS;
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
+			ent->ebx |= HV_ACCESS_VP_REGISTERS;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
 			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 28cde641b5474..9e909f0834598 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -90,6 +90,7 @@
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_MANAGEMENT			BIT(12)
 #define HV_ACCESS_VSM				BIT(16)
+#define HV_ACCESS_VP_REGISTERS			BIT(17)
 #define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
 
-- 
2.40.1


