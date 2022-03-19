Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750A4DE868
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 15:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbiCSOd3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243128AbiCSOd2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 10:33:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA54666A;
        Sat, 19 Mar 2022 07:32:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t14so7132319pgr.3;
        Sat, 19 Mar 2022 07:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ita7l0wGtSPkeGH0MYp6DuQ8B+HUFAN9YJxHE+vhgnE=;
        b=MgrmnScg55xzaNhNDoJrKkW+SnQ51vrFuBXQIyXGmgWr1Doufw216S2BclFUeix8sV
         f0ndKoY9XExTjBe0DtubodRIHHlVq2jqzCP8feBcDKLVnSEtaGYYGR8dNhjA+/vJDqlK
         +5obiab7wK2AZSEStMcFvMaZJxB47VRhGfWpIdEJAkxb+g43MBA0kSeMfX4fd3YH4PKF
         QSUaVz+kZyn4VpNGLlsPbQ9KB8BbTlDxuYmbNdOk3w5rUWUdQb7JxEdTP/jZ5EKWQW2I
         JOoICfxK4UmjZQA4oQCgqm39UZYa6CDadPcU6R4hKWN2JrkhaLBAvLyHF+VWF4+IvcUd
         pjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ita7l0wGtSPkeGH0MYp6DuQ8B+HUFAN9YJxHE+vhgnE=;
        b=SUloPXqoryuBQzg+Zg/pnAQoKDzN7ERbuRmeJ76Acy4WJF/HESJSmEFm5gmU84eGH3
         4jbN3OI/rIA7OrkaMCvqcUOyfSYojInwl8veHJTn65XefCCOxpZdjVdF0ZkHsJxZKeqz
         62+JV7LkUChLPmVBKiWbAAXR5xT9DqihPqTqQxqu7+isjuaDe5ZczuTPue1+e14o5oJO
         dfadEoQB0UalU3vtSpNiR1ThJ6If53pnMl0NW6ijNbfGI+pT87VTYBAWGQ3dKckdQZkl
         NB72ZSnUl4m9gt3Vah1OvKr69L/9+0NCRP+Hk0UEOi7fr4n4uGpVqsO67+beNY7KhS98
         5I3g==
X-Gm-Message-State: AOAM531kcXqudEkn9orNoPskLsszJeVRxf1fBKDk8FvViM5vNhpPE3Hh
        f621yF8/GsoGDLdjzu+GNn8=
X-Google-Smtp-Source: ABdhPJw0vozg0W7wlp5o3FkkRLSFwHY3ko++hrBdy6jXBEwj4YlOlEqFuglUk2nIgtLUkieKLfXgrA==
X-Received: by 2002:a65:604a:0:b0:375:5cc8:7458 with SMTP id a10-20020a65604a000000b003755cc87458mr12045583pgp.205.1647700325305;
        Sat, 19 Mar 2022 07:32:05 -0700 (PDT)
Received: from localhost.localdomain ([50.7.60.25])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a178c00b001bd036e11fdsm14886959pja.42.2022.03.19.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 07:32:05 -0700 (PDT)
Sender: Huacai Chen <chenhuacai@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
X-Google-Original-From: Huacai Chen <chenhuacai@loongson.cn>
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
Subject: [PATCH V8 03/22] LoongArch: Add elf-related definitions
Date:   Sat, 19 Mar 2022 22:31:11 +0800
Message-Id: <20220319143130.1026432-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220319143130.1026432-1-chenhuacai@loongson.cn>
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143130.1026432-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

