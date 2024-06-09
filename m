Return-Path: <linux-arch+bounces-4779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C711B9016D7
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731DDB2192E
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127946BA6;
	Sun,  9 Jun 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K91LMLvD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041146441;
	Sun,  9 Jun 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948675; cv=none; b=cmFIj93LbslBgSx14jZAhqNZBv+cg2tM/g01zCcvoH3P9cqa5RFppPAPmRJe/areIrZv/9+4fyT4SUIpVJFTef8gOaCMI0PJpbtsgPYIjvpJXWBZS+sWjn1ZEdliAOqTprlGAgAWdaZFfWBkFZYdkvaFCoeQybNhxBr2uz8FUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948675; c=relaxed/simple;
	bh=2ka8MvuD84iyFrsjou2EVsTvKhmpRdlc0YE7y7R91Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3rhEKfA2d2YdqD6had42/3G0f0I3kYRSVkjZv/LiqDv4cYiuI6u93jZwD6KOG5I8o+0Ws+EHJR/r56l+XLNk+v75qaQ3htsFXUuaPbhXG3R4fNOEF9crnvuoDO28ajZF8n9V8bjAcbN/wOSOVZpT7zNUKv49TuULTK+MIf1L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K91LMLvD; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948674; x=1749484674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yt+3Dcy20QMTHGnCk6/y0RPLFoY3XYTwlSVc1Aecjnc=;
  b=K91LMLvD9fdwoe1RpwtS7sFV8FxNIR8XfetmhKmdwwRqWCJk+nK8uI17
   ezJtUC/+Edba+7dk1WqKwv63f9r/CBt4rPVtEdEiaD9d5n6be9XLSSWN1
   tNc9nqWe95HGUBJH+K93jWx+9qyAmsLzyp4wUvOBSMKf4Z/5912vDHLRf
   c=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="731692654"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:57:54 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:32201]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.80:2525] with esmtp (Farcaster)
 id f4d45b61-398d-4935-98f2-085165cb7ee5; Sun, 9 Jun 2024 15:57:52 +0000 (UTC)
X-Farcaster-Flow-ID: f4d45b61-398d-4935-98f2-085165cb7ee5
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:57:52 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:57:46 +0000
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
Subject: [PATCH 14/18] KVM: x86/mmu: Init memslot if memory attributes available
Date: Sun, 9 Jun 2024 15:49:43 +0000
Message-ID: <20240609154945.55332-15-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Systems that lack private memory support are about to start using memory
attributes. So query if the memory attributes xarray is empty in order
to decide whether it's necessary to init the hugepage information when
installing a new memslot.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c   | 2 +-
 include/linux/kvm_host.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d56c04fbdc66b..91edd873dcdbc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7487,7 +7487,7 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 {
 	int level;
 
-	if (!kvm_arch_has_private_mem(kvm))
+	if (!kvm_memory_attributes_in_use(kvm))
 		return;
 
 	for (level = PG_LEVEL_2M; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4fa16c4772269..9250bf1c4db15 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2424,12 +2424,21 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 
+static inline bool kvm_memory_attributes_in_use(struct kvm *kvm)
+{
+	return !xa_empty(&kvm->mem_attr_array);
+}
+
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return IS_ENABLED(CONFIG_KVM_PRIVATE_MEM) &&
 	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
+static inline bool kvm_memory_attributes_in_use(struct kvm *kvm)
+{
+	return false;
+}
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
-- 
2.40.1


