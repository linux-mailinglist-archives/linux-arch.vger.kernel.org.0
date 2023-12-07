Return-Path: <linux-arch+bounces-754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EEC809068
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 19:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4586A1C20A4C
	for <lists+linux-arch@lfdr.de>; Thu,  7 Dec 2023 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A034E629;
	Thu,  7 Dec 2023 18:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csTXh3rM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F210EB;
	Thu,  7 Dec 2023 10:44:38 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a1e2f34467aso124795466b.2;
        Thu, 07 Dec 2023 10:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701974676; x=1702579476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXf2lAj8XDVwxOmvMwYO09ccy2NUDabGlY5Knm7jvKw=;
        b=csTXh3rMFTJhvJb/goSS2xFjOHdvRpHl/E9wUz/5twSHunuH2vjuythL8OssMn3tJZ
         nusyhB0pBjPy4MS5SRPN6ctKZRPlpWxUjGeMEueB8CTxhQEQZTB6QSWoYYJGzEw2ZCu4
         NdJrliLFFHagl3BJBwMNUANDtlxVDpUoT+jGlZL6YHgLr4azcKuucrOtiLXvRiovgfVz
         CagHFsmHxb00C5BrOcBhjYbazlchuAkcKKPa+CQfoTlTKXewa1VopR3fvmFTFNQ1GkZ7
         8z8vRHJD2lnGGwLaPHT8xKv3qiZziiFqqfMQwtifLgv6MCeDal8o32pwf/aV4k+vdpS2
         ZG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974676; x=1702579476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXf2lAj8XDVwxOmvMwYO09ccy2NUDabGlY5Knm7jvKw=;
        b=J/JPoqvnZn9NUpFKBrEn3BE25c9uuj9EmvkgYqC6Hsns0sdjGAQ80Zrru/meUEyh5r
         mzWCJVXhN2e3Ys/uZ2WkNy39lPZKOOGXoXEjME3h5rWxP6A3aFcAQv7lZltNEgA/4EXK
         oje1BgYJ1cGgiG+85InxKymRdSLiUQhL7qbPZ0+f1hPJOjvapzGe9TsYJx4G7gK1gza7
         yiVBNHKHHxbvO1Ey9ysE9fK5p/UpX0OgDivokuyUsU4+83ABknHirCrQVY2stSarRgIu
         SKrMugJ5bQmYGSmrlrszlWaGBEgEfrilYCEE2IBdRW3L/6t9dQWvQeR7IjaaJTBy1cQk
         ch3g==
X-Gm-Message-State: AOJu0Yy8vKUkK6MMur631Onrh4GeWv2UNJT9XyeVHUCaU2hop63HF798
	k+RQMCgbemkXdLnB9kbcRw==
X-Google-Smtp-Source: AGHT+IG8L55PCNrPucgL1/sFRpfhV8423aIsHP2Z6wo2jY09zJ7nIsTSpi7u44scNAUHxdQnF0wQYw==
X-Received: by 2002:a17:907:bb90:b0:a12:635d:fcd1 with SMTP id xo16-20020a170907bb9000b00a12635dfcd1mr1717463ejc.35.1701974675864;
        Thu, 07 Dec 2023 10:44:35 -0800 (PST)
Received: from p183 ([46.53.254.107])
        by smtp.gmail.com with ESMTPSA id tz4-20020a170907c78400b00a1aad4d92dbsm69623ejc.123.2023.12.07.10.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:44:35 -0800 (PST)
Date: Thu, 7 Dec 2023 21:44:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>, linux-mm@kvack.org
Subject: [PATCH v3] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <8582f7c9-b49d-4d21-8948-59d580e5317c@p183>
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
 <87v89dvuxg.fsf@oldenburg.str.redhat.com>
 <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>

Report available page shifts in arch independent manner, so that
userspace developers won't have to parse /proc/cpuinfo hunting
for arch specific strings.

Main users are supposed to be libhugetlbfs-like libraries which try
to abstract huge mappings across multiple architectures. Regular code
which queries hugepage support before using them benefits too because
it doesn't have to deal with descriptors and parsing sysfs hierarchies
while enjoying the simplicity and speed of getauxval(AT_PAGE_SHIFT_MASK).

Note!

This is strictly for userspace, if some page size is shutdown due
to kernel command line option or CPU bug workaround, than it must
not be reported in aux vector!

x86_64 machine with 1 GiB pages:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00

x86_64 machine with 2 MiB pages only:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00

AT_PAGESZ always reports one smallest page size which is not interesting.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v3: better comment and changelog
	v2: switch to page shifts, rename to ARCH_AT_PAGE_SHIFT_MASK

 arch/x86/include/asm/elf.h  |   12 ++++++++++++
 fs/binfmt_elf.c             |    3 +++
 include/uapi/linux/auxvec.h |   13 +++++++++++++
 3 files changed, 28 insertions(+)

--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -358,6 +358,18 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
 
 #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
 
+#define ARCH_AT_PAGE_SHIFT_MASK					\
+	do {							\
+		u32 val = 1 << 12;				\
+		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
+			val |= 1 << 21;				\
+		}						\
+		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
+			val |= 1 << 30;				\
+		}						\
+		NEW_AUX_ENT(AT_PAGE_SHIFT_MASK, val);		\
+	} while (0)
+
 #endif /* !CONFIG_X86_32 */
 
 #define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -240,6 +240,9 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 #endif
 	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
+#ifdef ARCH_AT_PAGE_SHIFT_MASK
+	ARCH_AT_PAGE_SHIFT_MASK;
+#endif
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,6 +33,19 @@
 #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
 #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
 
+/*
+ * All page sizes supported by CPU encoded as bitmask.
+ *
+ * Example: x86_64 system with pse, pdpe1gb /proc/cpuinfo flags
+ * reports 4 KiB, 2 MiB and 1 GiB page support.
+ *
+ *	$ LD_SHOW_AUXV=1 $(which true) | grep -e AT_PAGE_SHIFT_MASK
+ *	AT_PAGE_SHIFT_MASK: 0x40201000
+ *
+ * For 2^64 hugepage support please contact your Universe sales representative.
+ */
+#define AT_PAGE_SHIFT_MASK	29
+
 #define AT_EXECFN  31	/* filename of program */
 
 #ifndef AT_MINSIGSTKSZ

