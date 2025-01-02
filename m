Return-Path: <linux-arch+bounces-9558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05409FFE91
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9389D3A24B1
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B251B87E5;
	Thu,  2 Jan 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="vLWG7sfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iF5liQzE"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3841B87C7;
	Thu,  2 Jan 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842886; cv=none; b=kmnqlDLsSwxKgLS+ffm5YsVzh3RtZi2j7UdLDQBRWI6wC58obcZS4NBED/6Sf0IA/7SXlDKAi1Kl8Dhxd5T+CnlquNSg1Qybarja2yAZ08TfMo7VYXE/EUOEyaOOaTFatvrKumpV7qpwiLlb75GuDcjDv0G8W+/hOxjwl9TWNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842886; c=relaxed/simple;
	bh=w4f3TlGw9XqnVwPa+FzSha4Az1WTx3zGdxtidn31rb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjqsWYwXnzzsIZQS5lJko+EIVy4sPVuc0HNid+87j5famYSVFtd8Tn7h49aZWYCSkZ25EmtUtCFrbTFWbgkvcBsZRd2jR7CZ9eqncrT5YbH0Eu51B8WoOL+034JhTKL0OXrs1WYDSM1hqMCybw6bBp7mD0i8FKEHCfYt6DWxGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=vLWG7sfu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iF5liQzE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3879D1380198;
	Thu,  2 Jan 2025 13:34:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 02 Jan 2025 13:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735842883;
	 x=1735929283; bh=nQH07M+6II9wgzwQZvbsCpY0ojvdXDETDFiSzef6zZk=; b=
	vLWG7sfuzXPBOumAWhnaI/q9Arv45bY9sQmc27Z6iqer+atf85jQ6zwd4Cd7mEKo
	vRCGkwnxCtsnd40bTyZmP2iX0I9khB607cQojcqEvihB5AaU1ZW25a+6yOItwGWP
	NsG5zI4pTtpdCRmUAb0j4TnJRfxTGhTAxxLrQHauxWYBZ+iWHF4rhQ0MEh5uEukL
	We4rEKUmkx134PD3UxOKF21vFy0m3ACOwafb8RwQu4SiWBk/skm7vHuGeNj7k7Tz
	qhX2hCigAIdbyeR4sMjBe8+nhF0aSL5mFKFWJKX2+Wa9DsiU/eD7GXEeiVO5XxWP
	oS3DeXHj7MSZRHYfuAD0eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735842883; x=
	1735929283; bh=nQH07M+6II9wgzwQZvbsCpY0ojvdXDETDFiSzef6zZk=; b=i
	F5liQzEiUFTCZ7NhJZIkBs5JhiBcOVUnZmhUETsH1EYm6IC9hPsOoZZW95m5DNr1
	iIdqpFdcsNGcJ/urr4DbWwyPj/WJQPByHMu3ssgDZrGlCndMW3D5kETTxwt2v4Hf
	rRI+K2wE7F959gJFVrpvd36ppO2kKkv5+VW+K6j78r5F/9sPRSqzcDkFR3+La5TO
	rhob2eXWDQRv66/psxizqTm9yvJxXUPTku3PSoZEQWfO9Yn4AHlv79Y4NsNdhy44
	+w2XZ8jo1hRZ5/J58z5h/MUZeXNz4k2mljQTwuo+A/xbiwT7qy0va++gnWRimR/1
	q8aYK0VwOdfhAig9k3kNQ==
X-ME-Sender: <xms:Qtx2Z6zJnwo2J1oifckJMkIMwuA2W9EzCUD9XpJ6lrOVnQ-JHKwMhQ>
    <xme:Qtx2Z2SCv29PsHONCCEEkDnRS44mPP-l26R2i0Prsm9mOvlFg75YWvUkf15jVegax
    YQl_se2uC0NW8JSm1M>
X-ME-Received: <xmr:Qtx2Z8W0QIeCNipdjEizkmgoewVTSiVhgAOLLI4kuFW_lF1sBQ0wyzp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
    keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
    rdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    khgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggrih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgt
    phhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Qtx2ZwhidXmLy5kF1_0nZPKkCFshf6r5QNvKMFp3IOdLxTM9IRkXow>
    <xmx:Qtx2Z8CxsbjdklH3lHijNfcqo2fyP2afmywijMm0p23vsuL2u7K9Zg>
    <xmx:Qtx2ZxLLQSfKLXIEicxkVnpQ1WnzQ-LF3RLk3iSFUp5Pk6HLglkLyw>
    <xmx:Qtx2ZzA0qxYnKcHq6ajh7GWWBkuR0T8QSSydU7L_EDiJmmPGqyqFOQ>
    <xmx:Q9x2Z6BtXmZcbtzXxqS463FZY6mMajP3IAZQRSdQ5KUk144xVVjBt2GL>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 13:34:41 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 18:34:35 +0000
Subject: [PATCH 2/3] loongarch: Introduce sys_loongarch_flush_icache
 syscall
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-la32-uapi-v1-2-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
In-Reply-To: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=w4f3TlGw9XqnVwPa+FzSha4Az1WTx3zGdxtidn31rb4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSyO3Z/38ufjGVmL2Jc/6X52XGDO5dsV1QoV1YeUZtfU
 rz3E49MRykLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkaTrD/xiRSzWJuQV7/ITa
 q6qu/NrENflx2aKnJ/uTnqzY/15AyYvhf+Dq0+dbvjf9TZ1ZO1VoQrWMqqSJwRaHX12T75hvnV4
 5mRcA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

On LoongArch CPUs with ICACHET, writes automatically sync to both local and
remote instruction caches. CPUs without this feature lack userspace cache
flush instructions, requiring a syscall to maintain I/D cache coherence and
propagate to remote caches.

sys_loongarch_flush_icache() is defined to flush the instruction cache
over an address range, with the flush applying to either all threads or
just the caller.

Currently all LoongArch64 implementations from Loongson comes with ICACHET,
however most LoongArch32 implementations including openLA500 and emerging
third party LoongArch64 implementations such as WiredNG are coming without
ICACHET.

Sadly many user space applications are assuming ICACHET support, we can't
recall those binaries. So we'd better get UAPI for cacheflush ready soonish
and encourage application to start using it.

The syscall resolves to a ibar for now, it should be revised when we have
actual non-ICACHET support in kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/cacheflush.h |  6 ++++++
 arch/loongarch/include/asm/syscall.h    |  2 ++
 arch/loongarch/kernel/Makefile.syscalls |  3 +--
 arch/loongarch/kernel/syscall.c         | 28 ++++++++++++++++++++++++++++
 scripts/syscall.tbl                     |  2 ++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index f8754d08a31ab07490717c31b9253871668b9a76..94f4a47f00860977db0b360965a22ff0a461c098 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -80,6 +80,12 @@ static inline void flush_cache_line(int leaf, unsigned long addr)
 	}
 }
 
+/*
+ * Bits in sys_loongarch_flush_icache()'s flags argument.
+ */
+#define SYS_LOONGARCH_FLUSH_ICACHE_LOCAL 1UL
+#define SYS_LOONGARCH_FLUSH_ICACHE_ALL   (SYS_LOONGARCH_FLUSH_ICACHE_LOCAL)
+
 #include <asm-generic/cacheflush.h>
 
 #endif /* _ASM_CACHEFLUSH_H */
diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
index e286dc58476e6e6c5d126866a8590a96e4b4089a..6bd414a98a757de3c1bc78643fa1749f07efb1c0 100644
--- a/arch/loongarch/include/asm/syscall.h
+++ b/arch/loongarch/include/asm/syscall.h
@@ -71,4 +71,6 @@ static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 	return false;
 }
 
+asmlinkage long sys_loongarch_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+
 #endif	/* __ASM_LOONGARCH_SYSCALL_H */
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index ab7d9baa29152da97932c7e447a183fba265451c..11665e3000beffd24ef9d683a4ac337554e0b320 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# No special ABIs on loongarch so far
-syscall_abis_64 +=
+syscall_abis_64 += loongarch
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index b267db6ed79c20199504247c181cc245ef86abfd..2bc164d972b4d41c39e91481803d42bfd0184d3f 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -15,6 +15,7 @@
 #include <linux/unistd.h>
 
 #include <asm/asm.h>
+#include <asm/cacheflush.h>
 #include <asm/exception.h>
 #include <asm/loongarch.h>
 #include <asm/signal.h>
@@ -51,6 +52,33 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
 }
 #endif
 
+/*
+ * On LoongArch CPUs with ICACHET, writes automatically sync to both local and
+ * remote instruction caches. CPUs without this feature lack userspace cache
+ * flush instructions, requiring a syscall to maintain I/D cache coherence and
+ * propagate to remote caches.
+ *
+ * sys_loongarch_flush_icache() is defined to flush the instruction cache
+ * over an address range, with the flush applying to either all threads or
+ * just the caller.
+ */
+SYSCALL_DEFINE3(loongarch_flush_icache, uintptr_t, start, uintptr_t, end,
+	uintptr_t, flags)
+{
+	/* Check the reserved flags. */
+	if (unlikely(flags & ~SYS_LOONGARCH_FLUSH_ICACHE_ALL))
+		return -EINVAL;
+
+	/*
+	 * SYS_LOONGARCH_FLUSH_ICACHE_LOCAL is not handled so far, needs
+	 * to be realized when non-ICACHET CPUs are supported.
+	 */
+
+	flush_icache_user_range(start, end);
+
+	return 0;
+}
+
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
 #ifdef CONFIG_64BIT
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index ebbdb3c42e9f74613b003014c0baf44c842bb756..723fe859956809f26d6ec50ad7812933531ef687 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -298,6 +298,8 @@
 244	csky	set_thread_area			sys_set_thread_area
 245	csky	cacheflush			sys_cacheflush
 
+259	loongarch       loongarch_flush_icache	sys_loongarch_flush_icache
+
 244	nios2	cacheflush			sys_cacheflush
 
 244	or1k	or1k_atomic			sys_or1k_atomic

-- 
2.43.0


