Return-Path: <linux-arch+bounces-4780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CE9016DB
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C04DB21BF7
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB404655F;
	Sun,  9 Jun 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ko0KIgPg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533346556;
	Sun,  9 Jun 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948705; cv=none; b=VVtpRjCylr40mp3/uHrJY7inp27Fk8aC1S4dlBRxSF8gMFfXPnA2U1+zh6B521QCc3xmO+ULtXlVuIcNmXciA/rg03LvTtNhseLy6I5wSwlPHfJqixsJqgrq1rA9ZndHCKfgbUmibGe0J2xfCqAZJq2PYD3vTkl8nwO5/2Ng/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948705; c=relaxed/simple;
	bh=qVgfWGR0+Ng2AEJqXpjr86a2GUm5d3YWtMQGcfiAaQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdxvLDrzhQDLehc3M+s8Ndn1XtRVQ9aaa5EIA9ng4ta2GUEDqQrPzjoBcnUuM0NVKRHakPZ4AQ8xDKL2pzDFUVMbZX7HNUVyKC28KyN5mKMRdKQ+pO00Umstpxmcm7Rzt8QCaZIWVmPoNgye+j000j7REiMcQ9JRT8IJEmDNNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ko0KIgPg; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948704; x=1749484704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDjK0O0oeCWydOTmjmrWgRDxqczH4M2zJ1FRXg/k93o=;
  b=ko0KIgPgvl/Me3//j1gkohZtJ/OdSoeu0FfjuMWEI4Bw/B+M2hI2XqbZ
   2wcxWU/bQAXY7f36kkyUh4XY41XrC82f7i4foJxAq+vDRdm6GHCKYpBFJ
   a9W0rDN+pPQkZdsIYLPtiAfenzxmsv3IBYI8ts2UCRBukeOQfM0gTonTo
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="412307001"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:58:20 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:16891]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.105:2525] with esmtp (Farcaster)
 id 802edc05-6356-4740-9bda-fb23ca1c6163; Sun, 9 Jun 2024 15:58:17 +0000 (UTC)
X-Farcaster-Flow-ID: 802edc05-6356-4740-9bda-fb23ca1c6163
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:58:17 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:58:11 +0000
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
Subject: [PATCH 15/18] KVM: Introduce RWX memory attributes
Date: Sun, 9 Jun 2024 15:49:44 +0000
Message-ID: <20240609154945.55332-16-nsaenz@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Declare memory attributes to map memory regions as non-readable,
non-writable, and/or non-executable.

The attributes are negated for the following reasons:
 - Setting a 0 memory attribute (attr->attributes == 0) shouldn't
   introduce any access restrictions. For example, when moving from
   private to shared mappings in context of confidential computing.
 - In practice, with negated attributes, a non-private RWX memory
   attribute is analogous to a delete operation. It's a nice outcome, as
   it forces remapping the region with huge-pages, doing the right thing
   for use-cases that have short-lived access restricted regions like
   Hyper-V's VSM.
 - A non-negated version of the flags has no way of expressing
   non-access mapping (NR/NW/NX) without having to introduce an extra
   flag (since 0 isn't available).

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
---
 Documentation/virt/kvm/api.rst | 14 +++++++++++---
 include/linux/kvm_host.h       | 22 +++++++++++++++++++++-
 include/uapi/linux/kvm.h       |  3 +++
 virt/kvm/kvm_main.c            | 32 +++++++++++++++++++++++++++++---
 4 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 18ddea9c4c58a..6d3bc5092ea63 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6313,15 +6313,23 @@ of guest physical memory.
 	__u64 flags;
   };
 
+  #define KVM_MEMORY_ATTRIBUTE_NR                (1ULL << 0)
+  #define KVM_MEMORY_ATTRIBUTE_NW                (1ULL << 1)
+  #define KVM_MEMORY_ATTRIBUTE_NX                (1ULL << 2)
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 The address and size must be page aligned.  The supported attributes can be
 retrieved via ioctl(KVM_CHECK_EXTENSION) on KVM_CAP_MEMORY_ATTRIBUTES.  If
 executed on a VM, KVM_CAP_MEMORY_ATTRIBUTES precisely returns the attributes
 supported by that VM.  If executed at system scope, KVM_CAP_MEMORY_ATTRIBUTES
-returns all attributes supported by KVM.  The only attribute defined at this
-time is KVM_MEMORY_ATTRIBUTE_PRIVATE, which marks the associated gfn as being
-guest private memory.
+returns all attributes supported by KVM.  The attribute defined at this
+time are:
+
+ - KVM_MEMORY_ATTRIBUTE_NR/NW/NX - Respectively marks the memory region as
+   non-read, non-write and/or non-exec.  Note that write-only, exec-only and
+   write-exec mappings are not supported.
+ - KVM_MEMORY_ATTRIBUTE_PRIVATE - Which marks the associated gfn as being guest
+   private memory.
 
 Note, there is no "get" API.  Userspace is responsible for explicitly tracking
 the state of a gfn/page as needed.
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9250bf1c4db15..85378345e8e77 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2411,6 +2411,21 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
 
+static inline bool kvm_mem_attributes_may_read(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NR);
+}
+
+static inline bool kvm_mem_attributes_may_write(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NW);
+}
+
+static inline bool kvm_mem_attributes_may_exec(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NX);
+}
+
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
@@ -2423,7 +2438,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
-
+bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 static inline bool kvm_memory_attributes_in_use(struct kvm *kvm)
 {
 	return !xa_empty(&kvm->mem_attr_array);
@@ -2435,6 +2450,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 	       kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
+static inline bool kvm_mem_attributes_valid(struct kvm *kvm,
+					    unsigned long attrs)
+{
+	return false;
+}
 static inline bool kvm_memory_attributes_in_use(struct kvm *kvm)
 {
 	return false;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 516d39910f9ab..26d4477dae8c6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1550,6 +1550,9 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 63c4b6739edee..bd27fc01e9715 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2430,10 +2430,14 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+	u64 supported_attrs = KVM_MEMORY_ATTRIBUTE_NR |
+			      KVM_MEMORY_ATTRIBUTE_NW |
+			      KVM_MEMORY_ATTRIBUTE_NX;
+
 	if (!kvm || kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+		supported_attrs |= KVM_MEMORY_ATTRIBUTE_PRIVATE;
 
-	return 0;
+	return supported_attrs;
 }
 
 static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
@@ -2557,6 +2561,28 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	return r;
 }
+
+bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
+{
+	bool may_read = kvm_mem_attributes_may_read(attrs);
+	bool may_write = kvm_mem_attributes_may_write(attrs);
+	bool may_exec = kvm_mem_attributes_may_exec(attrs);
+	bool priv = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	if (attrs & ~kvm_supported_mem_attributes(kvm))
+		return false;
+
+	/* Private memory and access permissions are incompatible */
+	if (priv && (!may_read || !may_write || !may_exec))
+		return false;
+
+	/* Write and exec mappings require read access */
+	if ((may_write || may_exec) && !may_read)
+		return false;
+
+	return true;
+}
+
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 					   struct kvm_memory_attributes *attrs)
 {
@@ -2565,7 +2591,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	/* flags is currently not used. */
 	if (attrs->flags)
 		return -EINVAL;
-	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+	if (!kvm_mem_attributes_valid(kvm, attrs->attributes))
 		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
-- 
2.40.1


