Return-Path: <linux-arch+bounces-10789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382A2A609C3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FA217FDCB
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134D51F9423;
	Fri, 14 Mar 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEzI4GuC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687731F8BC9
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936369; cv=none; b=lW9vcAWrHG9ayevmpoQ2bUDnFStlRANAwrRR3D3kuaMVMx1ufsDsY8sEkrPKyA82LGkxPjaRikGFawpxWAZB8fKf9BTXtehubFczi80yGugDCuClxYSEyL0ZUy9OEWJHydZNKFVf2xu2WJyrYCjpU2p/SRoy+bKHyN2yr3Ri68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936369; c=relaxed/simple;
	bh=1j0Mrd2rcBno9V6DH6g7CSktn53jiGMVdlVE1hYrAVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/LubJ7UFkpZRXZkWIfXqBoWXubECRRPAeCHPphpsVUjr9GkD/mfMSuywebKF9UGMkATV/KC4VRDt5d6aX7AP1DCjPWccGX6ahO8cz0lF63lGA8QPtLqmTfIQnE1boss9vBaXtBB0ByVq0er/fJaBiCq12cmdUT5oOxrtg+LTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEzI4GuC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veC7XCo0gVBQGktNBcDEdjyEba98cZW4hqHPof6J04Y=;
	b=EEzI4GuCqR2wMUpKeWRb9PdIQFTA73ezGFPtaxYijl0srZ/9CIelh7xWBQoIanOUkn3w8t
	ebLqpibOXu/0Z6MCDJ0xWSYLaDx8Xx+BP4H0Of63UXQtgyifekwyEC3usQGB/8QNzY39TC
	Nd0JPH7/plKm1ZAU1rXbfdEa5a9qgXs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-jacOdnosOwSigk_unp9IQg-1; Fri,
 14 Mar 2025 03:12:41 -0400
X-MC-Unique: jacOdnosOwSigk_unp9IQg-1
X-Mimecast-MFC-AGG-ID: jacOdnosOwSigk_unp9IQg_1741936360
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C9F8180AB16;
	Fri, 14 Mar 2025 07:12:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFE9518001DE;
	Fri, 14 Mar 2025 07:12:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 31/41] s390x: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:10:02 +0100
Message-ID: <20250314071013.1575167-32-thuth@redhat.com>
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

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/boot/boot.h                  | 4 ++--
 arch/s390/include/asm/alternative.h    | 6 +++---
 arch/s390/include/asm/asm-const.h      | 2 +-
 arch/s390/include/asm/cpu.h            | 4 ++--
 arch/s390/include/asm/cpu_mf-insn.h    | 4 ++--
 arch/s390/include/asm/ctlreg.h         | 4 ++--
 arch/s390/include/asm/dwarf.h          | 4 ++--
 arch/s390/include/asm/extmem.h         | 2 +-
 arch/s390/include/asm/fpu-insn-asm.h   | 4 ++--
 arch/s390/include/asm/fpu-insn.h       | 4 ++--
 arch/s390/include/asm/ftrace.h         | 4 ++--
 arch/s390/include/asm/irq.h            | 4 ++--
 arch/s390/include/asm/jump_label.h     | 4 ++--
 arch/s390/include/asm/lowcore.h        | 6 +++---
 arch/s390/include/asm/mem_encrypt.h    | 4 ++--
 arch/s390/include/asm/nmi.h            | 4 ++--
 arch/s390/include/asm/nospec-branch.h  | 4 ++--
 arch/s390/include/asm/nospec-insn.h    | 4 ++--
 arch/s390/include/asm/page.h           | 4 ++--
 arch/s390/include/asm/processor.h      | 4 ++--
 arch/s390/include/asm/ptrace.h         | 4 ++--
 arch/s390/include/asm/purgatory.h      | 4 ++--
 arch/s390/include/asm/sclp.h           | 4 ++--
 arch/s390/include/asm/setup.h          | 4 ++--
 arch/s390/include/asm/sigp.h           | 4 ++--
 arch/s390/include/asm/thread_info.h    | 2 +-
 arch/s390/include/asm/tpi.h            | 4 ++--
 arch/s390/include/asm/types.h          | 4 ++--
 arch/s390/include/asm/vdso.h           | 4 ++--
 arch/s390/include/asm/vdso/getrandom.h | 4 ++--
 arch/s390/include/asm/vdso/vsyscall.h  | 4 ++--
 arch/s390/net/bpf_jit.h                | 4 ++--
 32 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/arch/s390/boot/boot.h b/arch/s390/boot/boot.h
index 69f261566a64a..de399f7d4af2c 100644
--- a/arch/s390/boot/boot.h
+++ b/arch/s390/boot/boot.h
@@ -6,7 +6,7 @@
 
 #define IPL_START	0x200
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/printk.h>
 #include <asm/physmem_info.h>
@@ -125,5 +125,5 @@ static inline bool intersects(unsigned long addr0, unsigned long size0,
 {
 	return addr0 + size0 > addr1 && addr1 + size1 > addr0;
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* BOOT_BOOT_H */
diff --git a/arch/s390/include/asm/alternative.h b/arch/s390/include/asm/alternative.h
index 73e781b56bfe8..a05e91092e816 100644
--- a/arch/s390/include/asm/alternative.h
+++ b/arch/s390/include/asm/alternative.h
@@ -50,7 +50,7 @@
 #define ALT_LOWCORE			(ALT_CTX_EARLY << ALT_CTX_SHIFT		| \
 					 ALT_TYPE_LOWCORE << ALT_TYPE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/stddef.h>
@@ -182,7 +182,7 @@ static inline void apply_alternatives(struct alt_instr *start, struct alt_instr
 /* Use this macro if clobbers are needed without inputs. */
 #define ASM_NO_INPUT_CLOBBER(clobber...) : clobber
 
-#else  /* __ASSEMBLY__ */
+#else  /* __ASSEMBLER__ */
 
 /*
  * Issue one struct alt_instr descriptor entry (need to put it into
@@ -232,6 +232,6 @@ static inline void apply_alternatives(struct alt_instr *start, struct alt_instr
 	.popsection
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_S390_ALTERNATIVE_H */
diff --git a/arch/s390/include/asm/asm-const.h b/arch/s390/include/asm/asm-const.h
index 11f615eb00663..1cfffad9eea0b 100644
--- a/arch/s390/include/asm/asm-const.h
+++ b/arch/s390/include/asm/asm-const.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_ASM_CONST_H
 #define _ASM_S390_ASM_CONST_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #  define stringify_in_c(...)	__VA_ARGS__
 #else
 /* This version of stringify will deal with commas... */
diff --git a/arch/s390/include/asm/cpu.h b/arch/s390/include/asm/cpu.h
index 26c710cd34859..5672e3fab52b2 100644
--- a/arch/s390/include/asm/cpu.h
+++ b/arch/s390/include/asm/cpu.h
@@ -9,7 +9,7 @@
 #ifndef _ASM_S390_CPU_H
 #define _ASM_S390_CPU_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/jump_label.h>
@@ -24,5 +24,5 @@ struct cpuid
 
 DECLARE_STATIC_KEY_FALSE(cpu_has_bear);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_CPU_H */
diff --git a/arch/s390/include/asm/cpu_mf-insn.h b/arch/s390/include/asm/cpu_mf-insn.h
index a68b362e09647..941663939cc70 100644
--- a/arch/s390/include/asm/cpu_mf-insn.h
+++ b/arch/s390/include/asm/cpu_mf-insn.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_S390_CPU_MF_INSN_H
 #define _ASM_S390_CPU_MF_INSN_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* Macro to generate the STCCTM instruction with a customized
  * M3 field designating the counter set.
@@ -17,6 +17,6 @@
 	.insn	rsy,0xeb0000000017,\r1,\m3 & 0xf,\db2
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/s390/include/asm/ctlreg.h b/arch/s390/include/asm/ctlreg.h
index e6527f51ad0b5..e93cc240a1ed4 100644
--- a/arch/s390/include/asm/ctlreg.h
+++ b/arch/s390/include/asm/ctlreg.h
@@ -80,7 +80,7 @@
 #define CR14_EXTERNAL_DAMAGE_SUBMASK		BIT(CR14_EXTERNAL_DAMAGE_SUBMASK_BIT)
 #define CR14_WARNING_SUBMASK			BIT(CR14_WARNING_SUBMASK_BIT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/bug.h>
 
@@ -252,5 +252,5 @@ union ctlreg15 {
 	};
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_S390_CTLREG_H */
diff --git a/arch/s390/include/asm/dwarf.h b/arch/s390/include/asm/dwarf.h
index 390906b8e386e..e3ad6798d0cd0 100644
--- a/arch/s390/include/asm/dwarf.h
+++ b/arch/s390/include/asm/dwarf.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_DWARF_H
 #define _ASM_S390_DWARF_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
@@ -33,6 +33,6 @@
 	.cfi_sections .eh_frame, .debug_frame
 #endif
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* _ASM_S390_DWARF_H */
diff --git a/arch/s390/include/asm/extmem.h b/arch/s390/include/asm/extmem.h
index e0a06060afddc..225ee89c3f5e0 100644
--- a/arch/s390/include/asm/extmem.h
+++ b/arch/s390/include/asm/extmem.h
@@ -6,7 +6,7 @@
 
 #ifndef _ASM_S390X_DCSS_H
 #define _ASM_S390X_DCSS_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * DCSS segment is defined as a contiguous range of pages using DEFSEG command.
diff --git a/arch/s390/include/asm/fpu-insn-asm.h b/arch/s390/include/asm/fpu-insn-asm.h
index d296322be4bcc..cc0468fdf2d07 100644
--- a/arch/s390/include/asm/fpu-insn-asm.h
+++ b/arch/s390/include/asm/fpu-insn-asm.h
@@ -16,7 +16,7 @@
 #error only <asm/fpu-insn.h> can be included directly
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* Macros to generate vector instruction byte code */
 
@@ -750,5 +750,5 @@
 	MRXBOPC	0, 0x77, v1, v2, v3
 .endm
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif	/* __ASM_S390_FPU_INSN_ASM_H */
diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index f668bffd6dd3d..135bb89c0a893 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -9,7 +9,7 @@
 
 #include <asm/fpu-insn-asm.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/instrumented.h>
 #include <asm/asm-extable.h>
@@ -475,5 +475,5 @@ static __always_inline void fpu_vzero(u8 v)
 		     : "memory");
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif	/* __ASM_S390_FPU_INSN_H */
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 185331e91f83c..bee2d16c29517 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -5,7 +5,7 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #define MCOUNT_INSN_SIZE	6
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/stacktrace.h>
 
 static __always_inline unsigned long return_address(unsigned int n)
@@ -134,7 +134,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs);
 #define ftrace_graph_func ftrace_graph_func
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_FUNCTION_TRACER
 
diff --git a/arch/s390/include/asm/irq.h b/arch/s390/include/asm/irq.h
index d9e705f4a697e..d9ac6a839db3d 100644
--- a/arch/s390/include/asm/irq.h
+++ b/arch/s390/include/asm/irq.h
@@ -25,7 +25,7 @@
 #define EXT_IRQ_CP_SERVICE	0x2603
 #define EXT_IRQ_IUCV		0x4000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/hardirq.h>
 #include <linux/percpu.h>
@@ -121,6 +121,6 @@ void irq_subclass_unregister(enum irq_subclass subclass);
 
 #define irq_canonicalize(irq)  (irq)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index bf78cf381dfcd..d9cbc18f6b2ee 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -4,7 +4,7 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/stringify.h>
@@ -51,5 +51,5 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 42a092fa10297..8db0d18913e30 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -21,7 +21,7 @@
 
 #define LOWCORE_ALT_ADDRESS	_AC(0x70000, UL)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct pgm_tdb {
 	u64 data[32];
@@ -235,7 +235,7 @@ static inline void set_prefix(__u32 address)
 	asm volatile("spx %0" : : "Q" (address) : "memory");
 }
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 .macro GET_LC reg
 	ALTERNATIVE "llilh	\reg,0",					\
@@ -249,5 +249,5 @@ static inline void set_prefix(__u32 address)
 		ALT_LOWCORE
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_LOWCORE_H */
diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index b85e13505a0f2..28c83ec1f2430 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -2,11 +2,11 @@
 #ifndef S390_MEM_ENCRYPT_H__
 #define S390_MEM_ENCRYPT_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 int set_memory_encrypted(unsigned long vaddr, int numpages);
 int set_memory_decrypted(unsigned long vaddr, int numpages);
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* S390_MEM_ENCRYPT_H__ */
diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 227466ce9e416..6454c15318544 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -33,7 +33,7 @@
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
 #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 union mci {
 	unsigned long val;
@@ -104,5 +104,5 @@ void nmi_free_mcesa(u64 *mcesad);
 void s390_handle_mcck(void);
 void s390_do_machine_check(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_NMI_H */
diff --git a/arch/s390/include/asm/nospec-branch.h b/arch/s390/include/asm/nospec-branch.h
index 192835a3e24dc..47356531d2800 100644
--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_S390_EXPOLINE_H
 #define _ASM_S390_EXPOLINE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/facility.h>
@@ -46,6 +46,6 @@ void __s390_indirect_jump_r15(void);
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_S390_EXPOLINE_H */
diff --git a/arch/s390/include/asm/nospec-insn.h b/arch/s390/include/asm/nospec-insn.h
index cb15dd25bf219..75c083d02567f 100644
--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -5,7 +5,7 @@
 #include <linux/linkage.h>
 #include <asm/dwarf.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CC_USING_EXPOLINE
 
@@ -128,6 +128,6 @@
 	.endm
 #endif /* CC_USING_EXPOLINE */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_S390_NOSPEC_ASM_H */
diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 1ff145f7b52b1..739ed1a8405fe 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -33,7 +33,7 @@
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
 #include <asm/setup.h>
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 void __storage_key_init_range(unsigned long start, unsigned long end);
 
@@ -267,7 +267,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_NON_EXEC
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 4f8d5592c2981..3a0befc129024 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -26,7 +26,7 @@
 
 #define RESTART_FLAG_CTLREGS	_AC(1 << 0, U)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/cpumask.h>
 #include <linux/linkage.h>
@@ -419,6 +419,6 @@ static __always_inline void bpon(void)
 	asm volatile(ALTERNATIVE("nop", ".insn	rrf,0xb2e80000,0,0,13,0", ALT_SPEC(82)));
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_S390_PROCESSOR_H */
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 788bc4467445c..25da883e2255f 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -55,7 +55,7 @@
 			 PSW_DEFAULT_KEY | PSW_MASK_BASE | PSW_MASK_MCHECK | \
 			 PSW_MASK_PSTATE | PSW_ASC_PRIMARY)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct psw_bits {
 	unsigned long	     :	1;
@@ -263,5 +263,5 @@ static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
 	regs->gprs[2] = rc;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _S390_PTRACE_H */
diff --git a/arch/s390/include/asm/purgatory.h b/arch/s390/include/asm/purgatory.h
index e297bcfc476f6..4c7a43bc43a19 100644
--- a/arch/s390/include/asm/purgatory.h
+++ b/arch/s390/include/asm/purgatory.h
@@ -7,11 +7,11 @@
 
 #ifndef _S390_PURGATORY_H_
 #define _S390_PURGATORY_H_
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/purgatory.h>
 
 int verify_sha256_digest(void);
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 #endif /* _S390_PURGATORY_H_ */
diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
index 18f37dff03c99..d472913e6bb0f 100644
--- a/arch/s390/include/asm/sclp.h
+++ b/arch/s390/include/asm/sclp.h
@@ -21,7 +21,7 @@
 #define SCLP_ERRNOTIFY_AQ_INFO_LOG		2
 #define SCLP_ERRNOTIFY_AQ_OPTICS_DATA		3
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/uio.h>
 #include <asm/chpid.h>
 #include <asm/cpu.h>
@@ -198,5 +198,5 @@ static inline int sclp_get_core_info(struct sclp_core_info *info, int early)
 	return _sclp_get_core_info(info);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_SCLP_H */
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 70b920b32827e..f8a6eba279dbf 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -46,7 +46,7 @@
 
 #define LEGACY_COMMAND_LINE_SIZE	896
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/lowcore.h>
 #include <asm/types.h>
@@ -142,5 +142,5 @@ static __always_inline u32 gen_lpswe(unsigned long addr)
 	BUILD_BUG_ON(addr > 0xfff);
 	return 0xb2b20000 | addr;
 }
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_SETUP_H */
diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index 472943b770662..97d77868f83ce 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -36,7 +36,7 @@
 #define SIGP_STATUS_INCORRECT_STATE	0x00000200UL
 #define SIGP_STATUS_NOT_RUNNING		0x00000400UL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
 
@@ -68,6 +68,6 @@ static inline int __pcpu_sigp(u16 addr, u8 order, unsigned long parm,
 	return cc;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __S390_ASM_SIGP_H */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index c33f7144d1b97..6cd0465745d86 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -26,7 +26,7 @@
 
 #define STACK_INIT_OFFSET (THREAD_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/lowcore.h>
 #include <asm/page.h>
 
diff --git a/arch/s390/include/asm/tpi.h b/arch/s390/include/asm/tpi.h
index f76e5fdff23a2..71c8b6f76cdd2 100644
--- a/arch/s390/include/asm/tpi.h
+++ b/arch/s390/include/asm/tpi.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <uapi/asm/schid.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* I/O-Interruption Code as stored by TEST PENDING INTERRUPTION (TPI). */
 struct tpi_info {
@@ -32,6 +32,6 @@ struct tpi_adapter_info {
 	u32 :27;
 } __packed __aligned(4);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_S390_TPI_H */
diff --git a/arch/s390/include/asm/types.h b/arch/s390/include/asm/types.h
index 0b5d550a0478b..53695b2196f78 100644
--- a/arch/s390/include/asm/types.h
+++ b/arch/s390/include/asm/types.h
@@ -5,7 +5,7 @@
 
 #include <uapi/asm/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 union register_pair {
 	unsigned __int128 pair;
@@ -15,5 +15,5 @@ union register_pair {
 	};
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_S390_TYPES_H */
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 92c73e4d97a93..5913c3a38192e 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -4,13 +4,13 @@
 
 #include <vdso/datapage.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern struct vdso_data *vdso_data;
 
 int vdso_getcpu_init(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define __VVAR_PAGES	2
 
diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/vdso/getrandom.h
index 36355af7160be..d9a59221aa87a 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_VDSO_GETRANDOM_H
 #define __ASM_VDSO_GETRANDOM_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
 #include <asm/vdso/vsyscall.h>
@@ -35,6 +35,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void
 	return &_vdso_rng_data;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
index 3eb576ecd3bd9..2b58681e6011f 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -4,7 +4,7 @@
 
 #define __VDSO_RND_DATA_OFFSET	768
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/hrtimer.h>
 #include <vdso/datapage.h>
@@ -31,6 +31,6 @@ static __always_inline struct vdso_rng_data *__s390_get_k_vdso_rnd_data(void)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/s390/net/bpf_jit.h b/arch/s390/net/bpf_jit.h
index 7822ea92e54af..615e6da713745 100644
--- a/arch/s390/net/bpf_jit.h
+++ b/arch/s390/net/bpf_jit.h
@@ -11,12 +11,12 @@
 #ifndef __ARCH_S390_NET_BPF_JIT_H
 #define __ARCH_S390_NET_BPF_JIT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/filter.h>
 #include <linux/types.h>
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Stackframe layout (packed stack):
-- 
2.48.1


