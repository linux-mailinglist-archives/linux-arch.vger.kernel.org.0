Return-Path: <linux-arch+bounces-10773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC4A6099F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A57619C4665
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B135C192B65;
	Fri, 14 Mar 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3BdptYh"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC11922EE
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936303; cv=none; b=H2eQBFNYZQAOtqHpnDYoHilxQUnFIzhXieXJyZ1umhJbZndumIgZeymJFX7x2BNbD2n0CVEwzKm/J7AwRoZEBlWTJooBiRKSIN75RlJdvGVvKBn02ik6pNc61cL9G6N60w8WwSyXBXiIskwMPQO4GRNbOS2Aj3qYWEZNj1qQW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936303; c=relaxed/simple;
	bh=SVEk6tjBjzMa/46GiOB/9d3IVcS1p+CL1UgzlIQSVCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uf1KIu9MsduGWshtSaM9p3V1m8L8CugQPuyAR4RpiE9Z79YDSXsEwI9Sdu/hvukussMEJHpLMgwWuI+03V9OugUJ+afHTX7UChh09REolizDp2oMtSHQQP4vOY4lGco61pzSmm3BOC7PIjeFaVgWU+TLnekxm5ITls5HvsSJYX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3BdptYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEKwBt7WFu8be+iYoxPrtQkDxzPELK9YZvRGW/QrmV4=;
	b=c3BdptYhYLFweET2rGS8+Gdv1cls3iE8QXhsZ77/bH/wGzpe4o7CwrJByrsmHvTs8XzBfc
	i+0Xej3Ty2Okv3sasi9Hgu344Rl5dKjdNPBMpudY0t3B5L4ys+bjVp0l0ITj9laCryqiik
	c7bwjcJQqu3kIbe/H05wc4Eju+KPoZk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-IfcePs7MO0ioNH9bAIoMCg-1; Fri,
 14 Mar 2025 03:11:37 -0400
X-MC-Unique: IfcePs7MO0ioNH9bAIoMCg-1
X-Mimecast-MFC-AGG-ID: IfcePs7MO0ioNH9bAIoMCg_1741936296
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD5951800258;
	Fri, 14 Mar 2025 07:11:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9F9918001D4;
	Fri, 14 Mar 2025 07:11:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH 16/41] m68k: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 14 Mar 2025 08:09:47 +0100
Message-ID: <20250314071013.1575167-17-thuth@redhat.com>
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
"sed -i" statement), with one comment tweaked manually in
arch/m68k/include/asm/mac_baboon.h (which was missing underscores).

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/m68k/include/asm/adb_iop.h          |  4 ++--
 arch/m68k/include/asm/bootinfo.h         |  4 ++--
 arch/m68k/include/asm/entry.h            |  4 ++--
 arch/m68k/include/asm/kexec.h            |  4 ++--
 arch/m68k/include/asm/mac_baboon.h       |  4 ++--
 arch/m68k/include/asm/mac_iop.h          |  4 ++--
 arch/m68k/include/asm/mac_oss.h          |  4 ++--
 arch/m68k/include/asm/mac_psc.h          |  4 ++--
 arch/m68k/include/asm/mac_via.h          |  4 ++--
 arch/m68k/include/asm/math-emu.h         |  6 +++---
 arch/m68k/include/asm/mcf_pgtable.h      |  4 ++--
 arch/m68k/include/asm/mcfmmu.h           |  2 +-
 arch/m68k/include/asm/motorola_pgtable.h |  4 ++--
 arch/m68k/include/asm/nettel.h           |  4 ++--
 arch/m68k/include/asm/openprom.h         |  4 ++--
 arch/m68k/include/asm/page.h             |  4 ++--
 arch/m68k/include/asm/page_mm.h          |  4 ++--
 arch/m68k/include/asm/page_no.h          |  4 ++--
 arch/m68k/include/asm/pgtable.h          |  2 +-
 arch/m68k/include/asm/pgtable_mm.h       |  8 ++++----
 arch/m68k/include/asm/ptrace.h           |  4 ++--
 arch/m68k/include/asm/setup.h            | 10 +++++-----
 arch/m68k/include/asm/sun3_pgtable.h     |  8 ++++----
 arch/m68k/include/asm/sun3mmu.h          |  4 ++--
 arch/m68k/include/asm/thread_info.h      |  6 +++---
 arch/m68k/include/asm/traps.h            |  6 +++---
 arch/m68k/math-emu/fp_emu.h              |  8 ++++----
 27 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/m68k/include/asm/adb_iop.h b/arch/m68k/include/asm/adb_iop.h
index 6aecd020e2fc9..ca10b1ec0c785 100644
--- a/arch/m68k/include/asm/adb_iop.h
+++ b/arch/m68k/include/asm/adb_iop.h
@@ -33,7 +33,7 @@
 #define ADB_IOP_SRQ		0x04	/* SRQ detected                */
 #define ADB_IOP_TIMEOUT		0x02	/* nonzero if timeout          */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct adb_iopmsg {
 	__u8 flags;		/* ADB flags         */
@@ -43,4 +43,4 @@ struct adb_iopmsg {
 	__u8 spare[21];		/* spare             */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/m68k/include/asm/bootinfo.h b/arch/m68k/include/asm/bootinfo.h
index 81c91af8ec6c0..267272b436e27 100644
--- a/arch/m68k/include/asm/bootinfo.h
+++ b/arch/m68k/include/asm/bootinfo.h
@@ -14,7 +14,7 @@
 #include <uapi/asm/bootinfo.h>
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_BOOTINFO_PROC
 extern void save_bootinfo(const struct bi_record *bi);
@@ -28,7 +28,7 @@ void process_uboot_commandline(char *commandp, int size);
 static inline void process_uboot_commandline(char *commandp, int size) {}
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _M68K_BOOTINFO_H */
diff --git a/arch/m68k/include/asm/entry.h b/arch/m68k/include/asm/entry.h
index 9b52b060c76ab..86cba7c19e679 100644
--- a/arch/m68k/include/asm/entry.h
+++ b/arch/m68k/include/asm/entry.h
@@ -4,7 +4,7 @@
 
 #include <asm/setup.h>
 #include <asm/page.h>
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/thread_info.h>
 #endif
 
@@ -41,7 +41,7 @@
 #define ALLOWINT	(~0x700)
 #endif /* machine compilation types */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 /*
  * This defines the normal kernel pt-regs layout.
  *
diff --git a/arch/m68k/include/asm/kexec.h b/arch/m68k/include/asm/kexec.h
index 3b0b64f0a3531..f79427bd64878 100644
--- a/arch/m68k/include/asm/kexec.h
+++ b/arch/m68k/include/asm/kexec.h
@@ -15,7 +15,7 @@
 
 #define KEXEC_ARCH KEXEC_ARCH_68K
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void crash_setup_regs(struct pt_regs *newregs,
 				    struct pt_regs *oldregs)
@@ -23,7 +23,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	/* Dummy implementation for now */
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* CONFIG_KEXEC_CORE */
 
diff --git a/arch/m68k/include/asm/mac_baboon.h b/arch/m68k/include/asm/mac_baboon.h
index 08d9b8829a1ab..ed5b5b48bdf83 100644
--- a/arch/m68k/include/asm/mac_baboon.h
+++ b/arch/m68k/include/asm/mac_baboon.h
@@ -5,7 +5,7 @@
 
 #define BABOON_BASE (0x50F1A000)	/* same as IDE controller base */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct baboon {
 	char	pad1[208];	/* generic IDE registers, not used here */
@@ -36,4 +36,4 @@ extern void baboon_register_interrupts(void);
 extern void baboon_irq_enable(int);
 extern void baboon_irq_disable(int);
 
-#endif /* __ASSEMBLY **/
+#endif /* __ASSEMBLER__ */
diff --git a/arch/m68k/include/asm/mac_iop.h b/arch/m68k/include/asm/mac_iop.h
index 32f1c79c818f1..a6753eb16ba46 100644
--- a/arch/m68k/include/asm/mac_iop.h
+++ b/arch/m68k/include/asm/mac_iop.h
@@ -66,7 +66,7 @@
 #define IOP_ADDR_ALIVE		0x031F
 #define IOP_ADDR_RECV_MSG	0x0320
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * IOP Control registers, staggered because in usual Apple style they were
@@ -163,4 +163,4 @@ extern void iop_ism_irq_poll(uint);
 
 extern void iop_register_interrupts(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/m68k/include/asm/mac_oss.h b/arch/m68k/include/asm/mac_oss.h
index 56ef986c0a9b1..a6e86e443155f 100644
--- a/arch/m68k/include/asm/mac_oss.h
+++ b/arch/m68k/include/asm/mac_oss.h
@@ -59,7 +59,7 @@
 
 #define OSS_POWEROFF	0x80
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mac_oss {
     __u8  irq_level[0x10];	/* [0x000-0x00f] Interrupt levels */
@@ -77,4 +77,4 @@ extern void oss_register_interrupts(void);
 extern void oss_irq_enable(int);
 extern void oss_irq_disable(int);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/m68k/include/asm/mac_psc.h b/arch/m68k/include/asm/mac_psc.h
index 86a5a5eab89ed..6587dbd544764 100644
--- a/arch/m68k/include/asm/mac_psc.h
+++ b/arch/m68k/include/asm/mac_psc.h
@@ -207,7 +207,7 @@
 				 * Unknown, always 0x0000.
 				 */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern volatile __u8 *psc;
 
@@ -249,4 +249,4 @@ static inline u32 psc_read_long(int offset)
 	return *((volatile __u32 *)(psc + offset));
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/m68k/include/asm/mac_via.h b/arch/m68k/include/asm/mac_via.h
index a9ef1e9ba6c41..b065cd8e5071e 100644
--- a/arch/m68k/include/asm/mac_via.h
+++ b/arch/m68k/include/asm/mac_via.h
@@ -250,7 +250,7 @@
 #define IER_SET_BIT(b) (0x80 | (1<<(b)) )
 #define IER_CLR_BIT(b) (0x7F & (1<<(b)) )
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern volatile __u8 *via1,*via2;
 extern int rbv_present,via_alt_mapping;
@@ -267,6 +267,6 @@ extern void via1_irq(struct irq_desc *desc);
 extern void via1_set_head(int);
 extern int via2_scsi_drq_pending(void);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_MAC_VIA_H_ */
diff --git a/arch/m68k/include/asm/math-emu.h b/arch/m68k/include/asm/math-emu.h
index eefaa3a2b596f..91074ade14ad6 100644
--- a/arch/m68k/include/asm/math-emu.h
+++ b/arch/m68k/include/asm/math-emu.h
@@ -67,7 +67,7 @@
 #define PMUNIMPL	(1<<PUNIMPL)
 #define PMMOVEM		(1<<PMOVEM)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -127,7 +127,7 @@ extern unsigned int fp_debugprint;
 
 #define FPDATA		((struct fp_data *)current->thread.fp)
 
-#else	/* __ASSEMBLY__ */
+#else	/* __ASSEMBLER__ */
 
 #define FPDATA		%a2
 
@@ -311,6 +311,6 @@ old_gas=old_gas+1
 .endm
 
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* _ASM_M68K_SETUP_H */
diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index 48f87a8a88320..a6189351aa907 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -92,7 +92,7 @@
 #define PTE_MASK	PAGE_MASK
 #define CF_PAGE_CHG_MASK (PTE_MASK | CF_PAGE_ACCESSED | CF_PAGE_DIRTY)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
@@ -298,5 +298,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define pfn_pte(pfn, prot)	__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 #define pte_pfn(pte)		(pte_val(pte) >> PAGE_SHIFT)
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 #endif	/* _MCF_PGTABLE_H */
diff --git a/arch/m68k/include/asm/mcfmmu.h b/arch/m68k/include/asm/mcfmmu.h
index 283352ab0d5d8..db16ea1057f7b 100644
--- a/arch/m68k/include/asm/mcfmmu.h
+++ b/arch/m68k/include/asm/mcfmmu.h
@@ -88,7 +88,7 @@
 #define	MMUDR_PAN	10			/* Physical address */
 #define	MMUDR_PAMASK	0xfffffc00		/* PA mask */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  *	Simple access functions for the MMU registers. Nothing fancy
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 9866c7acdabe1..aea231a2b2c04 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -44,7 +44,7 @@
 /* We borrow bit 11 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x800
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* This is the cache mode to be used for pages containing page descriptors for
  * processors >= '040. It is in pte_mknocache(), and the variable is defined
@@ -208,5 +208,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 #endif /* _MOTOROLA_PGTABLE_H */
diff --git a/arch/m68k/include/asm/nettel.h b/arch/m68k/include/asm/nettel.h
index 3bd4b7a4613f6..9bf55cef119e2 100644
--- a/arch/m68k/include/asm/nettel.h
+++ b/arch/m68k/include/asm/nettel.h
@@ -38,7 +38,7 @@
 
 #define	NETtel_LEDADDR	0x30400000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern volatile unsigned short ppdata;
 
@@ -80,7 +80,7 @@ static __inline__ void mcf_setppdata(unsigned int mask, unsigned int bits)
 #define	MCFPP_DTR0	0x0040
 #define	MCFPP_DTR1	0x0000		/* Port 1 no DTR support */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  *	These functions defined to give quasi generic access to the
  *	PPIO bits used for DTR/DCD.
diff --git a/arch/m68k/include/asm/openprom.h b/arch/m68k/include/asm/openprom.h
index dd22e649f5c56..6456ba40a9464 100644
--- a/arch/m68k/include/asm/openprom.h
+++ b/arch/m68k/include/asm/openprom.h
@@ -21,7 +21,7 @@
 #define	LINUX_OPPROM_MAGIC      0x10010407
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* V0 prom device operations. */
 struct linux_dev_v0_funcs {
 	int (*v0_devopen)(char *device_str);
@@ -308,6 +308,6 @@ struct linux_prom_ranges {
 	unsigned int or_size;
 };
 
-#endif /* !(__ASSEMBLY__) */
+#endif /* !(__ASSEMBLER__) */
 
 #endif /* !(__SPARC_OPENPROM_H) */
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index b173ba27d36f1..d30f8b2f15927 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -10,7 +10,7 @@
 
 #define PAGE_OFFSET	(PAGE_OFFSET_RAW)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * These are used to make use of C type-checking..
@@ -48,7 +48,7 @@ extern unsigned long _rambase;
 extern unsigned long _ramstart;
 extern unsigned long _ramend;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_MMU
 #include <asm/page_mm.h>
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index e0ae4d5fc9859..ed782609ca413 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -2,7 +2,7 @@
 #ifndef _M68K_PAGE_MM_H
 #define _M68K_PAGE_MM_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <asm/module.h>
@@ -144,6 +144,6 @@ extern int m68k_virt_to_node_shift;
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _M68K_PAGE_MM_H */
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index 63c0e706084b1..39db2026a4b4c 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -2,7 +2,7 @@
 #ifndef _M68K_PAGE_NO_H
 #define _M68K_PAGE_NO_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
  
 extern unsigned long memory_start;
 extern unsigned long memory_end;
@@ -37,6 +37,6 @@ static inline void *pfn_to_virt(unsigned long pfn)
 
 #define ARCH_PFN_OFFSET PHYS_PFN(PAGE_OFFSET_RAW)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _M68K_PAGE_NO_H */
diff --git a/arch/m68k/include/asm/pgtable.h b/arch/m68k/include/asm/pgtable.h
index 49fcfd7348600..02f1a4601379f 100644
--- a/arch/m68k/include/asm/pgtable.h
+++ b/arch/m68k/include/asm/pgtable.h
@@ -10,7 +10,7 @@
 #include <asm/pgtable_mm.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void paging_init(void);
 #endif
 
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index dbdf1c2b2f66b..62f2ff4e6799b 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -11,7 +11,7 @@
 
 #include <asm/setup.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <linux/sched.h>
 #include <linux/threads.h>
@@ -145,7 +145,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /* MMU-specific headers */
 
@@ -157,7 +157,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #include <asm/motorola_pgtable.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * Macro to mark a page protection value as "uncacheable".
  */
@@ -182,6 +182,6 @@ pgprot_t pgprot_dmacoherent(pgprot_t prot);
 #define pgprot_dmacoherent(prot)	pgprot_dmacoherent(prot)
 
 #endif /* CONFIG_COLDFIRE */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* _M68K_PGTABLE_H */
diff --git a/arch/m68k/include/asm/ptrace.h b/arch/m68k/include/asm/ptrace.h
index ea5a80ca1ab33..bc86ce012025e 100644
--- a/arch/m68k/include/asm/ptrace.h
+++ b/arch/m68k/include/asm/ptrace.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef PS_S
 #define PS_S  (0x2000)
@@ -24,5 +24,5 @@
 #define arch_has_block_step()	(1)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _M68K_PTRACE_H */
diff --git a/arch/m68k/include/asm/setup.h b/arch/m68k/include/asm/setup.h
index 2c99477aaf89a..e4ec169f5c7d6 100644
--- a/arch/m68k/include/asm/setup.h
+++ b/arch/m68k/include/asm/setup.h
@@ -28,9 +28,9 @@
 
 #define CL_SIZE COMMAND_LINE_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long m68k_machtype;
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #if !defined(CONFIG_AMIGA)
 #  define MACH_IS_AMIGA (0)
@@ -199,7 +199,7 @@ extern unsigned long m68k_machtype;
 #endif
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long m68k_cputype;
 extern unsigned long m68k_fputype;
 extern unsigned long m68k_mmutype;
@@ -213,7 +213,7 @@ extern unsigned long vme_brdtype;
      */
 
 extern int m68k_is040or060;
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #if !defined(CONFIG_M68020)
 #  define CPU_IS_020 (0)
@@ -321,7 +321,7 @@ extern int m68k_is040or060;
 
 #define NUM_MEMINFO	4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct m68k_mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index 30081aee81643..bdbeaa90dbcc7 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -4,7 +4,7 @@
 
 #include <asm/sun3mmu.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/virtconvert.h>
 #include <linux/linkage.h>
 
@@ -19,7 +19,7 @@
 #define PTOV(addr)	__va(addr)
 
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 /* These need to be defined for compatibility although the sun3 doesn't use them */
 #define _PAGE_NOCACHE030 0x040
@@ -74,7 +74,7 @@
 /* We borrow bit 6 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	0x040
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
@@ -192,5 +192,5 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 	return pte;
 }
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 #endif	/* !_SUN3_PGTABLE_H */
diff --git a/arch/m68k/include/asm/sun3mmu.h b/arch/m68k/include/asm/sun3mmu.h
index 21a75daa278f2..fee05cd2ce5ba 100644
--- a/arch/m68k/include/asm/sun3mmu.h
+++ b/arch/m68k/include/asm/sun3mmu.h
@@ -67,7 +67,7 @@
 #define SUN3_BUSERR_PROTERR	(0x40)
 #define SUN3_BUSERR_INVALID	(0x80)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Read bus error status register (implicitly clearing it). */
 static inline unsigned char sun3_get_buserr(void)
@@ -167,6 +167,6 @@ extern void __iomem *sun3_ioremap(unsigned long phys, unsigned long size,
 
 extern int sun3_map_test(unsigned long addr, char *val);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #endif	/* !__SUN3_MMU_H__ */
diff --git a/arch/m68k/include/asm/thread_info.h b/arch/m68k/include/asm/thread_info.h
index 3e31adbddc75f..5cb3ace556222 100644
--- a/arch/m68k/include/asm/thread_info.h
+++ b/arch/m68k/include/asm/thread_info.h
@@ -22,7 +22,7 @@
 
 #define THREAD_SIZE	(PAGE_SIZE << THREAD_SIZE_ORDER)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
@@ -31,7 +31,7 @@ struct thread_info {
 	__u32			cpu;		/* should always be 0 on m68k */
 	unsigned long		tp_value;	/* thread pointer */
 };
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define INIT_THREAD_INFO(tsk)			\
 {						\
@@ -39,7 +39,7 @@ struct thread_info {
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
diff --git a/arch/m68k/include/asm/traps.h b/arch/m68k/include/asm/traps.h
index a9d5c1c870d31..c7b3989bd4b25 100644
--- a/arch/m68k/include/asm/traps.h
+++ b/arch/m68k/include/asm/traps.h
@@ -11,7 +11,7 @@
 #ifndef _M68K_TRAPS_H
 #define _M68K_TRAPS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/linkage.h>
 #include <asm/ptrace.h>
@@ -94,7 +94,7 @@ asmlinkage void bad_inthandler(void);
 
 #define VECOFF(vec) ((vec)<<2)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Status register bits */
 #define PS_T  (0x8000)
@@ -271,6 +271,6 @@ struct frame {
 asmlinkage void berr_040cleanup(struct frame *fp);
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _M68K_TRAPS_H */
diff --git a/arch/m68k/math-emu/fp_emu.h b/arch/m68k/math-emu/fp_emu.h
index c1ecfef7886a6..6ac811c31ca4d 100644
--- a/arch/m68k/math-emu/fp_emu.h
+++ b/arch/m68k/math-emu/fp_emu.h
@@ -38,12 +38,12 @@
 #ifndef _FP_EMU_H
 #define _FP_EMU_H
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/asm-offsets.h>
 #endif
 #include <asm/math-emu.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define IS_INF(a) ((a)->exp == 0x7fff)
 #define IS_ZERO(a) ((a)->mant.m64 == 0)
@@ -124,7 +124,7 @@ extern const struct fp_ext fp_Inf;
 			: "a1", "d1", "d2", "memory");		\
 })
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /*
  * set, reset or clear a bit in the fp status register
@@ -141,6 +141,6 @@ extern const struct fp_ext fp_Inf;
 	btst	#(\bit&7),(FPD_FPSR+3-(\bit/8),FPDATA)
 .endm
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _FP_EMU_H */
-- 
2.48.1


