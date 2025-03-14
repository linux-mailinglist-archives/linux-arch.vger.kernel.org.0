Return-Path: <linux-arch+bounces-10781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38240A609B9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940D319C5B9A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719C1F3D45;
	Fri, 14 Mar 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4mjwQCg"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CD1F03E6
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936332; cv=none; b=mb2MNWoO5j/MMCLfWjiDCap6B+jX42F3IpGgOeSrtRJaCJfcasWOfr9wBhkjrhHIUktOR+RMWh+UaWqIp0RJlfaguhrVeOkoa1jwa/sosb0061BKbuaZqh0Diq2sfWLWSxbr4+jiNW0gGcVcjBrso2GUbpC/m5hZr9JJBbVkciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936332; c=relaxed/simple;
	bh=ETUVBlNCkQiPn4rCiLpWhDeZBoJXyUYPqGFu8wF9fUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR9is0NZ3mX0ELsSLaJiWCchyQtwxoBi4FcOQ8FjgQFuuO5DarX/cwV4qbgfh2ozL/ji82/MFw5A1yBg2KJj4mQdp0+ZgCdT0GI86/AqmffAlaz70R5WmjRBNl4zopRhU+DvyW0vUEP4Tm+XW/P+Ar8CI6J6rAZQpUZ/TwgkzHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4mjwQCg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tT2AerwYb423gQ2eMXw5cvMrxGOebJDIGyb+UH4VhVQ=;
	b=N4mjwQCgRSL4R5lgSUmR5jbmzqhssqgw4fepgxmPczSkdQ7+IPBUuJY7h8GzjEHgWTKazY
	yqPeNsC0y3ZKtLAQKbdaZn7UHQXhI+8OR6+pV0Fn/Zi0EfEKztsoUujBg44NufTu3yBIe6
	Q98lqSFthvMrO7BQUYltPDISo3fXKac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-U1OlAOBDP761T-RI5656rA-1; Fri,
 14 Mar 2025 03:12:06 -0400
X-MC-Unique: U1OlAOBDP761T-RI5656rA-1
X-Mimecast-MFC-AGG-ID: U1OlAOBDP761T-RI5656rA_1741936324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E0781956048;
	Fri, 14 Mar 2025 07:12:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58CBA18001D4;
	Fri, 14 Mar 2025 07:12:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH 23/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:54 +0100
Message-ID: <20250314071013.1575167-24-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize on
the __ASSEMBLER__ macro that is provided by the compilers now.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/openrisc/include/asm/mmu.h         | 2 +-
 arch/openrisc/include/asm/page.h        | 8 ++++----
 arch/openrisc/include/asm/pgtable.h     | 4 ++--
 arch/openrisc/include/asm/processor.h   | 4 ++--
 arch/openrisc/include/asm/ptrace.h      | 4 ++--
 arch/openrisc/include/asm/setup.h       | 2 +-
 arch/openrisc/include/asm/thread_info.h | 8 ++++----
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/openrisc/include/asm/mmu.h b/arch/openrisc/include/asm/mmu.h
index eb720110f3a20..e7826a681bc4a 100644
--- a/arch/openrisc/include/asm/mmu.h
+++ b/arch/openrisc/include/asm/mmu.h
@@ -15,7 +15,7 @@
 #ifndef __ASM_OPENRISC_MMU_H
 #define __ASM_OPENRISC_MMU_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef unsigned long mm_context_t;
 #endif
 
diff --git a/arch/openrisc/include/asm/page.h b/arch/openrisc/include/asm/page.h
index c589e96035e15..85797f94d1d74 100644
--- a/arch/openrisc/include/asm/page.h
+++ b/arch/openrisc/include/asm/page.h
@@ -25,7 +25,7 @@
  */
 #include <asm/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define clear_page(page)	memset((page), 0, PAGE_SIZE)
 #define copy_page(to, from)	memcpy((to), (from), PAGE_SIZE)
@@ -55,10 +55,10 @@ typedef struct page *pgtable_t;
 #define __pgd(x)	((pgd_t) { (x) })
 #define __pgprot(x)	((pgprot_t) { (x) })
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
 #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
@@ -73,7 +73,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 
 #define virt_addr_valid(kaddr)	(pfn_valid(virt_to_pfn(kaddr)))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 60c6ce7ff2dcf..cd979bd28ab3b 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -23,7 +23,7 @@
 
 #include <asm-generic/pgtable-nopmd.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/mmu.h>
 #include <asm/fixmap.h>
 
@@ -432,5 +432,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 
 typedef pte_t *pte_addr_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_OPENRISC_PGTABLE_H */
diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index e05d1b59e24e1..3ff893a67c13b 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -39,7 +39,7 @@
  */
 #define TASK_UNMAPPED_BASE      (TASK_SIZE / 8 * 3)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct task_struct;
 
@@ -78,5 +78,5 @@ void show_registers(struct pt_regs *regs);
 
 #define cpu_relax()     barrier()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_OPENRISC_PROCESSOR_H */
diff --git a/arch/openrisc/include/asm/ptrace.h b/arch/openrisc/include/asm/ptrace.h
index e5a282b670757..28facf2f3e00c 100644
--- a/arch/openrisc/include/asm/ptrace.h
+++ b/arch/openrisc/include/asm/ptrace.h
@@ -27,7 +27,7 @@
  * they share a cacheline (not done yet, though... future optimization).
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * This struct describes how the registers are laid out on the kernel stack
  * during a syscall or other kernel entry.
@@ -147,7 +147,7 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 	return *(unsigned long *)((unsigned long)regs + offset);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Offsets used by 'ptrace' system call interface.
diff --git a/arch/openrisc/include/asm/setup.h b/arch/openrisc/include/asm/setup.h
index 9acbc5deda691..dce9f4d3b378f 100644
--- a/arch/openrisc/include/asm/setup.h
+++ b/arch/openrisc/include/asm/setup.h
@@ -8,7 +8,7 @@
 #include <linux/init.h>
 #include <asm-generic/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 void __init or1k_early_setup(void *fdt);
 #endif
 
diff --git a/arch/openrisc/include/asm/thread_info.h b/arch/openrisc/include/asm/thread_info.h
index 4af3049c34c21..e338fff7efb0e 100644
--- a/arch/openrisc/include/asm/thread_info.h
+++ b/arch/openrisc/include/asm/thread_info.h
@@ -17,7 +17,7 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/types.h>
 #include <asm/processor.h>
 #endif
@@ -38,7 +38,7 @@
  * - if the contents of this structure are changed, the assembly constants
  *   must also be changed
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
@@ -58,7 +58,7 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define INIT_THREAD_INFO(tsk)				\
 {							\
 	.task		= &tsk,				\
@@ -75,7 +75,7 @@ register struct thread_info *current_thread_info_reg asm("r10");
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * thread information flags
-- 
2.48.1


