Return-Path: <linux-arch+bounces-15000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 622ACC78606
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 11:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCE4ED8AB
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1326F476;
	Fri, 21 Nov 2025 10:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZiFEGEJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DA34AAE9
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719280; cv=none; b=ARRpqZ7Y9JfHD2jluX8EK78KvkGHaDEtnDkuBekNe2gRY54WE/lirHhCsy7Hax6kfyLaz6+B4Hcuqb9/RlU0quqrWsCjj7hb/0pg67eGB2MmX7xg1mHMxoQ/NIyAXpa7DvC/t6Bmw5UaIOleII1CHg43jyF01A81pGrsAjkdUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719280; c=relaxed/simple;
	bh=5NFG9zYGJDCC0tU8JLmcZ80BvrnNyHeNZ9l9nB5EonI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzyZ7uxKvbBXWo1jpSVl/7naM/FehiIjUxbeMbYV1gbt5j29FOSdLtB8gQwEXs/X4OoPgsOyesPTQOZ4gkh1LzsZFXKxkpXxshaFtQ3Js2MrVN1cuvrhQlOb6LvJSpOIJv/IN68KwCrCv2eoSqYfpGhDPWSEapAy3dUbbZStOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZiFEGEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763719275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fav3y8h8nJPPN9sio+u+Q3x71Q5Lp3sUBRhdM7MrD/Q=;
	b=GZiFEGEJ1s+S4tgqcL7BRKOCuFX4YT3PUaCjFQLIjXQExhzfqYQBt+GgbcSZdtdGqCIC3W
	dkX0F2H4ZXRdCgL4/kpwBgzc6LvJcpHISQQfOtZp838ZsmOP2B3ZbEylaBVogUgpLUr67P
	G+iX2OCGAS5hmY/VQyCJRFWIQ4dQ3uA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Pb0UuUS5PU-A8_o_LIeW8g-1; Fri,
 21 Nov 2025 05:01:10 -0500
X-MC-Unique: Pb0UuUS5PU-A8_o_LIeW8g-1
X-Mimecast-MFC-AGG-ID: Pb0UuUS5PU-A8_o_LIeW8g_1763719269
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 130A11956067;
	Fri, 21 Nov 2025 10:01:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E9851955F67;
	Fri, 21 Nov 2025 10:01:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 3/9] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 21 Nov 2025 11:00:38 +0100
Message-ID: <20251121100044.282684-4-thuth@redhat.com>
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

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arm/include/asm/arch_gicv3.h                |  4 ++--
 arch/arm/include/asm/assembler.h                 |  2 +-
 arch/arm/include/asm/barrier.h                   |  4 ++--
 arch/arm/include/asm/cache.h                     |  2 +-
 arch/arm/include/asm/cp15.h                      |  4 ++--
 arch/arm/include/asm/cputype.h                   |  4 ++--
 arch/arm/include/asm/current.h                   |  4 ++--
 arch/arm/include/asm/delay.h                     |  4 ++--
 arch/arm/include/asm/domain.h                    |  8 ++++----
 arch/arm/include/asm/fpstate.h                   |  2 +-
 arch/arm/include/asm/ftrace.h                    |  6 +++---
 arch/arm/include/asm/hardware/cache-b15-rac.h    |  2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h       |  4 ++--
 arch/arm/include/asm/hardware/dec21285.h         |  2 +-
 arch/arm/include/asm/hardware/ioc.h              |  2 +-
 arch/arm/include/asm/hardware/iomd.h             |  4 ++--
 arch/arm/include/asm/hardware/memc.h             |  2 +-
 arch/arm/include/asm/hwcap.h                     |  2 +-
 arch/arm/include/asm/irq.h                       |  2 +-
 arch/arm/include/asm/jump_label.h                |  4 ++--
 arch/arm/include/asm/kexec.h                     |  4 ++--
 arch/arm/include/asm/kgdb.h                      |  4 ++--
 arch/arm/include/asm/mach/arch.h                 |  2 +-
 arch/arm/include/asm/mcpm.h                      |  4 ++--
 arch/arm/include/asm/memory.h                    |  4 ++--
 arch/arm/include/asm/mpu.h                       |  4 ++--
 arch/arm/include/asm/opcodes.h                   | 12 ++++++------
 arch/arm/include/asm/page.h                      |  4 ++--
 arch/arm/include/asm/pgtable-2level.h            |  4 ++--
 arch/arm/include/asm/pgtable-3level.h            |  4 ++--
 arch/arm/include/asm/pgtable-nommu.h             |  4 ++--
 arch/arm/include/asm/pgtable.h                   | 10 +++++-----
 arch/arm/include/asm/probes.h                    |  4 ++--
 arch/arm/include/asm/proc-fns.h                  |  4 ++--
 arch/arm/include/asm/ptrace.h                    |  4 ++--
 arch/arm/include/asm/system_info.h               |  4 ++--
 arch/arm/include/asm/system_misc.h               |  4 ++--
 arch/arm/include/asm/thread_info.h               |  2 +-
 arch/arm/include/asm/thread_notify.h             |  2 +-
 arch/arm/include/asm/tlbflush.h                  | 10 +++++-----
 arch/arm/include/asm/tls.h                       |  4 ++--
 arch/arm/include/asm/unified.h                   |  6 +++---
 arch/arm/include/asm/unwind.h                    |  4 ++--
 arch/arm/include/asm/v7m.h                       |  4 ++--
 arch/arm/include/asm/vdso.h                      |  4 ++--
 arch/arm/include/asm/vdso/cp15.h                 |  4 ++--
 arch/arm/include/asm/vdso/gettimeofday.h         |  4 ++--
 arch/arm/include/asm/vdso/processor.h            |  4 ++--
 arch/arm/include/asm/vdso/vsyscall.h             |  4 ++--
 arch/arm/include/asm/vfp.h                       |  2 +-
 arch/arm/include/asm/virt.h                      |  4 ++--
 arch/arm/mach-at91/pm.h                          |  2 +-
 arch/arm/mach-exynos/smc.h                       |  4 ++--
 arch/arm/mach-footbridge/include/mach/hardware.h |  2 +-
 arch/arm/mach-imx/hardware.h                     |  2 +-
 arch/arm/mach-imx/mxc.h                          |  2 +-
 arch/arm/mach-omap2/control.h                    |  8 ++++----
 arch/arm/mach-omap2/soc.h                        |  4 ++--
 arch/arm/mach-omap2/sram.h                       |  4 ++--
 arch/arm/mach-pxa/irqs.h                         |  2 +-
 arch/arm/mach-pxa/pxa-regs.h                     |  2 +-
 arch/arm/mach-s3c/map-base.h                     |  2 +-
 arch/arm/mach-sa1100/include/mach/bitfield.h     |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h     |  2 +-
 arch/arm/mach-tegra/reset.h                      |  2 +-
 arch/arm/mach-tegra/sleep.h                      |  2 +-
 arch/arm/tools/gen-mach-types                    |  2 +-
 drivers/memory/emif.h                            |  4 ++--
 include/linux/arm-smccc.h                        |  6 +++---
 69 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 311e83038bdb3..847590df75511 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARCH_GICV3_H
 #define __ASM_ARCH_GICV3_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
@@ -257,5 +257,5 @@ static inline bool gic_has_relaxed_pmr_sync(void)
 	return false;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* !__ASM_ARCH_GICV3_H */
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index d33c1e24e00b3..0f1f3b907825e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ASSEMBLER_H__
 #define __ASM_ASSEMBLER_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #error "Only include this from assembly code"
 #endif
 
diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 83ae97c049d9b..af3516cfa8dcd 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_BARRIER_H
 #define __ASM_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
@@ -99,5 +99,5 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 
 #include <asm-generic/barrier.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index ecbc100d22a56..38a38a53badc9 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -26,7 +26,7 @@
 
 #define __read_mostly __section(".data..read_mostly")
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARCH_HAS_CACHE_LINE_SIZE
 int cache_line_size(void);
 #endif
diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index a54230e656479..603a33c4bf572 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -40,7 +40,7 @@
 #define CR_AFE	(1 << 29)	/* Access flag enable			*/
 #define CR_TE	(1 << 30)	/* Thumb exception enable		*/
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if __LINUX_ARM_ARCH__ >= 4
 #define vectors_high()	(get_cr() & CR_V)
@@ -117,6 +117,6 @@ static inline unsigned long get_cr(void)
 
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
-#endif /* ifndef __ASSEMBLY__ */
+#endif /* ifndef __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 0163c3e78a67f..4b2832e14c3e1 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -109,7 +109,7 @@
 /* Qualcomm implemented cores */
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stringify.h>
 #include <linux/kernel.h>
@@ -343,6 +343,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 5225cb1c803b1..12968d3cdc269 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_ARM_CURRENT_H
 #define _ASM_ARM_CURRENT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/insn.h>
 
 struct task_struct;
@@ -60,6 +60,6 @@ static __always_inline __attribute_const__ struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_ARM_CURRENT_H */
diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 1d069e558d8de..6fffc2547f9df 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -41,7 +41,7 @@
 #define UDELAY_MULT	UL(2147 * HZ + 483648 * HZ / 1000000)
 #define UDELAY_SHIFT	31
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct delay_timer {
 	unsigned long (*read_current_timer)(void);
@@ -94,7 +94,7 @@ extern void __loop_const_udelay(unsigned long);
 #define ARCH_HAS_READ_CURRENT_TIMER
 extern void register_current_timer_delay(const struct delay_timer *timer);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* defined(_ARM_DELAY_H) */
 
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index d48859fdf32c5..66a06feb16c67 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_PROC_DOMAIN_H
 #define __ASM_PROC_DOMAIN_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/thread_info.h>
 #include <asm/barrier.h>
 #endif
@@ -79,7 +79,7 @@
 #define DACR_UACCESS_ENABLE	\
 	(__DACR_DEFAULT | domain_val(DOMAIN_USER, DOMAIN_CLIENT))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CPU_CP15_MMU
 static __always_inline unsigned int get_domain(void)
@@ -124,7 +124,7 @@ static __always_inline void set_domain(unsigned int val)
 #define TUSERCOND(instr, cond)	#instr #cond
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /*
  * Generate the T (user) versions of the LDR/STR and related
@@ -136,6 +136,6 @@ static __always_inline void set_domain(unsigned int val)
 #define TUSER(instr)	instr
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* !__ASM_PROC_DOMAIN_H */
diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index e29d9c7a52388..2b4469e151851 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -9,7 +9,7 @@
 #define __ASM_ARM_FPSTATE_H
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * VFP storage area has:
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 5be3ddc96a503..9675ede04f09c 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -12,7 +12,7 @@
 #define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __gnu_mcount_nc(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -33,7 +33,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 /*
@@ -79,6 +79,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self,
 			   unsigned long frame_pointer,
 			   unsigned long stack_pointer);
 
-#endif /* ifndef __ASSEMBLY__ */
+#endif /* ifndef __ASSEMBLER__ */
 
 #endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm/include/asm/hardware/cache-b15-rac.h b/arch/arm/include/asm/hardware/cache-b15-rac.h
index 3d43ec06fd359..b96365bfb2a87 100644
--- a/arch/arm/include/asm/hardware/cache-b15-rac.h
+++ b/arch/arm/include/asm/hardware/cache-b15-rac.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
 #define __ASM_ARM_HARDWARE_CACHE_B15_RAC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 void b15_flush_kern_cache_all(void);
 
diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 5a7ee70f561c9..2c9568768ad73 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -147,7 +147,7 @@
 
 #define L2X0_WAY_SIZE_SHIFT		3
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
@@ -187,6 +187,6 @@ struct l2x0_regs {
 
 extern struct l2x0_regs l2x0_saved_regs;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/asm/hardware/dec21285.h
index 894f2a635cbbd..bf722733bbb6f 100644
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ b/arch/arm/include/asm/hardware/dec21285.h
@@ -15,7 +15,7 @@
 #define DC21285_PCI_IO			0x7c000000
 #define DC21285_PCI_MEM			0x80000000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <mach/hardware.h>
 #define DC21285_IO(x)		((volatile unsigned long *)(ARMCSR_BASE+(x)))
 #else
diff --git a/arch/arm/include/asm/hardware/ioc.h b/arch/arm/include/asm/hardware/ioc.h
index 6edd27fcd0483..bd4f66591026b 100644
--- a/arch/arm/include/asm/hardware/ioc.h
+++ b/arch/arm/include/asm/hardware/ioc.h
@@ -10,7 +10,7 @@
 #ifndef __ASMARM_HARDWARE_IOC_H
 #define __ASMARM_HARDWARE_IOC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * We use __raw_base variants here so that we give the compiler the
diff --git a/arch/arm/include/asm/hardware/iomd.h b/arch/arm/include/asm/hardware/iomd.h
index 53006ba5350f0..9b8a289f4db63 100644
--- a/arch/arm/include/asm/hardware/iomd.h
+++ b/arch/arm/include/asm/hardware/iomd.h
@@ -11,7 +11,7 @@
 #define __ASMARM_HARDWARE_IOMD_H
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * We use __raw_base variants here so that we give the compiler the
@@ -167,7 +167,7 @@
 #define VDMA_START	IOMD_VIDSTART
 #define VDMA_END	IOMD_VIDEND
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int vram_half_sam;
 #define video_set_dma(start,end,offset)				\
 do {								\
diff --git a/arch/arm/include/asm/hardware/memc.h b/arch/arm/include/asm/hardware/memc.h
index 1d4ebe0a9678f..8b1865cb564ec 100644
--- a/arch/arm/include/asm/hardware/memc.h
+++ b/arch/arm/include/asm/hardware/memc.h
@@ -10,7 +10,7 @@
 #define VDMA_START	1
 #define VDMA_END	2
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void memc_write(unsigned int reg, unsigned long val);
 
 #define video_set_dma(start,end,offset)				\
diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index e31d9f1b8549b..d5b5ebaad011b 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/hwcap.h>
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 26c1d2ced4ce1..7c8f826071162 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -22,7 +22,7 @@
 #define NO_IRQ	((unsigned int)(-1))
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct irqaction;
 struct pt_regs;
 
diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index a35aba7f548cc..11024b7f1ef4a 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_ARM_JUMP_LABEL_H
 #define _ASM_ARM_JUMP_LABEL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/unified.h>
@@ -49,5 +49,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif
diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index a8287e7ab9d41..8488f4b611402 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -16,7 +16,7 @@
 #define KEXEC_ARM_ATAGS_OFFSET  0x1000
 #define KEXEC_ARM_ZIMAGE_OFFSET 0x8000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ARCH_HAS_KIMAGE_ARCH
 struct kimage_arch {
@@ -78,6 +78,6 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 }
 #define boot_pfn_to_page boot_pfn_to_page
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ARM_KEXEC_H */
diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 8de1100d10674..1b7c65935976f 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -39,7 +39,7 @@
 #define KGDB_COMPILED_BREAK	0xe7ffdeff
 #define CACHE_FLUSH_IS_SAFE	1
 
-#ifndef	__ASSEMBLY__
+#ifndef	__ASSEMBLER__
 
 static inline void arch_kgdb_breakpoint(void)
 {
@@ -49,7 +49,7 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * From Kevin Hilman:
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2b18a258204d7..ce0137aee0845 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -7,7 +7,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/reboot.h>
 
 struct tag;
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 755c97de348c3..743f68f89337e 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -24,7 +24,7 @@
 #define MAX_NR_CLUSTERS		2
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/cacheflush.h>
@@ -307,7 +307,7 @@ struct sync_struct {
 #include <asm/asm-offsets.h>
 #define __CACHE_WRITEBACK_GRANULE CACHE_WRITEBACK_GRANULE
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 /* Definitions for mcpm_sync_struct */
 #define CPU_DOWN		0x11
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 7c2fa7dcec6d4..308418f236e42 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -98,7 +98,7 @@
 
 #else /* CONFIG_MMU */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long setup_vectors_base(void);
 extern unsigned long vectors_base;
 #define VECTORS_BASE		vectors_base
@@ -155,7 +155,7 @@ extern unsigned long vectors_base;
  */
 #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Physical start and end address of the kernel sections. These addresses are
diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 5e088c83d3d8e..6058788a85730 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -91,7 +91,7 @@
 #define PMSAv7_DATA_SIDE	0
 #define PMSAv7_INSTR_SIDE	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mpu_rgn {
 	/* Assume same attributes for d/i-side  */
@@ -128,6 +128,6 @@ static inline void pmsav7_setup(void) {};
 static inline void pmsav8_setup(void) {};
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 38e3eabff5c3f..c2e3ed5157cf3 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -6,7 +6,7 @@
 #ifndef __ASM_ARM_OPCODES_H
 #define __ASM_ARM_OPCODES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/linkage.h>
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #endif
@@ -71,7 +71,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  * involving inline assembler.  For .S files, the normal __opcode_*() macros
  * should do the right thing.
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define ___opcode_swab32(x) ___asm_opcode_swab32(x)
 #define ___opcode_swab16(x) ___asm_opcode_swab16(x)
@@ -80,7 +80,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___opcode_identity32(x) ___asm_opcode_identity32(x)
 #define ___opcode_identity16(x) ___asm_opcode_identity16(x)
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 
 #include <linux/types.h>
 #include <linux/swab.h>
@@ -92,7 +92,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___opcode_identity32(x) ((u32)(x))
 #define ___opcode_identity16(x) ((u16)(x))
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
@@ -111,7 +111,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
 #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
 #ifdef CONFIG_CPU_ENDIAN_BE32
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
  * work in all cases, due to alignment constraints.  For now, a correct
@@ -219,7 +219,7 @@ extern __u32 __opcode_to_mem_thumb32(__u32);
 #endif
 
 /* Helpers for the helpers.  Don't use these directly. */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define ___inst_arm(x) .long x
 #define ___inst_thumb16(x) .short x
 #define ___inst_thumb32(first, second) .short first, second
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index ef11b721230e2..79bdff0c34ab1 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -9,7 +9,7 @@
 
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef CONFIG_MMU
 
@@ -180,7 +180,7 @@ extern int pfn_valid(unsigned long);
 #define pfn_valid pfn_valid
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #include <asm/memory.h>
 
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 6b5392e20f411..5edc1f3bdb090 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -175,7 +175,7 @@
 #define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
 #define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * The "pud_xxx()" functions here are trivial when the pmd is folded into
@@ -242,6 +242,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
  */
 #define pmd_hugewillfault(pmd)	(0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 7b71a3d414b72..5b17ebef203ea 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -109,7 +109,7 @@
  */
 #define L_PGD_SWAPPER		(_AT(pgdval_t, 1) << 55)	/* swapper_pg_dir entry */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
@@ -245,6 +245,6 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	flush_pmd_entry(pmdp);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PGTABLE_3LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 61480d096054d..a8bca82198381 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -8,7 +8,7 @@
 #ifndef _ASMARM_PGTABLE_NOMMU_H
 #define _ASMARM_PGTABLE_NOMMU_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/slab.h>
 #include <asm/processor.h>
@@ -84,6 +84,6 @@ extern unsigned int kobjsize(const void *objp);
 #define v6_user_fns	(0)
 #define xscale_mc_user_fns (0)
 
-#endif /*__ASSEMBLY__*/
+#endif /*__ASSEMBLER__*/
 
 #endif /* _ASMARM_PGTABLE_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 86378eec77573..2e9dac29f3d66 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -10,7 +10,7 @@
 #include <linux/const.h>
 #include <asm/proc-fns.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
@@ -52,7 +52,7 @@ extern struct page *empty_zero_page;
 
 #define LIBRARY_TEXT_START	0x0c000000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __pte_error(const char *file, int line, pte_t);
 extern void __pmd_error(const char *file, int line, pmd_t);
 extern void __pgd_error(const char *file, int line, pgd_t);
@@ -135,7 +135,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED | L_PTE_XN)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The table below defines the page protection levels that we insert into our
@@ -146,7 +146,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  *  3) write implies read permissions
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
@@ -329,7 +329,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* CONFIG_MMU */
 
diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
index ebbd9ec95d21c..0d5067e7f51a9 100644
--- a/arch/arm/include/asm/probes.h
+++ b/arch/arm/include/asm/probes.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_PROBES_H
 #define _ASM_PROBES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef u32 probes_opcode_t;
 
@@ -37,7 +37,7 @@ struct arch_probes_insn {
 	bool				kprobe_direct_exec;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * We assume one instruction can consume at most 64 bytes stack, which is
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index b4986a23d8528..fd72f5fac6602 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -13,7 +13,7 @@
 #include <asm/glue-proc.h>
 #include <asm/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mm_struct;
 
@@ -196,6 +196,6 @@ static inline void cpu_set_ttbcr(unsigned int ttbcr)
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_PROCFNS_H */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 6eb311fb2da06..de3378a8845ec 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -9,7 +9,7 @@
 
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bitfield.h>
 #include <linux/types.h>
 
@@ -198,5 +198,5 @@ static inline unsigned long it_advance(unsigned long cpsr)
 int syscall_trace_enter(struct pt_regs *regs);
 void syscall_trace_exit(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
index ef7fdb588b5fe..3a872ec5d4e2e 100644
--- a/arch/arm/include/asm/system_info.h
+++ b/arch/arm/include/asm/system_info.h
@@ -14,7 +14,7 @@
 #define CPU_ARCH_ARMv7		9
 #define CPU_ARCH_ARMv7M		10
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* information about the system we're running on */
 extern unsigned int system_rev;
@@ -25,6 +25,6 @@ extern unsigned int mem_fclk_21285;
 
 extern int __pure cpu_architecture(void);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_ARM_SYSTEM_INFO_H */
diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 98b37340376bc..8f9f7e833c013 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_ARM_SYSTEM_MISC_H
 #define __ASM_ARM_SYSTEM_MISC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
@@ -37,6 +37,6 @@ static inline void harden_branch_predictor(void)
 
 extern unsigned int user_debug;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_ARM_SYSTEM_MISC_H */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d29..186fd662b1c62 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -33,7 +33,7 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct task_struct;
 
diff --git a/arch/arm/include/asm/thread_notify.h b/arch/arm/include/asm/thread_notify.h
index 1c1542e2ed634..eac8fc4837651 100644
--- a/arch/arm/include/asm/thread_notify.h
+++ b/arch/arm/include/asm/thread_notify.h
@@ -9,7 +9,7 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/notifier.h>
 #include <asm/thread_info.h>
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 38c6e4a2a0b60..3eb0b3fa6cc9c 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -7,7 +7,7 @@
 #ifndef _ASMARM_TLBFLUSH_H
 #define _ASMARM_TLBFLUSH_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # include <linux/mm_types.h>
 #endif
 
@@ -200,7 +200,7 @@
 #error Unknown TLB model
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/sched.h>
 
@@ -641,7 +641,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline void local_flush_tlb_all(void)									{ }
 static inline void local_flush_tlb_mm(struct mm_struct *mm)							{ }
 static inline void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)			{ }
@@ -657,11 +657,11 @@ extern void flush_tlb_kernel_page(unsigned long kaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_bp_all(void);
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARM_ERRATA_798181
 extern void erratum_a15_798181_init(void);
 #else
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 3dcd0f71a0dae..9b09775e20931 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 #include <asm/thread_info.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/asm-offsets.h>
 	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
 	.endm
@@ -68,7 +68,7 @@ ALT_UP_B(.L0_\@)
 #define switch_tls	switch_tls_software
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void set_tls(unsigned long val)
 {
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index ce9689118dbb9..2cdeafb6afb63 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_UNIFIED_H
 #define __ASM_UNIFIED_H
 
-#if defined(__ASSEMBLY__)
+#if defined(__ASSEMBLER__)
 	.syntax unified
 #else
 __asm__(".syntax unified");
@@ -29,7 +29,7 @@ __asm__(".syntax unified");
 
 #define ARM(x...)
 #define THUMB(x...)	x
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define W(instr)	instr.w
 #else
 #define WASM(instr)	#instr ".w"
@@ -42,7 +42,7 @@ __asm__(".syntax unified");
 
 #define ARM(x...)	x
 #define THUMB(x...)
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define W(instr)	instr
 #else
 #define WASM(instr)	#instr
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index d60b09a5acfc3..071c89b1b4099 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_UNWIND_H
 #define __ASM_UNWIND_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Unwind reason code according the the ARM EABI documents */
 enum unwind_reason_code {
@@ -44,7 +44,7 @@ void __aeabi_unwind_cpp_pr0(void);
 void __aeabi_unwind_cpp_pr1(void);
 void __aeabi_unwind_cpp_pr2(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_ARM_UNWIND
 #define UNWIND(code...)		code
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 4512f7e1918f0..b334f8009a505 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -89,10 +89,10 @@
 #define	V7M_SCB_DCCISW		0x274	/* D-cache clean and invalidate by set-way */
 #define	V7M_SCB_BPIALL		0x278	/* D-cache clean and invalidate by set-way */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum reboot_mode;
 
 void armv7m_restart(enum reboot_mode mode, const char *cmd);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 88364a6727ffc..93a7338cd3057 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -6,7 +6,7 @@
 
 #define __VDSO_PAGES	4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mm_struct;
 
@@ -26,7 +26,7 @@ static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 #endif /* CONFIG_VDSO */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/arm/include/asm/vdso/cp15.h b/arch/arm/include/asm/vdso/cp15.h
index bed16fa1865e9..f5dea30743765 100644
--- a/arch/arm/include/asm/vdso/cp15.h
+++ b/arch/arm/include/asm/vdso/cp15.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_CP15_H
 #define __ASM_VDSO_CP15_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CPU_CP15
 
@@ -33,6 +33,6 @@
 
 #endif /* CONFIG_CPU_CP15 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_CP15_H */
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 1e9f81639c88c..7e70c0998f1db 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/barrier.h>
 #include <asm/errno.h>
@@ -135,6 +135,6 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode,
 #endif
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso/processor.h b/arch/arm/include/asm/vdso/processor.h
index 45efb3ff511c9..b24304f248b71 100644
--- a/arch/arm/include/asm/vdso/processor.h
+++ b/arch/arm/include/asm/vdso/processor.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_PROCESSOR_H
 #define __ASM_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
 #define cpu_relax()						\
@@ -17,6 +17,6 @@
 #define cpu_relax()			barrier()
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index ff1c729af05f0..f6ef582cb3d8a 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
@@ -17,6 +17,6 @@ void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index 85ccc422d4d0b..94171e09bda0b 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -90,7 +90,7 @@
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 void vfp_disable(void);
 #endif
 
diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index dd9697b2bde80..719a08fa6a29b 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -15,7 +15,7 @@
  */
 #define BOOT_CPU_MODE_MISMATCH	PSR_N_BIT
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_ARM_VIRT_EXT
@@ -74,7 +74,7 @@ static inline bool is_kernel_in_hyp_mode(void)
 #define HVC_SET_VECTORS 0
 #define HVC_SOFT_RESTART 1
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define HVC_STUB_ERR	0xbadca11
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 50c3a425d1400..2193e1ab98476 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -25,7 +25,7 @@
 #define AT91_PM_ULP1		0x03
 #define	AT91_PM_BACKUP		0x04
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct at91_pm_data {
 	void __iomem *pmc;
 	void __iomem *ramc[2];
diff --git a/arch/arm/mach-exynos/smc.h b/arch/arm/mach-exynos/smc.h
index 5c30feb8f07d9..5c7730f6259fc 100644
--- a/arch/arm/mach-exynos/smc.h
+++ b/arch/arm/mach-exynos/smc.h
@@ -32,11 +32,11 @@
 #define SMC_REG_CLASS_SFR_W	(0x1 << 30)
 #define SMC_REG_ID_SFR_W(addr)	(SMC_REG_CLASS_SFR_W | ((addr) >> 2))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void exynos_smc(u32 cmd, u32 arg1, u32 arg2, u32 arg3);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /* op type for SMC_CMD_SAVE and SMC_CMD_SHUTDOWN */
 #define OP_TYPE_CORE		0x0
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 985ad3a956712..5391848d8c8cc 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -79,7 +79,7 @@
 #define CPLD_UNMUTE		2
 #define CPLD_FLASH_WR_ENABLE	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern raw_spinlock_t nw_gpio_lock;
 extern void nw_gpio_modify_op(unsigned int mask, unsigned int set);
 extern void nw_gpio_modify_io(unsigned int mask, unsigned int in);
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index 0760fff39a0b3..71f09648c7778 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARCH_MXC_HARDWARE_H__
 #define __ASM_ARCH_MXC_HARDWARE_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/io.h>
 #include <soc/imx/revision.h>
 #endif
diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
index fe2d0f5abfcc2..1d13e3959159e 100644
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -16,7 +16,7 @@
 
 #define IMX_DDR_TYPE_LPDDR2		1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_SOC_IMX6SL
 static inline bool cpu_is_imx6sl(void)
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 7e7440533bf90..e4f4b16958084 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -18,7 +18,7 @@
 
 #include "am33xx.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define OMAP242X_CTRL_REGADDR(reg)					\
 		OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
@@ -36,7 +36,7 @@
 		OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
 #define AM33XX_CTRL_REGADDR(reg)					\
 		AM33XX_L4_WK_IO_ADDRESS(AM33XX_SCM_BASE + (reg))
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
@@ -503,7 +503,7 @@
 #define		FEAT_NEON_NONE		1
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARCH_OMAP2PLUS
 extern u8 omap_ctrl_readb(u16 offset);
 extern u16 omap_ctrl_readw(u16 offset);
@@ -534,7 +534,7 @@ int omap_control_init(void);
 #define omap_ctrl_writel(x, y)		WARN_ON(1)
 #define omap4_ctrl_pad_writel(x, y)	WARN_ON(1)
 #endif
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif /* __ARCH_ARM_MACH_OMAP2_CONTROL_H */
 
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 9e3dbb743e5c4..b3949559edadf 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -19,7 +19,7 @@
 #include "am33xx.h"
 #include "omap54xx.h"
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/bitops.h>
 #include <linux/of.h>
@@ -501,4 +501,4 @@ level(__##fn);
 #define cpu_is_ti816x()		soc_is_ti816x()
 #define cpu_is_ti81xx()		soc_is_ti81xx()
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 030cabc39821d..a1d72e014e62b 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -3,7 +3,7 @@
  * Interface for functions that need to be run in internal SRAM
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern void omap2_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 				u32 base_cs, u32 force_unlock);
@@ -48,7 +48,7 @@ extern void omap_push_sram_idle(void);
 static inline void omap_push_sram_idle(void) {}
 #endif /* CONFIG_PM */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * OMAP2+: define the SRAM PA addresses.
diff --git a/arch/arm/mach-pxa/irqs.h b/arch/arm/mach-pxa/irqs.h
index 22bf536a462d0..07d7aa3a65065 100644
--- a/arch/arm/mach-pxa/irqs.h
+++ b/arch/arm/mach-pxa/irqs.h
@@ -94,7 +94,7 @@
 
 #define PXA_NR_IRQS		(IRQ_BOARD_START)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct irq_data;
 struct pt_regs;
 
diff --git a/arch/arm/mach-pxa/pxa-regs.h b/arch/arm/mach-pxa/pxa-regs.h
index ba5120c06b8a5..b56c8899042c4 100644
--- a/arch/arm/mach-pxa/pxa-regs.h
+++ b/arch/arm/mach-pxa/pxa-regs.h
@@ -31,7 +31,7 @@
 #define io_v2p(x) (0x3c000000 + ((x) & 0x01ffffff) + (((x) & 0x0e000000) << 1))
 #define io_p2v(x) IOMEM(0xf2000000 + ((x) & 0x01ffffff) + (((x) & 0x1c000000) >> 1))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # define __REG(x)	(*((volatile u32 __iomem *)io_p2v(x)))
 
 /* With indexed regs we don't want to feed the index through io_p2v()
diff --git a/arch/arm/mach-s3c/map-base.h b/arch/arm/mach-s3c/map-base.h
index 463a995b399bc..beb58e6f12e16 100644
--- a/arch/arm/mach-s3c/map-base.h
+++ b/arch/arm/mach-s3c/map-base.h
@@ -20,7 +20,7 @@
 
 #define S3C_ADDR_BASE	0xF6000000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define S3C_ADDR(x)	((void __iomem __force *)S3C_ADDR_BASE + (x))
 #else
 #define S3C_ADDR(x)	(S3C_ADDR_BASE + (x))
diff --git a/arch/arm/mach-sa1100/include/mach/bitfield.h b/arch/arm/mach-sa1100/include/mach/bitfield.h
index f1f0e3387d9c6..e786bf730b31c 100644
--- a/arch/arm/mach-sa1100/include/mach/bitfield.h
+++ b/arch/arm/mach-sa1100/include/mach/bitfield.h
@@ -15,7 +15,7 @@
 #ifndef __BITFIELD_H
 #define __BITFIELD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define UData(Data)	((unsigned long) (Data))
 #else
 #define UData(Data)	(Data)
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index 6f2dbdc286632..350e2665ca495 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -39,7 +39,7 @@
 
 #define __MREG(x)	IOMEM(io_p2v(x))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 # define __REG(x)	(*((volatile unsigned long __iomem *)io_p2v(x)))
 # define __PREG(x)	(io_v2p((unsigned long)&(x)))
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 51265592cb1ae..92a89713d5e57 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -21,7 +21,7 @@
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include "irammap.h"
 
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 4718a3cb45a16..e332d261c1dbd 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -38,7 +38,7 @@
 #define TEGRA_FLUSH_CACHE_LOUIS	0
 #define TEGRA_FLUSH_CACHE_ALL	1
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 /* waits until the microsecond counter (base) is > rn */
 .macro wait_until, rn, base, tmp
 	add	\rn, \rn, #1
diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb8710..6ad8f055ba6b5 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -29,7 +29,7 @@ END	{
 	  printf(" */\n\n");
 	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
 	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
-	  printf("#ifndef __ASSEMBLY__\n");
+	  printf("#ifndef __ASSEMBLER__\n");
 	  printf("/* The type of machine we're running on */\n");
 	  printf("extern unsigned int __machine_arch_type;\n");
 	  printf("#endif\n\n");
diff --git a/drivers/memory/emif.h b/drivers/memory/emif.h
index 55aeb36a5bf24..5dfb09adb0960 100644
--- a/drivers/memory/emif.h
+++ b/drivers/memory/emif.h
@@ -558,7 +558,7 @@
 #define EMIF_SRAM_AM33_REG_LAYOUT			0x00000000
 #define EMIF_SRAM_AM43_REG_LAYOUT			0x00000001
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Structure containing shadow of important registers in EMIF
  * The calculation function fills in this structure to be later used for
@@ -603,5 +603,5 @@ void ti_emif_enter_sr(void);
 void ti_emif_exit_sr(void);
 void ti_emif_abort_sr(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __EMIF_H */
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 50b47eba7d015..a95077b2fc17e 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -8,7 +8,7 @@
 #include <linux/args.h>
 #include <linux/init.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/uuid.h>
 #endif
 
@@ -353,7 +353,7 @@ s32 arm_smccc_get_soc_id_version(void);
  */
 s32 arm_smccc_get_soc_id_revision(void);
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Returns whether a specific hypervisor UUID is advertised for the
@@ -402,7 +402,7 @@ static inline u32 smccc_uuid_to_reg(const uuid_t *uuid, int reg)
 	return val;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /**
  * struct arm_smccc_res - Result from SMC/HVC call
-- 
2.51.1


