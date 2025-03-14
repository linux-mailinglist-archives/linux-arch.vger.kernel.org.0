Return-Path: <linux-arch+bounces-10769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB23CA60993
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2DD19C3E7A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475691C6FE0;
	Fri, 14 Mar 2025 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnBfDy/T"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8641C5D59
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936286; cv=none; b=gD6UsczVPwGGTS6mtasIXkp9RAyO//vvbpsXzS/N9AgfGcVx0njYxkVu28P2JtOLdRR+CRjmV8DosSQyUOcdOXtLaMQjDRCnX2iaGMw0dKhuYOLy3e4Xza4Bb9TtM7ZyBJv1a1bXIV09eCmOG4Hm93788W91IzcU4pEw0Wdi4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936286; c=relaxed/simple;
	bh=5uX+x+4I+PDtJMoHjQpZAuP4KuxPMCbKwnXvt63T+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uj27NXykiNH6Ub3TenGcScbYi9JJf8j0nlWTvg+jybqk9d+U3AQgS6/L+xKs/o3k6snk4+NmSCHxlqxtAtmAyJAWEN81JN/hGIvINyTU+XAlE9HAr/nUg+DNop3QzD3A1lcPC5yJL63RTnGxNMyv+wuUuTx0pQ50/zvKaItlFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnBfDy/T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPKXptQ7csh+TD1gzpwcBn/+Oau+AFcXhRBRZnuZIRw=;
	b=DnBfDy/TSGQ+Z5RUziorle67YTSVZRL4sUAV8MDq8+qi1DlHqc8FjK3i9iQK5XmZRxhAK/
	+parRPXuQcoLFeaIGNlm9g+NosEIfZhbGtEkf7VyfxR6He7wQj8h1YBA1lsWXEujrlaaKh
	+ufciBeHwrPs4HYa+a7gp6uLjc0QCI0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-v_rwsxSRP0e8iV3Df2eORg-1; Fri,
 14 Mar 2025 03:11:19 -0400
X-MC-Unique: v_rwsxSRP0e8iV3Df2eORg-1
X-Mimecast-MFC-AGG-ID: v_rwsxSRP0e8iV3Df2eORg_1741936278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE541955E93;
	Fri, 14 Mar 2025 07:11:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17FD218001DE;
	Fri, 14 Mar 2025 07:11:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH 11/41] csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:42 +0100
Message-ID: <20250314071013.1575167-12-thuth@redhat.com>
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

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
 arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
 arch/csky/include/asm/barrier.h     | 4 ++--
 arch/csky/include/asm/cache.h       | 2 +-
 arch/csky/include/asm/ftrace.h      | 4 ++--
 arch/csky/include/asm/jump_label.h  | 4 ++--
 arch/csky/include/asm/page.h        | 4 ++--
 arch/csky/include/asm/ptrace.h      | 4 ++--
 arch/csky/include/asm/string.h      | 2 +-
 arch/csky/include/asm/thread_info.h | 4 ++--
 10 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
index 7b386fd670702..c75ecf2cafd7c 100644
--- a/arch/csky/abiv1/inc/abi/regdef.h
+++ b/arch/csky/abiv1/inc/abi/regdef.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_REGDEF_H
 #define __ASM_CSKY_REGDEF_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define syscallid	r1
 #else
 #define syscallid	"r1"
diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
index 0933addbc27b7..fc08d56ccdbe1 100644
--- a/arch/csky/abiv2/inc/abi/regdef.h
+++ b/arch/csky/abiv2/inc/abi/regdef.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_REGDEF_H
 #define __ASM_CSKY_REGDEF_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define syscallid	r7
 #else
 #define syscallid	"r7"
diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index 15de58b10aece..c33fdcfe3770c 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_BARRIER_H
 #define __ASM_CSKY_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define nop()	asm volatile ("nop\n":::"memory")
 
@@ -84,5 +84,5 @@
 
 #include <asm-generic/barrier.h>
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_CSKY_BARRIER_H */
diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
index 4b5c09bf1d25e..d575482e0fcec 100644
--- a/arch/csky/include/asm/cache.h
+++ b/arch/csky/include/asm/cache.h
@@ -10,7 +10,7 @@
 
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 void dcache_wb_line(unsigned long start);
 
diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
index 00f9f7647e3f3..21532f2180587 100644
--- a/arch/csky/include/asm/ftrace.h
+++ b/arch/csky/include/asm/ftrace.h
@@ -11,7 +11,7 @@
 
 #define MCOUNT_ADDR	((unsigned long)_mcount)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void _mcount(unsigned long);
 
@@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_CSKY_FTRACE_H */
diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/jump_label.h
index ef2e37a10a0fe..603b0caa80249 100644
--- a/arch/csky/include/asm/jump_label.h
+++ b/arch/csky/include/asm/jump_label.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_CSKY_JUMP_LABEL_H
 #define __ASM_CSKY_JUMP_LABEL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
 				      enum jump_label_type type);
 #define arch_jump_label_transform_static arch_jump_label_transform_static
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif	/* __ASM_CSKY_JUMP_LABEL_H */
diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index 4911d0892b71d..76774dbce8697 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -26,7 +26,7 @@
 
 #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/pfn.h>
 
@@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_CSKY_PAGE_H */
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index 0634b7895d81d..5f01839e11843 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define PS_S	0x80000000 /* Supervisor Mode */
 
@@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs);
 asmlinkage void syscall_trace_exit(struct pt_regs *regs);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_CSKY_PTRACE_H */
diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
index a0d81e9d6b8f6..82e99f52b547c 100644
--- a/arch/csky/include/asm/string.h
+++ b/arch/csky/include/asm/string.h
@@ -3,7 +3,7 @@
 #ifndef _CSKY_STRING_MM_H_
 #define _CSKY_STRING_MM_H_
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <abi/string.h>
diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index b5ed788f0c681..fdd4f8ad45acf 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -3,7 +3,7 @@
 #ifndef _ASM_CSKY_THREAD_INFO_H
 #define _ASM_CSKY_THREAD_INFO_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/types.h>
 #include <asm/page.h>
@@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_info(void)
 	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
-- 
2.48.1


