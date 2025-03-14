Return-Path: <linux-arch+bounces-10777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEFA609AA
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C581886A6A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411D71E991A;
	Fri, 14 Mar 2025 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUZpGaKt"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F91DFD83
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936316; cv=none; b=rs6MU4jyYQh0/C+bWFmhg6BJiYCEYJJDxScvE+Bks/mh/9g7c1zfaXwQBEx3MAKetiXiKQWFqJwHEiWKgZiJdi5vI6iNbml3i8+N118Zh+noPFHmuIsQ7R1/oG9wsI1VbcQpXVByUabEeKN5KaOhBuUaKb1W/7miwWaqakxgI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936316; c=relaxed/simple;
	bh=9QO8YJRzb4z57ewPqDrvK91uo5N2cIwLiBlSsi0IkFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muWctNVb+iI7qMX1aFQpDgmsQTpnIpJGbn6o93EpTe6APVANsytjs+8X2BhG0Md9pbAyCFFbQe42JY5Cw2E8aWcpYn6usWgzAJsq2IPkbVOKkwDpiSlPq9832TaQYosnanGSnh9wvp2hGJ9UfBvpYJN4zMxIudmdn9y37sCV4mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AUZpGaKt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TKd2R4tRrFo/X98mecfthcE98rskMCqLmYXr51Wf5A=;
	b=AUZpGaKt0YrN1XWeBrxsjSvzwQLK6CLP+pUoSHX9F9t4Kon6mqSlWd+aDv59db6Kf3IcSo
	NG5pOeX4ipaaCo6hAON9kRANMXkpWr5p2XQmNrZxsbFTUWc+o1Q6ql102AGMEgcKd6qBcd
	p+ylwvsi+80ek+03yXZvra6/MjvILE8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-gWOA_4PGPCC31sdbrlxe3w-1; Fri,
 14 Mar 2025 03:11:49 -0400
X-MC-Unique: gWOA_4PGPCC31sdbrlxe3w-1
X-Mimecast-MFC-AGG-ID: gWOA_4PGPCC31sdbrlxe3w_1741936308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E4D219560AB;
	Fri, 14 Mar 2025 07:11:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 394E418001DE;
	Fri, 14 Mar 2025 07:11:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Subject: [PATCH 19/41] mips: Replace __ASSEMBLY__ with __ASSEMBLER__ in the mips headers
Date: Fri, 14 Mar 2025 08:09:50 +0100
Message-ID: <20250314071013.1575167-20-thuth@redhat.com>
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

This is almost a completely mechanical patch (done with a simple
"sed -i" statement), with just one comment tweaked manually in
arch/mips/include/asm/cpu.h (that was missing some underscores).

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/mips/include/asm/addrspace.h            |  4 +--
 arch/mips/include/asm/asm-eva.h              |  6 ++--
 arch/mips/include/asm/asm.h                  |  8 ++---
 arch/mips/include/asm/bmips.h                |  4 +--
 arch/mips/include/asm/cpu.h                  |  4 +--
 arch/mips/include/asm/dec/ecc.h              |  2 +-
 arch/mips/include/asm/dec/interrupts.h       |  4 +--
 arch/mips/include/asm/dec/kn01.h             |  2 +-
 arch/mips/include/asm/dec/kn02.h             |  2 +-
 arch/mips/include/asm/dec/kn02xa.h           |  2 +-
 arch/mips/include/asm/eva.h                  |  4 +--
 arch/mips/include/asm/ftrace.h               |  4 +--
 arch/mips/include/asm/hazards.h              |  4 +--
 arch/mips/include/asm/irqflags.h             |  4 +--
 arch/mips/include/asm/jazz.h                 | 16 ++++-----
 arch/mips/include/asm/jump_label.h           |  4 +--
 arch/mips/include/asm/linkage.h              |  2 +-
 arch/mips/include/asm/mach-generic/spaces.h  |  4 +--
 arch/mips/include/asm/mips-boards/bonito64.h |  4 +--
 arch/mips/include/asm/mipsmtregs.h           |  6 ++--
 arch/mips/include/asm/mipsregs.h             |  6 ++--
 arch/mips/include/asm/msa.h                  |  4 +--
 arch/mips/include/asm/pci/bridge.h           |  4 +--
 arch/mips/include/asm/pm.h                   |  6 ++--
 arch/mips/include/asm/prefetch.h             |  2 +-
 arch/mips/include/asm/regdef.h               |  4 +--
 arch/mips/include/asm/sibyte/board.h         |  4 +--
 arch/mips/include/asm/sibyte/sb1250.h        |  2 +-
 arch/mips/include/asm/sibyte/sb1250_defs.h   |  6 ++--
 arch/mips/include/asm/smp-cps.h              |  6 ++--
 arch/mips/include/asm/sn/addrs.h             | 18 +++++-----
 arch/mips/include/asm/sn/gda.h               |  4 +--
 arch/mips/include/asm/sn/kldir.h             |  4 +--
 arch/mips/include/asm/sn/klkernvars.h        |  4 +--
 arch/mips/include/asm/sn/launch.h            |  4 +--
 arch/mips/include/asm/sn/nmi.h               |  8 ++---
 arch/mips/include/asm/sn/sn0/addrs.h         | 14 ++++----
 arch/mips/include/asm/sn/sn0/hub.h           |  2 +-
 arch/mips/include/asm/sn/sn0/hubio.h         | 36 ++++++++++----------
 arch/mips/include/asm/sn/sn0/hubmd.h         |  4 +--
 arch/mips/include/asm/sn/sn0/hubni.h         |  6 ++--
 arch/mips/include/asm/sn/sn0/hubpi.h         |  4 +--
 arch/mips/include/asm/sn/types.h             |  2 +-
 arch/mips/include/asm/sync.h                 |  2 +-
 arch/mips/include/asm/thread_info.h          |  4 +--
 arch/mips/include/asm/unistd.h               |  4 +--
 arch/mips/include/asm/vdso/gettimeofday.h    |  4 +--
 arch/mips/include/asm/vdso/processor.h       |  4 +--
 arch/mips/include/asm/vdso/vdso.h            |  4 +--
 arch/mips/include/asm/vdso/vsyscall.h        |  4 +--
 arch/mips/include/asm/xtalk/xtalk.h          |  4 +--
 arch/mips/include/asm/xtalk/xwidget.h        |  4 +--
 drivers/soc/bcm/brcmstb/pm/pm.h              |  2 +-
 53 files changed, 140 insertions(+), 140 deletions(-)

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 7e9ef01cb182b..e2354e9b0ee28 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -15,7 +15,7 @@
 /*
  *  Configure language
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _ATYPE_
 #define _ATYPE32_
 #define _ATYPE64_
@@ -34,7 +34,7 @@
 /*
  *  32-bit MIPS address spaces
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _ACAST32_
 #define _ACAST64_
 #else
diff --git a/arch/mips/include/asm/asm-eva.h b/arch/mips/include/asm/asm-eva.h
index e327ebc767539..220431d00ee9b 100644
--- a/arch/mips/include/asm/asm-eva.h
+++ b/arch/mips/include/asm/asm-eva.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_ASM_EVA_H
 #define __ASM_ASM_EVA_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Kernel variants */
 
@@ -99,7 +99,7 @@
 
 #endif /* CONFIG_EVA */
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define kernel_cache(op, base)		cache op, base
 #define kernel_pref(hint, base)		pref hint, base
@@ -185,6 +185,6 @@
 
 #endif /* CONFIG_EVA */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_ASM_EVA_H */
diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index 87ff609b53fe1..0ed19ffed0769 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -37,7 +37,7 @@
 #define CFI_SECTIONS
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 /*
  * LEAF - declare leaf routine
  */
@@ -123,7 +123,7 @@ symbol		=	value
 #define ASM_PRINT(string)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Stack alignment
@@ -228,7 +228,7 @@ symbol		=	value
 #define LONG_INS	ins
 #define LONG_EXT	ext
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define LONG		.word
 #endif
 #define LONGSIZE	4
@@ -257,7 +257,7 @@ symbol		=	value
 #define LONG_INS	dins
 #define LONG_EXT	dext
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define LONG		.dword
 #endif
 #define LONGSIZE	8
diff --git a/arch/mips/include/asm/bmips.h b/arch/mips/include/asm/bmips.h
index 3a1cdfddb987e..0eee81be9e2b5 100644
--- a/arch/mips/include/asm/bmips.h
+++ b/arch/mips/include/asm/bmips.h
@@ -42,7 +42,7 @@
 
 #define ZSCM_REG_BASE			0x97000000
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 #include <linux/cpumask.h>
 #include <asm/r4kcache.h>
@@ -124,6 +124,6 @@ static inline void bmips_write_zscm_reg(unsigned int offset, unsigned long data)
 	barrier();
 }
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 
 #endif /* _ASM_BMIPS_H */
diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
index ecb9854cb4324..32cf5496006e4 100644
--- a/arch/mips/include/asm/cpu.h
+++ b/arch/mips/include/asm/cpu.h
@@ -288,7 +288,7 @@
 
 #define FPIR_IMP_NONE		0x0000
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 enum cpu_type_enum {
 	CPU_UNKNOWN,
@@ -329,7 +329,7 @@ enum cpu_type_enum {
 	CPU_LAST
 };
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * ISA Level encodings
diff --git a/arch/mips/include/asm/dec/ecc.h b/arch/mips/include/asm/dec/ecc.h
index c3a3f71f1a544..dbc39643c31c5 100644
--- a/arch/mips/include/asm/dec/ecc.h
+++ b/arch/mips/include/asm/dec/ecc.h
@@ -37,7 +37,7 @@
 #define KN0X_ESR_SYNLO		(0x7f<<0)	/* syndrome from ECC logic */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/interrupt.h>
 
diff --git a/arch/mips/include/asm/dec/interrupts.h b/arch/mips/include/asm/dec/interrupts.h
index e10d341067c82..c1cd36c04b6c8 100644
--- a/arch/mips/include/asm/dec/interrupts.h
+++ b/arch/mips/include/asm/dec/interrupts.h
@@ -95,7 +95,7 @@
 #define DEC_CPU_IRQ_ALL		(0xff << CAUSEB_IP)
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Interrupt table structures to hide differences between systems.
@@ -121,6 +121,6 @@ extern void cpu_all_int(void);
 extern void dec_intr_unimplemented(void);
 extern void asic_intr_unimplemented(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/mips/include/asm/dec/kn01.h b/arch/mips/include/asm/dec/kn01.h
index 88d9ffd742588..6c074b93a7dbf 100644
--- a/arch/mips/include/asm/dec/kn01.h
+++ b/arch/mips/include/asm/dec/kn01.h
@@ -71,7 +71,7 @@
 #define KN01_CSR_LEDS		(0xff<<0) /* ~diagnostic LEDs (w/o) */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
diff --git a/arch/mips/include/asm/dec/kn02.h b/arch/mips/include/asm/dec/kn02.h
index 93430b5f47241..9fea17020079d 100644
--- a/arch/mips/include/asm/dec/kn02.h
+++ b/arch/mips/include/asm/dec/kn02.h
@@ -80,7 +80,7 @@
 #define KN02_IRQ_ALL		0xff
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
diff --git a/arch/mips/include/asm/dec/kn02xa.h b/arch/mips/include/asm/dec/kn02xa.h
index b56b4577f6eff..3580d78b906fb 100644
--- a/arch/mips/include/asm/dec/kn02xa.h
+++ b/arch/mips/include/asm/dec/kn02xa.h
@@ -70,7 +70,7 @@
 #define KN02XA_EAR_RES_0	(0x3<<0)	/* unused */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/interrupt.h>
 
diff --git a/arch/mips/include/asm/eva.h b/arch/mips/include/asm/eva.h
index a3d1807f227c2..c7b39f38634b8 100644
--- a/arch/mips/include/asm/eva.h
+++ b/arch/mips/include/asm/eva.h
@@ -13,7 +13,7 @@
 
 #include <kernel-entry-init.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef CONFIG_EVA
 
@@ -38,6 +38,6 @@ platform_eva_init
 
 #endif /* CONFIG_EVA */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index dc025888f6d28..55d32cdeba4f3 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -15,7 +15,7 @@
 #define MCOUNT_ADDR ((unsigned long)(_mcount))
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void _mcount(void);
 #define mcount _mcount
 
@@ -89,6 +89,6 @@ struct dyn_arch_ftrace {
 void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 			   unsigned long fp);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/include/asm/hazards.h b/arch/mips/include/asm/hazards.h
index cb16be93b048e..a084b3b3bc810 100644
--- a/arch/mips/include/asm/hazards.h
+++ b/arch/mips/include/asm/hazards.h
@@ -301,7 +301,7 @@ do {									\
 
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define _ssnop ___ssnop
 #define	_ehb ___ehb
@@ -417,6 +417,6 @@ do {									\
  */
 extern void mips_ihb(void);
 
-#endif /* __ASSEMBLY__  */
+#endif /* __ASSEMBLER__  */
 
 #endif /* _ASM_HAZARDS_H */
diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index f5b8300f45735..70e5b05fd88bd 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_IRQFLAGS_H
 #define _ASM_IRQFLAGS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/stringify.h>
@@ -142,7 +142,7 @@ static inline int arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
-#endif /* #ifndef __ASSEMBLY__ */
+#endif /* #ifndef __ASSEMBLER__ */
 
 /*
  * Do the CPU's IRQ-state tracing from assembly code.
diff --git a/arch/mips/include/asm/jazz.h b/arch/mips/include/asm/jazz.h
index a61970d01a81c..9356e87dd64be 100644
--- a/arch/mips/include/asm/jazz.h
+++ b/arch/mips/include/asm/jazz.h
@@ -70,7 +70,7 @@
 #define LED_E			0x9e
 #define LED_F			0x8e
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static __inline__ void pica_set_led(unsigned int bits)
 {
@@ -79,7 +79,7 @@ static __inline__ void pica_set_led(unsigned int bits)
 	*led_register = bits;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Base address of the Sonic Ethernet adapter in Jazz machines.
@@ -100,7 +100,7 @@ static __inline__ void pica_set_led(unsigned int bits)
 #define JAZZ_KEYBOARD_DATA	0xe0005000
 #define JAZZ_KEYBOARD_COMMAND	0xe0005001
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef struct {
 	unsigned char data;
@@ -121,7 +121,7 @@ typedef struct {
  */
 #define keyboard_hardware	jazz_keyboard_hardware
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * i8042 keyboard controller for most other Mips machines.
@@ -154,7 +154,7 @@ typedef struct {
 /*
  * DRAM configuration register
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef __MIPSEL__
 typedef struct {
 	unsigned int bank2 : 3;
@@ -174,7 +174,7 @@ typedef struct {
 	unsigned int bank2 : 3;
 } dram_configuration;
 #endif
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define PICA_DRAM_CONFIG	0xe00fffe0
 
@@ -260,7 +260,7 @@ typedef struct {
 /*
  * Access the R4030 DMA and I/O Controller
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void r4030_delay(void)
 {
@@ -299,7 +299,7 @@ static inline void r4030_write_reg32(unsigned long addr, unsigned val)
 	r4030_delay();
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define JAZZ_FDC_BASE	0xe0003000
 #define JAZZ_RTC_BASE	0xe0004000
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index ff5d388502d4a..c1508f88e03ea 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -10,7 +10,7 @@
 
 #define arch_jump_label_transform_static arch_jump_label_transform
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/isa-rev.h>
@@ -76,5 +76,5 @@ struct jump_entry {
 	jump_label_t key;
 };
 
-#endif  /* __ASSEMBLY__ */
+#endif  /* __ASSEMBLER__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
diff --git a/arch/mips/include/asm/linkage.h b/arch/mips/include/asm/linkage.h
index 1829c2b6da6cd..fd44ba754f1a6 100644
--- a/arch/mips/include/asm/linkage.h
+++ b/arch/mips/include/asm/linkage.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/asm.h>
 #endif
 
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index f8783d339fb0d..6332b6cbf7eef 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -21,13 +21,13 @@
 /*
  * This gives the physical RAM offset.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # if defined(CONFIG_MIPS_AUTO_PFN_OFFSET)
 #  define PHYS_OFFSET		((unsigned long)PFN_PHYS(ARCH_PFN_OFFSET))
 # elif !defined(PHYS_OFFSET)
 #  define PHYS_OFFSET		_AC(0, UL)
 # endif
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #ifdef CONFIG_32BIT
 #define CAC_BASE		_AC(0x80000000, UL)
diff --git a/arch/mips/include/asm/mips-boards/bonito64.h b/arch/mips/include/asm/mips-boards/bonito64.h
index 31a31fe78d775..74c5fc0fc6c04 100644
--- a/arch/mips/include/asm/mips-boards/bonito64.h
+++ b/arch/mips/include/asm/mips-boards/bonito64.h
@@ -21,7 +21,7 @@
 #ifndef _ASM_MIPS_BOARDS_BONITO64_H
 #define _ASM_MIPS_BOARDS_BONITO64_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /* offsets from base register */
 #define BONITO(x)	(x)
@@ -36,7 +36,7 @@ extern unsigned long _pcictrl_bonito_pcicfg;
 
 #define BONITO(x)		*(volatile u32 *)(_pcictrl_bonito + (x))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #define BONITO_BOOT_BASE		0x1fc00000
diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
index b1ee3c48e84ba..cab7582010e80 100644
--- a/arch/mips/include/asm/mipsmtregs.h
+++ b/arch/mips/include/asm/mipsmtregs.h
@@ -10,7 +10,7 @@
 
 #include <asm/mipsregs.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * C macros
@@ -176,7 +176,7 @@
 /* TCHalt */
 #define TCHALT_H		(_ULCAST_(1))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline unsigned core_nvpes(void)
 {
@@ -469,6 +469,6 @@ do {									\
 
 __BUILD_SET_C0(mvpcontrol)
 
-#endif /* Not __ASSEMBLY__ */
+#endif /* Not __ASSEMBLER__ */
 
 #endif
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index c025558754d57..f799c0d723dac 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -32,7 +32,7 @@
 /*
  *  Configure language
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _ULCAST_
 #define _U64CAST_
 #else
@@ -1346,7 +1346,7 @@
 #define FPU_CSR_RD	0x3	/* towards -Infinity */
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Macros for handling the ISA mode bit for MIPS16 and microMIPS.
@@ -3095,6 +3095,6 @@ static inline unsigned int get_ebase_cpunum(void)
 	return read_c0_ebase() & MIPS_EBASE_CPUNUM;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_MIPSREGS_H */
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index 236a49ee2e3e7..c6077f5fa4b18 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -8,7 +8,7 @@
 
 #include <asm/mipsregs.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/inst.h>
 
@@ -218,7 +218,7 @@ __BUILD_MSA_CTL_REG(request, 5)
 __BUILD_MSA_CTL_REG(map, 6)
 __BUILD_MSA_CTL_REG(unmap, 7)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define MSA_IR		0
 #define MSA_CSR		1
diff --git a/arch/mips/include/asm/pci/bridge.h b/arch/mips/include/asm/pci/bridge.h
index 9c476a0400e0c..eaeafccd82c7d 100644
--- a/arch/mips/include/asm/pci/bridge.h
+++ b/arch/mips/include/asm/pci/bridge.h
@@ -43,7 +43,7 @@
  *    Bridge address map
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ATE_V		0x01
 #define ATE_CO		0x02
@@ -288,7 +288,7 @@ struct bridge_err_cmdword {
 };
 
 #define berr_field	berr_un.berr_st
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * The values of these macros can and should be crosschecked
diff --git a/arch/mips/include/asm/pm.h b/arch/mips/include/asm/pm.h
index 7ecd4dfe38461..52f3d64c5f347 100644
--- a/arch/mips/include/asm/pm.h
+++ b/arch/mips/include/asm/pm.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_PM_H
 #define __ASM_PM_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #include <asm/asm-offsets.h>
 #include <asm/asm.h>
@@ -130,7 +130,7 @@
 	RESUME_RESTORE_REGS_RETURN
 .endm
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /**
  * struct mips_static_suspend_state - Core saved CPU state across S2R.
@@ -150,6 +150,6 @@ struct mips_static_suspend_state {
 	unsigned long sp;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_PM_HELPERS_H */
diff --git a/arch/mips/include/asm/prefetch.h b/arch/mips/include/asm/prefetch.h
index a56594f360ee2..4bd359fa3d977 100644
--- a/arch/mips/include/asm/prefetch.h
+++ b/arch/mips/include/asm/prefetch.h
@@ -42,7 +42,7 @@
 #define Pref_WriteBackInvalidate	25
 #define Pref_PrepareForStore		30
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 	.macro	__pref hint addr
 #ifdef CONFIG_CPU_HAS_PREFETCH
diff --git a/arch/mips/include/asm/regdef.h b/arch/mips/include/asm/regdef.h
index 236051364f78e..dd0b558c97672 100644
--- a/arch/mips/include/asm/regdef.h
+++ b/arch/mips/include/asm/regdef.h
@@ -103,7 +103,7 @@
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 /*
@@ -192,6 +192,6 @@
 #define ra	$31	/* return address */
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_REGDEF_H */
diff --git a/arch/mips/include/asm/sibyte/board.h b/arch/mips/include/asm/sibyte/board.h
index 03463faa42446..d29c1c013dc5c 100644
--- a/arch/mips/include/asm/sibyte/board.h
+++ b/arch/mips/include/asm/sibyte/board.h
@@ -19,7 +19,7 @@
 #include <asm/sibyte/bigsur.h>
 #endif
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #ifdef LEDS_PHYS
 #define setleds(t0, t1, c0, c1, c2, c3) \
@@ -46,6 +46,6 @@ extern void setleds(char *str);
 #define setleds(s) do { } while (0)
 #endif /* LEDS_PHYS */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _SIBYTE_BOARD_H */
diff --git a/arch/mips/include/asm/sibyte/sb1250.h b/arch/mips/include/asm/sibyte/sb1250.h
index 495b31925ed77..de4b352256c8a 100644
--- a/arch/mips/include/asm/sibyte/sb1250.h
+++ b/arch/mips/include/asm/sibyte/sb1250.h
@@ -19,7 +19,7 @@
 
 #define SB1250_DUART_MINOR_BASE		64
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/addrspace.h>
 
diff --git a/arch/mips/include/asm/sibyte/sb1250_defs.h b/arch/mips/include/asm/sibyte/sb1250_defs.h
index 68cd7c0b37eae..98cbb65cce0ac 100644
--- a/arch/mips/include/asm/sibyte/sb1250_defs.h
+++ b/arch/mips/include/asm/sibyte/sb1250_defs.h
@@ -199,7 +199,7 @@
  * Note: you'll need to define uint32_t and uint64_t in your headers.
  */
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 #define _SB_MAKE64(x) ((uint64_t)(x))
 #define _SB_MAKE32(x) ((uint32_t)(x))
 #else
@@ -238,9 +238,9 @@
  */
 
 
-#if defined(__mips64) && !defined(__ASSEMBLY__)
+#if defined(__mips64) && !defined(__ASSEMBLER__)
 #define SBWRITECSR(csr, val) *((volatile uint64_t *) PHYS_TO_K1(csr)) = (val)
 #define SBREADCSR(csr) (*((volatile uint64_t *) PHYS_TO_K1(csr)))
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/mips/include/asm/smp-cps.h b/arch/mips/include/asm/smp-cps.h
index ab94e50f62b87..d80a629a71f95 100644
--- a/arch/mips/include/asm/smp-cps.h
+++ b/arch/mips/include/asm/smp-cps.h
@@ -9,7 +9,7 @@
 
 #define CPS_ENTRY_PATCH_INSNS	6
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct vpe_boot_config {
 	unsigned long pc;
@@ -49,9 +49,9 @@ static inline bool mips_cps_smp_in_use(void) { return false; }
 
 #endif /* !CONFIG_MIPS_CPS */
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 .extern mips_cps_bootcfg;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __MIPS_ASM_SMP_CPS_H__ */
diff --git a/arch/mips/include/asm/sn/addrs.h b/arch/mips/include/asm/sn/addrs.h
index 837d23e249768..7c675fecbf9a9 100644
--- a/arch/mips/include/asm/sn/addrs.h
+++ b/arch/mips/include/asm/sn/addrs.h
@@ -10,10 +10,10 @@
 #define _ASM_SN_ADDRS_H
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/smp.h>
 #include <linux/types.h>
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #include <asm/addrspace.h>
 #include <asm/sn/kldir.h>
@@ -25,15 +25,15 @@
 #endif
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define UINT64_CAST		(unsigned long)
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define UINT64_CAST
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #define NASID_GET_META(_n)	((_n) >> NASID_LOCAL_BITS)
@@ -254,7 +254,7 @@
 #define LOCAL_HUB_ADDR(_x)	(IALIAS_BASE + (_x))
 #define REMOTE_HUB_ADDR(_n, _x) ((NODE_SWIN_BASE(_n, 1) + 0x800000 + (_x)))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define LOCAL_HUB_PTR(_x)	((u64 *)LOCAL_HUB_ADDR((_x)))
 #define REMOTE_HUB_PTR(_n, _x)	((u64 *)REMOTE_HUB_ADDR((_n), (_x)))
@@ -265,7 +265,7 @@
 #define REMOTE_HUB_S(_n, _r, _d)	__raw_writeq((_d),		\
 						REMOTE_HUB_PTR((_n), (_r)))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Software structure locations -- permanently fixed
@@ -315,7 +315,7 @@
 #define KLI_KERN_XP		8
 #define KLI_KERN_PARTID		9
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define KLD_BASE(nasid)		((kldir_ent_t *) KLDIR_ADDR(nasid))
 #define KLD_LAUNCH(nasid)	(KLD_BASE(nasid) + KLI_LAUNCH)
@@ -371,7 +371,7 @@
 #define KERN_VARS_ADDR(nasid)	KLD_KERN_VARS(nasid)->pointer
 #define KERN_VARS_SIZE(nasid)	KLD_KERN_VARS(nasid)->size
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 #endif /* _ASM_SN_ADDRS_H */
diff --git a/arch/mips/include/asm/sn/gda.h b/arch/mips/include/asm/sn/gda.h
index 5b8c96d5b5870..d8fd80137206a 100644
--- a/arch/mips/include/asm/sn/gda.h
+++ b/arch/mips/include/asm/sn/gda.h
@@ -39,7 +39,7 @@
 #define G_PARTIDOFF	40
 #define G_TABLEOFF	128
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef struct gda {
 	u32	g_magic;	/* GDA magic number */
@@ -63,7 +63,7 @@ typedef struct gda {
 
 #define GDA ((gda_t*) GDA_ADDR(get_nasid()))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 /*
  * Define:	PART_GDA_VERSION
  * Purpose:	Define the minimum version of the GDA required, lower
diff --git a/arch/mips/include/asm/sn/kldir.h b/arch/mips/include/asm/sn/kldir.h
index 245f59bf38454..f394b1e0c9566 100644
--- a/arch/mips/include/asm/sn/kldir.h
+++ b/arch/mips/include/asm/sn/kldir.h
@@ -15,7 +15,7 @@
 #define KLDIR_ENT_SIZE			0x40
 #define KLDIR_MAX_ENTRIES		(0x400 / 0x40)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct kldir_ent_s {
 	u64		magic;		/* Indicates validity of entry	    */
 	off_t		offset;		/* Offset from start of node space  */
@@ -27,7 +27,7 @@ typedef struct kldir_ent_s {
 	/* NOTE: These 16 bytes are used in the Partition KLDIR
 	   entry to store partition info. Refer to klpart.h for this. */
 } kldir_ent_t;
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_SGI_IP27
 #include <asm/sn/sn0/kldir.h>
diff --git a/arch/mips/include/asm/sn/klkernvars.h b/arch/mips/include/asm/sn/klkernvars.h
index ea6b217951636..bb7a6c36f6e7b 100644
--- a/arch/mips/include/asm/sn/klkernvars.h
+++ b/arch/mips/include/asm/sn/klkernvars.h
@@ -12,7 +12,7 @@
 
 #define KV_MAGIC		0x5f4b565f
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/sn/types.h>
 
@@ -24,6 +24,6 @@ typedef struct kern_vars_s {
 	unsigned long	kv_rw_baseaddr;
 } kern_vars_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_SN_KLKERNVARS_H */
diff --git a/arch/mips/include/asm/sn/launch.h b/arch/mips/include/asm/sn/launch.h
index 04226d8d30c42..ce95187362e70 100644
--- a/arch/mips/include/asm/sn/launch.h
+++ b/arch/mips/include/asm/sn/launch.h
@@ -59,7 +59,7 @@
  * clears the BUSY flag after control is returned to it.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef int launch_state_t;
 typedef void (*launch_proc_t)(u64 call_parm);
@@ -101,6 +101,6 @@ typedef struct launch_s {
 #define LAUNCH_FLASH	(*(void (*)(void)) \
 			 IP27PROM_FLASHLEDS)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_SN_LAUNCH_H */
diff --git a/arch/mips/include/asm/sn/nmi.h b/arch/mips/include/asm/sn/nmi.h
index 12ac210f12a17..eff51606bbcea 100644
--- a/arch/mips/include/asm/sn/nmi.h
+++ b/arch/mips/include/asm/sn/nmi.h
@@ -48,7 +48,7 @@
  *
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef struct nmi_s {
 	volatile unsigned long	 magic;		/* Magic number */
@@ -59,13 +59,13 @@ typedef struct nmi_s {
 	volatile unsigned long	 gmaster;	/* Flag true only on global master*/
 } nmi_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* Following definitions are needed both in the prom & the kernel
  * to identify the format of the nmi cpu register save area in the
  * low memory on each node.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct reg_struct {
 	unsigned long	gpr[32];
@@ -78,7 +78,7 @@ struct reg_struct {
 	unsigned long	nmi_sr;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* These are the assembly language offsets into the reg_struct structure */
 
diff --git a/arch/mips/include/asm/sn/sn0/addrs.h b/arch/mips/include/asm/sn/sn0/addrs.h
index f13df84edfdd5..a28158a91ecf5 100644
--- a/arch/mips/include/asm/sn/sn0/addrs.h
+++ b/arch/mips/include/asm/sn/sn0/addrs.h
@@ -84,15 +84,15 @@
 #define NASID_GET(_pa)		(int) ((UINT64_CAST (_pa) >>		\
 					NASID_SHFT) & NASID_BITMASK)
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 #define NODE_SWIN_BASE(nasid, widget)					\
 	((widget == 0) ? NODE_BWIN_BASE((nasid), SWIN0_BIGWIN)		\
 	: RAW_NODE_SWIN_BASE(nasid, widget))
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 #define NODE_SWIN_BASE(nasid, widget) \
      (NODE_IO_BASE(nasid) + (UINT64_CAST(widget) << SWIN_SIZE_BITS))
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The following definitions pertain to the IO special address
@@ -139,11 +139,11 @@
 /* Turn on sable logging for the processors whose bits are set. */
 #define SABLE_LOG_TRIGGER(_map)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define KERN_NMI_ADDR(nasid, slice)					\
 		    TO_NODE_UNCAC((nasid), IP27_NMI_KREGS_OFFSET +	\
 				  (IP27_NMI_KREGS_CPU_SIZE * (slice)))
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef PROM
 
@@ -248,7 +248,7 @@
 #define KL_UART_DATA	LOCAL_HUB_ADDR(MD_UREG0_1)	/* UART data reg */
 #define KL_I2C_REG	MD_UREG0_0			/* I2C reg */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Address 0x400 to 0x1000 ualias points to cache error eframe + misc
  * CACHE_ERR_SP_PTR could either contain an address to the stack, or
@@ -266,7 +266,7 @@
 #define CACHE_ERR_SP		(CACHE_ERR_SP_PTR - 16)
 #define CACHE_ERR_AREA_SIZE	(ARCS_SPB_OFFSET - CACHE_ERR_EFRAME)
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #define _ARCSPROM
 
diff --git a/arch/mips/include/asm/sn/sn0/hub.h b/arch/mips/include/asm/sn/sn0/hub.h
index c84adde36d41f..916394319af59 100644
--- a/arch/mips/include/asm/sn/sn0/hub.h
+++ b/arch/mips/include/asm/sn/sn0/hub.h
@@ -37,7 +37,7 @@
 #define UATTR_MSPEC	2
 #define UATTR_UNCAC	3
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 /*
  * Returns the local nasid into res.
  */
diff --git a/arch/mips/include/asm/sn/sn0/hubio.h b/arch/mips/include/asm/sn/sn0/hubio.h
index 57ece90f8cf1e..c489426f8f9e2 100644
--- a/arch/mips/include/asm/sn/sn0/hubio.h
+++ b/arch/mips/include/asm/sn/sn0/hubio.h
@@ -169,7 +169,7 @@
 /*
  * The IO LLP control status register and widget control register
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef union hubii_wid_u {
 	u64	wid_reg_value;
@@ -292,7 +292,7 @@ typedef union io_perf_cnt {
 	} perf_cnt_bits;
 } io_perf_cnt_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 #define LNK_STAT_WORKING	0x2
@@ -440,7 +440,7 @@ typedef union io_perf_cnt {
 /*
  * Fields in CRB Register A
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef union icrba_u {
 	u64	reg_value;
 	struct {
@@ -486,7 +486,7 @@ typedef union h1_icrba_u {
 #define ICRBN_A_CERR_SHFT	54
 #define ICRBN_A_ERR_MASK	0x3ff
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define IIO_ICRB_ADDR_SHFT	2	/* Shift to get proper address */
 
@@ -509,7 +509,7 @@ typedef union h1_icrba_u {
 /*
  * Fields in CRB Register B
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef union icrbb_u {
 	u64	reg_value;
 	struct {
@@ -608,7 +608,7 @@ typedef union h1_icrbb_u {
 #define b_imsg		icrbb_field_s.imsg
 #define b_initiator	icrbb_field_s.initiator
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * values for field xtsize
@@ -666,7 +666,7 @@ typedef union h1_icrbb_u {
  * Fields in CRB Register C
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef union icrbc_s {
 	u64	reg_value;
@@ -698,13 +698,13 @@ typedef union icrbc_s {
 #define c_barrop	icrbc_field_s.barrop
 #define c_doresp	icrbc_field_s.doresp
 #define c_gbr	icrbc_field_s.gbr
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Fields in CRB Register D
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef union icrbd_s {
 	u64	reg_value;
 	struct {
@@ -737,7 +737,7 @@ typedef union hubii_ifdr_u {
 	} hi_ifdr_fields;
 } hubii_ifdr_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * Hardware designed names for the BTE control registers.
@@ -784,7 +784,7 @@ typedef union hubii_ifdr_u {
  * IO PIO Read Table Entry format
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef union iprte_a {
 	u64	entry;
@@ -806,7 +806,7 @@ typedef union iprte_a {
 #define iprte_init	iprte_fields.initiator
 #define iprte_addr	iprte_fields.addr
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #define IPRTE_ADDRSHFT	3
 
@@ -814,7 +814,7 @@ typedef union iprte_a {
  * Hub IIO PRB Register format.
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Note: Fields bnakctr, anakctr, xtalkctrmode, ovflow fields are
  * "Status" fields, and should only be used in case of clean up after errors.
@@ -846,7 +846,7 @@ typedef union iprb_u {
 #define iprb_anakctr	iprb_fields_s.anakctr
 #define iprb_xtalkctr	iprb_fields_s.xtalkctr
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * values for mode field in iprb_t.
@@ -861,7 +861,7 @@ typedef union iprb_u {
 /*
  * IO CRB entry C_A to E_A : Partial (cache) CRBS
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef union icrbp_a {
 	u64   ip_reg;	    /* the entire register value	*/
 	struct {
@@ -895,7 +895,7 @@ typedef union icrbp_a {
 	} ip_fmt;
 } icrbp_a_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * A couple of defines to go with the above structure.
@@ -903,7 +903,7 @@ typedef union icrbp_a {
 #define ICRBP_A_CERR_SHFT	54
 #define ICRBP_A_ERR_MASK	0x3ff
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef union hubii_idsr {
 	u64 iin_reg;
 	struct {
@@ -917,7 +917,7 @@ typedef union hubii_idsr {
 		    level : 7;
 	} iin_fmt;
 } hubii_idsr_t;
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * IO BTE Length/Status (IIO_IBLS) register bit field definitions
diff --git a/arch/mips/include/asm/sn/sn0/hubmd.h b/arch/mips/include/asm/sn/sn0/hubmd.h
index 305d002be1825..97d9cbbf9f4c6 100644
--- a/arch/mips/include/asm/sn/sn0/hubmd.h
+++ b/arch/mips/include/asm/sn/sn0/hubmd.h
@@ -423,7 +423,7 @@
  * Operations on page migration threshold register
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * LED register macros
@@ -735,7 +735,7 @@ typedef union md_perf_cnt {
 } md_perf_cnt_t;
 
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 #define DIR_ERROR_VALID_MASK	0xe000000000000000
diff --git a/arch/mips/include/asm/sn/sn0/hubni.h b/arch/mips/include/asm/sn/sn0/hubni.h
index b8253142cb834..4830bae723e4b 100644
--- a/arch/mips/include/asm/sn/sn0/hubni.h
+++ b/arch/mips/include/asm/sn/sn0/hubni.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_SGI_SN0_HUBNI_H
 #define _ASM_SGI_SN0_HUBNI_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #endif
 
@@ -226,7 +226,7 @@
 
 #define NLT_EXIT_PORT_MASK (UINT64_CAST 0xf)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef union	hubni_port_error_u {
 	u64	nipe_reg_value;
@@ -258,6 +258,6 @@ static inline int get_region_shift(void)
 	return NASID_TO_COARSEREG_SHFT;
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_SGI_SN0_HUBNI_H */
diff --git a/arch/mips/include/asm/sn/sn0/hubpi.h b/arch/mips/include/asm/sn/sn0/hubpi.h
index 7b83655913c52..a4fe0feeef0cc 100644
--- a/arch/mips/include/asm/sn/sn0/hubpi.h
+++ b/arch/mips/include/asm/sn/sn0/hubpi.h
@@ -306,7 +306,7 @@
 #define ERR_STACK_SIZE_BYTES(_sz) \
        ((_sz) ? (PI_MIN_STACK_SIZE << ((_sz) - 1)) : 0)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * format of error stack and error status registers.
  */
@@ -359,7 +359,7 @@ typedef union pi_err_stat1 {
 
 typedef u64	rtc_time_t;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 
 /* Bits in PI_SYSAD_ERRCHK_EN */
diff --git a/arch/mips/include/asm/sn/types.h b/arch/mips/include/asm/sn/types.h
index 451ba1ee41ad8..53d04c04d6f55 100644
--- a/arch/mips/include/asm/sn/types.h
+++ b/arch/mips/include/asm/sn/types.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef unsigned long	cpuid_t;
 typedef signed short	nasid_t;	/* node id in numa-as-id space */
diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
index 44c04a82d0b7d..d7873e8d7e6f8 100644
--- a/arch/mips/include/asm/sync.h
+++ b/arch/mips/include/asm/sync.h
@@ -193,7 +193,7 @@
  * Preprocessor magic to expand macros used as arguments before we insert them
  * into assembly code.
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 # define ___SYNC(type, reason, else)				\
 	____SYNC(type, reason, else)
 #else
diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/asm/thread_info.h
index b9d76e8ac5a23..2707dad260dd7 100644
--- a/arch/mips/include/asm/thread_info.h
+++ b/arch/mips/include/asm/thread_info.h
@@ -11,7 +11,7 @@
 #ifdef __KERNEL__
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/processor.h>
 
@@ -73,7 +73,7 @@ static inline struct thread_info *current_thread_info(void)
 register unsigned long current_stack_pointer __asm__("sp");
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* thread information allocation */
 #if defined(CONFIG_PAGE_SIZE_4KB) && defined(CONFIG_32BIT)
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index ba83d3fb0a848..6a974b990f4b2 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -29,7 +29,7 @@
 #define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
@@ -62,6 +62,6 @@
 /* whitelists for checksyscalls */
 #define __IGNORE_fadvise64_64
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_UNISTD_H */
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index 44a45f3fa4b01..e69bf35006625 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/vdso.h>
 #include <asm/clocksource.h>
@@ -214,6 +214,6 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return get_vdso_data();
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/mips/include/asm/vdso/processor.h b/arch/mips/include/asm/vdso/processor.h
index 511c95d735e65..05cdb366dc21c 100644
--- a/arch/mips/include/asm/vdso/processor.h
+++ b/arch/mips/include/asm/vdso/processor.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_PROCESSOR_H
 #define __ASM_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CPU_LOONGSON64
 /*
@@ -22,6 +22,6 @@
 #define cpu_relax()	barrier()
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/vdso.h
index 6cd88191fefa9..1cbe6aca73201 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -6,7 +6,7 @@
 
 #include <asm/sgidefs.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
 #include <asm/page.h>
@@ -72,4 +72,4 @@ static inline void __iomem *get_gic(const struct vdso_data *data)
 
 #endif /* CONFIG_CLKSRC_MIPS_GIC */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vdso/vsyscall.h
index a4582870aaea4..ea9d04d05eafa 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <vdso/datapage.h>
 
@@ -21,6 +21,6 @@ struct vdso_data *__mips_get_k_vdso_data(void)
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/mips/include/asm/xtalk/xtalk.h b/arch/mips/include/asm/xtalk/xtalk.h
index 680e7efebbaf6..dfe6a3fce65a5 100644
--- a/arch/mips/include/asm/xtalk/xtalk.h
+++ b/arch/mips/include/asm/xtalk/xtalk.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_XTALK_XTALK_H
 #define _ASM_XTALK_XTALK_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * User-level device driver visible types
  */
@@ -47,6 +47,6 @@ typedef struct xtalk_piomap_s *xtalk_piomap_t;
 #define XIO_PORT(x)	((xwidgetnum_t)(((x)&XIO_PORT_BITS) >> XIO_PORT_SHIFT))
 #define XIO_PACK(p, o)	((((uint64_t)(p))<<XIO_PORT_SHIFT) | ((o)&XIO_ADDR_BITS))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_XTALK_XTALK_H */
diff --git a/arch/mips/include/asm/xtalk/xwidget.h b/arch/mips/include/asm/xtalk/xwidget.h
index 24f121da6a1d9..efcfe4494576a 100644
--- a/arch/mips/include/asm/xtalk/xwidget.h
+++ b/arch/mips/include/asm/xtalk/xwidget.h
@@ -203,7 +203,7 @@ static const struct widget_ident __initconst widget_idents[] = {
  * widget target flush register are widget dependent thus will not be
  * defined here
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef u32 widgetreg_t;
 
 /* widget configuration registers */
@@ -274,6 +274,6 @@ typedef struct xwidget_hwid_s {
 	((hwid2)->mfg_num == XWIDGET_MFG_NUM_NONE) || \
 	((hwid1)->mfg_num == (hwid2)->mfg_num)))
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _ASM_XTALK_XWIDGET_H */
diff --git a/drivers/soc/bcm/brcmstb/pm/pm.h b/drivers/soc/bcm/brcmstb/pm/pm.h
index 94a380470a2f9..17f7a06a7a836 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm.h
+++ b/drivers/soc/bcm/brcmstb/pm/pm.h
@@ -60,7 +60,7 @@
 			   PM_DEEP_STANDBY | \
 			   PM_PLL_PWRDOWN | PM_PWR_DOWN)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef CONFIG_MIPS
 extern const unsigned long brcmstb_pm_do_s2_sz;
-- 
2.48.1


