Return-Path: <linux-arch+bounces-4767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E55901697
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A36B1F226CD
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E445BFF;
	Sun,  9 Jun 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XtmHmQgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2941446DE;
	Sun,  9 Jun 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948297; cv=none; b=tjkncIpU85Z9zBW1+4wKmIheToXfbaJi0ToCn94uCvBIX1q99OemI8THWlcsqQCOHz1F26S1aM1NCaYYSCwbpb4jSCeaTaYySTCa7kQgjfzCMPKDBXNeDOf6KnLkj3uTbxdsX5QGJ/1BxxtU/SvXIAe6TQbcIHsizWxnwMXXl1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948297; c=relaxed/simple;
	bh=xoDOnoxRP1Skg8wlkw9LFdoDrWMS0M1cQHhDOmR7bEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9yxxwkHIgJ/7TtmHpt8aHNM2Ml4US2VozehnW4ezwjBnW1BaCkuW6BzfH+NgqR7OuHGlHWBKgrFrOJujaRfz9Iv1YXGngLFgaw+ejpb1YzTBOO9zRxncALyqSw5xjvZEWbIomunFnoep7a1WFsrkLGZUkgqVbTtg6ryo6sdAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XtmHmQgg; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948297; x=1749484297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FoWiVs4WmecYZS9CVkXEhJZc5evZL+HijJCjdvnwTvc=;
  b=XtmHmQggovWMf6gKYrjNlYmvdLAyCd5jlQqZL3QjBgi0VYc2mh/MAbZ1
   zKnsIDdl5vCszbg8TcBfdzCAXEn5J74Kn6xHT/x/3vBZUMK9BMIwAOnlp
   cUADGg92d6BqwYqbbWIJJfoOTo8H/lCfQwFWKo0ay+Y83wXJxAf6amhvR
   k=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="210677666"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:51:34 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:48096]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.97:2525] with esmtp (Farcaster)
 id d60679e4-5673-4a13-b2f5-ce65b531245e; Sun, 9 Jun 2024 15:51:32 +0000 (UTC)
X-Farcaster-Flow-ID: d60679e4-5673-4a13-b2f5-ce65b531245e
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:51:32 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:51:26 +0000
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
Subject: [PATCH 02/18] KVM: x86: hyper-v: Introduce helpers to check if VSM is exposed to guest
Date: Sun, 9 Jun 2024 15:49:30 +0000
Message-ID: <20240609154945.55332-3-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Introduce a helper function to check if the guest exposes the VSM CPUID
bit.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/hyperv.h             | 10 ++++++++++
 include/asm-generic/hyperv-tlfs.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 923e64903da9a..d007d2203e0e4 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -265,6 +265,12 @@ static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu,
 }
 
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
+static inline bool kvm_hv_cpuid_vsm_enabled(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	return hv_vcpu && (hv_vcpu->cpuid_cache.features_ebx & HV_ACCESS_VSM);
+}
 #else /* CONFIG_KVM_HYPERV */
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
@@ -322,6 +328,10 @@ static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 	return vcpu->vcpu_idx;
 }
 static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu, bool tdp_enabled) {}
+static inline bool kvm_hv_cpuid_vsm_enabled(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 #endif /* CONFIG_KVM_HYPERV */
 
 #endif /* __ARCH_X86_KVM_HYPERV_H__ */
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 814207e7c37fc..ffac04bbd0c19 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -89,6 +89,7 @@
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
 #define HV_CPU_MANAGEMENT			BIT(12)
+#define HV_ACCESS_VSM				BIT(16)
 #define HV_ENABLE_EXTENDED_HYPERCALLS		BIT(20)
 #define HV_ISOLATION				BIT(22)
 
-- 
2.40.1


