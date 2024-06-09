Return-Path: <linux-arch+bounces-4772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEC9016B1
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71133281735
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7746525;
	Sun,  9 Jun 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aUGeZdHJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CA7A3F;
	Sun,  9 Jun 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948500; cv=none; b=bWiujfr2V3VeeFfrU1RBsFIVPzrMiu4cTfNyUXKDG5Ob/om/IZuJHb2nUqowQIY15H4z9YvazOVYsp6FUM5YZKdJIFtgDL2CDzIDtiSCi4sA/rTKmTPAV4RBjmqbPqcbUG3+67jK9kB6He764nWTj49+QPbGogT5tftdZg5QG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948500; c=relaxed/simple;
	bh=zeOHXyH1AkerZ6qtIpe8nKHYadyVlMSclUF0sVIwb3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsxmJ+tyGwUJAxcSfAbNvtit0Wx8Nh5bPzf910ys+K+PMGMhx0fMbmpnlK1XTlOB1QiFf29HXe/cHuvHvSpGW423h1rOS+hkTZrdVnTyDv5WnDn5xa9d9LASDIGO9t9oNXO8SAec5BN3Y2oOM8NJPI+GHYfv/b49djbDijytaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aUGeZdHJ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948499; x=1749484499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/86j7aiva56pQ+cJSneB/HDhIcRakQ4RDBTmO4bL2M=;
  b=aUGeZdHJrXcuEuRcNj0qYPR1LOrOpm7p+86DzyrbMvwrzsksGCrea2ha
   E+ftxkxXEvYpzsem2MvPVBMqk4iWujFrCdTWRfSzf65bXUCAalGjBK9v4
   AT9uV3WGYv//eRCAsBUSqiq/TCjt6TCcgk6IkaAx4mYgcOJShqVLSBn0e
   k=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="95483540"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:54:57 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:59043]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.97:2525] with esmtp (Farcaster)
 id f5f950e2-1e34-489a-994f-b9379fca9c2d; Sun, 9 Jun 2024 15:54:56 +0000 (UTC)
X-Farcaster-Flow-ID: f5f950e2-1e34-489a-994f-b9379fca9c2d
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:54:56 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:54:49 +0000
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
Subject: [PATCH 07/18] KVM: x86: hyper-v: Exit on TranslateVirtualAddress hcall
Date: Sun, 9 Jun 2024 15:49:36 +0000
Message-ID: <20240609154945.55332-8-nsaenz@amazon.com>
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

Handle HvTranslateVirtualAddress in user-space. The hypercall is
VTL-aware and only used in the context of VSM. Additionally, the TLFS
doesn't introduce an ad-hoc CPUID bit for it, so the hypercall
availability is tracked as part of the HV_ACCESS_VSM CPUID. This will be
documented with the main VSM commit.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 arch/x86/kvm/hyperv.c             | 3 +++
 include/asm-generic/hyperv-tlfs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d0edc2bec5a4f..cbe2aca52514b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2427,6 +2427,7 @@ static bool kvm_hv_is_xmm_output_hcall(u16 code)
 {
 	switch (code) {
 	case HVCALL_GET_VP_REGISTERS:
+	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
 		return true;
 	}
 
@@ -2512,6 +2513,7 @@ static bool is_xmm_fast_hypercall(struct kvm_hv_hcall *hc)
 	case HVCALL_SEND_IPI_EX:
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
+	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
 		return true;
 	}
 
@@ -2740,6 +2742,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		goto hypercall_userspace_exit;
 	case HVCALL_GET_VP_REGISTERS:
 	case HVCALL_SET_VP_REGISTERS:
+	case HVCALL_TRANSLATE_VIRTUAL_ADDRESS:
 		goto hypercall_userspace_exit;
 	default:
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 9e909f0834598..57c791c555861 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -159,6 +159,7 @@ union hv_reference_tsc_msr {
 #define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
+#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 #define HVCALL_POST_DEBUG_DATA			0x0069
-- 
2.40.1


