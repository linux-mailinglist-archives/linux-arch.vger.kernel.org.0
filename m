Return-Path: <linux-arch+bounces-15002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9AC78534
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id BCA3431F0E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDED34C990;
	Fri, 21 Nov 2025 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnk2SFDB"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B95343208
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719283; cv=none; b=urm6u2fESMFOQXntd2xOlbeEzciouFNdHtKIbz+IsD7WI0EtnkeKkC31OQ9rKQMdJPzfRmaO+OkR1OIPWyUey3LGAPNbNqEO8/DPIk+zh80AqISlbpo2D3DbXmWsEeVnNpMOhDJ7qFOrX74wJRgWZG2/9oDDh+1FAl32xtnruG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719283; c=relaxed/simple;
	bh=LT1BUueUeG/RSYzxYTNK+EK8UtaLF3x8AM0qu8TrIFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG5xMXDHFNwTe7OQVav+9aFvYNaNfl+j7R/9ZYh3n6nNTWfrf/v7Jz1NqST62F43Mo3l7CH6fSFlb96W9rpeHUKDhuat4hdFSbu/GpnNjRdgqpAeD5XB+LQXyRYEt3RClyT6vsRk9Ns2bdRTgsE8ME3gSsFnlqOykntnMorNGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnk2SFDB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GrCua9hgAWiQ3//K2j8DdRzDOS0asZkTg7UL0JjeQzk=;
	b=hnk2SFDBhOrDChS1p1u48Dpu5zOUgQ+gIP2i6ozHFarxmmSfLRqn6DnHcAj4YK9Ef09q1w
	VZ//gV8X++ZsLnxsKVa6VrblIg+laS7J8iJT3HUnxgiS18CD731U1dvlHBnX5Q8Pa/4d6E
	x+SjktCS0Ila+MJZvhVOfUPe09EdYZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-JHYIc-gmNuCcW7X0uNxFAg-1; Fri,
 21 Nov 2025 05:01:17 -0500
X-MC-Unique: JHYIc-gmNuCcW7X0uNxFAg-1
X-Mimecast-MFC-AGG-ID: JHYIc-gmNuCcW7X0uNxFAg_1763719276
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 234A9180122F;
	Fri, 21 Nov 2025 10:01:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 979731956045;
	Fri, 21 Nov 2025 10:01:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	linux-hexagon@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v4 5/9] hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 21 Nov 2025 11:00:40 +0100
Message-ID: <20251121100044.282684-6-thuth@redhat.com>
In-Reply-To: <20251121100044.282684-1-thuth@redhat.com>
References: <20251121100044.282684-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Thomas Huth <thuth@redhat.com>

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/asm/hexagon_vm.h  |  4 ++--
 arch/hexagon/include/asm/mem-layout.h  |  6 +++---
 arch/hexagon/include/asm/page.h        |  4 ++--
 arch/hexagon/include/asm/processor.h   |  4 ++--
 arch/hexagon/include/asm/thread_info.h | 12 ++++++------
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 9aa2493fe7863..e1e702eb9e12a 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -39,7 +39,7 @@
 #define HVM_TRAP1_VMGETREGS		22
 #define HVM_TRAP1_VMTIMEROP		24
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum VM_CACHE_OPS {
 	hvmc_ickill,
@@ -178,7 +178,7 @@ static inline long __vmintop_clear(long i)
 
 #else /* Only assembly code should reference these */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Constants for virtual instruction parameters and return values
diff --git a/arch/hexagon/include/asm/mem-layout.h b/arch/hexagon/include/asm/mem-layout.h
index e2f99413fe56e..8bad920d8928a 100644
--- a/arch/hexagon/include/asm/mem-layout.h
+++ b/arch/hexagon/include/asm/mem-layout.h
@@ -25,7 +25,7 @@
  */
 
 #ifdef CONFIG_HEXAGON_PHYS_OFFSET
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long	__phys_offset;
 #endif
 #define PHYS_OFFSET	__phys_offset
@@ -44,7 +44,7 @@ extern unsigned long	__phys_offset;
 #define STACK_TOP			TASK_SIZE
 #define STACK_TOP_MAX			TASK_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 enum fixed_addresses {
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END,  /*  check for per-cpuism  */
@@ -101,7 +101,7 @@ extern int max_kernel_seg;
  * and pkmap_base begins.
  */
 #define VMALLOC_END (PKMAP_BASE-PAGE_SIZE*2)
-#endif /*  !__ASSEMBLY__  */
+#endif /*  !__ASSEMBLER__  */
 
 
 #endif /* _ASM_HEXAGON_MEM_LAYOUT_H */
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 137ba7c5de481..7e651428a08c0 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -48,7 +48,7 @@
 #include <vdso/page.h>
 
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This is for PFN_DOWN, which mm.h needs.  Seems the right place to pull it in.
@@ -128,7 +128,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 /* XXX Todo: implement assembly-optimized version of getorder. */
 #include <asm-generic/getorder.h>
 
-#endif /* ifdef __ASSEMBLY__ */
+#endif /* ifdef __ASSEMBLER__ */
 #endif /* ifdef __KERNEL__ */
 
 #endif
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index 0cd39c2cdf8f7..b93c2cc4be22e 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_PROCESSOR_H
 #define _ASM_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/mem-layout.h>
 #include <asm/registers.h>
@@ -124,6 +124,6 @@ struct hexagon_switch_stack {
 	unsigned long		lr;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif
diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index e90f280b9ce3e..a0da6c694c87b 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -10,7 +10,7 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <asm/registers.h>
 #include <asm/page.h>
@@ -20,7 +20,7 @@
 #define THREAD_SIZE		(1<<THREAD_SHIFT)
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This is union'd with the "bottom" of the kernel stack.
@@ -47,13 +47,13 @@ struct thread_info {
 	unsigned long		sp;
 };
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #include <asm/asm-offsets.h>
 
-#endif  /* __ASSEMBLY__  */
+#endif  /* __ASSEMBLER__  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define INIT_THREAD_INFO(tsk)                   \
 {                                               \
@@ -73,7 +73,7 @@ struct thread_info {
 register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define current_thread_info()  __current_thread_info
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * thread information flags
-- 
2.51.1


