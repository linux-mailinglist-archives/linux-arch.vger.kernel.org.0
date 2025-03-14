Return-Path: <linux-arch+bounces-10783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F17A609BD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D8419C5E22
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C21F4620;
	Fri, 14 Mar 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtJr2IsR"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5C1F417D
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936340; cv=none; b=Fqj4P8/xiieOs0jdzzXHac2fb7edjBeL7Lcao0KGCqlSJh0fTxXsrT3VUzqbZDGiUh5UBEJXgtO1hcqVvsRSYMgTtCsgsbYdB/nUV8TzhJW0SLRoZ6Ndonep0bkt2ZlqywXQAKB5+gZ6To7A+gKRzodb5wyAcBVQxwox+5QSwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936340; c=relaxed/simple;
	bh=KiKC+ceZSyw354WwApQaK53/LRuQX0v8ZlOTkcpRIJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3l/qq9LkPX0NUu/J3cH3PnTXG5AClNc/I9gBQlFpZ5CJeIeahJAsUv6njtL5Yc4gXB4EQuMQOS/wbhAEizFQHbbYWVCC/AGIPJ0nf6f7X9ENcviOODOIGUL7jnm6xnH+Fu4Jw34zrHWO5YDsTYEaPp12kf9eaRPa3jCEaKyiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtJr2IsR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wyL4doJZ7vHuBtsXfyuYL3UJ8yR3I3f1gdCj7t43hI=;
	b=DtJr2IsRTVO3ltJQCIDLsdv4nHi1jWs8KX5bMWBUP4052+Lr3hJH9Uai/jEFp11OM+MsVr
	3Gjhwu3MzkR5A0ZeTX+8rb9h9JzgjXsXUL+M9GFOoZj9awFS3iM9uDOcxASIHnKZTetGnd
	YTBvRKiZeIsn/siocn0f8ozMlGN78W8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-C0qN8OiIOK26Y-6AdvgpVQ-1; Fri,
 14 Mar 2025 03:12:13 -0400
X-MC-Unique: C0qN8OiIOK26Y-6AdvgpVQ-1
X-Mimecast-MFC-AGG-ID: C0qN8OiIOK26Y-6AdvgpVQ_1741936332
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 614291800267;
	Fri, 14 Mar 2025 07:12:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF71A18001D4;
	Fri, 14 Mar 2025 07:12:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Subject: [PATCH 25/41] parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:56 +0100
Message-ID: <20250314071013.1575167-26-thuth@redhat.com>
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

This is mostly a completely mechanical patch (done with a simple
"sed -i" statement), except for some manual tweaks in the files
arch/parisc/include/asm/smp.h, arch/parisc/include/asm/signal.h,
arch/parisc/include/asm/thread_info.h and arch/parisc/include/asm/vdso.h
that had the macro spelled in a wrong way.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/parisc/include/asm/alternative.h    | 4 ++--
 arch/parisc/include/asm/assembly.h       | 4 ++--
 arch/parisc/include/asm/barrier.h        | 4 ++--
 arch/parisc/include/asm/cache.h          | 4 ++--
 arch/parisc/include/asm/current.h        | 4 ++--
 arch/parisc/include/asm/dwarf.h          | 4 ++--
 arch/parisc/include/asm/fixmap.h         | 4 ++--
 arch/parisc/include/asm/ftrace.h         | 4 ++--
 arch/parisc/include/asm/jump_label.h     | 4 ++--
 arch/parisc/include/asm/kexec.h          | 4 ++--
 arch/parisc/include/asm/kgdb.h           | 2 +-
 arch/parisc/include/asm/linkage.h        | 4 ++--
 arch/parisc/include/asm/page.h           | 6 +++---
 arch/parisc/include/asm/pdc.h            | 4 ++--
 arch/parisc/include/asm/pdcpat.h         | 4 ++--
 arch/parisc/include/asm/pgtable.h        | 8 ++++----
 arch/parisc/include/asm/prefetch.h       | 4 ++--
 arch/parisc/include/asm/processor.h      | 8 ++++----
 arch/parisc/include/asm/psw.h            | 4 ++--
 arch/parisc/include/asm/signal.h         | 4 ++--
 arch/parisc/include/asm/smp.h            | 4 ++--
 arch/parisc/include/asm/spinlock_types.h | 4 ++--
 arch/parisc/include/asm/thread_info.h    | 4 ++--
 arch/parisc/include/asm/traps.h          | 2 +-
 arch/parisc/include/asm/unistd.h         | 4 ++--
 arch/parisc/include/asm/vdso.h           | 4 ++--
 26 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/parisc/include/asm/alternative.h b/arch/parisc/include/asm/alternative.h
index 1eb488f25b838..1601ae4b888d9 100644
--- a/arch/parisc/include/asm/alternative.h
+++ b/arch/parisc/include/asm/alternative.h
@@ -13,7 +13,7 @@
 #define INSN_PxTLB	0x02		/* modify pdtlb, pitlb */
 #define INSN_NOP	0x08000240	/* nop */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/init.h>
 #include <linux/types.h>
@@ -61,6 +61,6 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
 	.word (new_instr_ptr - .)	!	\
 	.previous
 
-#endif  /*  __ASSEMBLY__  */
+#endif  /*  __ASSEMBLER__  */
 
 #endif /* __ASM_PARISC_ALTERNATIVE_H */
diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index 000a28e1c5e8d..c20261604f09c 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -53,7 +53,7 @@
 #define SR_TEMP2	2
 #define SR_USER		3
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CONFIG_64BIT
 #define LDREG	ldd
@@ -582,5 +582,5 @@
 	.previous
 
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/parisc/include/asm/barrier.h b/arch/parisc/include/asm/barrier.h
index c705decf2bed5..519b1903c5ed3 100644
--- a/arch/parisc/include/asm/barrier.h
+++ b/arch/parisc/include/asm/barrier.h
@@ -4,7 +4,7 @@
 
 #include <asm/alternative.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* The synchronize caches instruction executes as a nop on systems in
    which all memory references are performed in order. */
@@ -93,5 +93,5 @@ do {									\
 })
 #include <asm-generic/barrier.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index a3f0f100f2194..3f8d3be6ef244 100644
--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -16,7 +16,7 @@
 #define L1_CACHE_BYTES 16
 #define L1_CACHE_SHIFT 4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
 
@@ -66,7 +66,7 @@ void parisc_setup_cache_timing(void);
 			ALTERNATIVE(ALT_COND_NO_IOC_FDC, INSN_NOP) :::"memory")
 #define asm_syncdma()	asm volatile("syncdma" :::"memory")
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 /* Classes of processor wrt: disabling space register hashing */
 
diff --git a/arch/parisc/include/asm/current.h b/arch/parisc/include/asm/current.h
index dc7aea07c3f38..2814529a4c286 100644
--- a/arch/parisc/include/asm/current.h
+++ b/arch/parisc/include/asm/current.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PARISC_CURRENT_H
 #define _ASM_PARISC_CURRENT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct task_struct;
 
 static __always_inline struct task_struct *get_current(void)
@@ -16,6 +16,6 @@ static __always_inline struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PARISC_CURRENT_H */
diff --git a/arch/parisc/include/asm/dwarf.h b/arch/parisc/include/asm/dwarf.h
index f4512db86a190..526f4a79262cd 100644
--- a/arch/parisc/include/asm/dwarf.h
+++ b/arch/parisc/include/asm/dwarf.h
@@ -6,7 +6,7 @@
 #ifndef _ASM_PARISC_DWARF_H
 #define _ASM_PARISC_DWARF_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define CFI_STARTPROC	.cfi_startproc
 #define CFI_ENDPROC	.cfi_endproc
@@ -15,6 +15,6 @@
 #define CFI_REL_OFFSET	.cfi_rel_offset
 #define CFI_UNDEFINED	.cfi_undefined
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* _ASM_PARISC_DWARF_H */
diff --git a/arch/parisc/include/asm/fixmap.h b/arch/parisc/include/asm/fixmap.h
index 5cd80ce1163a8..9cafa449c4a7d 100644
--- a/arch/parisc/include/asm/fixmap.h
+++ b/arch/parisc/include/asm/fixmap.h
@@ -39,7 +39,7 @@
 #define KERNEL_MAP_START	(GATEWAY_PAGE_SIZE)
 #define KERNEL_MAP_END		(FIXMAP_START)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
 enum fixed_addresses {
@@ -59,6 +59,6 @@ extern void *parisc_vmalloc_start;
 void set_fixmap(enum fixed_addresses idx, phys_addr_t phys);
 void clear_fixmap(enum fixed_addresses idx);
 
-#endif /*__ASSEMBLY__*/
+#endif /*__ASSEMBLER__*/
 
 #endif /*_ASM_FIXMAP_H*/
diff --git a/arch/parisc/include/asm/ftrace.h b/arch/parisc/include/asm/ftrace.h
index f1cc1ee3a6473..8b89d2b642eb2 100644
--- a/arch/parisc/include/asm/ftrace.h
+++ b/arch/parisc/include/asm/ftrace.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PARISC_FTRACE_H
 #define _ASM_PARISC_FTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void mcount(void);
 
 #define MCOUNT_ADDR		((unsigned long)mcount)
@@ -29,6 +29,6 @@ unsigned long ftrace_call_adjust(unsigned long addr);
 
 #define ftrace_return_address(n) return_address(n)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PARISC_FTRACE_H */
diff --git a/arch/parisc/include/asm/jump_label.h b/arch/parisc/include/asm/jump_label.h
index 317ebc5edc9fe..f325ae3c622f3 100644
--- a/arch/parisc/include/asm/jump_label.h
+++ b/arch/parisc/include/asm/jump_label.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PARISC_JUMP_LABEL_H
 #define _ASM_PARISC_JUMP_LABEL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/stringify.h>
@@ -44,5 +44,5 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif
diff --git a/arch/parisc/include/asm/kexec.h b/arch/parisc/include/asm/kexec.h
index 87e1740069955..bf31e2d50df9e 100644
--- a/arch/parisc/include/asm/kexec.h
+++ b/arch/parisc/include/asm/kexec.h
@@ -14,7 +14,7 @@
 #define KEXEC_ARCH KEXEC_ARCH_PARISC
 #define ARCH_HAS_KIMAGE_ARCH
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct kimage_arch {
 	unsigned long initrd_start;
@@ -28,6 +28,6 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	/* Dummy implementation for now */
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PARISC_KEXEC_H */
diff --git a/arch/parisc/include/asm/kgdb.h b/arch/parisc/include/asm/kgdb.h
index 317cd434bee3d..9ece98bc6d9d6 100644
--- a/arch/parisc/include/asm/kgdb.h
+++ b/arch/parisc/include/asm/kgdb.h
@@ -21,7 +21,7 @@
 
 #define CACHE_FLUSH_IS_SAFE		1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void arch_kgdb_breakpoint(void)
 {
diff --git a/arch/parisc/include/asm/linkage.h b/arch/parisc/include/asm/linkage.h
index cd6fe4febeadb..d4cad492b971c 100644
--- a/arch/parisc/include/asm/linkage.h
+++ b/arch/parisc/include/asm/linkage.h
@@ -15,7 +15,7 @@
  */
 #define ASM_NL	!
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define ENTRY(name) \
 	ALIGN	!\
@@ -35,6 +35,6 @@ name:		ASM_NL\
 	.procend	ASM_NL\
 	ENDPROC(name)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif  /* __ASM_PARISC_LINKAGE_H */
diff --git a/arch/parisc/include/asm/page.h b/arch/parisc/include/asm/page.h
index 7fd4470926307..8f4e51071ea1d 100644
--- a/arch/parisc/include/asm/page.h
+++ b/arch/parisc/include/asm/page.h
@@ -8,7 +8,7 @@
 
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/types.h>
 #include <asm/cache.h>
@@ -93,7 +93,7 @@ typedef struct __physmem_range {
 extern physmem_range_t pmem_ranges[];
 extern int npmem_ranges;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* WARNING: The definitions below must match exactly to sizeof(pte_t)
  * etc
@@ -139,7 +139,7 @@ extern int npmem_ranges;
 #define KERNEL_BINARY_TEXT_START	(__PAGE_OFFSET + 0x100000)
 
 /* These macros don't work for 64-bit C code -- don't allow in C at all */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #   define PA(x)	((x)-__PAGE_OFFSET)
 #   define VA(x)	((x)+__PAGE_OFFSET)
 #endif
diff --git a/arch/parisc/include/asm/pdc.h b/arch/parisc/include/asm/pdc.h
index 5d2d9737e579d..6080a1516b349 100644
--- a/arch/parisc/include/asm/pdc.h
+++ b/arch/parisc/include/asm/pdc.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/pdc.h>
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 extern int parisc_narrow_firmware;
 
@@ -109,5 +109,5 @@ static inline char * os_id_to_string(u16 os_id) {
 	}
 }
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 #endif /* _PARISC_PDC_H */
diff --git a/arch/parisc/include/asm/pdcpat.h b/arch/parisc/include/asm/pdcpat.h
index 8f160375b865b..84ac81b1addec 100644
--- a/arch/parisc/include/asm/pdcpat.h
+++ b/arch/parisc/include/asm/pdcpat.h
@@ -210,7 +210,7 @@
 #define PDC_PAT_SYSTEM_INFO	76L
 /* PDC_PAT_SYSTEM_INFO uses the same options as PDC_SYSTEM_INFO function. */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 
 #ifdef CONFIG_64BIT
@@ -389,6 +389,6 @@ extern int pdc_pat_mem_get_dimm_phys_location(
                 struct pdc_pat_mem_phys_mem_location *pret,
                 unsigned long phys_addr);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* ! __PARISC_PATPDC_H */
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index babf65751e818..4ac43e8014652 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -12,7 +12,7 @@
 
 #include <asm/fixmap.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * we simulate an x86-style page table for the linux mm code
  */
@@ -73,7 +73,7 @@ extern void __update_cache(pte_t pte);
 		mb();				\
 	} while(0)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
@@ -226,7 +226,7 @@ extern void __update_cache(pte_t pte);
 #define PxD_FLAG_SHIFT    (4)
 #define PxD_VALUE_SHIFT   (PFN_PTE_SHIFT-PxD_FLAG_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_USER)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_READ | _PAGE_WRITE)
@@ -477,7 +477,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 /* TLB page size encoding - see table 3-1 in parisc20.pdf */
diff --git a/arch/parisc/include/asm/prefetch.h b/arch/parisc/include/asm/prefetch.h
index 6e63f720024da..748eefb27c68a 100644
--- a/arch/parisc/include/asm/prefetch.h
+++ b/arch/parisc/include/asm/prefetch.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_PARISC_PREFETCH_H
 #define __ASM_PARISC_PREFETCH_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_PREFETCH
 
 #define ARCH_HAS_PREFETCH
@@ -40,6 +40,6 @@ static inline void prefetchw(const void *addr)
 #endif /* CONFIG_PA20 */
 
 #endif /* CONFIG_PREFETCH */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_PARISC_PROCESSOR_H */
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 77fac02188e19..4c14bde39aac0 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_PARISC_PROCESSOR_H
 #define __ASM_PARISC_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/threads.h>
 #include <linux/irqreturn.h>
 
@@ -20,7 +20,7 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 #include <asm/percpu.h>
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
 
@@ -45,7 +45,7 @@
 #define STACK_TOP	TASK_SIZE
 #define STACK_TOP_MAX	DEFAULT_TASK_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct rlimit;
 unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
@@ -325,6 +325,6 @@ extern void sba_directed_lmmio(struct parisc_device *, struct resource *);
 extern void lba_set_iregs(struct parisc_device *lba, u32 ibase, u32 imask);
 extern void ccio_cujo20_fixup(struct parisc_device *dev, u32 iovp);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_PARISC_PROCESSOR_H */
diff --git a/arch/parisc/include/asm/psw.h b/arch/parisc/include/asm/psw.h
index 46921ffcc4077..9140e1ab7e636 100644
--- a/arch/parisc/include/asm/psw.h
+++ b/arch/parisc/include/asm/psw.h
@@ -60,7 +60,7 @@
 #define USER_PSW_MASK (WIDE_PSW | PSW_T | PSW_N | PSW_X | PSW_B | PSW_V | PSW_CB)
 #define USER_PSW      (PSW_C | PSW_Q | PSW_P | PSW_D | PSW_I)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* The program status word as bitfields.  */
 struct pa_psw {
@@ -99,6 +99,6 @@ struct pa_psw {
 #define pa_psw(task) ((struct pa_psw *) ((char *) (task) + TASK_PT_PSW))
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif
diff --git a/arch/parisc/include/asm/signal.h b/arch/parisc/include/asm/signal.h
index e84883c6b4c7a..85c3d7409bbcd 100644
--- a/arch/parisc/include/asm/signal.h
+++ b/arch/parisc/include/asm/signal.h
@@ -4,12 +4,12 @@
 
 #include <uapi/asm/signal.h>
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
 
 #include <asm/sigcontext.h>
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 #endif /* _ASM_PARISC_SIGNAL_H */
diff --git a/arch/parisc/include/asm/smp.h b/arch/parisc/include/asm/smp.h
index 94d1f21ce99a1..0cf1c3a2696a9 100644
--- a/arch/parisc/include/asm/smp.h
+++ b/arch/parisc/include/asm/smp.h
@@ -12,7 +12,7 @@ extern int init_per_cpu(int cpuid);
 #define PDC_OS_BOOT_RENDEZVOUS     0x10
 #define PDC_OS_BOOT_RENDEZVOUS_HI  0x28
 
-#ifndef ASSEMBLY
+#ifndef __ASSEMBLER__
 #include <linux/bitops.h>
 #include <linux/threads.h>	/* for NR_CPUS */
 #include <linux/cpumask.h>
@@ -34,7 +34,7 @@ extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 #define raw_smp_processor_id()		(current_thread_info()->cpu)
 
-#endif /* !ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 
 #else /* CONFIG_SMP */
 
diff --git a/arch/parisc/include/asm/spinlock_types.h b/arch/parisc/include/asm/spinlock_types.h
index 7b986b09dba84..8e6889bc23ccf 100644
--- a/arch/parisc/include/asm/spinlock_types.h
+++ b/arch/parisc/include/asm/spinlock_types.h
@@ -6,7 +6,7 @@
 
 #define SPINLOCK_BREAK_INSN	0x0000c006	/* break 6,6 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef struct {
 	volatile unsigned int lock[4];
@@ -26,7 +26,7 @@ typedef struct {
 	volatile unsigned int	counter;
 } arch_rwlock_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define __ARCH_RW_LOCK_UNLOCKED__       0x01000000
 #define __ARCH_RW_LOCK_UNLOCKED         { .lock_mutex = __ARCH_SPIN_LOCK_UNLOCKED, \
diff --git a/arch/parisc/include/asm/thread_info.h b/arch/parisc/include/asm/thread_info.h
index 1a58795f785c5..b283738bb6dab 100644
--- a/arch/parisc/include/asm/thread_info.h
+++ b/arch/parisc/include/asm/thread_info.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_PARISC_THREAD_INFO_H
 #define _ASM_PARISC_THREAD_INFO_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <asm/special_insns.h>
 
@@ -20,7 +20,7 @@ struct thread_info {
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 
 /* thread information allocation */
 
diff --git a/arch/parisc/include/asm/traps.h b/arch/parisc/include/asm/traps.h
index 0ccdb738a9a36..10c8fb68e4040 100644
--- a/arch/parisc/include/asm/traps.h
+++ b/arch/parisc/include/asm/traps.h
@@ -4,7 +4,7 @@
 
 #define PARISC_ITLB_TRAP	6 /* defined by architecture. Do not change. */
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 struct pt_regs;
 
 /* traps.c */
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index a97c0fd55f91b..3e46c6ea9df6e 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -6,7 +6,7 @@
 
 #define __NR_Linux_syscalls	__NR_syscalls
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
@@ -144,7 +144,7 @@
 #define __ARCH_WANT_SYS_UTIME
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #undef STR
 
diff --git a/arch/parisc/include/asm/vdso.h b/arch/parisc/include/asm/vdso.h
index 2a2dc11b5545f..83697711bd64d 100644
--- a/arch/parisc/include/asm/vdso.h
+++ b/arch/parisc/include/asm/vdso.h
@@ -2,7 +2,7 @@
 #ifndef __PARISC_VDSO_H__
 #define __PARISC_VDSO_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_64BIT
 #include <generated/vdso64-offsets.h>
@@ -14,7 +14,7 @@
 
 extern struct vdso_data *vdso_data;
 
-#endif /* __ASSEMBLY __ */
+#endif /* __ASSEMBLER__ */
 
 /* Default link addresses for the vDSOs */
 #define VDSO_LBASE	0
-- 
2.48.1


