Return-Path: <linux-arch+bounces-9559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E49FFE94
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 19:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19F21883709
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798481BAEF8;
	Thu,  2 Jan 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="RxWvuxry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CIp6ZmbE"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD11B87C8;
	Thu,  2 Jan 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842888; cv=none; b=eIAlual7Ni11Fx7a7ZXyGqCMXu9zE1hhLUNf429CeJlVkfJPHYY7GOrfdf2UVY5FVBwIO497hhvuhU+MfkmklCa2g+fU7z6pDCl7Pcg37a4xGf7YusJrFLonJdA+20DUA7P/xgEmXSXanVGZlCS6D62i8ptBL+MzmHwWI4gWnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842888; c=relaxed/simple;
	bh=yOrtMqTEXajMX/FmL8KpbG69isM181QHBtawwM9Q2fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLgRF6kQwq+tPC1oCPBy19a9HWwz/tBSJSRkQRpNrjXVAqpt2KdgKKmDqmqZ1kdoUR6ZYjBcPk8u7al/hmQTjdWfCQYQt9B5c8ZgVGx9Pmz5eNdveyvoaM+LuRTuId7hGtJcs9TGi315gi34E8x+sjnkMOsxhA15A2rRH7FU6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=RxWvuxry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CIp6ZmbE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0056811400F8;
	Thu,  2 Jan 2025 13:34:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jan 2025 13:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735842884;
	 x=1735929284; bh=07UcmEskV2VfZVwVOkMNDeq/FSvh/LVokBdz/HaClGo=; b=
	RxWvuxrygYTbvaU5lmpX7gzxLP7/oVeEHKS1zWHFsMP8xqfwex+Nc29mlptQDq+l
	/TcY1pCuvs4Olj3Jthr6BboUZwZ9pSJwVQvR9zwBTVUb10gj0m2p6wpkFy7i72ct
	mHdZ2zaUjJObIEEx/YfyQj+ODXR8m7vUfjOFhQwO91O9Kr03Y0SLWsWRT6elAE4Q
	pg8J+1M6TmmzynMfmbUa0qerntVSJv2oStJmA6pyd8tcomdNBlasxL3oK8aL3uzq
	3H8Jx0HJnP3wjnyQXKLd12PkRs41JfQ7ENeBGHqzZbaBdz0bpmxdNcESOiIVA6PL
	W1oRcYsRLK4UUJqO8TSTfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735842884; x=
	1735929284; bh=07UcmEskV2VfZVwVOkMNDeq/FSvh/LVokBdz/HaClGo=; b=C
	Ip6ZmbEtc5yvgPC3b9Q9vJkKkU1f3DspqGnYXkwWH/PA1ABfpNDEdVhT/MF4EFEz
	MaqEJs5gXusVHnVsapUaM85VfK6HX6B3DGJ12zc6dG5Nt1zlfsfimCSU9jLMq2KS
	O/KnhkHBGuZnx6hJ6VdCOT94rSO0T43TEspJkBuGDFvR9i9WGD9/yP8mPjyOerEf
	T+NxS+5EyjDJSujIluX37mpd8dVmFGBQ+/5qQ+Yj62Fp+nKxGCaaavW0A9x7uCrR
	ySmp4wDrnwOnZpbeA0EdqFLPSexJW7P77Jx6l0a0dM+atvzvROb0BXIFA02cSnIx
	DLUhEVwa9eUEKfcRUFICQ==
X-ME-Sender: <xms:RNx2Z9L6GJhI6N8XflfXAR5RCPdu4hDuTXGXnN3kQ6LTMrakFvPbgQ>
    <xme:RNx2Z5KTidEa5iV70XwEPEv72y1qmUQSbJOAzWwl_-ZwFkhOauPrunp0ubQE4nv0_
    FykuaukFk9clNeFQQg>
X-ME-Received: <xmr:RNx2Z1tZIXBfjm_ySqhK97WZyBHv2IUTbExrVDZYjVChz897F7Ex4k5D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeegfefgleektddtkeduvefffeek
    gfefgeejgefhkefhhefffeelteeuudetudfhvdenucffohhmrghinheplhgushdrshgsne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgig
    uhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoohhnghgrrhgthheslhhishhtshdrlhhi
    nhhugidruggvvhdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtg
    hpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    rhhnugesrghrnhgusgdruggvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirgiguhhnrdihrghnghesfhhlhihg
    ohgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RNx2Z-Y5QkN7QmY-qSiO7UNhoz-wdaShA0QZmB4oDCXwnLSJMPav0w>
    <xmx:RNx2Z0YPgzNTkWHgI952T7caVwBAjlsEXzoReuWOtG6S3H9MqcS3Cg>
    <xmx:RNx2ZyAB9fd0jsyOMmNMar67f0mjteuAlrCbZjwd_GNGCX_P7FRmKg>
    <xmx:RNx2ZybMce785aN3rDPu8H1br231O_D3J766K8vMMgrOjOcdS2VtyA>
    <xmx:RNx2Z04mp9emvkzhYLDlrBkz3_lw9XwL1Pwwyj-MAGocAAbL5k8vccG0>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 13:34:43 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 18:34:36 +0000
Subject: [PATCH 3/3] loongarch: vdso: Introduce __vdso_flush_icache
 function
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-la32-uapi-v1-3-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
In-Reply-To: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6056;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=yOrtMqTEXajMX/FmL8KpbG69isM181QHBtawwM9Q2fc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSyO3avLnAolIdL3+PyClOY/MVxXwCP8ARNNrmJd7j1u
 w6cV/neUcrCIMbFICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABOZGsTw35lt6S0lt8OLz1k2
 ihTwzVC7cme2WqP1vumHJd1Cs/6kz2VkmK74OXm1vIbd4qcnPhQY7PxWmfoy9e+a017u92aLv6u
 24wUA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Introduce __vdso_flush_icache function for performing cache
flush in userspace whenever possible.

It will use ibar in userspace if CPU comes with ICACHET support,
and fallback to syscall if not. It also made infra ready for
possible future userspace cache flush instruction.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/vdso/vdso.h     | 10 ++++++
 arch/loongarch/include/asm/vdso/vsyscall.h |  1 +
 arch/loongarch/kernel/vdso.c               |  2 ++
 arch/loongarch/mm/cache.c                  |  3 ++
 arch/loongarch/vdso/Makefile               |  2 +-
 arch/loongarch/vdso/flush_icache.c         | 50 ++++++++++++++++++++++++++++++
 arch/loongarch/vdso/vdso.lds.S             |  5 +++
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 1c183a9b2115a29a997ec8db0e788d87fb191dce..215b8c85fb2347a2ba9b53167a4343086efb9af3 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -13,6 +13,15 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 
+enum vdso_icacle_flush_mode {
+	VDSO_ICACLE_FLUSH_IBAR,
+	VDSO_ICACLE_FLUSH_FALLBACK,
+};
+
+struct vdso_icache_flush_data {
+	enum vdso_icacle_flush_mode mode;
+};
+
 struct vdso_pcpu_data {
 	u32 node;
 } ____cacheline_aligned_in_smp;
@@ -20,6 +29,7 @@ struct vdso_pcpu_data {
 struct loongarch_vdso_data {
 	struct vdso_pcpu_data pdata[NR_CPUS];
 	struct vdso_rng_data rng_data;
+	struct vdso_icache_flush_data icache_flush_data;
 };
 
 /*
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
index 8987e951d0a93c34ca75de676fb9c191ff4ef3c2..a02663ddf7cdccbe4b0e4c4d87b65874ab14070a 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -8,6 +8,7 @@
 
 extern struct vdso_data *vdso_data;
 extern struct vdso_rng_data *vdso_rng_data;
+extern struct vdso_icache_flush_data *vdso_icache_flush_data;
 
 static __always_inline
 struct vdso_data *__loongarch_get_k_vdso_data(void)
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 05e5fbac102a902016e633db75d9aff7ed550c50..4085452b3e1081e115d346f5870d54dad5c6ef54 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -36,6 +36,8 @@ static union {
 struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 struct vdso_rng_data *vdso_rng_data = &loongarch_vdso_data.vdata.rng_data;
+struct vdso_icache_flush_data *vdso_icache_flush_data =
+				&loongarch_vdso_data.vdata.icache_flush_data;
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
 {
diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 6be04d36ca0769658a2b52d25af50dd6ad7e07e0..a424a9b24827e5eb83a8d4db7da76b42ba3f4d8b 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -24,6 +24,7 @@
 #include <asm/numa.h>
 #include <asm/processor.h>
 #include <asm/setup.h>
+#include <asm/vdso/vsyscall.h>
 
 void cache_error_setup(void)
 {
@@ -156,6 +157,8 @@ void cpu_cache_init(void)
 
 	current_cpu_data.cache_leaves_present = leaf;
 	current_cpu_data.options |= LOONGARCH_CPU_PREFETCH;
+
+	vdso_icache_flush_data->mode = VDSO_ICACLE_FLUSH_IBAR;
 }
 
 static const pgprot_t protection_map[16] = {
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e2663bd400dcc6becc4261b7d5dce3a..8407d85548a4d4ff03571f35317ba2a0881f684c 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -4,7 +4,7 @@
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile
 
-obj-vdso-y := elf.o vgetcpu.o vgettimeofday.o vgetrandom.o \
+obj-vdso-y := elf.o flush_icache.o vgetcpu.o vgettimeofday.o vgetrandom.o \
               vgetrandom-chacha.o sigreturn.o
 
 # Common compiler flags between ABIs.
diff --git a/arch/loongarch/vdso/flush_icache.c b/arch/loongarch/vdso/flush_icache.c
new file mode 100644
index 0000000000000000000000000000000000000000..e1f95572175a0bf4c136afd1107ea2f8d8933b21
--- /dev/null
+++ b/arch/loongarch/vdso/flush_icache.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fast user context implementation of getcpu()
+ */
+
+#include <asm/vdso.h>
+#include <asm/unistd.h>
+
+static int flush_icache_ibar(void)
+{
+	__asm__ __volatile__ ("\tibar 0\n"::);
+
+	return 0;
+}
+
+static int flush_icache_fallback(uintptr_t start, uintptr_t end,
+				  uintptr_t flags)
+{
+	register long _num  __asm__ ("a7") = __NR_loongarch_flush_icache;
+	register long _arg1 __asm__ ("a0") = (long)(start);
+	register long _arg2 __asm__ ("a1") = (long)(end);
+	register long _arg3 __asm__ ("a2") = (long)(flags);
+
+	__asm__ volatile (
+		"syscall 0\n"
+		: "+r"(_arg1)
+		: "r"(_arg2), "r"(_arg3),
+		  "r"(_num)
+		: "memory", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5",
+		  "$t6", "$t7", "$t8"
+	);
+
+	return _arg1;
+}
+
+extern int __vdso_flush_icache(uintptr_t start, uintptr_t end,
+			       uintptr_t flags);
+int __vdso_flush_icache(uintptr_t start, uintptr_t end, uintptr_t flags)
+{
+
+	switch (_loongarch_data.icache_flush_data.mode) {
+	case VDSO_ICACLE_FLUSH_IBAR:
+		return flush_icache_ibar();
+	case VDSO_ICACLE_FLUSH_FALLBACK:
+	default:
+		return flush_icache_fallback(start, end, flags);
+	}
+
+	return -EINVAL;
+}
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 160cfaef2de45b1243502c7356f8a913658548fe..a1023d10fbb7b45c2a70ead0304c2753c05f9654 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -72,6 +72,11 @@ VERSION
 		__vdso_rt_sigreturn;
 	local: *;
 	};
+	LINUX_6.14 {
+	global:
+		__vdso_flush_icache;
+	local: *;
+	};
 }
 
 /*

-- 
2.43.0


