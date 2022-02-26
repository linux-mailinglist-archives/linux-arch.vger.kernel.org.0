Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39E4C5566
	for <lists+linux-arch@lfdr.de>; Sat, 26 Feb 2022 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiBZLJT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Feb 2022 06:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiBZLJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2022 06:09:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804EE49F98;
        Sat, 26 Feb 2022 03:08:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32E4BB81C18;
        Sat, 26 Feb 2022 11:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35435C340E8;
        Sat, 26 Feb 2022 11:08:37 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V6 03/22] LoongArch: Add elf-related definitions
Date:   Sat, 26 Feb 2022 19:03:19 +0800
Message-Id: <20220226110338.77547-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220226110338.77547-1-chenhuacai@loongson.cn>
References: <20220226110338.77547-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 8eda133ca4c1..7c1dc818b1d5 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -439,6 +439,8 @@ enum {
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
index 3a8ea5ed553d..fe5700459844 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -60,6 +60,10 @@
 #define EM_RISCV	243
 #endif
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258
+#endif
+
 static uint32_t (*r)(const uint32_t *);
 static uint16_t (*r2)(const uint16_t *);
 static uint64_t (*r8)(const uint64_t *);
@@ -354,6 +358,7 @@ static int do_file(char const *const fname, void *addr)
 	case EM_ARCOMPACT:
 	case EM_ARCV2:
 	case EM_ARM:
+	case EM_LOONGARCH:
 	case EM_MICROBLAZE:
 	case EM_MIPS:
 	case EM_XTENSA:
-- 
2.27.0

