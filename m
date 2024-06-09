Return-Path: <linux-arch+bounces-4782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3753E9016E5
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3698B222D2
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC94778B;
	Sun,  9 Jun 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="opNAvep7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6B481DA;
	Sun,  9 Jun 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948751; cv=none; b=CkmxbgI8+42EEN3ZONQdqBdwT/iXwZtJ8EgzwEZ5RL7Kymam9s7OFYe3zsP9ttgFYSNJriKYipKEfmZ5u+E1txKfr//D2/Vr5OMemlA1aJJuxq6FSleCqlYQNJsFMABfJ7EbgCCVgCDmK2GlTqS3kuFT+aWZ/2oJVnhFY/8h3UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948751; c=relaxed/simple;
	bh=4qqNteFovRvgrdnNLVbXKhbzhO0um01VZnTrVRwWtc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWmiDUqPVGXfCLARp/5vCgr6FfxaohC5BH1agTXyIDgGu1vZBNmQm4niRhmTAb3sW2ICwIL7TvhU509ZcA89bsUP/R1OW6ZJmTxxvK88FHNakIjEl1kLyPUJmwWx7pssUUI/6Xvikbyfoy5ldAcpLdjjyNQnC1ZGLH1Bt/Rk+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=opNAvep7; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948750; x=1749484750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIRfnv2djVA+xk4ZO/I3aViZ1lXTyDCx5f6sDl9wnrk=;
  b=opNAvep743w6mDmVkai8g0ORNB6+LHzvEv8yYs2N1QP/yZHAwmwV/R/y
   JFdxIy642rBQVDlZisb57wig4d0/XhroxqtYbsl03IXXUpsqRqJ++ychD
   AR1zhBZ7TCHrYWHLtNkT8rcr8f+aqRJbRcoQQ/TN3LobiUiUAF5cVFboJ
   w=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="412307054"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:59:09 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:54959]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.105:2525] with esmtp (Farcaster)
 id 8bb8ad60-10df-4243-8ba3-f92239dae527; Sun, 9 Jun 2024 15:59:08 +0000 (UTC)
X-Farcaster-Flow-ID: 8bb8ad60-10df-4243-8ba3-f92239dae527
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:59:07 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:59:01 +0000
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
Subject: [PATCH 17/18] KVM: Introduce traces to track memory attributes modification.
Date: Sun, 9 Jun 2024 15:49:46 +0000
Message-ID: <20240609154945.55332-18-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Introduce traces that track memory attributes modification.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 include/trace/events/kvm.h | 20 ++++++++++++++++++++
 virt/kvm/kvm_main.c        |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 74e40d5d4af42..aa6caeb16f12a 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -489,6 +489,26 @@ TRACE_EVENT(kvm_test_age_hva,
 	TP_printk("mmu notifier test age hva: %#016lx", __entry->hva)
 );
 
+TRACE_EVENT(kvm_vm_set_mem_attributes,
+	TP_PROTO(u64 start, u64 cnt, u64 attributes),
+	TP_ARGS(start, cnt, attributes),
+
+	TP_STRUCT__entry(
+		__field(	u64,	start		)
+		__field(	u64,	cnt		)
+		__field(	u64,	attributes	)
+	),
+
+	TP_fast_assign(
+		__entry->start		= start;
+		__entry->cnt		= cnt;
+		__entry->attributes	= attributes;
+	),
+
+	TP_printk("gfn 0x%llx, cnt 0x%llx, attributes 0x%llx",
+		  __entry->start, __entry->cnt, __entry->attributes)
+);
+
 #endif /* _TRACE_KVM_MAIN_H */
 
 /* This part must be outside protection */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bd27fc01e9715..1c493ece3deb1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2556,6 +2556,8 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	kvm_handle_gfn_range(kvm, &post_set_range);
 
+	trace_kvm_vm_set_mem_attributes(start, end - start, attributes);
+
 out_unlock:
 	mutex_unlock(&kvm->slots_lock);
 
-- 
2.40.1


