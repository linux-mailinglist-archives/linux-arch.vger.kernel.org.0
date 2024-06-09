Return-Path: <linux-arch+bounces-4768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E429A90169C
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1551C20A66
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF2E46435;
	Sun,  9 Jun 2024 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GqV4CWRR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C4A3F;
	Sun,  9 Jun 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948333; cv=none; b=kpClNe9SZP+ipS8ADMZf4q2QE7u42tywoP9QQC9kK0br+dtsK29KeXHYuKQd/WRIKI9c3d2mC8j2y5wL4TjsRGVwYAJxOKgL6SijL2GRbxMGmtGM9ayDPPqLeMZIG4YCf8Hs71DakvkRMfiY2IwFk17OKvXTD0MNJlPE6iqFEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948333; c=relaxed/simple;
	bh=fiIqYPG8ldJzwcsfZRp24T3B9YwKV2wISc7Jz2FOA2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBKYX8BNqUBoyVqhhFX1mZuCZ9kjyTH5eX5gs8Vn1BIvwjMGUt+Bi6iFUtYcGJ3e/wJsvS8uym8VfBRTQUPeKkPVS+qKQOC3G4ApyIEO2BSuOk5jDrYZC0ux7ftTZl8VH8L+5u5J9A68xTfbZ3rnF4swOkBk7gsfXrwQvp6w38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GqV4CWRR; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948331; x=1749484331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDJVYAfP5VuuNJ8sdIBv6AEo9E99xin2DvJrLfd7Gyk=;
  b=GqV4CWRR5ZhKbaCjmBQsXq6FSPyaE1C3rmKQujp9k8ufHRf5LNiYkxwM
   8afz+QdHv1qnb+fFbjz6nhZ81ALIz+N+LI/BAgexoHqWbiubIe7bbU+tp
   ZQTiPwH9VelJiE27Z+IPy78qAO9DXxI4fXbzLboXzrBCbCZfexJtHMVkz
   w=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="402162364"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:52:10 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:17093]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.80:2525] with esmtp (Farcaster)
 id 6f63b893-adde-4c3f-b595-c77d23d59666; Sun, 9 Jun 2024 15:52:09 +0000 (UTC)
X-Farcaster-Flow-ID: 6f63b893-adde-4c3f-b595-c77d23d59666
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:52:06 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:52:00 +0000
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
Subject: [PATCH 03/18] hyperv-tlfs: Update struct hv_send_ipi{_ex}'s declarations
Date: Sun, 9 Jun 2024 15:49:31 +0000
Message-ID: <20240609154945.55332-4-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Both 'struct hv_send_ipi' and 'struct hv_send_ipi_ex' have an 'union
hv_input_vtl' parameter which has been ignored until now. Expose it, as
KVM will soon provide a way of dealing with VTL-aware IPIs. While doing
Also fixup __send_ipi_mask_ex().

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/hyperv/hv_apic.c         | 3 +--
 include/asm-generic/hyperv-tlfs.h | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 0569f579338b5..97907371d51ef 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -121,9 +121,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	if (unlikely(!ipi_arg))
 		goto ipi_mask_ex_done;
 
+	memset(ipi_arg, 0, sizeof(*ipi_arg));
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
-	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
 	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index ffac04bbd0c19..28cde641b5474 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -425,14 +425,16 @@ struct hv_vpset {
 /* HvCallSendSyntheticClusterIpi hypercall */
 struct hv_send_ipi {
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	u64 cpu_mask;
 } __packed;
 
 /* HvCallSendSyntheticClusterIpiEx hypercall */
 struct hv_send_ipi_ex {
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	struct hv_vpset vp_set;
 } __packed;
 
-- 
2.40.1


