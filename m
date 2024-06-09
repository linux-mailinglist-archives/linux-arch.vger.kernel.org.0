Return-Path: <linux-arch+bounces-4773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80CA9016B7
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445C1281824
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1C46556;
	Sun,  9 Jun 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ro4HUwWu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECB4436C;
	Sun,  9 Jun 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948528; cv=none; b=ci9uEsCAovYIM8SnOVLzxw68AnbqKhtn5yIt8dBSFRkIruWnf6vtztuNweDgtROz5ubyGDkvgCK0w3PVYGb4br6+VxrbpHF+lBv0jMXPhjRrYobh2Piipkn2i4Ev2RTS15oM0QOwarDy9kCEI7K6ashQQIbXEXB9nYgDl6wpz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948528; c=relaxed/simple;
	bh=DqvLUFFsM4kKgd1oMzVjqszyKJwGL5RQYsMX7F6kX0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMDx6vLF7AWmm9Eu+uYFxT/pfVgzjusiIcLVAuMHm8EogKw0D9Y/UE3zQxAS2MN39WGV6bNF9Bt/2zT4inUParRekdOQCTlC3vnhSG7R1P/LsaMjckXjvY6IXkdT2ro10hFHbiZojgHlc5bU/gFCtdEhjAHyT6aQT7quvlHqjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ro4HUwWu; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948527; x=1749484527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTqojU/JXT3fYm8Yq++n3olx+D224pV1FluFfxEsmp8=;
  b=ro4HUwWuP0OAH0Cjayg4FsiaDRws1ubvoEbn+wQzkmcmqS4ZId1dbIZd
   itp1tVEye5uK8jH9rVaBZ+uhTqaaLCe1hDuv/hXAl7EG2aFNkFDIExiK5
   LvZKwuNoCDkKHNavKKEcWwJOUQwQMnjK6kXC5YKIDYbu6LSp5bireczXM
   U=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="349362166"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:55:24 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.43.254:49558]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.214:2525] with esmtp (Farcaster)
 id c7591299-d521-4ea1-9828-a09e4088386b; Sun, 9 Jun 2024 15:55:21 +0000 (UTC)
X-Farcaster-Flow-ID: c7591299-d521-4ea1-9828-a09e4088386b
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:55:21 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:55:15 +0000
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
Subject: [PATCH 08/18] KVM: x86: hyper-v: Exit on StartVirtualProcessor and GetVpIndexFromApicId hcalls
Date: Sun, 9 Jun 2024 15:49:37 +0000
Message-ID: <20240609154945.55332-9-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Both HvCallStartVirtualProcessor and GetVpIndexFromApicId are used as
part of the Hyper-V VSM CPU bootstrap process, and requires VTL
awareness, as such handle the hypercall in user-space. Also, expose the
ad-hoc CPUID bit.

Note that these hypercalls aren't necessary on Hyper-V guests that don't
enable VSM.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst    | 11 +++++++++++
 arch/x86/kvm/hyperv.c             |  7 +++++++
 include/asm-generic/hyperv-tlfs.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 05b01b00a395c..161a772c23c6a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8941,3 +8941,14 @@ This CPUID indicates that KVM supports HvGetVpRegisters and HvSetVpRegisters.
 Currently, it is only used in conjunction with HV_ACCESS_VSM, and immediately
 exits to userspace with KVM_EXIT_HYPERV_HCALL as the reason. Userspace is
 expected to complete the hypercall before resuming execution.
+
+10.3 HV_START_VIRTUAL_PROCESSOR
+-------------------------------
+
+:Location: CPUID.40000003H:EBX[bit 21]
+
+This CPUID indicates that KVM supports HvCallStartVirtualProcessor and
+HvCallGetVpIndexFromApicId. Currently, it is only used in conjunction with
+HV_ACCESS_VSM, and immediately exits to userspace with KVM_EXIT_HYPERV_HCALL as
+the reason. Userspace is expected to complete the hypercall before resuming
+execution.
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cbe2aca52514b..dd64f41dc835d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2556,6 +2556,10 @@ static bool hv_check_hypercall_access(struct kvm_vcpu_hv *hv_vcpu, u16 code)
 	case HVCALL_SET_VP_REGISTERS:
 		return hv_vcpu->cpuid_cache.features_ebx &
 			HV_ACCESS_VP_REGISTERS;
+	case HVCALL_START_VP:
+	case HVCALL_GET_VP_ID_FROM_APIC_ID:
+		return hv_vcpu->cpuid_cache.features_ebx &
+			HV_START_VIRTUAL_PROCESSOR;
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX:
 	case HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX:
 		if (!(hv_vcpu->cpuid_cache.enlightenments_eax &
@@ -2743,6 +2747,8 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
 	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
+	case HVCALL_START_VP:
+	case HVCALL_GET_VP_ID_FROM_APIC_ID:
 		goto hypercall_userspace_exit;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
@@ -2916,6 +2922,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->ebx |= HV_SIGNAL_EVENTS;
 			ent->ebx |= HV_ENABLE_EXTENDED_HYPERCALLS;
 			ent->ebx |= HV_ACCESS_VP_REGISTERS;
+			ent->ebx |= HV_START_VIRTUAL_PROCESSOR;
 
 			ent->edx |= HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE;
 			ent->edx |= HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 57c791c555861..e24b88ec4ec00 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -92,6 +92,7 @@
 #define HV_ACCESS_VSM				BIT(16)
 #define HV_ACCESS_VP_REGISTERS			BIT(17)
 #define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
+#define HV_START_VIRTUAL_PROCESSOR		BIT(21)
 #define HV_ISOLATION				BIT(22)
 
 /*
-- 
2.40.1


