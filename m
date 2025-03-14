Return-Path: <linux-arch+bounces-10795-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF31A609E3
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C55A3B6D8C
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006D1FC10D;
	Fri, 14 Mar 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMn7w7EL"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02111B414F
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936398; cv=none; b=BMPFczZEI4n5KdgI4M1mu+/aQUUrkDfUe4kw7wRvW3S2OGqxPjpHnTBH/H4JubosBtJlAsp1d/sUYiD8voAaNNyAbTRjfKeuY0rzS6HDmYDuM/kxKRxre/3wygdgAAm+G0fLsxfQwM81N3+RiurJGQ8mfBPR3SAU2dJ2H1TSGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936398; c=relaxed/simple;
	bh=6g7mnES0+75sIDVST8nCv0Z7mGbZywFFsXlvSb4YHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2iMCjhy8HtIdXA5hSKvMo+SvVtxcEAmK68vFA4YzcvbocVUau278Bou3pXJ+qGQIeuYJ851itAd/YO7it87pshReWVVoRJGBq4VgBSlTUxNnoPTCEkHf0aAerKiZoTnph5h/j13Cy6W4QeUuc125qGbx0fP/XrqEbxP7XvQ+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMn7w7EL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOIYMQ/AiyqDd5zwzLULUaA3WkFqK0aOYcLwBKiFDsA=;
	b=FMn7w7EL8/VvEwd3OhBVI6ncUAU/IhIaGdMzY+Tx6uAnJNK14DJcZIfTtsbiLUEjD08weo
	mugToTo+PCdvB7ZfsztYryh3fHhuc9dIP5quWbuDPGm7xqCB67bgcnCqm2O+CV6wWQc8GN
	bJqk+zpENe7tSblUeqD8hsFGeIuWlGc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-GeIWbMUIPvKWxIoaUC7ETw-1; Fri,
 14 Mar 2025 03:13:11 -0400
X-MC-Unique: GeIWbMUIPvKWxIoaUC7ETw-1
X-Mimecast-MFC-AGG-ID: GeIWbMUIPvKWxIoaUC7ETw_1741936390
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A07F3180AF4C;
	Fri, 14 Mar 2025 07:13:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA26318001DE;
	Fri, 14 Mar 2025 07:13:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [PATCH 37/41] x86: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:10:08 +0100
Message-ID: <20250314071013.1575167-38-thuth@redhat.com>
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

This is mostly a mechanical patch (done with a simple "sed -i"
statement), with some manual tweaks in arch/x86/include/asm/frame.h,
arch/x86/include/asm/hw_irq.h and arch/x86/include/asm/setup.h
that mentioned this macro in comments with some missing underscores.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/x86/boot/boot.h                        |  4 ++--
 arch/x86/entry/vdso/extable.h               |  2 +-
 arch/x86/include/asm/alternative.h          |  6 +++---
 arch/x86/include/asm/asm.h                  | 10 +++++-----
 arch/x86/include/asm/boot.h                 |  2 +-
 arch/x86/include/asm/cpufeature.h           |  4 ++--
 arch/x86/include/asm/cpumask.h              |  4 ++--
 arch/x86/include/asm/current.h              |  4 ++--
 arch/x86/include/asm/desc_defs.h            |  4 ++--
 arch/x86/include/asm/dwarf2.h               |  2 +-
 arch/x86/include/asm/fixmap.h               |  4 ++--
 arch/x86/include/asm/frame.h                | 10 +++++-----
 arch/x86/include/asm/fred.h                 |  4 ++--
 arch/x86/include/asm/fsgsbase.h             |  4 ++--
 arch/x86/include/asm/ftrace.h               |  8 ++++----
 arch/x86/include/asm/hw_irq.h               |  4 ++--
 arch/x86/include/asm/ibt.h                  | 12 ++++++------
 arch/x86/include/asm/idtentry.h             |  6 +++---
 arch/x86/include/asm/inst.h                 |  2 +-
 arch/x86/include/asm/irqflags.h             | 10 +++++-----
 arch/x86/include/asm/jump_label.h           |  4 ++--
 arch/x86/include/asm/kasan.h                |  2 +-
 arch/x86/include/asm/kexec.h                |  4 ++--
 arch/x86/include/asm/linkage.h              |  6 +++---
 arch/x86/include/asm/mem_encrypt.h          |  4 ++--
 arch/x86/include/asm/msr.h                  |  4 ++--
 arch/x86/include/asm/nops.h                 |  2 +-
 arch/x86/include/asm/nospec-branch.h        |  6 +++---
 arch/x86/include/asm/orc_types.h            |  4 ++--
 arch/x86/include/asm/page.h                 |  4 ++--
 arch/x86/include/asm/page_32.h              |  4 ++--
 arch/x86/include/asm/page_32_types.h        |  4 ++--
 arch/x86/include/asm/page_64.h              |  4 ++--
 arch/x86/include/asm/page_64_types.h        |  2 +-
 arch/x86/include/asm/page_types.h           |  4 ++--
 arch/x86/include/asm/paravirt.h             | 14 +++++++-------
 arch/x86/include/asm/paravirt_types.h       |  4 ++--
 arch/x86/include/asm/percpu.h               |  6 +++---
 arch/x86/include/asm/pgtable-2level_types.h |  4 ++--
 arch/x86/include/asm/pgtable-3level_types.h |  4 ++--
 arch/x86/include/asm/pgtable-invert.h       |  4 ++--
 arch/x86/include/asm/pgtable.h              | 12 ++++++------
 arch/x86/include/asm/pgtable_32.h           |  4 ++--
 arch/x86/include/asm/pgtable_32_areas.h     |  2 +-
 arch/x86/include/asm/pgtable_64.h           |  6 +++---
 arch/x86/include/asm/pgtable_64_types.h     |  4 ++--
 arch/x86/include/asm/pgtable_types.h        | 10 +++++-----
 arch/x86/include/asm/prom.h                 |  4 ++--
 arch/x86/include/asm/pti.h                  |  4 ++--
 arch/x86/include/asm/ptrace.h               |  4 ++--
 arch/x86/include/asm/purgatory.h            |  4 ++--
 arch/x86/include/asm/pvclock-abi.h          |  4 ++--
 arch/x86/include/asm/realmode.h             |  4 ++--
 arch/x86/include/asm/segment.h              |  8 ++++----
 arch/x86/include/asm/setup.h                |  6 +++---
 arch/x86/include/asm/setup_data.h           |  4 ++--
 arch/x86/include/asm/shared/tdx.h           |  4 ++--
 arch/x86/include/asm/shstk.h                |  4 ++--
 arch/x86/include/asm/signal.h               |  8 ++++----
 arch/x86/include/asm/smap.h                 |  6 +++---
 arch/x86/include/asm/smp.h                  |  4 ++--
 arch/x86/include/asm/tdx.h                  |  4 ++--
 arch/x86/include/asm/thread_info.h          | 12 ++++++------
 arch/x86/include/asm/unwind_hints.h         |  4 ++--
 arch/x86/include/asm/vdso/getrandom.h       |  4 ++--
 arch/x86/include/asm/vdso/gettimeofday.h    |  4 ++--
 arch/x86/include/asm/vdso/processor.h       |  4 ++--
 arch/x86/include/asm/vdso/vsyscall.h        |  4 ++--
 arch/x86/include/asm/xen/interface.h        | 10 +++++-----
 arch/x86/include/asm/xen/interface_32.h     |  4 ++--
 arch/x86/include/asm/xen/interface_64.h     |  4 ++--
 arch/x86/math-emu/control_w.h               |  2 +-
 arch/x86/math-emu/exception.h               |  6 +++---
 arch/x86/math-emu/fpu_emu.h                 |  6 +++---
 arch/x86/math-emu/status_w.h                |  6 +++---
 arch/x86/realmode/rm/realmode.h             |  4 ++--
 arch/x86/realmode/rm/wakeup.h               |  2 +-
 tools/arch/x86/include/asm/asm.h            |  8 ++++----
 tools/arch/x86/include/asm/nops.h           |  2 +-
 tools/arch/x86/include/asm/orc_types.h      |  4 ++--
 tools/arch/x86/include/asm/pvclock-abi.h    |  4 ++--
 81 files changed, 202 insertions(+), 202 deletions(-)

diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 0f24f7ebec9ba..38f17a1e1e367 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -16,7 +16,7 @@
 
 #define STACK_SIZE	1024	/* Minimum number of bytes for stack */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stdarg.h>
 #include <linux/types.h>
@@ -327,6 +327,6 @@ void probe_cards(int unsafe);
 /* video-vesa.c */
 void vesa_store_edid(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* BOOT_BOOT_H */
diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
index b56f6b0129416..baba612b832c3 100644
--- a/arch/x86/entry/vdso/extable.h
+++ b/arch/x86/entry/vdso/extable.h
@@ -7,7 +7,7 @@
  * vDSO uses a dedicated handler the addresses are relative to the overall
  * exception table, not each individual entry.
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
 	ASM_VDSO_EXTABLE_HANDLE from to
 
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e3903b731305c..8e4fb4828e1bd 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -15,7 +15,7 @@
 #define ALT_DIRECT_CALL(feature) ((ALT_FLAG_DIRECT_CALL << ALT_FLAGS_SHIFT) | (feature))
 #define ALT_CALL_ALWAYS		ALT_DIRECT_CALL(X86_FEATURE_ALWAYS)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stddef.h>
 
@@ -286,7 +286,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 void BUG_func(void);
 void nop_func(void);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_SMP
 	.macro LOCK_PREFIX
@@ -369,6 +369,6 @@ void nop_func(void);
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 	newinstr_yes, ft_flags
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_ALTERNATIVE_H */
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 2bec0c89a95c2..e9653ee72813c 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_ASM_H
 #define _ASM_X86_ASM_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
@@ -113,7 +113,7 @@
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef __pic__
 static __always_inline __pure void *rip_rel_ptr(void *p)
 {
@@ -144,7 +144,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 # include <asm/extable_fixup_types.h>
 
 /* Exception table entry */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
@@ -164,7 +164,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 #  define _ASM_NOKPROBE(entry)
 # endif
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 
 # define DEFINE_EXTABLE_TYPE_REG \
 	".macro extable_type_reg type:req reg:req\n"						\
@@ -221,7 +221,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_DEFAULT)
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 3e5b111e619d4..3f02ff6d333d3 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -74,7 +74,7 @@
 # define BOOT_STACK_SIZE	0x1000
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int output_len;
 extern const unsigned long kernel_text_size;
 extern const unsigned long kernel_total_size;
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index de1ad09fe8d72..7e67bacf02f37 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor.h>
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 
 #include <asm/asm.h>
 #include <linux/bitops.h>
@@ -208,5 +208,5 @@ static __always_inline bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/include/asm/cpumask.h b/arch/x86/include/asm/cpumask.h
index 4acfd57de8f1c..70f6b60ad67b9 100644
--- a/arch/x86/include/asm/cpumask.h
+++ b/arch/x86/include/asm/cpumask.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_CPUMASK_H
 #define _ASM_X86_CPUMASK_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 
 extern void setup_cpu_local_masks(void);
@@ -34,5 +34,5 @@ static __always_inline void arch_cpumask_clear_cpu(int cpu, struct cpumask *dstp
 
 #define arch_cpu_is_offline(cpu)	unlikely(!arch_cpu_online(cpu))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_CPUMASK_H */
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec36..f2d0b38879808 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -5,7 +5,7 @@
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/cache.h>
 #include <asm/percpu.h>
@@ -51,6 +51,6 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_CURRENT_H */
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index d440a65af8f39..7e6b9314758a1 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -58,7 +58,7 @@
 
 #define DESC_USER		(_DESC_DPL(3))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -166,7 +166,7 @@ struct desc_ptr {
 	unsigned long address;
 } __attribute__((packed)) ;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* Boot IDT definitions */
 #define	BOOT_IDT_ENTRIES	32
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 430fca13bb568..302e11b15da86 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_DWARF2_H
 #define _ASM_X86_DWARF2_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index d0dcefb5cc59d..4519c9f35ba04 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -31,7 +31,7 @@
 /* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
 #define FIXMAP_PMD_TOP	507
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/kernel.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
@@ -196,5 +196,5 @@ void __init *early_memremap_decrypted_wp(resource_size_t phys_addr,
 void __early_set_fixmap(enum fixed_addresses idx,
 			phys_addr_t phys, pgprot_t flags);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_FIXMAP_H */
diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index fb42659f6e988..0ab65073c1cc0 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro FRAME_BEGIN
 	push %_ASM_BP
@@ -51,7 +51,7 @@
 .endm
 #endif /* CONFIG_X86_64 */
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #define FRAME_BEGIN				\
 	"push %" _ASM_BP "\n"			\
@@ -82,18 +82,18 @@ static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
 
 #endif /* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define FRAME_OFFSET __ASM_SEL(4, 8)
 
 #else /* !CONFIG_FRAME_POINTER */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
 .endm
 
-#else /* !__ASSEMBLY */
+#else /* !__ASSEMBLER__ */
 
 #define ENCODE_FRAME_POINTER
 
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 25ca00bd70e83..2a29e52168815 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -32,7 +32,7 @@
 #define FRED_CONFIG_INT_STKLVL(l)	(_AT(unsigned long, l) << 9)
 #define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
@@ -113,6 +113,6 @@ static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) {
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* ASM_X86_FRED_H */
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 9e7e8ca8e2997..02f239569b93d 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_FSGSBASE_H
 #define _ASM_FSGSBASE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_64
 
@@ -80,6 +80,6 @@ extern unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 
 #endif /* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index f9cb4d07df58f..2d02d5b0517c1 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -22,7 +22,7 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __fentry__(void);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
@@ -118,11 +118,11 @@ struct dyn_arch_ftrace {
 };
 
 #endif /*  CONFIG_DYNAMIC_FTRACE */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 			   unsigned long frame_pointer);
@@ -166,6 +166,6 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 }
 #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
 #endif /* !COMPILE_OFFSETS */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index edebf1020e049..162ebd73a6981 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,7 +16,7 @@
 
 #include <asm/irq_vectors.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/percpu.h>
 #include <linux/profile.h>
@@ -128,6 +128,6 @@ extern char spurious_entries_start[];
 typedef struct irq_desc* vector_irq_t[NR_VECTORS];
 DECLARE_PER_CPU(vector_irq_t, vector_irq);
 
-#endif /* !ASSEMBLY_ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_HW_IRQ_H */
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 1e59581d500ca..e7f4caa42839a 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -21,7 +21,7 @@
 
 #define HAS_KERNEL_IBT	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_X86_64
 #define ASM_ENDBR	"endbr64\n\t"
@@ -77,7 +77,7 @@ static inline bool is_endbr(u32 val)
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_64
 #define ENDBR	endbr64
@@ -85,13 +85,13 @@ extern __noendbr void ibt_restore(u64 save);
 #define ENDBR	endbr32
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* !IBT */
 
 #define HAS_KERNEL_IBT	0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ASM_ENDBR
 #define IBT_NOSEAL(name)
@@ -103,11 +103,11 @@ static inline bool is_endbr(u32 val) { return false; }
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define ENDBR
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ad5c68f0509d4..a4ec27c679887 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,7 +7,7 @@
 
 #define IDT_ALIGN	(8 * (1 + HAS_KERNEL_IBT))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/entry-common.h>
 #include <linux/hardirq.h>
 
@@ -474,7 +474,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 		idt_install_sysvec(vector, asm_##function);		\
 }
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 /*
  * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
@@ -579,7 +579,7 @@ SYM_CODE_START(spurious_entries_start)
 SYM_CODE_END(spurious_entries_start)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The actual entry points. Note that DECLARE_IDTENTRY*() serves two
diff --git a/arch/x86/include/asm/inst.h b/arch/x86/include/asm/inst.h
index 438ccd4f3cc45..e48a00b3311d5 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/include/asm/inst.h
@@ -6,7 +6,7 @@
 #ifndef X86_ASM_INST_H
 #define X86_ASM_INST_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define REG_NUM_INVALID		100
 
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b8e3ce1..abb8374c9ff7a 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -4,7 +4,7 @@
 
 #include <asm/processor-flags.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/nospec-branch.h>
 
@@ -79,7 +79,7 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 static __always_inline unsigned long arch_local_save_flags(void)
@@ -133,10 +133,10 @@ static __always_inline unsigned long arch_local_irq_save(void)
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_PARAVIRT_XXL */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static __always_inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & X86_EFLAGS_IF);
@@ -154,6 +154,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 3f1c1d6c0da12..61dd1dee7812e 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -7,7 +7,7 @@
 #include <asm/asm.h>
 #include <asm/nops.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stringify.h>
 #include <linux/types.h>
@@ -55,6 +55,6 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
 
 extern int arch_jump_entry_size(struct jump_entry *entry);
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index de75306b932ef..d7e33c7f096b0 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -23,7 +23,7 @@
 					(1ULL << (__VIRTUAL_MASK_SHIFT - \
 						  KASAN_SHADOW_SCALE_SHIFT)))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 8ad187462b68e..c75509241ff28 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -13,7 +13,7 @@
 # define KEXEC_CONTROL_PAGE_SIZE	4096
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -225,6 +225,6 @@ unsigned int arch_crash_get_elfcorehdr_size(void);
 #define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dc31b13b87a0d..c95dad65801d5 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -38,7 +38,7 @@
 #define ASM_FUNC_ALIGN		__stringify(__FUNC_ALIGN)
 #define SYM_F_ALIGN		__FUNC_ALIGN
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
@@ -50,7 +50,7 @@
 #endif
 #endif /* CONFIG_MITIGATION_RETPOLINE */
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
@@ -62,7 +62,7 @@
 #endif
 #endif /* CONFIG_MITIGATION_RETPOLINE */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Depending on -fpatchable-function-entry=N,N usage (CONFIG_CALL_PADDING) the
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index f922b682b9b4c..1530ee301dfea 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -10,7 +10,7 @@
 #ifndef __X86_MEM_ENCRYPT_H__
 #define __X86_MEM_ENCRYPT_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/init.h>
 #include <linux/cc_platform.h>
@@ -114,6 +114,6 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 001853541f1e8..9397a319d165d 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -4,7 +4,7 @@
 
 #include "msr-index.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
 #include <asm/errno.h>
@@ -397,5 +397,5 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 	return wrmsr_safe_regs(regs);
 }
 #endif  /* CONFIG_SMP */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_MSR_H */
diff --git a/arch/x86/include/asm/nops.h b/arch/x86/include/asm/nops.h
index 1c1b7550fa550..cd94221d83358 100644
--- a/arch/x86/include/asm/nops.h
+++ b/arch/x86/include/asm/nops.h
@@ -82,7 +82,7 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern const unsigned char * const x86_nops[];
 #endif
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index aee26bb8230f8..1dbc40080448d 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -177,7 +177,7 @@
 	add	$(BITS_PER_LONG/8), %_ASM_SP;		\
 	lfence;
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * (ab)use RETPOLINE_SAFE on RET to annotate away 'bare' RET instructions
@@ -335,7 +335,7 @@
 #define CLEAR_BRANCH_HISTORY_VMEXIT
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
@@ -602,6 +602,6 @@ static __always_inline void mds_idle_clear_cpu_buffers(void)
 		mds_clear_cpu_buffers();
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 46d7e06763c9f..e0125afa53fb9 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -45,7 +45,7 @@
 #define ORC_TYPE_REGS			3
 #define ORC_TYPE_REGS_PARTIAL		4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/byteorder.h>
 
 /*
@@ -73,6 +73,6 @@ struct orc_entry {
 #endif
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index c9fe207916f48..9265f2fca99ae 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -14,7 +14,7 @@
 #include <asm/page_32.h>
 #endif	/* CONFIG_X86_64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct page;
 
@@ -84,7 +84,7 @@ static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
 	return __canonical_address(vaddr, vaddr_bits) == vaddr;
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 580d71aca65a4..0c623706cb7ef 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -4,7 +4,7 @@
 
 #include <asm/page_32_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __phys_addr_nodebug(x)	((x) - PAGE_OFFSET)
 #ifdef CONFIG_DEBUG_VIRTUAL
@@ -26,6 +26,6 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
index faf9cc1c14bb6..88e3c8d582986 100644
--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -63,7 +63,7 @@
  */
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
@@ -75,6 +75,6 @@ extern int sysctl_legacy_va_layout;
 extern void find_low_pfn_range(void);
 extern void setup_bootmem_allocator(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PAGE_32_DEFS_H */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index d63576608ce76..442357defa117 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -4,7 +4,7 @@
 
 #include <asm/page_64_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
@@ -94,7 +94,7 @@ static __always_inline unsigned long task_size_max(void)
 }
 #endif	/* CONFIG_X86_5LEVEL */
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 # define __HAVE_ARCH_GATE_AREA 1
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 06ef25411d622..1faa8f88850ab 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PAGE_64_DEFS_H
 #define _ASM_X86_PAGE_64_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/kaslr.h>
 #endif
 
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 974688973cf6e..9f77bf03d7472 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -43,7 +43,7 @@
 #define IOREMAP_MAX_ORDER       (PMD_SHIFT)
 #endif	/* CONFIG_X86_64 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
 extern phys_addr_t physical_mask;
@@ -66,6 +66,6 @@ bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn);
 
 extern void initmem_init(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif	/* _ASM_X86_PAGE_DEFS_H */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50f..d784d26173461 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,7 +6,7 @@
 
 #include <asm/paravirt_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct mm_struct;
 #endif
 
@@ -15,7 +15,7 @@ struct mm_struct;
 #include <asm/asm.h>
 #include <asm/nospec-branch.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
@@ -720,7 +720,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 extern void default_banner(void);
 void native_pv_lock_init(void) __init;
 
-#else  /* __ASSEMBLY__ */
+#else  /* __ASSEMBLER__ */
 
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
@@ -740,18 +740,18 @@ void native_pv_lock_init(void) __init;
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline void native_pv_lock_init(void)
 {
 }
 #endif
 #endif /* !CONFIG_PARAVIRT */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef CONFIG_PARAVIRT_XXL
 static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
@@ -769,5 +769,5 @@ static inline void paravirt_set_cap(void)
 {
 }
 #endif
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PARAVIRT_H */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f4365..4ec926518207a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -4,7 +4,7 @@
 
 #ifdef CONFIG_PARAVIRT
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 #include <asm/desc_defs.h>
@@ -519,7 +519,7 @@ unsigned long pv_native_read_cr2(void);
 
 #define paravirt_nop	((void *)nop_func)
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
 
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index e525cd85f999f..a1a4fb45274fb 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -10,7 +10,7 @@
 # define __percpu_rel
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CONFIG_SMP
 # define __percpu		%__percpu_seg:
@@ -26,7 +26,7 @@
 # define INIT_PER_CPU_VAR(var)  var
 #endif
 
-#else /* !__ASSEMBLY__: */
+#else /* !__ASSEMBLER__: */
 
 #include <linux/build_bug.h>
 #include <linux/stringify.h>
@@ -619,7 +619,7 @@ do {									\
 /* We can use this directly for local CPU (faster). */
 DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 4a12c276b1812..66425424ce91a 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PGTABLE_2LEVEL_DEFS_H
 #define _ASM_X86_PGTABLE_2LEVEL_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 typedef unsigned long	pteval_t;
@@ -16,7 +16,7 @@ typedef union {
 	pteval_t pte;
 	pteval_t pte_low;
 } pte_t;
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	0
 
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 80911349519e8..9d5b257d44e3c 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_DEFS_H
 #define _ASM_X86_PGTABLE_3LEVEL_DEFS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 typedef u64	pteval_t;
@@ -25,7 +25,7 @@ typedef union {
 	};
 	pmdval_t pmd;
 } pmd_t;
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
 
diff --git a/arch/x86/include/asm/pgtable-invert.h b/arch/x86/include/asm/pgtable-invert.h
index a0c1525f1b6f4..e12e52ae8083d 100644
--- a/arch/x86/include/asm/pgtable-invert.h
+++ b/arch/x86/include/asm/pgtable-invert.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PGTABLE_INVERT_H
 #define _ASM_PGTABLE_INVERT_H 1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * A clear pte value is special, and doesn't get inverted.
@@ -36,6 +36,6 @@ static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask)
 	return val;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 593f10aabd45a..7bd6bd6df4a11 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -15,7 +15,7 @@
 		     cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS)))	\
 	 : (prot))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/spinlock.h>
 #include <asm/x86_init.h>
 #include <asm/pkru.h>
@@ -973,7 +973,7 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 }
 #endif  /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 
 #ifdef CONFIG_X86_32
@@ -982,7 +982,7 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 # include <asm/pgtable_64.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/mm_types.h>
 #include <linux/mmdebug.h>
 #include <linux/log2.h>
@@ -1233,12 +1233,12 @@ static inline int pgd_none(pgd_t pgd)
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #define KERNEL_PGD_BOUNDARY	pgd_index(PAGE_OFFSET)
 #define KERNEL_PGD_PTRS		(PTRS_PER_PGD - KERNEL_PGD_BOUNDARY)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern int direct_gbpages;
 void init_mem_mapping(void);
@@ -1812,6 +1812,6 @@ bool arch_is_platform_page(u64 paddr);
 	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
 	set_pgd(pgdp, pgd); \
 })
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7d4ad8907297c..b612cc57a4d34 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -13,7 +13,7 @@
  * This file contains the functions and defines necessary to modify and use
  * the i386 page table tree.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <linux/threads.h>
 #include <asm/paravirt.h>
@@ -45,7 +45,7 @@ do {						\
 	flush_tlb_one_kernel((vaddr));		\
 } while (0)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * This is used to calculate the .brk reservation for initial pagetables.
diff --git a/arch/x86/include/asm/pgtable_32_areas.h b/arch/x86/include/asm/pgtable_32_areas.h
index b6355416a15a8..921148b429676 100644
--- a/arch/x86/include/asm/pgtable_32_areas.h
+++ b/arch/x86/include/asm/pgtable_32_areas.h
@@ -13,7 +13,7 @@
  */
 #define VMALLOC_OFFSET	(8 * 1024 * 1024)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern bool __vmalloc_start_set; /* set once high_memory is set */
 #endif
 
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index d1426b64c1b97..b89f8f1194a9f 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -5,7 +5,7 @@
 #include <linux/const.h>
 #include <asm/pgtable_64_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This file contains the functions and defines necessary to modify and use
@@ -270,7 +270,7 @@ static inline bool gup_fast_permitted(unsigned long start, unsigned long end)
 
 #include <asm/pgtable-invert.h>
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define l4_index(x)	(((x) >> 39) & 511)
 #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
@@ -291,5 +291,5 @@ L3_START_KERNEL = pud_index(__START_KERNEL_map)
 	i = i + 1 ;					\
 	.endr
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PGTABLE_64_H */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index ec68f8369bdca..5bb782d856f2c 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -4,7 +4,7 @@
 
 #include <asm/sparsemem.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #include <asm/kaslr.h>
 
@@ -44,7 +44,7 @@ static inline bool pgtable_l5_enabled(void)
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define SHARED_KERNEL_PMD	0
 
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 4b804531b03c3..ded7075c60634 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -164,7 +164,7 @@
  * to have the WB mode at index 0 (all bits clear). This is the default
  * right now and likely would break too much if changed.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 enum page_cache_mode {
 	_PAGE_CACHE_MODE_WB       = 0,
 	_PAGE_CACHE_MODE_WC       = 1,
@@ -239,7 +239,7 @@ enum page_cache_mode {
 #define __PAGE_KERNEL_IO_NOCACHE	__PAGE_KERNEL_NOCACHE
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __PAGE_KERNEL_ENC	(__PAGE_KERNEL    | _ENC)
 #define __PAGE_KERNEL_ENC_WP	(__PAGE_KERNEL_WP | _ENC)
@@ -262,7 +262,7 @@ enum page_cache_mode {
 #define PAGE_KERNEL_IO		__pgprot_mask(__PAGE_KERNEL_IO)
 #define PAGE_KERNEL_IO_NOCACHE	__pgprot_mask(__PAGE_KERNEL_IO_NOCACHE)
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 /*
  * early identity mapping  pte attrib macros.
@@ -281,7 +281,7 @@ enum page_cache_mode {
 # include <asm/pgtable_64_types.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -580,6 +580,6 @@ extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
 					  unsigned long page_flags);
 extern int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 					    unsigned long numpages);
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_PGTABLE_DEFS_H */
diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 365798cb4408d..5d0dbab852640 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -8,7 +8,7 @@
 
 #ifndef _ASM_X86_PROM_H
 #define _ASM_X86_PROM_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/of.h>
 #include <linux/types.h>
@@ -33,5 +33,5 @@ static inline void x86_flattree_get_config(void) { }
 
 extern char cmd_line[COMMAND_LINE_SIZE];
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index ab167c96b9ab4..88d0a1ab1f77e 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PTI_H
 #define _ASM_X86_PTI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
@@ -11,5 +11,5 @@ extern void pti_finalize(void);
 static inline void pti_check_boottime_disable(void) { }
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PTI_H */
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 5a83fbd9bc0b4..50f75467f73d0 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -6,7 +6,7 @@
 #include <asm/page_types.h>
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef __i386__
 
 struct pt_regs {
@@ -469,5 +469,5 @@ extern int do_set_thread_area(struct task_struct *p, int idx,
 # define do_set_thread_area_64(p, s, t)	(0)
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_PTRACE_H */
diff --git a/arch/x86/include/asm/purgatory.h b/arch/x86/include/asm/purgatory.h
index 5528e93250494..2fee5e9f1ccc3 100644
--- a/arch/x86/include/asm/purgatory.h
+++ b/arch/x86/include/asm/purgatory.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_PURGATORY_H
 #define _ASM_X86_PURGATORY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/purgatory.h>
 
 extern void purgatory(void);
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* _ASM_PURGATORY_H */
diff --git a/arch/x86/include/asm/pvclock-abi.h b/arch/x86/include/asm/pvclock-abi.h
index 1436226efe3ef..b9fece5fc96d6 100644
--- a/arch/x86/include/asm/pvclock-abi.h
+++ b/arch/x86/include/asm/pvclock-abi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PVCLOCK_ABI_H
 #define _ASM_X86_PVCLOCK_ABI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * These structs MUST NOT be changed.
@@ -44,5 +44,5 @@ struct pvclock_wall_clock {
 #define PVCLOCK_GUEST_STOPPED	(1 << 1)
 /* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
 #define PVCLOCK_COUNTS_FROM_ZERO (1 << 2)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PVCLOCK_ABI_H */
diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 87e5482acd0dc..f607081a022ab 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -9,7 +9,7 @@
 #define TH_FLAGS_SME_ACTIVE_BIT		0
 #define TH_FLAGS_SME_ACTIVE		BIT(TH_FLAGS_SME_ACTIVE_BIT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/io.h>
@@ -95,6 +95,6 @@ void reserve_real_mode(void);
 void load_trampoline_pgtable(void);
 void init_real_mode(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ARCH_X86_REALMODE_H */
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c659205..77d8f49b92bdd 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -233,7 +233,7 @@
 #define VDSO_CPUNODE_BITS		12
 #define VDSO_CPUNODE_MASK		0xfff
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Helper functions to store/load CPU and node numbers */
 
@@ -265,7 +265,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 		*node = (p >> VDSO_CPUNODE_BITS);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef __KERNEL__
 
@@ -286,7 +286,7 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
  */
 #define XEN_EARLY_IDT_HANDLER_SIZE (8 + ENDBR_INSN_SIZE)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern const char early_idt_handler_array[NUM_EXCEPTION_VECTORS][EARLY_IDT_HANDLER_SIZE];
 extern void early_ignore_irq(void);
@@ -350,7 +350,7 @@ static inline void __loadsegment_fs(unsigned short value)
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SEGMENT_H */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 85f4fde3515c4..09201d47c967b 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -27,7 +27,7 @@
 #define OLD_CL_ADDRESS		0x020	/* Relative to real mode data */
 #define NEW_CL_POINTER		0x228	/* Relative to real mode data */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cache.h>
 
 #include <asm/bootparam.h>
@@ -141,7 +141,7 @@ extern bool builtin_cmdline_added __ro_after_init;
 #define builtin_cmdline_added 0
 #endif
 
-#else  /* __ASSEMBLY */
+#else  /* __ASSEMBLER__ */
 
 .macro __RESERVE_BRK name, size
 	.pushsection .bss..brk, "aw"
@@ -153,6 +153,6 @@ SYM_DATA_END(__brk_\name)
 
 #define RESERVE_BRK(name, size) __RESERVE_BRK name, size
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/include/asm/setup_data.h b/arch/x86/include/asm/setup_data.h
index 77c51111a8939..7bb16f843c93d 100644
--- a/arch/x86/include/asm/setup_data.h
+++ b/arch/x86/include/asm/setup_data.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/setup_data.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct pci_setup_rom {
 	struct setup_data data;
@@ -27,6 +27,6 @@ struct efi_setup_data {
 	u64 reserved[8];
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SETUP_DATA_H */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fcbbef484a78e..a28ff6b141458 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -106,7 +106,7 @@
 #define TDX_PS_1G	2
 #define TDX_PS_NR	(TDX_PS_1G + 1)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_attributes.h>
 
@@ -177,5 +177,5 @@ static __always_inline u64 hcall_func(u64 exit_reason)
         return exit_reason;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_SHARED_TDX_H */
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index 4cb77e004615d..ba6f2fe438488 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_SHSTK_H
 #define _ASM_X86_SHSTK_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 struct task_struct;
@@ -37,6 +37,6 @@ static inline int shstk_update_last_frame(unsigned long val) { return 0; }
 static inline bool shstk_is_enabled(void) { return false; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SHSTK_H */
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 4a4043ca64934..c72d461753742 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_SIGNAL_H
 #define _ASM_X86_SIGNAL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/linkage.h>
 
 /* Most things should be clean enough to redefine this at will, if care
@@ -28,9 +28,9 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #include <uapi/asm/signal.h>
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __ARCH_HAS_SA_RESTORER
 
@@ -101,5 +101,5 @@ struct pt_regs;
 
 #endif /* !__i386__ */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_SIGNAL_H */
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 2de1e5a75c573..daea94c2993c5 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -13,7 +13,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define ASM_CLAC \
 	ALTERNATIVE "", "clac", X86_FEATURE_SMAP
@@ -21,7 +21,7 @@
 #define ASM_STAC \
 	ALTERNATIVE "", "stac", X86_FEATURE_SMAP
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 static __always_inline void clac(void)
 {
@@ -61,6 +61,6 @@ static __always_inline void smap_restore(unsigned long flags)
 #define ASM_STAC \
 	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_SMAP_H */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698fa..d234a6321c189 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_SMP_H
 #define _ASM_X86_SMP_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/cpumask.h>
 
 #include <asm/cpumask.h>
@@ -175,7 +175,7 @@ extern void nmi_selftest(void);
 extern unsigned int smpboot_control;
 extern unsigned long apic_mmio_base;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* Control bits for startup_64 */
 #define STARTUP_READ_APICID	0x80000000
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16dafd55ed..65394aa9b49f8 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -30,7 +30,7 @@
 #define TDX_SUCCESS		0ULL
 #define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <uapi/asm/mce.h>
 
@@ -126,5 +126,5 @@ static inline int tdx_enable(void)  { return -ENODEV; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a55c214f3ba64..9282465eea21d 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -54,7 +54,7 @@
  * - this struct should fit entirely inside of one cache line
  * - this struct shares the supervisor stack pages
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct task_struct;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
@@ -73,7 +73,7 @@ struct thread_info {
 	.flags		= 0,			\
 }
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #include <asm/asm-offsets.h>
 
@@ -161,7 +161,7 @@ struct thread_info {
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Walks up the stack frames to make sure that the specified object is
@@ -213,7 +213,7 @@ static inline int arch_within_stack_frames(const void * const stack,
 #endif
 }
 
-#endif  /* !__ASSEMBLY__ */
+#endif  /* !__ASSEMBLER__ */
 
 /*
  * Thread-synchronous status.
@@ -224,7 +224,7 @@ static inline int arch_within_stack_frames(const void * const stack,
  */
 #define TS_COMPAT		0x0002	/* 32bit syscall active (64BIT)*/
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_COMPAT
 #define TS_I386_REGS_POKED	0x0004	/* regs poked by 32-bit ptracer */
 
@@ -242,6 +242,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 
 extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 85cc57cb65392..8f4579c5a6f8b 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -5,7 +5,7 @@
 
 #include "orc_types.h"
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 .macro UNWIND_HINT_END_OF_STACK
 	UNWIND_HINT type=UNWIND_HINT_TYPE_END_OF_STACK
@@ -88,6 +88,6 @@
 #define UNWIND_HINT_RESTORE \
 	UNWIND_HINT(UNWIND_HINT_TYPE_RESTORE, 0, 0, 0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_X86_UNWIND_HINTS_H */
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index 2bf9c0e970c3e..785f8edcb9c99 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_GETRANDOM_H
 #define __ASM_VDSO_GETRANDOM_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/unistd.h>
 
@@ -37,6 +37,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void
 	return &vdso_rng_data;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 375a34b0f3657..428f3f4c2235f 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <uapi/linux/time.h>
 #include <asm/vgtod.h>
@@ -350,6 +350,6 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles,
 }
 #define vdso_calc_ns vdso_calc_ns
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
index 2cbce97d29eaf..c9b2ba7a9ec4c 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_PROCESSOR_H
 #define __ASM_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static __always_inline void rep_nop(void)
@@ -22,6 +22,6 @@ struct getcpu_cache;
 
 notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index 37b4a70559a82..72aedebb7648a 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -9,7 +9,7 @@
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
@@ -36,6 +36,6 @@ struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/x86/include/asm/xen/interface.h b/arch/x86/include/asm/xen/interface.h
index baca0b00ef768..a078a2b0f032b 100644
--- a/arch/x86/include/asm/xen/interface.h
+++ b/arch/x86/include/asm/xen/interface.h
@@ -72,7 +72,7 @@
 #endif
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* Explicitly size integers that represent pfns in the public interface
  * with Xen so that on ARM we can have one ABI that works for 32 and 64
  * bit guests. */
@@ -137,7 +137,7 @@ DEFINE_GUEST_HANDLE(xen_ulong_t);
 #define TI_SET_DPL(_ti, _dpl)	((_ti)->flags |= (_dpl))
 #define TI_SET_IF(_ti, _if)	((_ti)->flags |= ((!!(_if))<<2))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct trap_info {
     uint8_t       vector;  /* exception vector                              */
     uint8_t       flags;   /* 0-3: privilege level; 4: clear event enable?  */
@@ -186,7 +186,7 @@ struct arch_shared_info {
 	uint32_t wc_sec_hi;
 #endif
 };
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_X86_32
 #include <asm/xen/interface_32.h>
@@ -196,7 +196,7 @@ struct arch_shared_info {
 
 #include <asm/pvclock-abi.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * The following is all CPU context. Note that the fpu_ctxt block is filled
  * in by FXSAVE if the CPU has feature FXSR; otherwise FSAVE is used.
@@ -376,7 +376,7 @@ struct xen_pmu_arch {
 	} c;
 };
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 /*
  * Prefix forces emulation of some non-trapping instructions.
diff --git a/arch/x86/include/asm/xen/interface_32.h b/arch/x86/include/asm/xen/interface_32.h
index dc40578abded7..74d9768a9cf77 100644
--- a/arch/x86/include/asm/xen/interface_32.h
+++ b/arch/x86/include/asm/xen/interface_32.h
@@ -44,7 +44,7 @@
  */
 #define __HYPERVISOR_VIRT_START 0xF5800000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct cpu_user_regs {
     uint32_t ebx;
@@ -85,7 +85,7 @@ typedef struct xen_callback xen_callback_t;
 
 #define XEN_CALLBACK(__cs, __eip)				\
 	((struct xen_callback){ .cs = (__cs), .eip = (unsigned long)(__eip) })
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 /*
diff --git a/arch/x86/include/asm/xen/interface_64.h b/arch/x86/include/asm/xen/interface_64.h
index c10f279aae936..38a19edb81a31 100644
--- a/arch/x86/include/asm/xen/interface_64.h
+++ b/arch/x86/include/asm/xen/interface_64.h
@@ -77,7 +77,7 @@
 #define VGCF_in_syscall  (1<<_VGCF_in_syscall)
 #define VGCF_IN_SYSCALL  VGCF_in_syscall
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct iret_context {
     /* Top of stack (%rsp at point of hypercall). */
@@ -143,7 +143,7 @@ typedef unsigned long xen_callback_t;
 #define XEN_CALLBACK(__cs, __rip)				\
 	((unsigned long)(__rip))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 #endif /* _ASM_X86_XEN_INTERFACE_64_H */
diff --git a/arch/x86/math-emu/control_w.h b/arch/x86/math-emu/control_w.h
index 60f4dcc5edc3c..93cbc89b34e25 100644
--- a/arch/x86/math-emu/control_w.h
+++ b/arch/x86/math-emu/control_w.h
@@ -11,7 +11,7 @@
 #ifndef _CONTROLW_H_
 #define _CONTROLW_H_
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	_Const_(x)	$##x
 #else
 #define	_Const_(x)	x
diff --git a/arch/x86/math-emu/exception.h b/arch/x86/math-emu/exception.h
index 75230b9775777..59961d350bc4d 100644
--- a/arch/x86/math-emu/exception.h
+++ b/arch/x86/math-emu/exception.h
@@ -10,7 +10,7 @@
 #ifndef _EXCEPTION_H_
 #define _EXCEPTION_H_
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	Const_(x)	$##x
 #else
 #define	Const_(x)	x
@@ -37,7 +37,7 @@
 #define PRECISION_LOST_UP    Const_((EX_Precision | SW_C1))
 #define PRECISION_LOST_DOWN  Const_(EX_Precision)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef DEBUG
 #define	EXCEPTION(x)	{ printk("exception in %s at line %d\n", \
@@ -46,6 +46,6 @@
 #define	EXCEPTION(x)	FPU_exception(x)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _EXCEPTION_H_ */
diff --git a/arch/x86/math-emu/fpu_emu.h b/arch/x86/math-emu/fpu_emu.h
index 0c122226ca56f..def569c50b760 100644
--- a/arch/x86/math-emu/fpu_emu.h
+++ b/arch/x86/math-emu/fpu_emu.h
@@ -20,7 +20,7 @@
  */
 #define PECULIAR_486
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include "fpu_asm.h"
 #define	Const(x)	$##x
 #else
@@ -68,7 +68,7 @@
 
 #define FPU_Exception   Const(0x80000000)	/* Added to tag returns. */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include "fpu_system.h"
 
@@ -213,6 +213,6 @@ asmlinkage int FPU_round(FPU_REG *arg, unsigned int extent, int dummy,
 #include "fpu_proto.h"
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _FPU_EMU_H_ */
diff --git a/arch/x86/math-emu/status_w.h b/arch/x86/math-emu/status_w.h
index b77bafec95260..f642957330efc 100644
--- a/arch/x86/math-emu/status_w.h
+++ b/arch/x86/math-emu/status_w.h
@@ -13,7 +13,7 @@
 
 #include "fpu_emu.h"		/* for definition of PECULIAR_486 */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define	Const__(x)	$##x
 #else
 #define	Const__(x)	x
@@ -37,7 +37,7 @@
 
 #define SW_Exc_Mask     Const__(0x27f)	/* Status word exception bit mask */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define COMP_A_gt_B	1
 #define COMP_A_eq_B	2
@@ -63,6 +63,6 @@ static inline void setcc(int cc)
 #  define clear_C1()
 #endif /* PECULIAR_486 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _STATUS_H_ */
diff --git a/arch/x86/realmode/rm/realmode.h b/arch/x86/realmode/rm/realmode.h
index c76041a353970..867e55f1d6af4 100644
--- a/arch/x86/realmode/rm/realmode.h
+++ b/arch/x86/realmode/rm/realmode.h
@@ -2,7 +2,7 @@
 #ifndef ARCH_X86_REALMODE_RM_REALMODE_H
 #define ARCH_X86_REALMODE_RM_REALMODE_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * 16-bit ljmpw to the real_mode_seg
@@ -12,7 +12,7 @@
  */
 #define LJMPW_RM(to)	.byte 0xea ; .word (to), real_mode_seg
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Signature at the end of the realmode region
diff --git a/arch/x86/realmode/rm/wakeup.h b/arch/x86/realmode/rm/wakeup.h
index 0e4fd08ae4471..3b6d8fa82d3e1 100644
--- a/arch/x86/realmode/rm/wakeup.h
+++ b/arch/x86/realmode/rm/wakeup.h
@@ -7,7 +7,7 @@
 #ifndef ARCH_X86_KERNEL_ACPI_RM_WAKEUP_H
 #define ARCH_X86_KERNEL_ACPI_RM_WAKEUP_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 /* This must match data at wakeup.S */
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/asm.h
index 3ad3da9a7d974..dbe39b44256ba 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_ASM_H
 #define _ASM_X86_ASM_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
@@ -123,7 +123,7 @@
 #ifdef __KERNEL__
 
 /* Exception table entry */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
@@ -154,7 +154,7 @@
 #  define _ASM_NOKPROBE(entry)
 # endif
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
@@ -186,7 +186,7 @@
  */
 register unsigned long current_stack_pointer asm(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 
diff --git a/tools/arch/x86/include/asm/nops.h b/tools/arch/x86/include/asm/nops.h
index 1c1b7550fa550..cd94221d83358 100644
--- a/tools/arch/x86/include/asm/nops.h
+++ b/tools/arch/x86/include/asm/nops.h
@@ -82,7 +82,7 @@
 #define ASM_NOP7 _ASM_BYTES(BYTES_NOP7)
 #define ASM_NOP8 _ASM_BYTES(BYTES_NOP8)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern const unsigned char * const x86_nops[];
 #endif
 
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 46d7e06763c9f..e0125afa53fb9 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -45,7 +45,7 @@
 #define ORC_TYPE_REGS			3
 #define ORC_TYPE_REGS_PARTIAL		4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/byteorder.h>
 
 /*
@@ -73,6 +73,6 @@ struct orc_entry {
 #endif
 } __packed;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/tools/arch/x86/include/asm/pvclock-abi.h b/tools/arch/x86/include/asm/pvclock-abi.h
index 1436226efe3ef..b9fece5fc96d6 100644
--- a/tools/arch/x86/include/asm/pvclock-abi.h
+++ b/tools/arch/x86/include/asm/pvclock-abi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_X86_PVCLOCK_ABI_H
 #define _ASM_X86_PVCLOCK_ABI_H
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * These structs MUST NOT be changed.
@@ -44,5 +44,5 @@ struct pvclock_wall_clock {
 #define PVCLOCK_GUEST_STOPPED	(1 << 1)
 /* PVCLOCK_COUNTS_FROM_ZERO broke ABI and can't be used anymore. */
 #define PVCLOCK_COUNTS_FROM_ZERO (1 << 2)
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_PVCLOCK_ABI_H */
-- 
2.48.1


