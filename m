Return-Path: <linux-arch+bounces-10779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E880CA609A9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B6117F42B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376A1E521B;
	Fri, 14 Mar 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILX5Oqpu"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F31EE7B3
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936322; cv=none; b=mjTPGzDdVSckfYAdjP4OW+b5URpWDEikdyFhELbphHpmpajSzrjhygAZdpHJLwHo+SckYQ7um7I0sF8xP5EvemcSZPY3/IL3hzKkG/Q7c1ikKKo2FQceqYCZh1rFJcffSLrIRP74JfvsWDDWb5Ppzk8kwD/hwPVSfvXAFn7yefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936322; c=relaxed/simple;
	bh=KkmkmAuetJOmZ51LkCpnDWW6Qh90sIhoC9OqtrRDe9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9FoJLubuySvo3lnzTdui/fDqyMjNJNGt2TLXiUZLJl18+VF5TLtU7Tz9P4k9AxoTZgPVrKlefqI23ayZgBtYjZJGSYE2xxlyy44CXBmwCuJ8ZsayvFCsJ/ocFbSonTUJFxI8G0evsZ3nLlHaqtajlF2sLXQ8DzCe9N0Kew8B7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILX5Oqpu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeukQ1SXpPcXv8185pK8ZpJPa413R1od3ox35AbmyJQ=;
	b=ILX5OqpubHTNHGefR7J2gVRjS771RRCxqlJfN5jrSPe0LxtRcmOq7qqrFZIjOikHaZSAJG
	7W8dm6Jpka4q0bUcTks9+CeHnQQyGAlb8JRn6/TSnTHDMr5b7jLMQOx8E3S0Or/Gj19hlh
	uy+GwQolHX9nZIpH0GKGysPgMW6Edp8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-HRbBm6RYNz6bE2k3uri9xw-1; Fri,
 14 Mar 2025 03:11:56 -0400
X-MC-Unique: HRbBm6RYNz6bE2k3uri9xw-1
X-Mimecast-MFC-AGG-ID: HRbBm6RYNz6bE2k3uri9xw_1741936315
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E668C1955DB9;
	Fri, 14 Mar 2025 07:11:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A210F18001D4;
	Fri, 14 Mar 2025 07:11:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 21/41] nios2: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:52 +0100
Message-ID: <20250314071013.1575167-22-thuth@redhat.com>
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

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/nios2/include/asm/entry.h       | 4 ++--
 arch/nios2/include/asm/page.h        | 4 ++--
 arch/nios2/include/asm/processor.h   | 4 ++--
 arch/nios2/include/asm/ptrace.h      | 4 ++--
 arch/nios2/include/asm/registers.h   | 4 ++--
 arch/nios2/include/asm/setup.h       | 4 ++--
 arch/nios2/include/asm/thread_info.h | 4 ++--
 arch/nios2/include/asm/traps.h       | 2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/nios2/include/asm/entry.h b/arch/nios2/include/asm/entry.h
index bafb7b2ca59fc..cb25ed56450ab 100644
--- a/arch/nios2/include/asm/entry.h
+++ b/arch/nios2/include/asm/entry.h
@@ -10,7 +10,7 @@
 #ifndef _ASM_NIOS2_ENTRY_H
 #define _ASM_NIOS2_ENTRY_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #include <asm/processor.h>
 #include <asm/registers.h>
@@ -117,5 +117,5 @@
 	addi	sp, sp, SWITCH_STACK_SIZE
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_NIOS2_ENTRY_H */
diff --git a/arch/nios2/include/asm/page.h b/arch/nios2/include/asm/page.h
index 2897ec1b74f61..00a51623d38a5 100644
--- a/arch/nios2/include/asm/page.h
+++ b/arch/nios2/include/asm/page.h
@@ -26,7 +26,7 @@
 #define PAGE_OFFSET	\
 	(CONFIG_NIOS2_MEM_BASE + CONFIG_NIOS2_KERNEL_REGION_BASE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This gives the physical RAM offset.
@@ -90,6 +90,6 @@ extern struct page *mem_map;
 
 #include <asm-generic/getorder.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_NIOS2_PAGE_H */
diff --git a/arch/nios2/include/asm/processor.h b/arch/nios2/include/asm/processor.h
index eb44130364a9a..d9521c3c2df98 100644
--- a/arch/nios2/include/asm/processor.h
+++ b/arch/nios2/include/asm/processor.h
@@ -36,7 +36,7 @@
 /* Kuser helpers is mapped to this user space address */
 #define KUSER_BASE		0x1000
 #define KUSER_SIZE		(PAGE_SIZE)
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 # define TASK_SIZE		0x7FFF0000UL
 # define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
@@ -72,6 +72,6 @@ extern unsigned long __get_wchan(struct task_struct *p);
 
 #define cpu_relax()	barrier()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_NIOS2_PROCESSOR_H */
diff --git a/arch/nios2/include/asm/ptrace.h b/arch/nios2/include/asm/ptrace.h
index 9da34c3022a27..96cbcd40c7ce5 100644
--- a/arch/nios2/include/asm/ptrace.h
+++ b/arch/nios2/include/asm/ptrace.h
@@ -18,7 +18,7 @@
 /* This struct defines the way the registers are stored on the
    stack during a system call.  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct pt_regs {
 	unsigned long  r8;	/* r8-r15 Caller-saved GP registers */
 	unsigned long  r9;
@@ -78,5 +78,5 @@ extern void show_regs(struct pt_regs *);
 
 int do_syscall_trace_enter(void);
 void do_syscall_trace_exit(void);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_NIOS2_PTRACE_H */
diff --git a/arch/nios2/include/asm/registers.h b/arch/nios2/include/asm/registers.h
index 95b67dd16f818..165dab26221f2 100644
--- a/arch/nios2/include/asm/registers.h
+++ b/arch/nios2/include/asm/registers.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_NIOS2_REGISTERS_H
 #define _ASM_NIOS2_REGISTERS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cpuinfo.h>
 #endif
 
@@ -44,7 +44,7 @@
 
 /* tlbmisc register bits */
 #define TLBMISC_PID_SHIFT	4
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define TLBMISC_PID_MASK	((1UL << cpuinfo.tlb_pid_num_bits) - 1)
 #endif
 #define TLBMISC_WAY_MASK	0xf
diff --git a/arch/nios2/include/asm/setup.h b/arch/nios2/include/asm/setup.h
index 908a1526d1bd7..6d3f26a71cb51 100644
--- a/arch/nios2/include/asm/setup.h
+++ b/arch/nios2/include/asm/setup.h
@@ -8,7 +8,7 @@
 
 #include <asm-generic/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef __KERNEL__
 
 extern char exception_handler_hook[];
@@ -18,6 +18,6 @@ extern char fast_handler_end[];
 extern void pagetable_init(void);
 
 #endif/* __KERNEL__ */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_NIOS2_SETUP_H */
diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 5abac9893b32b..83df79286d62e 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -24,7 +24,7 @@
 #define THREAD_SIZE_ORDER	1
 #define THREAD_SIZE		8192 /* 2 * PAGE_SIZE */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -61,7 +61,7 @@ static inline struct thread_info *current_thread_info(void)
 
 	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * thread information flags
diff --git a/arch/nios2/include/asm/traps.h b/arch/nios2/include/asm/traps.h
index afd77bef01c65..133a3dedbc3e8 100644
--- a/arch/nios2/include/asm/traps.h
+++ b/arch/nios2/include/asm/traps.h
@@ -12,7 +12,7 @@
 
 #define TRAP_ID_SYSCALL		0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 void _exception(int signo, struct pt_regs *regs, int code, unsigned long addr);
 void do_page_fault(struct pt_regs *regs, unsigned long cause,
 		   unsigned long address);
-- 
2.48.1


