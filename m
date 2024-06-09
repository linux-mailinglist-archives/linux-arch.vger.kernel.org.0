Return-Path: <linux-arch+bounces-4774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7319016BE
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436E31F21390
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEA46522;
	Sun,  9 Jun 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JKxPNg4v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911634436C;
	Sun,  9 Jun 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948555; cv=none; b=pXcgJGA/glsZP6KIxnYns33egmIIAOCyDQ3O90DX4tYUL9RN81JLTn/akFNfDBddMbNg4J1anT5rkc4YWVcbbxNrvPz4P363m/vGebxc+wDUMoUqD/dRQwuaTc2XzSu/BtUZsCyDi7pQnIjez8cRfh1Ub65zhpRAxY4kJZOMJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948555; c=relaxed/simple;
	bh=uCUtObTjiEnV3j9+EyoqPUnLoSRAi6mm5Lb+ySRZSYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7cnZxF0GB8lTDfXAc9J/Pt0rcCi1qkbmjCO41i/e/3DwNDQmVW4THqFfe3D5qiOnh61AScv+60/FBNhf2zZJMcO/WAiqnfG1QpwIa2dS8EBI6hPVpHZIs4RBAtLKFRnPL4p3X0S5VOJBwGncd6J+EiT255ps8VTMkq0EKFBEYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JKxPNg4v; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948554; x=1749484554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pM/dNrIh1bZMVrAjyRovRDN62/6qtCzxnE8/uU1weJg=;
  b=JKxPNg4vFliU63RiCUidd0OgqZXgZ059Ih1AiIKnmFKgmrU+0hx0d1L3
   rwbuMGoWUJCJAKhjx/xR2wfr6YUzDBHDbSCC857IDkxrvIyRWaXgRCJ71
   GdwxRNEX2fO5XkKWwIzmsnztxiNH78nKNQmrGoVdI2/WTF1CCOJZOWfQx
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="731692502"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:55:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:6729]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.168:2525] with esmtp (Farcaster)
 id 83a55886-23e8-4ce4-97de-7b5d50a5344d; Sun, 9 Jun 2024 15:55:46 +0000 (UTC)
X-Farcaster-Flow-ID: 83a55886-23e8-4ce4-97de-7b5d50a5344d
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:55:46 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:55:40 +0000
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
Subject: [PATCH 09/18] KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to userspace
Date: Sun, 9 Jun 2024 15:49:38 +0000
Message-ID: <20240609154945.55332-10-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

From: Anish Moorthy <amoorthy@google.com>

kvm_prepare_memory_fault_exit() already takes parameters describing the
RWX-ness of the relevant access but doesn't actually do anything with
them. Define and use the flags necessary to pass this information on to
userspace.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anish Moorthy <amoorthy@google.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst | 5 +++++
 include/linux/kvm_host.h       | 9 ++++++++-
 include/uapi/linux/kvm.h       | 3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 161a772c23c6a..761b99987cf1a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7014,6 +7014,9 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
 
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
+  #define KVM_MEMORY_EXIT_FLAG_READ     (1ULL << 0)
+  #define KVM_MEMORY_EXIT_FLAG_WRITE    (1ULL << 1)
+  #define KVM_MEMORY_EXIT_FLAG_EXEC     (1ULL << 2)
   #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 			__u64 flags;
 			__u64 gpa;
@@ -7025,6 +7028,8 @@ could not be resolved by KVM.  The 'gpa' and 'size' (in bytes) describe the
 guest physical address range [gpa, gpa + size) of the fault.  The 'flags' field
 describes properties of the faulting access that are likely pertinent:
 
+ - KVM_MEMORY_EXIT_FLAG_READ/WRITE/EXEC - When set, indicates that the memory
+   fault occurred on a read/write/exec access respectively.
  - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault occurred
    on a private memory access.  When clear, indicates the fault occurred on a
    shared access.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 692c01e41a18e..59f687985ba24 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2397,8 +2397,15 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 	vcpu->run->memory_fault.gpa = gpa;
 	vcpu->run->memory_fault.size = size;
 
-	/* RWX flags are not (yet) defined or communicated to userspace. */
 	vcpu->run->memory_fault.flags = 0;
+
+	if (is_write)
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_WRITE;
+	else if (is_exec)
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_EXEC;
+	else
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_READ;
+
 	if (is_private)
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f4864e6907e0b..d6d8b17bfa9a7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -434,6 +434,9 @@ struct kvm_run {
 		} notify;
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
+#define KVM_MEMORY_EXIT_FLAG_READ       (1ULL << 0)
+#define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
+#define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 			__u64 flags;
 			__u64 gpa;
-- 
2.40.1


