Return-Path: <linux-arch+bounces-2292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C98530C5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414271C262D5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EF54667;
	Tue, 13 Feb 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9650BW9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B753805
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707828144; cv=none; b=DESDz+2E3Mftg0+YT7KDnPrpOL4D+duRzte6pSg6qL2PELl7hJgAxOhT6sFPNfLUb2CPvfJNhxJFUswY+1FXkGx4wOzQRD1nENYiJ5L2TO5UL7qBhLEvHcAmcLH6aKjJs+kBM6EDzsTDX14tjqkpZvbIvis2dIkhVMrMKAYqiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707828144; c=relaxed/simple;
	bh=oVU6VFoULzmc4tmrHb0t9imKrLlrN7N2PGEhiPIi8jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HYGrb9I9q9H+XB22+raW1JB6fffOW3mCADY2ULEAX7HFkNzd+lS1PSEwEHL7ASqlhmYZ14FE1KoB28pqxqWSaC0sQ7s+Evy3Hkk83OuIui5jzQ1UxTC6+/nnnAJ7hPri+wijhVYwveJo9mMaIbjMRbcZkq07kufj0BejMz8+2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9650BW9; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33ce2dca806so41421f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707828140; x=1708432940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FN139qBzPwhjMtuDTCrSTJijK28dahNsbuGrqs5W2w=;
        b=D9650BW9nvHJBvDG3w5z5agP99e1GyWoNebyRFm3n2zNwNNTGu7TqrlDK+6MUtiimv
         50xohzKBTPRzSusQNknYU52de9/GkPVFssgssRmwylYdxxuf/sqsmXhWC0EFePyRtPdE
         YV2XPNUqlhE+zrDaGhlmsOvpUAHdIbjJvhNHI4tCQMqPHUsPuLIYhbWk0Yn/3dKhuEJn
         +ylJpk/l2aVk+dXa+cycsFL7vmJiK0KzDCTKyz/qXyR4gSeyys8MVYhNJ/hXmspmyuJ4
         mhxotzHYJ7g1vKB+okIUvPuRExOh0AROXX/a3vBZ6eEhkmDKmrLjVZus2e/IrC93415U
         FIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707828140; x=1708432940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FN139qBzPwhjMtuDTCrSTJijK28dahNsbuGrqs5W2w=;
        b=kUi0rl0Pn+DoEaXPUvFYNbdJgbNBZyYKA2IFLDQ0B5pDMG6VAwkZcrAzNbjwPKzvWZ
         P6nkuV76zrUsP8XHtiOa4nmCqYYSBhPeGxlFyEls2c420U3O+6I7UeKB4OnQyWZvAUjc
         jxSs7mgN6s51ReUbOr8yRKT5WrvZ+sX4VOUXxS7A/OWDSNt2a1N/QNtWGXFdLsgG2m34
         jLXKO3fx93FdQA/xLBFdTqCZFVKR3OIou7Y5Q/B60H/S7dUU95YlxHWZuLk+N/L5F5QT
         e6yr/hz/EfhQcEX3qWJXtBtM9OaomYaTNVmAadcEdzVpulH18kkVGzbPvsm5Ng4W9ZEo
         oSUg==
X-Forwarded-Encrypted: i=1; AJvYcCXBL4Q8zFF2l3xDjYvIt4lTLpieXtySRbEatQUcqyR1FHzZLAuMx/bUvSFU9qMOKDih4YmruoK06PRN32H/a2SJSCqX3plt0J98hw==
X-Gm-Message-State: AOJu0YwkLImhASgtB3VwAhg/LQVDVpupPauM1m18RIAb/U6Hvqxwh0L7
	1Ur5Q5B1k48MiGgudcMTs5tKGdDCOnoIrhsXB5fDWWRp8yb6HNkcNjpkZ2BkvfGOfBfmQQ==
X-Google-Smtp-Source: AGHT+IH8KSJ1CiSR5fT2hDCx7McyG+cTe83z81N7Bxz7EjwTKQbiHUWS13YYuigjHx5OM1nzfDNvs+vT
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:314a:b0:411:c45a:3926 with SMTP id
 h10-20020a05600c314a00b00411c45a3926mr8396wmo.1.1707828139786; Tue, 13 Feb
 2024 04:42:19 -0800 (PST)
Date: Tue, 13 Feb 2024 13:41:52 +0100
In-Reply-To: <20240213124143.1484862-13-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6958; i=ardb@kernel.org;
 h=from:subject; bh=eogXneMNGSkhcOk/JligRmO4hko1csHM8X0odsNJfPM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfV08sT9Mq9jwnQj33kvK+1V0T2b9qdvVTGvDIu686KCs
 2dlypZ0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImsM2BkuP3m2rY5zR8F1V7L
 zPoSYH/o+LKd+g+vzHeZvmv7zxiJGdmMDB/5Eifo76v4l/zn0v7iHrcei5thvHeYdy98bS/52eg nHz8A
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213124143.1484862-21-ardb+git@google.com>
Subject: [PATCH v4 08/11] x86/boot: Move mem_encrypt= parsing to the decompressor
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The early SME/SEV code parses the command line very early, in order to
decide whether or not memory encryption should be enabled, which needs
to occur even before the initial page tables are created.

This is problematic for a number of reasons:
- this early code runs from the 1:1 mapping provided by the decompressor
  or firmware, which uses a different translation than the one assumed by
  the linker, and so the code needs to be built in a special way;
- parsing external input while the entire kernel image is still mapped
  writable is a bad idea in general, and really does not belong in
  security minded code;
- the current code ignores the built-in command line entirely (although
  this appears to be the case for the entire decompressor)

Given that the decompressor/EFI stub is an intrinsic part of the x86
bootable kernel image, move the command line parsing there and out of
the core kernel. This removes the need to build lib/cmdline.o in a
special way, or to use RIP-relative LEA instructions in inline asm
blocks.

This involves a new xloadflag in the setup header to indicate
that mem_encrypt=on appeared on the kernel command line.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c         | 15 +++++++++
 arch/x86/include/uapi/asm/bootparam.h   |  1 +
 arch/x86/lib/Makefile                   | 13 --------
 arch/x86/mm/mem_encrypt_identity.c      | 32 ++------------------
 drivers/firmware/efi/libstub/x86-stub.c |  3 ++
 5 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..6c5c190a4d86 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -357,6 +357,19 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 	return entry;
 }
 
+/*
+ * Set the memory encryption xloadflag based on the mem_encrypt= command line
+ * parameter, if provided.
+ */
+static void parse_mem_encrypt(struct setup_header *hdr)
+{
+	int on = cmdline_find_option_bool("mem_encrypt=on");
+	int off = cmdline_find_option_bool("mem_encrypt=off");
+
+	if (on > off)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -387,6 +400,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
+	parse_mem_encrypt(&boot_params_ptr->hdr);
+
 	sanitize_boot_params(boot_params_ptr);
 
 	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..eeea058cf602 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -38,6 +38,7 @@
 #define XLF_EFI_KEXEC			(1<<4)
 #define XLF_5LEVEL			(1<<5)
 #define XLF_5LEVEL_ENABLED		(1<<6)
+#define XLF_MEM_ENCRYPTION		(1<<7)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e7b613..f0dae4fb6d07 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -14,19 +14,6 @@ ifdef CONFIG_KCSAN
 CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
 endif
 
-# Early boot use of cmdline; don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
-KCOV_INSTRUMENT_cmdline.o := n
-KASAN_SANITIZE_cmdline.o  := n
-KCSAN_SANITIZE_cmdline.o  := n
-
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_cmdline.o = -pg
-endif
-
-CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
-endif
-
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/arch/x86/lib/x86-opcode-map.txt
 quiet_cmd_inat_tables = GEN     $@
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 0166ab1780cc..d210c7fc8fa2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -43,7 +43,6 @@
 
 #include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/sev.h>
 
@@ -95,9 +94,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -504,11 +500,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	char buffer[16];
 	bool snp;
 	u64 msr;
 
@@ -551,6 +545,9 @@ void __init sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
+			return;
+
 		/*
 		 * No SME if Hypervisor bit is set. This check is here to
 		 * prevent a guest from trying to enable SME. For running as a
@@ -570,31 +567,8 @@ void __init sme_enable(struct boot_params *bp)
 		msr = __rdmsr(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
-	} else {
-		/* SEV state cannot be controlled by a command line option */
-		goto out;
 	}
 
-	/*
-	 * Fixups have not been applied to phys_base yet and we're running
-	 * identity mapped, so we must obtain the address to the SME command
-	 * line argument data using rip-relative addressing.
-	 */
-	asm ("lea sme_cmdline_arg(%%rip), %0"
-	     : "=r" (cmdline_arg)
-	     : "p" (sme_cmdline_arg));
-	asm ("lea sme_cmdline_on(%%rip), %0"
-	     : "=r" (cmdline_on)
-	     : "p" (sme_cmdline_on));
-
-	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
-				     ((u64)bp->ext_cmd_line_ptr << 32));
-
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
-	    strncmp(buffer, cmdline_on, sizeof(buffer)))
-		return;
-
-out:
 	RIP_REL_REF(sme_me_mask) = me_mask;
 	physical_mask &= ~me_mask;
 	cc_vendor = CC_VENDOR_AMD;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..9a25ec16b344 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -879,6 +879,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+	if (efi_mem_encrypt > 0)
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+
 	status = efi_decompress_kernel(&kernel_entry);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
-- 
2.43.0.687.g38aa6559b0-goog


