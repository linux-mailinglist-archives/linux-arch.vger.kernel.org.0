Return-Path: <linux-arch+bounces-2087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044F849705
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 10:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E921C20C3E
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF6A134B1;
	Mon,  5 Feb 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ5xTNij"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588F13AC8;
	Mon,  5 Feb 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126710; cv=none; b=SFpm7qsP9k9gkwNxxD/2vjoGOnzXOpIax/788bhbbk7SVagyGJ8uejFZ2bKyLHE3drcXLdLK0TL0vNMS1zOKUqku525XYSiSiqj8WHd4R3C6IqS9J6VtdQ+i/56fp52ouIGf0EhTo4k2mQXO/UU2G0HqMntjSx0RFLub7MGSX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126710; c=relaxed/simple;
	bh=jWRt49ILlS5VT3W+LLHU0Hhs3n557Q/ZgSd9czq32FE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KcB3O7X2/VBJ0ABM9BSi3JR0M8zTSW+AkuyzeX2XuCqsIWJSwUpKF2eVpPY8RAw2ri+skeC3RX6AXO6+MF0SyxF7yTSayjroYeqiihLC+s4/IaNbBs2t0m6LbK6dzhHgj/M5zTg8vjjTLYSTJZpsEL7inXPggeZRKJGPYPDKf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQ5xTNij; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51121637524so6302134e87.1;
        Mon, 05 Feb 2024 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126706; x=1707731506; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9QP8sLSXFD8c0XIiwWaagxTqni0W8MyH2JGoDbixps=;
        b=UQ5xTNijIftTMD7yzP0NzqR05NVNS+V7ww7B9TiNcwLOimBbkOgfa4XQFgrxDpN77H
         cUG39QAu4Bimbri7+GlyKeCykFEiNRLRUSDIIzxKqzn2jYVEVV5v1ZJQWfoa4vAbqjYF
         ZRKGNovdybtIfPJXEkLn0wBe+AGShBIeAlmhjXRRB+D/lrwIbbyr7ANXsk5zOGbcqHNV
         2MSq2UW6x9R+TNUpZJ2L2pZ+V8zgChBpohzn9vDSdTHVOSnwTEvVUNL/9A6zqgj5Qoc7
         q/KACE8wO7ND4JnN5FqbMqGysJGn8alAoHjLiEqaM/TPJgi5iUU/9SbGNyw/wbAml/3J
         lL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126706; x=1707731506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9QP8sLSXFD8c0XIiwWaagxTqni0W8MyH2JGoDbixps=;
        b=qDqZjLJ6nLgke6KXVJVn/VNfp8Fo0PD6Ii2pyX1xEgztBDopaUgxBz7kVs20ZCnFZW
         LdFNw6eRaKQKlqP2m6/WGPr3is+p470vPY90oENW+MSJqzmgp9rcL2vgQ3+TPBD+ON7u
         X0rtIv0VgE498X7tK2sP4zdbpZ5HgMYmNtK64VDHjwoK+hScTa9idpNK/KnZUiayGl3B
         d4zM69icQk9mYfvO2p3FtArHneJ6mEqpODMWr3tKRj9xpLiGKe6xkhwePGFPgySq/Lyv
         lZV6u07QxPXsdv6LODHHraJPjYZwrIlsX24JSWZx5+GnRe6CKrga2i8v6lOT5m7E9kCh
         26fQ==
X-Gm-Message-State: AOJu0YxrZXCwa1QX/SnA/lq4BaS8zTN7opYAGZex/qUeFKXTMUSUPxJh
	WD096Ty4ObahyyuEKnuWrQbSZ70IJqtOvl5y09oV0OW9HvZVpfewNcExZki8SA==
X-Google-Smtp-Source: AGHT+IG3u5ggjEsSDL7MT/pLmzTNV8XHvX4QEZsaL47FKIg0HYDLm9WmIXoLP32VEFxp4cl1PLFfoA==
X-Received: by 2002:a05:6512:5d2:b0:511:5026:abac with SMTP id o18-20020a05651205d200b005115026abacmr1291306lfo.52.1707126705874;
        Mon, 05 Feb 2024 01:51:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUfK2Xe0hei/qlHWOhySOhXm8UOa1jMRN0nvZP1IMVWQZ+EiUbp68D9txmHhcU/GAZZViUL4kEKBwvXVZGSpZze26FNr3hvcaZX2ZCye3pCe88m1gCZW7nEdAEPdlsZCFdomMV08jNIi0QhqcEXPNoQc/Lu9alGlDQiiNlUpz4JUCtzY7IEhy2N0kIDCdUEPCxhOJwUoRoaRSafBAyRQRy7AZvjTqCTqIJwu83eTTJV39uxKKJygWeZZ5gph+49GEBQGlOrcSDMCD1IfkOf0UIMkz3xPM0urMt2smjjibA6GHxIOQB59iDX37JXaFbahvm31Jp451YkUq5WmhOFeoCH0xRwQUfrkgZdDoyhIzbrLYaggghrff6dMOzx+pkz4M/uLiTOExRqsf2G
Received: from p183 ([46.53.250.163])
        by smtp.gmail.com with ESMTPSA id iv15-20020a05600c548f00b0040e9d507424sm8072628wmb.5.2024.02.05.01.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:51:45 -0800 (PST)
Date: Mon, 5 Feb 2024 12:51:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
	linux-mm@kvack.org
Subject: [PATCH v4] ELF: AT_PAGE_SHIFT_MASK -- supply userspace with
 available page shifts
Message-ID: <ecb049aa-bcac-45c7-bbb1-4612d094935a@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Report available page shifts in arch independent manner, so that
userspace developers won't have to parse /proc/cpuinfo hunting
for arch specific strings.

Main users are supposed to be libhugetlbfs-like libraries which try
to abstract huge mappings across multiple architectures. Regular code
which queries hugepage support before using them benefits too because
it doesn't have to deal with descriptors and parsing sysfs hierarchies
while enjoying the simplicity and speed of getauxval(3).

Note 1!

This is strictly for userspace, if some page size is shutdown due
to kernel command line option or CPU bug workaround, than it must
not be reported in aux vector!

Note 2!

getauxval(AT_PAGE_SHIFT_MASK) output is a function of CPU capabilities
only, it is not changed by system memory size, hugepage availability at
any given moment, hugetlbfs being mounted, etc.

Example output:

x86_64 machine with 1 GiB pages:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 40 00 00 00 00

x86_64 machine with 2 MiB pages only:

	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  00 10 20 00 00 00 00 00

AT_PAGESZ always reports one smallest page size which is not interesting.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	changes since v3 -- even better changelog

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

