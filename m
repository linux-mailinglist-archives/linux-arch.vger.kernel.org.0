Return-Path: <linux-arch+bounces-4778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B861D9016D1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6CA1F22AD3
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F8646BA0;
	Sun,  9 Jun 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LpPRGVnQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FC46441;
	Sun,  9 Jun 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948651; cv=none; b=NBs2D2hNs6ppF17y4WzwTtIZ6Gr5DHGJlilK6Gcx/n4FQ4BChacN0rvxZEXG07P9HlZ0ma+s7HsoSrGxyq3H5MXysjKn421NPgp1z69MXLeELLryhxRF8KJ2EfwvF/4AwNHNOPLKxieGs8MoOmO4QRxUhl7KmIT5pLBchXqTX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948651; c=relaxed/simple;
	bh=+Tv5yHEFjqh1Rpgd3wuBbZaDYV3FvrXaVRj6ufcU9Qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU60hHQWwN56PeTovA3IWZZLrcSNT+BLYm6JCAGKtLPXJex1ZUUmI79h1T2VEoDECSnEe71PIbtpJCxxoHY/Y16kSWSHl9uDdFEp+Uv8O37zNICJHELHe3KqjLx5HhFkfz0UlT+8zCzHB/3gewoXLkq0e+oRX+UFQJzGBdWejCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LpPRGVnQ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948650; x=1749484650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQwnm28YLoi/23yqXhNNFcKbD35vEjDl1rOMbl5bsvk=;
  b=LpPRGVnQf5PyIoUwweMi1F3GKECPH3BVKc/ouZsCNg5Rdv+PcSa4ZBbR
   kCvzxCTf2HvVSImJjGS2hjCeXfmlubzE6ILQkV8QpurnvF1uO7/jdjnFa
   UmkM0OkK4LpDWrJWiomo6H++0JtWr4NW9lKiyNsLXxd9WS9hwE1pZ0Qkp
   g=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="302170451"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:57:28 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:16374]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.105:2525] with esmtp (Farcaster)
 id aaf56908-2e02-4c60-8d3f-48c034269da9; Sun, 9 Jun 2024 15:57:27 +0000 (UTC)
X-Farcaster-Flow-ID: aaf56908-2e02-4c60-8d3f-48c034269da9
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:57:27 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:57:21 +0000
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
Subject: [PATCH 13/18] KVM: x86/mmu: Avoid warning when installing non-private memory attributes
Date: Sun, 9 Jun 2024 15:49:42 +0000
Message-ID: <20240609154945.55332-14-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

In preparation to introducing RWX memory attributes, make sure
user-space is attempting to install a memory attribute with
KVM_MEMORY_ATTRIBUTE_PRIVATE before throwing a warning on systems with
no private memory support.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++++--
 virt/kvm/kvm_main.c    | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b0c210b96419f..d56c04fbdc66b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7359,6 +7359,9 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range)
 {
+	unsigned long attrs = range->arg.attributes;
+	bool priv_attr = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
 	/*
 	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
 	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
@@ -7370,7 +7373,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
 	 * a hugepage can be used for affected ranges.
 	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
+	if (WARN_ON_ONCE(priv_attr && !kvm_arch_has_private_mem(kvm)))
 		return false;
 
 	return kvm_unmap_gfn_range(kvm, range);
@@ -7415,6 +7418,7 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range)
 {
 	unsigned long attrs = range->arg.attributes;
+	bool priv_attr = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 	struct kvm_memory_slot *slot = range->slot;
 	int level;
 
@@ -7427,7 +7431,7 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 	 * a range that has PRIVATE GFNs, and conversely converting a range to
 	 * SHARED may now allow hugepages.
 	 */
-	if (WARN_ON_ONCE(!kvm_arch_has_private_mem(kvm)))
+	if (WARN_ON_ONCE(priv_attr && !kvm_arch_has_private_mem(kvm)))
 		return false;
 
 	/*
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 14841acb8b959..63c4b6739edee 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2506,6 +2506,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
+		.arg.attributes = attributes,
 		.handler = kvm_pre_set_memory_attributes,
 		.on_lock = kvm_mmu_invalidate_begin,
 		.flush_on_ret = true,
-- 
2.40.1


