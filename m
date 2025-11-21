Return-Path: <linux-arch+bounces-15004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98449C78763
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D2E8B3523C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217F34CFDD;
	Fri, 21 Nov 2025 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzB7kY1n"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA3B34C155
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719293; cv=none; b=PkUiByKcnYkVL1FG99E34Tky7TVurtZxzd/XB+M817AVj5G/R9RslBKAJ9mrfuxUol3zAzg6jJw3Ln8lcw30RaGUFGQ76HBJ1I7hZSWXzNKWB0TLY85q5c/jfMrKtt7pGgGEZ0PFd0G7O/nWowBUpe7Q+eqD8GqARmsk2JagLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719293; c=relaxed/simple;
	bh=HLgawoAy9DaAij1+s86Avcd2g0KZab1a2dtzO5/YVtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swxnjp8i3S0vhubgKBw0WcvqgNCkbU0WzZMvnJwE7I9JLr6qCcfiULhTRfXG77wbR72aDu3Nv/pTGRFwPeX3JQEFCzWsAH7KXqrbn4cwzQn6lO5EFKnhr46sEjhgjdPmHEHV5O9lcBhDtNDlRVvnKLouXShGy3Hji/tOrBECbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzB7kY1n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWsngmRcWoomZwp/YKT5IiVx2Zr6I0AegdG9zHZZohY=;
	b=hzB7kY1nGX01W4cMD96XbQkQJGfHfjyinA2SSF6h4epsfV7OYqss5jen8BvS77PXTrx9OG
	Z+ri4DLLUO0DE7cJYvPeY1hrgOMuu5cr2K8Z1aoWYs0gwCSSWOok7pRYzaAnV6JW1mdv8W
	Nhe5WIp09j1wtaD4ah7rcdrIRTLJlUY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-1TU8z1g3OAydl1nOpf8z0A-1; Fri,
 21 Nov 2025 05:01:23 -0500
X-MC-Unique: 1TU8z1g3OAydl1nOpf8z0A-1
X-Mimecast-MFC-AGG-ID: 1TU8z1g3OAydl1nOpf8z0A_1763719282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 181E31800673;
	Fri, 21 Nov 2025 10:01:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3E7E1955F66;
	Fri, 21 Nov 2025 10:01:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 7/9] include: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 21 Nov 2025 11:00:42 +0100
Message-ID: <20251121100044.282684-8-thuth@redhat.com>
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
statement), except for some manual tweaking in the files
include/linux/irqchip/arm-gic.h and include/soc/tegra/flowctrl.h
(which got the macro wrong in a comment).

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/asm-generic/barrier.h           |  4 ++--
 include/asm-generic/bug.h               |  4 ++--
 include/asm-generic/current.h           |  2 +-
 include/asm-generic/error-injection.h   |  2 +-
 include/asm-generic/fixmap.h            |  4 ++--
 include/asm-generic/getorder.h          |  4 ++--
 include/asm-generic/int-ll64.h          |  6 +++---
 include/asm-generic/kprobes.h           |  4 ++--
 include/asm-generic/memory_model.h      |  4 ++--
 include/asm-generic/mmu.h               |  2 +-
 include/asm-generic/pgtable-nop4d.h     |  4 ++--
 include/asm-generic/pgtable-nopmd.h     |  4 ++--
 include/asm-generic/pgtable-nopud.h     |  4 ++--
 include/asm-generic/rwonce.h            |  4 ++--
 include/asm-generic/signal.h            |  4 ++--
 include/asm-generic/vdso/vsyscall.h     |  4 ++--
 include/linux/amba/serial.h             |  4 ++--
 include/linux/annotate.h                | 18 +++++++++---------
 include/linux/arm-smccc.h               |  4 ++--
 include/linux/bitmap.h                  |  4 ++--
 include/linux/bits.h                    |  6 +++---
 include/linux/cfi_types.h               |  6 +++---
 include/linux/compiler.h                |  4 ++--
 include/linux/compiler_types.h          |  4 ++--
 include/linux/edd.h                     |  4 ++--
 include/linux/err.h                     |  2 +-
 include/linux/export.h                  |  2 +-
 include/linux/init.h                    |  6 +++---
 include/linux/ioport.h                  |  4 ++--
 include/linux/irqchip/arm-gic-v3.h      |  2 +-
 include/linux/irqchip/arm-gic.h         |  4 ++--
 include/linux/jump_label.h              | 10 +++++-----
 include/linux/kexec.h                   |  2 +-
 include/linux/linkage.h                 |  6 +++---
 include/linux/mem_encrypt.h             |  4 ++--
 include/linux/mmzone.h                  |  4 ++--
 include/linux/objtool.h                 |  8 ++++----
 include/linux/objtool_types.h           |  4 ++--
 include/linux/of_fdt.h                  |  4 ++--
 include/linux/pe.h                      |  4 ++--
 include/linux/percpu-defs.h             |  4 ++--
 include/linux/pfn.h                     |  2 +-
 include/linux/pgtable.h                 |  4 ++--
 include/linux/platform_data/emif_plat.h |  4 ++--
 include/linux/serial_s3c.h              |  4 ++--
 include/linux/static_call_types.h       |  4 ++--
 include/linux/ti-emif-sram.h            |  2 +-
 include/linux/types.h                   |  4 ++--
 include/soc/imx/cpu.h                   |  2 +-
 include/soc/tegra/flowctrl.h            |  4 ++--
 include/soc/tegra/fuse.h                |  4 ++--
 include/vdso/datapage.h                 |  6 +++---
 include/vdso/helpers.h                  |  4 ++--
 include/vdso/processor.h                |  4 ++--
 include/vdso/vsyscall.h                 |  4 ++--
 include/xen/arm/interface.h             |  2 +-
 include/xen/interface/xen-mca.h         |  4 ++--
 include/xen/interface/xen.h             |  8 ++++----
 tools/include/asm-generic/barrier.h     |  4 ++--
 tools/include/asm/alternative.h         |  2 +-
 tools/include/linux/bits.h              |  6 +++---
 tools/include/linux/cfi_types.h         |  6 +++---
 tools/include/linux/compiler.h          |  4 ++--
 tools/include/linux/objtool_types.h     |  4 ++--
 tools/include/linux/static_call_types.h |  4 ++--
 65 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21da..e8038f7084a87 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_GENERIC_BARRIER_H
 #define __ASM_GENERIC_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
@@ -302,5 +302,5 @@ do {									\
 # define smp_mb__after_switch_mm()	smp_mb()
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 2d9f61346dab8..884f546477938 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -23,7 +23,7 @@
 # define WARN_CONDITION_STR(cond_str)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/panic.h>
 #include <linux/printk.h>
 
@@ -231,6 +231,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 # define WARN_ON_SMP(x)			({0;})
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
index 9c2aeecbd05a6..8e7d8f019377f 100644
--- a/include/asm-generic/current.h
+++ b/include/asm-generic/current.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_CURRENT_H
 #define __ASM_GENERIC_CURRENT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/thread_info.h>
 
 #define get_current() (current_thread_info()->task)
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa5..0a9ec33fa8f20 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_ERROR_INJECTION_H
 #define _ASM_GENERIC_ERROR_INJECTION_H
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 enum {
 	EI_ETYPE_NULL,		/* Return NULL if failure */
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 29cab7947980a..3ff832ebcea50 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -21,7 +21,7 @@
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * 'index to address' translation. If anyone tries to use the idx
  * directly without translation, we catch the bug with a NULL-deference
@@ -97,5 +97,5 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #define set_fixmap_io(idx, phys) \
 	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_GENERIC_FIXMAP_H */
diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index f2979e3a96b60..875ccae196832 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_GETORDER_H
 #define __ASM_GENERIC_GETORDER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/log2.h>
@@ -47,6 +47,6 @@ static __always_inline __attribute_const__ int get_order(unsigned long size)
 #endif
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __ASM_GENERIC_GETORDER_H */
diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
index a248545f1e18c..58974e8abbfae 100644
--- a/include/asm-generic/int-ll64.h
+++ b/include/asm-generic/int-ll64.h
@@ -11,7 +11,7 @@
 #include <uapi/asm-generic/int-ll64.h>
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef __s8  s8;
 typedef __u8  u8;
@@ -31,7 +31,7 @@ typedef __u64 u64;
 #define S64_C(x) x ## LL
 #define U64_C(x) x ## ULL
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define S8_C(x)  x
 #define U8_C(x)  x
@@ -42,6 +42,6 @@ typedef __u64 u64;
 #define S64_C(x) x
 #define U64_C(x) x
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_GENERIC_INT_LL64_H */
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 060eab094e5a2..7161a90d0aa6e 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_KPROBES_H
 #define _ASM_GENERIC_KPROBES_H
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 #ifdef CONFIG_KPROBES
 /*
  * Blacklist ganerating macro. Specify functions which is not probed
@@ -21,6 +21,6 @@ static unsigned long __used					\
 # define __kprobes
 # define nokprobe_inline	inline
 #endif
-#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
 
 #endif /* _ASM_GENERIC_KPROBES_H */
diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index efa6610acbc79..fd74de50b0540 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -4,7 +4,7 @@
 
 #include <linux/pfn.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * supports 3 memory models.
@@ -86,6 +86,6 @@ static inline int pfn_valid(unsigned long pfn)
 #endif /* CONFIG_DEBUG_VIRTUAL */
 #define phys_to_page(phys)	pfn_to_page(PHYS_PFN(phys))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/include/asm-generic/mmu.h b/include/asm-generic/mmu.h
index 0618380375429..5f78971e3ac2c 100644
--- a/include/asm-generic/mmu.h
+++ b/include/asm-generic/mmu.h
@@ -6,7 +6,7 @@
  * This is the mmu.h header for nommu implementations.
  * Architectures with an MMU need something more complex.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct {
 	unsigned long		end_brk;
 
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd43..89c21f84cffbe 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOP4D_H
 #define _PGTABLE_NOP4D_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __PAGETABLE_P4D_FOLDED 1
 
@@ -54,5 +54,5 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _PGTABLE_NOP4D_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24cb..36b6490ed1808 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOPMD_H
 #define _PGTABLE_NOPMD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm-generic/pgtable-nopud.h>
 
@@ -68,6 +68,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 #undef  pmd_addr_end
 #define pmd_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _PGTABLE_NOPMD_H */
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff2..356cbfbaab247 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOPUD_H
 #define _PGTABLE_NOPUD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm-generic/pgtable-nop4d.h>
 
@@ -62,5 +62,5 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #undef  pud_addr_end
 #define pud_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _PGTABLE_NOPUD_H */
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 52b969c7cef93..c35b262ee4223 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_GENERIC_RWONCE_H
 #define __ASM_GENERIC_RWONCE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_types.h>
 #include <linux/kasan-checks.h>
@@ -94,5 +94,5 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif	/* __ASM_GENERIC_RWONCE_H */
diff --git a/include/asm-generic/signal.h b/include/asm-generic/signal.h
index 663dd6d0795dc..392e59fd3d8b9 100644
--- a/include/asm-generic/signal.h
+++ b/include/asm-generic/signal.h
@@ -4,10 +4,10 @@
 
 #include <uapi/asm-generic/signal.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/sigcontext.h>
 #undef __HAVE_ARCH_SIG_BITOPS
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_GENERIC_SIGNAL_H */
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 5c6d9799f4e74..a6b03cfba0e24 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_VSYSCALL_H
 #define __ASM_GENERIC_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
@@ -30,6 +30,6 @@ static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vd
 }
 #endif /* __arch_sync_vdso_time_data */
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_GENERIC_VSYSCALL_H */
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 9120de05ead08..b9129c0d6304f 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -10,7 +10,7 @@
 #ifndef ASM_ARM_HARDWARE_SERIAL_AMBA_H
 #define ASM_ARM_HARDWARE_SERIAL_AMBA_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #endif
@@ -215,7 +215,7 @@
 #define UART01x_RSR_ANY		(UART01x_RSR_OE | UART01x_RSR_BE | UART01x_RSR_PE | UART01x_RSR_FE)
 #define UART01x_FR_MODEM_ANY	(UART01x_FR_DCD | UART01x_FR_DSR | UART01x_FR_CTS)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct amba_device; /* in uncompress this is included but amba/bus.h is not */
 struct amba_pl010_data {
 	void (*set_mctrl)(struct amba_device *dev, void __iomem *base, unsigned int mctrl);
diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index 7c10d34d198cf..11b755e6a9db1 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_OBJTOOL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __ASM_ANNOTATE(section, label, type)				\
 	".pushsection " section ",\"M\", @progbits, 8\n\t"		\
@@ -25,7 +25,7 @@
 	"912:\n\t"							\
 	__ASM_ANNOTATE(".discard.annotate_data", 912b, type)
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 .macro __ANNOTATE section, type
 .Lhere_\@:
@@ -43,22 +43,22 @@
 	__ANNOTATE ".discard.annotate_data", \type
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* !CONFIG_OBJTOOL */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define ASM_ANNOTATE_LABEL(label, type) ""
 #define ASM_ANNOTATE(type)
 #define ASM_ANNOTATE_DATA(type)
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 .macro ANNOTATE type
 .endm
 .macro ANNOTATE_DATA type
 .endm
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* !CONFIG_OBJTOOL */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
@@ -118,7 +118,7 @@
  */
 #define ANNOTATE_DATA_SPECIAL		ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 #define ANNOTATE_NOENDBR		ANNOTATE type=ANNOTYPE_NOENDBR
 #define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=ANNOTYPE_RETPOLINE_SAFE
 /*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=ANNOTYPE_INSTR_BEGIN */
@@ -129,6 +129,6 @@
 #define ANNOTATE_REACHABLE		ANNOTATE type=ANNOTYPE_REACHABLE
 #define ANNOTATE_NOCFI_SYM		ANNOTATE type=ANNOTYPE_NOCFI
 #define ANNOTATE_DATA_SPECIAL		ANNOTATE_DATA type=ANNOTYPE_DATA_SPECIAL
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _LINUX_ANNOTATE_H */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index a95077b2fc17e..96d7a61055a70 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -302,7 +302,7 @@
 #define SMCCC_RET_NOT_REQUIRED			-2
 #define SMCCC_RET_INVALID_PARAMETER		-3
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -750,5 +750,5 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
 	})
 #endif /*CONFIG_ARM64*/
 
-#endif /*__ASSEMBLY__*/
+#endif /*__ASSEMBLER__*/
 #endif /*__LINUX_ARM_SMCCC_H*/
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index b0395e4ccf903..2e7f7bb0277f3 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -2,7 +2,7 @@
 #ifndef __LINUX_BITMAP_H
 #define __LINUX_BITMAP_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/align.h>
 #include <linux/bitops.h>
@@ -846,6 +846,6 @@ void bitmap_write(unsigned long *map, unsigned long value,
 #define bitmap_set_value8(map, value, start)		\
 	bitmap_write(map, value, start, BITS_PER_BYTE)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/include/linux/bits.h b/include/linux/bits.h
index a40cc861b3a7c..b7509f15718e6 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -17,7 +17,7 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 /*
  * Missing asm support
@@ -75,7 +75,7 @@
 #define BIT_U32(nr)	BIT_TYPE(u32, nr)
 #define BIT_U64(nr)	BIT_TYPE(u64, nr)
 
-#else /* defined(__ASSEMBLY__) */
+#else /* defined(__ASSEMBLER__) */
 
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
@@ -84,6 +84,6 @@
 #define GENMASK(h, l)		__GENMASK(h, l)
 #define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 
 #endif	/* __LINUX_BITS_H */
diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
index a86af9bc8bdc4..b17614c493e4c 100644
--- a/include/linux/cfi_types.h
+++ b/include/linux/cfi_types.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_CFI_TYPES_H
 #define _LINUX_CFI_TYPES_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <linux/linkage.h>
 
 #ifdef CONFIG_CFI
@@ -41,7 +41,7 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_CFI
 #define DEFINE_CFI_TYPE(name, func)						\
@@ -64,5 +64,5 @@
 	);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_CFI_TYPES_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ff71bebe56f5c..081f7ec81f936 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -4,7 +4,7 @@
 
 #include <linux/compiler_types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef __KERNEL__
 
@@ -271,7 +271,7 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Force the compiler to emit 'sym' as a symbol, so that we can reference
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c46855162a8ab..d706fe4635e7c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -15,7 +15,7 @@
 #define ___PASTE(a, b) a##b
 #define __PASTE(a, b) ___PASTE(a, b)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Skipped when running bindgen due to a libclang issue;
@@ -422,7 +422,7 @@ struct ftrace_likely_data {
 
 #endif /* __KERNEL__ */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The below symbols may be defined for one or more, but not ALL, of the above
diff --git a/include/linux/edd.h b/include/linux/edd.h
index 1c16fbcb81c06..32517f283f044 100644
--- a/include/linux/edd.h
+++ b/include/linux/edd.h
@@ -23,7 +23,7 @@
 
 #include <uapi/linux/edd.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern struct edd edd;
-#endif				/*!__ASSEMBLY__ */
+#endif				/*!__ASSEMBLER__ */
 #endif				/* _LINUX_EDD_H */
diff --git a/include/linux/err.h b/include/linux/err.h
index 8c37be0620abf..cd330aeabecd8 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -17,7 +17,7 @@
  */
 #define MAX_ERRNO	4095
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /**
  * IS_ERR_VALUE - Detect an error pointer.
diff --git a/include/linux/export.h b/include/linux/export.h
index a686fd0ba4065..432e980140f2b 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -51,7 +51,7 @@
 
 #define __EXPORT_SYMBOL(sym, license, ns)	__GENKSYMS_EXPORT_SYMBOL(sym)
 
-#elif defined(__ASSEMBLY__)
+#elif defined(__ASSEMBLER__)
 
 #define __EXPORT_SYMBOL(sym, license, ns) \
 	___EXPORT_SYMBOL(sym, license, ns)
diff --git a/include/linux/init.h b/include/linux/init.h
index 40331923b9f4a..e74e7283cd1cf 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -102,7 +102,7 @@
 #define __REFDATA        .section       ".ref.data", "aw"
 #define __REFCONST       .section       ".ref.rodata", "a"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Used for initialization calls..
  */
@@ -180,7 +180,7 @@ extern struct module __this_module;
   
 #ifndef MODULE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * initcalls are now grouped by functionality into separate
@@ -375,7 +375,7 @@ extern const struct obs_kernel_param __setup_start[], __setup_end[];
 /* Relies on boot_command_line being set */
 void __init parse_early_param(void);
 void __init parse_early_options(char *cmdline);
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* MODULE */
 
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 9afa30f9346fc..3c7cc25f3ec9d 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -9,7 +9,7 @@
 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/minmax.h>
@@ -435,5 +435,5 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 
 extern struct address_space *iomem_get_mapping(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 70c0948f978eb..9628465516abc 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -603,7 +603,7 @@
 
 #include <asm/arch_gicv3.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * We need a value to serve as a irq-type for LPIs. Choose one that will
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index d45fa19f9e470..849386dc5ec80 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -131,7 +131,7 @@
 #define GICV_PMR_PRIORITY_SHIFT		3
 #define GICV_PMR_PRIORITY_MASK		(0x1f << GICV_PMR_PRIORITY_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/irqdomain.h>
 
@@ -162,5 +162,5 @@ int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 unsigned long gic_get_sgir_physaddr(void);
 
-#endif /* __ASSEMBLY */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index fdb79dd1ebd8c..b4bb7854963c3 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -71,7 +71,7 @@
  * Additional babbling in: Documentation/staging/static-keys.rst
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <linux/compiler.h>
@@ -107,12 +107,12 @@ struct static_key {
 #endif	/* CONFIG_JUMP_LABEL */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_JUMP_LABEL
 #include <asm/jump_label.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE
 
 struct jump_entry {
@@ -187,7 +187,7 @@ static inline int jump_entry_size(struct jump_entry *entry)
 #endif
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum jump_label_type {
 	JUMP_LABEL_NOP = 0,
@@ -538,6 +538,6 @@ extern bool ____wrong_branch_error(void);
 #define static_branch_enable_cpuslocked(x)	static_key_enable_cpuslocked(&(x)->key)
 #define static_branch_disable_cpuslocked(x)	static_key_disable_cpuslocked(&(x)->key)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif	/* _LINUX_JUMP_LABEL_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c8..0af8ae4fdd087 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -13,7 +13,7 @@
 #define IND_SOURCE       (1 << IND_SOURCE_BIT)
 #define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 #include <linux/vmcore_info.h>
 #include <linux/crash_reserve.h>
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index b11660b706c58..dd7e3baff0b26 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -62,7 +62,7 @@
  * end up needing stack temporaries for).
  */
 /* Assembly files may be compiled with -traditional .. */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef asmlinkage_protect
 # define asmlinkage_protect(n, ret, args...)	do { } while (0)
 #endif
@@ -73,7 +73,7 @@
 #define __ALIGN_STR		__stringify(__ALIGN)
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* SYM_T_FUNC -- type used by assembler to mark functions */
 #ifndef SYM_T_FUNC
@@ -351,6 +351,6 @@
 	SYM_DATA_END(name)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _LINUX_LINKAGE_H */
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 07584c5e36fb4..463090c4f9517 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -10,7 +10,7 @@
 #ifndef __MEM_ENCRYPT_H__
 #define __MEM_ENCRYPT_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_ARCH_HAS_MEM_ENCRYPT
 
@@ -54,6 +54,6 @@
 #define dma_addr_canonical(x)		(x)
 #endif
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __MEM_ENCRYPT_H__ */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4398e027f450e..694c20e4ae064 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef __GENERATING_BOUNDS_H
 
 #include <linux/spinlock.h>
@@ -2306,5 +2306,5 @@ void sparse_init(void);
 #endif
 
 #endif /* !__GENERATING_BOUNDS.H */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _LINUX_MMZONE_H */
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index b18ab53561c99..2459eb0830002 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_OBJTOOL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal)		\
 	"987: \n\t"						\
@@ -53,7 +53,7 @@
 
 #define __ASM_BREF(label)	label ## b
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /*
  * In asm, there are two kinds of code: normal C-type callable functions and
@@ -102,11 +102,11 @@
 #endif
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #else /* !CONFIG_OBJTOOL */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index c6def4049b1ae..c24e9ea392696 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_OBJTOOL_TYPES_H
 #define _LINUX_OBJTOOL_TYPES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -18,7 +18,7 @@ struct unwind_hint {
 	u8		signal;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * UNWIND_HINT_TYPE_UNDEFINED: A blind spot in ORC coverage which can result in
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 51dadbaa3d63a..72b452e388eeb 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -16,7 +16,7 @@
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_OF_FLATTREE)
 
@@ -103,5 +103,5 @@ static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_OF_FDT_H */
diff --git a/include/linux/pe.h b/include/linux/pe.h
index cd2b7275385f3..ab45bba90ce82 100644
--- a/include/linux/pe.h
+++ b/include/linux/pe.h
@@ -240,7 +240,7 @@
 #define IMAGE_DEBUG_TYPE_EX_DLLCHARACTERISTICS	20 /* Extended DLL characteristics bits */
 #define IMAGE_DEBUG_TYPE_PERFMAP		21 /* Location of associated Ready To Run PerfMap file */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mz_hdr {
 	uint16_t magic;		/* MZ_MAGIC */
@@ -546,6 +546,6 @@ struct win_certificate {
 	uint16_t cert_type;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __LINUX_PE_H */
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 12d90360f6db9..d3103307402fe 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -203,7 +203,7 @@
 /*
  * Accessors and operations.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * __verify_pcpu_ptr() verifies @ptr is a percpu pointer without evaluating
@@ -514,5 +514,5 @@ do {									\
 #define this_cpu_inc_return(pcp)	this_cpu_add_return(pcp, 1)
 #define this_cpu_dec_return(pcp)	this_cpu_add_return(pcp, -1)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_PERCPU_DEFS_H */
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index b90ca0b6c331e..cfedf0f61bb3c 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_PFN_H_
 #define _LINUX_PFN_H_
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #endif
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ee3148ef87f60..bdf1cb021f6f9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -8,7 +8,7 @@
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_MMU
 
 #include <linux/mm_types.h>
@@ -2005,7 +2005,7 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
diff --git a/include/linux/platform_data/emif_plat.h b/include/linux/platform_data/emif_plat.h
index b93feef5d586f..ad7f706c124e3 100644
--- a/include/linux/platform_data/emif_plat.h
+++ b/include/linux/platform_data/emif_plat.h
@@ -39,7 +39,7 @@
 #define EMIF_CUSTOM_CONFIG_TEMP_ALERT_POLL_INTERVAL	0x00000002
 #define EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART		0x00000004
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /**
  * struct ddr_device_info - All information about the DDR device except AC
  *		timing parameters
@@ -121,6 +121,6 @@ struct emif_platform_data {
 	u32 ip_rev;
 	u32 phy_type;
 };
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __LINUX_EMIF_H */
diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 102aa33d956c4..f54cb6e23f85e 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -269,7 +269,7 @@
 #define APPLE_S5L_UTRSTAT_RXTO		BIT(9)
 #define APPLE_S5L_UTRSTAT_ALL_FLAGS	GENMASK(9, 3)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/serial_core.h>
 
@@ -294,7 +294,7 @@ struct s3c2410_uartcfg {
 	unsigned long	   ufcon;	 /* value of ufcon for port */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_ARM_REGS_SERIAL_H */
 
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index cfb6ddeb292b6..ac55bc966a56c 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -25,7 +25,7 @@
 #define STATIC_CALL_SITE_INIT 2UL	/* init section */
 #define STATIC_CALL_SITE_FLAGS 3UL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * The static call site table needs to be created by external tooling (objtool
@@ -102,6 +102,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/include/linux/ti-emif-sram.h b/include/linux/ti-emif-sram.h
index 441b2988e66a5..b256a9b4ef053 100644
--- a/include/linux/ti-emif-sram.h
+++ b/include/linux/ti-emif-sram.h
@@ -10,7 +10,7 @@
 
 #include <linux/kbuild.h>
 #include <linux/types.h>
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct emif_regs_amx3 {
 	u32 emif_sdcfg_val;
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c35..00b44dd5bdfd7 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -5,7 +5,7 @@
 #define __EXPORTED_HEADERS__
 #include <uapi/linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
@@ -265,5 +265,5 @@ struct rcuwait {
 	struct task_struct __rcu *task;
 };
 
-#endif /*  __ASSEMBLY__ */
+#endif /*  __ASSEMBLER__ */
 #endif /* _LINUX_TYPES_H */
diff --git a/include/soc/imx/cpu.h b/include/soc/imx/cpu.h
index 0bf610acafd06..8c53150acd76e 100644
--- a/include/soc/imx/cpu.h
+++ b/include/soc/imx/cpu.h
@@ -30,7 +30,7 @@
 #define MXC_CPU_VF600		0x600
 #define MXC_CPU_VF610		(MXC_CPU_VF600 | MXC_CPU_VFx10)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int __mxc_cpu_type;
 #endif
 
diff --git a/include/soc/tegra/flowctrl.h b/include/soc/tegra/flowctrl.h
index 1aacc5c7a9dba..2a60bd4934c32 100644
--- a/include/soc/tegra/flowctrl.h
+++ b/include/soc/tegra/flowctrl.h
@@ -39,7 +39,7 @@
 #define TEGRA30_FLOW_CTRL_CSR_WFE_BITMAP	(0xF << 4)
 #define TEGRA30_FLOW_CTRL_CSR_WFI_BITMAP	(0xF << 8)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_SOC_TEGRA_FLOWCTRL
 u32 flowctrl_read_cpu_csr(unsigned int cpuid);
 void flowctrl_write_cpu_csr(unsigned int cpuid, u32 value);
@@ -67,5 +67,5 @@ static inline void flowctrl_cpu_suspend_exit(unsigned int cpuid)
 {
 }
 #endif /* CONFIG_SOC_TEGRA_FLOWCTRL */
-#endif /* __ASSEMBLY */
+#endif /* __ASSEMBLER__ */
 #endif /* __SOC_TEGRA_FLOWCTRL_H__ */
diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index 8f421b9f7585c..c4f7a1b97c547 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -24,7 +24,7 @@
 #define TEGRA30_FUSE_SATA_CALIB	0x124
 #define TEGRA_FUSE_USB_CALIB_EXT_0 0x250
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum tegra_revision {
 	TEGRA_REVISION_UNKNOWN = 0,
@@ -122,6 +122,6 @@ static inline int tegra194_miscreg_mask_serror(void)
 
 struct device *tegra_soc_device_register(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __SOC_TEGRA_FUSE_H__ */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 23c39b96190fd..96e6eb0cb7df9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -2,7 +2,7 @@
 #ifndef __VDSO_DATAPAGE_H
 #define __VDSO_DATAPAGE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <uapi/linux/bits.h>
@@ -195,7 +195,7 @@ enum vdso_pages {
  */
 #include <asm/vdso/gettimeofday.h>
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_VDSO_GETRANDOM
 #define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data = vdso_u_data + 2 * PAGE_SIZE);
@@ -216,6 +216,6 @@ enum vdso_pages {
 	__vdso_u_arch_data					\
 
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 1a5ee9d9052c3..20439e6d5fbf0 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -2,7 +2,7 @@
 #ifndef __VDSO_HELPERS_H
 #define __VDSO_HELPERS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
@@ -82,6 +82,6 @@ static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 	vdso_write_seq_end(&vc[CS_RAW]);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_HELPERS_H */
diff --git a/include/vdso/processor.h b/include/vdso/processor.h
index fbe8265ea3c49..cc781912a696e 100644
--- a/include/vdso/processor.h
+++ b/include/vdso/processor.h
@@ -5,10 +5,10 @@
 #ifndef __VDSO_PROCESSOR_H
 #define __VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/processor.h>
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __VDSO_PROCESSOR_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index b0fdc9c6bf439..c5c2a2c078571 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -2,13 +2,13 @@
 #ifndef __VDSO_VSYSCALL_H
 #define __VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/vsyscall.h>
 
 unsigned long vdso_update_begin(void);
 void vdso_update_end(unsigned long flags);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_VSYSCALL_H */
diff --git a/include/xen/arm/interface.h b/include/xen/arm/interface.h
index c3eada2642aa9..61360b89da405 100644
--- a/include/xen/arm/interface.h
+++ b/include/xen/arm/interface.h
@@ -30,7 +30,7 @@
 
 #define __HYPERVISOR_platform_op_raw __HYPERVISOR_platform_op
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* Explicitly size integers that represent pfns in the interface with
  * Xen so that we can have one ABI that works for 32 and 64 bit guests.
  * Note that this means that the xen_pfn_t type may be capable of
diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 1c9afbe8cc260..8f5815f1d3ab3 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -50,7 +50,7 @@
 /* OUT: There was no machine check data to fetch. */
 #define XEN_MC_NODATA		0x2
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* vIRQ injected to Dom0 */
 #define VIRQ_MCA VIRQ_ARCH_0
 
@@ -388,5 +388,5 @@ struct xen_mce_log {
 #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
 #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __XEN_PUBLIC_ARCH_X86_MCA_H__ */
diff --git a/include/xen/interface/xen.h b/include/xen/interface/xen.h
index 0ca23eca2a9cc..40c9793e98805 100644
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -337,7 +337,7 @@
 #define MMUEXT_MARK_SUPER       19
 #define MMUEXT_UNMARK_SUPER     20
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct mmuext_op {
 	unsigned int cmd;
 	union {
@@ -415,7 +415,7 @@ DEFINE_GUEST_HANDLE_STRUCT(mmuext_op);
 
 #define MAX_VMASST_TYPE 5
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef uint16_t domid_t;
 
@@ -760,11 +760,11 @@ struct tmem_op {
 
 DEFINE_GUEST_HANDLE(u64);
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /* In assembly code we cannot use C numeric constant suffixes. */
 #define mk_unsigned_long(x) x
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __XEN_PUBLIC_XEN_H__ */
diff --git a/tools/include/asm-generic/barrier.h b/tools/include/asm-generic/barrier.h
index 6ef36e920ea8a..b61c3bde0447e 100644
--- a/tools/include/asm-generic/barrier.h
+++ b/tools/include/asm-generic/barrier.h
@@ -13,7 +13,7 @@
 #ifndef __TOOLS_LINUX_ASM_GENERIC_BARRIER_H
 #define __TOOLS_LINUX_ASM_GENERIC_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 
@@ -36,5 +36,5 @@
 #define wmb()	mb()
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __TOOLS_LINUX_ASM_GENERIC_BARRIER_H */
diff --git a/tools/include/asm/alternative.h b/tools/include/asm/alternative.h
index 8e548ac8f740c..85db65074a714 100644
--- a/tools/include/asm/alternative.h
+++ b/tools/include/asm/alternative.h
@@ -3,7 +3,7 @@
 #define _TOOLS_ASM_ALTERNATIVE_ASM_H
 
 #if defined(__s390x__)
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 .macro ALTERNATIVE oldinstr, newinstr, feature
 	\oldinstr
 .endm
diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index a40cc861b3a7c..b7509f15718e6 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -17,7 +17,7 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 /*
  * Missing asm support
@@ -75,7 +75,7 @@
 #define BIT_U32(nr)	BIT_TYPE(u32, nr)
 #define BIT_U64(nr)	BIT_TYPE(u64, nr)
 
-#else /* defined(__ASSEMBLY__) */
+#else /* defined(__ASSEMBLER__) */
 
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
@@ -84,6 +84,6 @@
 #define GENMASK(h, l)		__GENMASK(h, l)
 #define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 
 #endif	/* __LINUX_BITS_H */
diff --git a/tools/include/linux/cfi_types.h b/tools/include/linux/cfi_types.h
index a86af9bc8bdc4..b17614c493e4c 100644
--- a/tools/include/linux/cfi_types.h
+++ b/tools/include/linux/cfi_types.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_CFI_TYPES_H
 #define _LINUX_CFI_TYPES_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <linux/linkage.h>
 
 #ifdef CONFIG_CFI
@@ -41,7 +41,7 @@
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #ifdef CONFIG_CFI
 #define DEFINE_CFI_TYPE(name, func)						\
@@ -64,5 +64,5 @@
 	);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _LINUX_CFI_TYPES_H */
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index f40bd2b04c298..45b2405de8967 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -2,7 +2,7 @@
 #ifndef _TOOLS_LINUX_COMPILER_H_
 #define _TOOLS_LINUX_COMPILER_H_
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_types.h>
 
@@ -256,6 +256,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #endif
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _TOOLS_LINUX_COMPILER_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtool_types.h
index c6def4049b1ae..c24e9ea392696 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_OBJTOOL_TYPES_H
 #define _LINUX_OBJTOOL_TYPES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -18,7 +18,7 @@ struct unwind_hint {
 	u8		signal;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * UNWIND_HINT_TYPE_UNDEFINED: A blind spot in ORC coverage which can result in
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index cfb6ddeb292b6..ac55bc966a56c 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -25,7 +25,7 @@
 #define STATIC_CALL_SITE_INIT 2UL	/* init section */
 #define STATIC_CALL_SITE_FLAGS 3UL
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * The static call site table needs to be created by external tooling (objtool
@@ -102,6 +102,6 @@ struct static_call_key {
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _STATIC_CALL_TYPES_H */
-- 
2.51.1


