Return-Path: <linux-arch+bounces-4769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C449E9016A1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F38A1F210AD
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9546441;
	Sun,  9 Jun 2024 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vDSwP40q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF145BF1;
	Sun,  9 Jun 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948366; cv=none; b=dN27R75wFSZHluGqaYuwvV1kOj7cEgDip+fSmBBiueKE9cE5pPIBvTEJ1OvU6wW4zIUzGSNtbhsNMbLZYwfEDZbe5KrMvOo4ib2JBSlHFDjLkAlZRF1qqOxzeEC7XWkrv+RxjvLpUQD0f1y0lKSHSL2kEp7VFYZuTRNRxtjsBGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948366; c=relaxed/simple;
	bh=O57QZSKQXPGZrBKQ3RZKVtUEiqpL95hz4AvhMAmm7MY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC8JWCyOjFglKBiZAvbptMwKBzbntdkg0amDv7zWvjbiPn3XWzHovC0kXDaAX2b8b20y+55mb2aLov8BTTDxRMYVzqNjayS+hm54rsYiLPui45+u7MWYTTLTstk4E5iRpNohPikF+23MSbiyJ77MakEM5JAYenWLkAn3CQY4b5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vDSwP40q; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948365; x=1749484365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mVP6aPqw1csbFkoDM3jiyC1IOI7STtntA93lIEw6LCQ=;
  b=vDSwP40qfWKBjwjiCnyJqOo+Eq6EvP/AR6/jjra9Y/ndcceoi1BbVoUZ
   oBwGeZihrPF+YQdRx6OJEx2vr3o0m50jSUx3FErSl2HSp6+todFfUfBw4
   v2V9ekt+hMuHBoX01kZPIfP7aSRhXpbSFmp6VkH2PwePZ/tCcRn4BAC6i
   E=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="3828056"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:52:41 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:56310]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.214:2525] with esmtp (Farcaster)
 id 2c750468-da6e-4b39-9ee5-571566531d31; Sun, 9 Jun 2024 15:52:39 +0000 (UTC)
X-Farcaster-Flow-ID: 2c750468-da6e-4b39-9ee5-571566531d31
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:52:38 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:52:32 +0000
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
Subject: [PATCH 04/18] KVM: x86: hyper-v: Introduce VTL awareness to Hyper-V's PV-IPIs
Date: Sun, 9 Jun 2024 15:49:32 +0000
Message-ID: <20240609154945.55332-5-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

HvCallSendSyntheticClusterIpi and HvCallSendSyntheticClusterIpiEx allow
sending VTL-aware IPIs. Honour the hcall by exiting to user-space upon
receiving a request with a valid VTL target. This behaviour is only
available if the VSM CPUID flag is available and exposed to the guest.
It doesn't introduce a behaviour change otherwise.

User-space is accountable for the correct processing of the PV-IPI
before resuming execution.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/hyperv.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 42f44546fe79c..d00baf3ffb165 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2217,16 +2217,20 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 
 static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
+	bool vsm_enabled = kvm_hv_cpuid_vsm_enabled(vcpu);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 *sparse_banks = hv_vcpu->sparse_banks;
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_send_ipi_ex send_ipi_ex;
 	struct hv_send_ipi send_ipi;
+	union hv_input_vtl *in_vtl;
 	u64 valid_bank_mask;
+	int rsvd_shift;
 	u32 vector;
 	bool all_cpus;
 
 	if (hc->code == HVCALL_SEND_IPI) {
+		in_vtl = &send_ipi.in_vtl;
 		if (!hc->fast) {
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
 						    sizeof(send_ipi))))
@@ -2235,16 +2239,22 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			vector = send_ipi.vector;
 		} else {
 			/* 'reserved' part of hv_send_ipi should be 0 */
-			if (unlikely(hc->ingpa >> 32 != 0))
+			rsvd_shift = vsm_enabled ? 40 : 32;
+			if (unlikely(hc->ingpa >> rsvd_shift != 0))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			in_vtl->as_uint8 = (u8)(hc->ingpa >> 32);
 			sparse_banks[0] = hc->outgpa;
 			vector = (u32)hc->ingpa;
 		}
 		all_cpus = false;
 		valid_bank_mask = BIT_ULL(0);
 
+		if (in_vtl->use_target_vtl)
+			return -ENODEV;
+
 		trace_kvm_hv_send_ipi(vector, sparse_banks[0]);
 	} else {
+		in_vtl = &send_ipi_ex.in_vtl;
 		if (!hc->fast) {
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi_ex,
 						    sizeof(send_ipi_ex))))
@@ -2253,8 +2263,12 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			send_ipi_ex.vector = (u32)hc->ingpa;
 			send_ipi_ex.vp_set.format = hc->outgpa;
 			send_ipi_ex.vp_set.valid_bank_mask = sse128_lo(hc->xmm[0]);
+			in_vtl->as_uint8 = (u8)(hc->ingpa >> 32);
 		}
 
+		if (vsm_enabled && in_vtl->use_target_vtl)
+			return -ENODEV;
+
 		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
 					 send_ipi_ex.vp_set.format,
 					 send_ipi_ex.vp_set.valid_bank_mask);
@@ -2682,6 +2696,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		ret = kvm_hv_send_ipi(vcpu, &hc);
+		/* VTL-enabled ipi, let user-space handle it */
+		if (ret == -ENODEV)
+			goto hypercall_userspace_exit;
 		break;
 	case HVCALL_POST_DEBUG_DATA:
 	case HVCALL_RETRIEVE_DEBUG_DATA:
-- 
2.40.1


