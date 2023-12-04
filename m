Return-Path: <linux-arch+bounces-644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E548803B42
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F96E1C20A21
	for <lists+linux-arch@lfdr.de>; Mon,  4 Dec 2023 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946792E643;
	Mon,  4 Dec 2023 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m02aiGjI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A518C0;
	Mon,  4 Dec 2023 09:18:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fa2714e828so632886466b.1;
        Mon, 04 Dec 2023 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701710331; x=1702315131; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zq81Lz5INITag9UbS+znegk7+9XIHocUg1TbRaMZkAk=;
        b=m02aiGjIVLNYmw2pj7cd4wMIasYwKr/ygVALB14fZNewUyNAlwJKEgIcLXPM7Y+hy1
         Q8M5fom1xHivTzsgN4NcbB4uewTFawQqhUv0LRpVTnGLAunF55p++SwHvs5PIohg92hb
         Bn4BvSyoH9V10mYWHHk1QLInLsy8tlHc/kOQIqH5zfnaDEGsAtQB/SlEYXF38psNhzYP
         OzqaYY6qoBLKfDZrnfPVugFzYRJiV7qwM/+1BIF4wGJyBUqs98xespQnwnSp6NnNWpwy
         kFjya+5mDwabo4LF4dwVG6t7RRQQ6mrWDrzouuHZ7gqlQQNdOuCxn5Z8ZxwlQYYO0gxE
         hLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710331; x=1702315131;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq81Lz5INITag9UbS+znegk7+9XIHocUg1TbRaMZkAk=;
        b=FTbR1GDLTO9jZufvSTDJgx3x5ApSXuK07VAghDNgZxzlHr8gMFx39Wk8QJyMAOLQil
         PlAuZ7dtIScoWhr5xdGFrJyzSiInsA+OBhKHFBK/PGnsXVNWRp3eJ2J5SLfwU3xPdi5X
         H5n1Elx70Fv8krqLF2vA11emCVPNKzEeozTCqzI5FM5se3iUfpb7ZAr2H2+QN3kv3Qj0
         McUbhXQht5XMh+6O1qbBtJT6rAS+4iwA+ohCCLAda4nMhSw49kpKwe48eIWFps9PNgtE
         N3mrBTuH8+yl2dU2/1Y6bsvbkusdLZCpnU2EvOitO5y+u5hl1g12R9kmvhXiWNpqt+Fp
         wp9w==
X-Gm-Message-State: AOJu0Yw/upJhrSuOjSJt1AUtSSuSoyqByTbWxQOchUrL8U8boGC56cHq
	WGXMp6UTvcjt8Mc7+k8weQ==
X-Google-Smtp-Source: AGHT+IEWjUa35ZWQonlJodnSjs/Bt2TrOHFtYeRbA7EG3l3atTmCqN/lsFPouXw6gMfQrq+Mv3QdkA==
X-Received: by 2002:a17:906:fa0d:b0:a19:a19b:55d1 with SMTP id lo13-20020a170906fa0d00b00a19a19b55d1mr3094547ejb.97.1701710330893;
        Mon, 04 Dec 2023 09:18:50 -0800 (PST)
Received: from p183 ([46.53.253.246])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b009fe1d575365sm5481589ejq.55.2023.12.04.09.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 09:18:50 -0800 (PST)
Date: Mon, 4 Dec 2023 20:18:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_LIST)
Message-ID: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Report available page shifts in arch independent manner, so that poor
userspace developers won't have to parse /proc/cpuinfo hunting for
arch-specific flag strings:

	unsigned long val = getauxval(AT_PAGE_SHIFT_LIST);
	while (val && (val & 255) != 30) {
		val >>= 8;
	}
	if (val) {
		page_size_1gib = true;
	} else {
		page_size_1gib = false;
	}

Note!

This is strictly for userspace, if some page size is shutdown due
to kernel command line option or CPU bug workaround, than is must not
be reported in aux vector!

x86_64 machine with 1 GiB pages:

	$ hexdump -C /proc/self/auxv
	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  0c 15 1e 00 00 00 00 00

x86_64 machine with 2MiB pages only:

	$ hexdump -C /proc/self/auxv
	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
	00000040  1d 00 00 00 00 00 00 00  0c 15 00 00 00 00 00 00

AT_PAGESZ is always 4096 which is not much information.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/include/asm/elf.h  |   13 +++++++++++++
 fs/binfmt_elf.c             |    3 +++
 include/uapi/linux/auxvec.h |   17 +++++++++++++++++
 3 files changed, 33 insertions(+)

--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -358,6 +358,19 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
 
 #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
 
+#define ARCH_AT_PAGE_SHIFT_LIST					\
+	do {							\
+		u32 val = 12;					\
+		int s = 0;					\
+		if (boot_cpu_has(X86_FEATURE_PSE)) {		\
+			val |= 21 << (s += 8);			\
+		}						\
+		if (boot_cpu_has(X86_FEATURE_GBPAGES)) {	\
+			val |= 30 << (s += 8);			\
+		}						\
+		NEW_AUX_ENT(AT_PAGE_SHIFT_LIST, val);		\
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
+#ifdef ARCH_AT_PAGE_SHIFT_LIST
+	ARCH_AT_PAGE_SHIFT_LIST;
+#endif
 	NEW_AUX_ENT(AT_CLKTCK, CLOCKS_PER_SEC);
 	NEW_AUX_ENT(AT_PHDR, phdr_addr);
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
--- a/include/uapi/linux/auxvec.h
+++ b/include/uapi/linux/auxvec.h
@@ -33,6 +33,23 @@
 #define AT_RSEQ_FEATURE_SIZE	27	/* rseq supported feature size */
 #define AT_RSEQ_ALIGN		28	/* rseq allocation alignment */
 
+/*
+ * Page sizes available for mmap(2) encoded as 1 page shift per byte in
+ * increasing order.
+ *
+ * Thus 32-bit systems get 4 shifts, 64-bit systems get 8 shifts tops.
+ *
+ * Example:
+ * x86_64 system with "pdpe1gb" reports 4 KiB, 2 MiB and 1 GiB page support.
+ *
+ *	$ hexdump -C /proc/self/auxv
+ *	00000030  06 00 00 00 00 00 00 00  00 10 00 00 00 00 00 00
+ *	00000040  1d 00 00 00 00 00 00 00  0c 15 1e 00 00 00 00 00
+ *
+ * For 2^256 hugepage support please contact your Universe sales representative.
+ */
+#define AT_PAGE_SHIFT_LIST	29
+
 #define AT_EXECFN  31	/* filename of program */
 
 #ifndef AT_MINSIGSTKSZ

