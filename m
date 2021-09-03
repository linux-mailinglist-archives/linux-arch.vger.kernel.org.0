Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB63FFD93
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 11:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348989AbhICJ4E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 05:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348984AbhICJ4C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Sep 2021 05:56:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2896C60FC4;
        Fri,  3 Sep 2021 09:54:58 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 03/22] LoongArch: Add elf-related definitions
Date:   Fri,  3 Sep 2021 17:51:54 +0800
Message-Id: <20210903095213.797973-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903095213.797973-1-chenhuacai@loongson.cn>
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add elf-related definitions for LoongArch, including: EM_LOONGARCH,
KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
and NT_LOONGARCH_*.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/uapi/linux/audit.h  | 2 ++
 include/uapi/linux/elf-em.h | 1 +
 include/uapi/linux/elf.h    | 5 +++++
 include/uapi/linux/kexec.h  | 1 +
 scripts/sorttable.c         | 5 +++++
 5 files changed, 14 insertions(+)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index daa481729e9b..e6023f00eaf9 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -434,6 +434,8 @@ enum {
 #define AUDIT_ARCH_UNICORE	(EM_UNICORE|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_XTENSA	(EM_XTENSA)
+#define AUDIT_ARCH_LOONGARCH32	(EM_LOONGARCH|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_LOONGARCH64	(EM_LOONGARCH|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 
 #define AUDIT_PERM_EXEC		1
 #define AUDIT_PERM_WRITE	2
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index f47e853546fa..ef38c2bc5ab7 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -51,6 +51,7 @@
 #define EM_RISCV	243	/* RISC-V */
 #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
 #define EM_CSKY		252	/* C-SKY */
+#define EM_LOONGARCH	258	/* LoongArch */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
 
 /*
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..c788dd648226 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -432,6 +432,11 @@ typedef struct elf64_shdr {
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
 #define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
+#define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
+#define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
+#define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extension registers */
+#define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation registers */
 
 /* Note types with note name "GNU" */
 #define NT_GNU_PROPERTY_TYPE_0	5
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 778dc191c265..5ef2df004565 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -43,6 +43,7 @@
 #define KEXEC_ARCH_MIPS    ( 8 << 16)
 #define KEXEC_ARCH_AARCH64 (183 << 16)
 #define KEXEC_ARCH_RISCV   (243 << 16)
+#define KEXEC_ARCH_LOONGARCH	(258 << 16)
 
 /* The artificial cap on the number of segments passed to kexec_load. */
 #define KEXEC_SEGMENT_MAX 16
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 0ef3abfc4a51..3823079cf692 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -54,6 +54,10 @@
 #define EM_ARCV2	195
 #endif
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258
+#endif
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -347,6 +351,7 @@ static int do_file(char const *const fname, void *addr)
 	case EM_ARCOMPACT:
 	case EM_ARCV2:
 	case EM_ARM:
+	case EM_LOONGARCH:
 	case EM_MICROBLAZE:
 	case EM_MIPS:
 	case EM_XTENSA:
-- 
2.27.0

