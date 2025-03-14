Return-Path: <linux-arch+bounces-10797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803EA609D6
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDCF46034C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510621ACED3;
	Fri, 14 Mar 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpSnj57o"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3D1FC7D7
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936407; cv=none; b=lxXAXMrWUPWf9rV6UwWDy6is9o/xBmuqqPE8odjdRSvdwvljF1fxmFtzCbgzeXub4XoTd5eHm4Hb34dwGv7Uu3A7VDfT2XnSrZswbbzVSl/Glj5Ze+x9tt8i7y1SjhJS0CUJ0VjjK940t+2MSUOUqG5gSdtyUXQqKjJNc5BItww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936407; c=relaxed/simple;
	bh=aqtt3culzYRwGYUdNSnvjRRRk1D882IdvQVzHi9xjys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndRPPXA2lQ269+Lhe7hFefQaU+15s+MdGF5jtpVuwWlkkpLZIqYWEcrpWz9FbuNyGHK+BGs0yyi9Lc3sBJ8OO1gbAK88oM4ASFRg2LN+qQGK4b08JN1mmBRGwL1cf7HSm8Mau4I6ByVuC5LPH6mTKXbYf2HmIHWFBaHpQpNHktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpSnj57o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RvarZCzaPXu4Zi+f86mBIqKEDbLmXQn+o/JyQQNW8o=;
	b=KpSnj57oO1CEjgxsEMz+OXQhLg37Z8ibFSjKrvdSdtCeq9UR7jfoBEllhqO6sGFEKDhOCW
	ofTE3d2V3e9uWsdHtfTrLg6Na0wjcp/mv2vVq2x5HIJHHafBL1zdovfoP9AQei2ubjkSAo
	ahAxJbTIvowWm81Wv0cZZIfu4WrWg0g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-F15eQqXIPymbldts10BFLA-1; Fri,
 14 Mar 2025 03:13:18 -0400
X-MC-Unique: F15eQqXIPymbldts10BFLA-1
X-Mimecast-MFC-AGG-ID: F15eQqXIPymbldts10BFLA_1741936397
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAAD2195609F;
	Fri, 14 Mar 2025 07:13:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 16C9A1801751;
	Fri, 14 Mar 2025 07:13:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 39/41] xtensa: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:10:10 +0100
Message-ID: <20250314071013.1575167-40-thuth@redhat.com>
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

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/xtensa/include/asm/bootparam.h      | 2 +-
 arch/xtensa/include/asm/cmpxchg.h        | 4 ++--
 arch/xtensa/include/asm/coprocessor.h    | 8 ++++----
 arch/xtensa/include/asm/current.h        | 2 +-
 arch/xtensa/include/asm/ftrace.h         | 8 ++++----
 arch/xtensa/include/asm/initialize_mmu.h | 4 ++--
 arch/xtensa/include/asm/jump_label.h     | 4 ++--
 arch/xtensa/include/asm/kasan.h          | 2 +-
 arch/xtensa/include/asm/kmem_layout.h    | 2 +-
 arch/xtensa/include/asm/page.h           | 4 ++--
 arch/xtensa/include/asm/pgtable.h        | 8 ++++----
 arch/xtensa/include/asm/processor.h      | 4 ++--
 arch/xtensa/include/asm/ptrace.h         | 6 +++---
 arch/xtensa/include/asm/signal.h         | 4 ++--
 arch/xtensa/include/asm/thread_info.h    | 8 ++++----
 arch/xtensa/include/asm/tlbflush.h       | 4 ++--
 16 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/xtensa/include/asm/bootparam.h b/arch/xtensa/include/asm/bootparam.h
index 6333bd1eb9d2a..a459ffbaf7ab1 100644
--- a/arch/xtensa/include/asm/bootparam.h
+++ b/arch/xtensa/include/asm/bootparam.h
@@ -27,7 +27,7 @@
 #define BP_TAG_FIRST		0x7B0B  /* first tag with a version number */
 #define BP_TAG_LAST 		0x7E0B	/* last tag */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* All records are aligned to 4 bytes */
 
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 95e33a913962d..b6db4838b175a 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -11,7 +11,7 @@
 #ifndef _XTENSA_CMPXCHG_H
 #define _XTENSA_CMPXCHG_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
@@ -220,6 +220,6 @@ __arch_xchg(unsigned long x, volatile void * ptr, int size)
 	}
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _XTENSA_CMPXCHG_H */
diff --git a/arch/xtensa/include/asm/coprocessor.h b/arch/xtensa/include/asm/coprocessor.h
index 3b1a0d5d2169d..e0447bcc52c50 100644
--- a/arch/xtensa/include/asm/coprocessor.h
+++ b/arch/xtensa/include/asm/coprocessor.h
@@ -16,7 +16,7 @@
 #include <asm/core.h>
 #include <asm/types.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # include <variant/tie-asm.h>
 
 .macro	xchal_sa_start  a b
@@ -69,7 +69,7 @@
 
 
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 /*
  * XTENSA_HAVE_COPROCESSOR(x) returns 1 if coprocessor x is configured.
@@ -87,7 +87,7 @@
 #define XTENSA_HAVE_IO_PORTS						\
 	XCHAL_CP_PORT_MASK
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Additional registers.
@@ -151,5 +151,5 @@ void local_coprocessors_flush_release_all(void);
 
 #endif	/* XTENSA_HAVE_COPROCESSORS */
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 #endif	/* _XTENSA_COPROCESSOR_H */
diff --git a/arch/xtensa/include/asm/current.h b/arch/xtensa/include/asm/current.h
index df275d5547884..7b483538f066c 100644
--- a/arch/xtensa/include/asm/current.h
+++ b/arch/xtensa/include/asm/current.h
@@ -13,7 +13,7 @@
 
 #include <asm/thread_info.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/thread_info.h>
 
diff --git a/arch/xtensa/include/asm/ftrace.h b/arch/xtensa/include/asm/ftrace.h
index 0ea4f84cd5581..f676d209d1105 100644
--- a/arch/xtensa/include/asm/ftrace.h
+++ b/arch/xtensa/include/asm/ftrace.h
@@ -12,20 +12,20 @@
 
 #include <asm/processor.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long return_address(unsigned level);
 #define ftrace_return_address(n) return_address(n)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
 
 #define MCOUNT_ADDR ((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE 3
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void _mcount(void);
 #define mcount _mcount
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
 #endif /* _XTENSA_FTRACE_H */
diff --git a/arch/xtensa/include/asm/initialize_mmu.h b/arch/xtensa/include/asm/initialize_mmu.h
index 574795a20d6f6..101bcb87e15be 100644
--- a/arch/xtensa/include/asm/initialize_mmu.h
+++ b/arch/xtensa/include/asm/initialize_mmu.h
@@ -34,7 +34,7 @@
 #define CA_WRITEBACK	(0x4)
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define XTENSA_HWVERSION_RC_2009_0 230000
 
@@ -240,6 +240,6 @@
 
 	.endm
 
-#endif /*__ASSEMBLY__*/
+#endif /*__ASSEMBLER__*/
 
 #endif /* _XTENSA_INITIALIZE_MMU_H */
diff --git a/arch/xtensa/include/asm/jump_label.h b/arch/xtensa/include/asm/jump_label.h
index 46c8596259d2d..38e3e2a9b0fb4 100644
--- a/arch/xtensa/include/asm/jump_label.h
+++ b/arch/xtensa/include/asm/jump_label.h
@@ -4,7 +4,7 @@
 #ifndef _ASM_XTENSA_JUMP_LABEL_H
 #define _ASM_XTENSA_JUMP_LABEL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -61,5 +61,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif
diff --git a/arch/xtensa/include/asm/kasan.h b/arch/xtensa/include/asm/kasan.h
index 8d2b4248466fd..0da91b64fab96 100644
--- a/arch/xtensa/include/asm/kasan.h
+++ b/arch/xtensa/include/asm/kasan.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_KASAN
 
diff --git a/arch/xtensa/include/asm/kmem_layout.h b/arch/xtensa/include/asm/kmem_layout.h
index 6fc05cba61a27..6949724625a07 100644
--- a/arch/xtensa/include/asm/kmem_layout.h
+++ b/arch/xtensa/include/asm/kmem_layout.h
@@ -80,7 +80,7 @@
 
 #if (!XCHAL_HAVE_PTP_MMU || XCHAL_HAVE_SPANNING_WAY) && defined(CONFIG_USE_OF)
 #define XCHAL_KIO_PADDR			xtensa_get_kio_paddr()
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long xtensa_kio_paddr;
 
 static inline unsigned long xtensa_get_kio_paddr(void)
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 644413792bf35..20655174b1115 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -80,7 +80,7 @@
 #endif
 
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define __pgprot(x)	(x)
 
@@ -172,7 +172,7 @@ static inline unsigned long ___pa(unsigned long va)
 #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #include <asm-generic/memory_model.h>
 #endif /* _XTENSA_PAGE_H */
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 1647a7cc3fbf6..46b634934f13f 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -203,7 +203,7 @@
  * What follows is the closest we can get by reasonable means..
  * See linux/mm/mmap.c for protection_map[] array that uses these definitions.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -372,10 +372,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-#endif /*  !defined (__ASSEMBLY__) */
+#endif /*  !defined (__ASSEMBLER__) */
 
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* Assembly macro _PGD_INDEX is the same as C pgd_index(unsigned long),
  *                _PGD_OFFSET as C pgd_offset(struct mm_struct*, unsigned long),
@@ -414,7 +414,7 @@ void update_mmu_tlb_range(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep, unsigned int nr);
 #define update_mmu_tlb_range update_mmu_tlb_range
 
-#endif /* !defined (__ASSEMBLY__) */
+#endif /* !defined (__ASSEMBLER__) */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index 47b5df86ab5c5..60a2113563358 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -105,7 +105,7 @@
 #error Unsupported xtensa ABI
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(__XTENSA_WINDOWED_ABI__)
 
@@ -263,5 +263,5 @@ static inline unsigned long get_er(unsigned long addr)
 
 #endif /* XCHAL_HAVE_EXTERN_REGS */
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif	/* _XTENSA_PROCESSOR_H */
diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index 86c70117371bb..f0f5e7c224c9e 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -41,7 +41,7 @@
 
 #define NO_SYSCALL (-1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/coprocessor.h>
 #include <asm/core.h>
@@ -109,11 +109,11 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 int do_syscall_trace_enter(struct pt_regs *regs);
 void do_syscall_trace_leave(struct pt_regs *regs);
 
-#else	/* __ASSEMBLY__ */
+#else	/* __ASSEMBLER__ */
 
 # include <asm/asm-offsets.h>
 #define PT_REGS_OFFSET	  (KERNEL_STACK_SIZE - PT_USER_SIZE)
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif	/* _XTENSA_PTRACE_H */
diff --git a/arch/xtensa/include/asm/signal.h b/arch/xtensa/include/asm/signal.h
index de169b4eaeef5..d301e68573cc1 100644
--- a/arch/xtensa/include/asm/signal.h
+++ b/arch/xtensa/include/asm/signal.h
@@ -14,10 +14,10 @@
 
 #include <uapi/asm/signal.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define __ARCH_HAS_SA_RESTORER
 
 #include <asm/sigcontext.h>
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif	/* _XTENSA_SIGNAL_H */
diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index e0dffcc43b9e6..5b74dfc35ef95 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -16,7 +16,7 @@
 
 #define CURRENT_SHIFT KERNEL_STACK_SHIFT
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # include <asm/processor.h>
 #endif
 
@@ -28,7 +28,7 @@
  *   must also be changed
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if XTENSA_HAVE_COPROCESSORS
 
@@ -80,7 +80,7 @@ struct thread_info {
  * macros/functions for gaining access to the thread information structure
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
@@ -99,7 +99,7 @@ static __always_inline struct thread_info *current_thread_info(void)
 	return ti;
 }
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg,sp) \
diff --git a/arch/xtensa/include/asm/tlbflush.h b/arch/xtensa/include/asm/tlbflush.h
index 573df8cea2006..3edaebeef4239 100644
--- a/arch/xtensa/include/asm/tlbflush.h
+++ b/arch/xtensa/include/asm/tlbflush.h
@@ -20,7 +20,7 @@
 #define ITLB_HIT_BIT	3
 #define DTLB_HIT_BIT	4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* TLB flushing:
  *
@@ -201,5 +201,5 @@ static inline unsigned long read_itlb_translation (int way)
 	return tmp;
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif	/* _XTENSA_TLBFLUSH_H */
-- 
2.48.1


