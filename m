Return-Path: <linux-arch+bounces-1779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AE384119E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D031C230F1
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A3476021;
	Mon, 29 Jan 2024 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4paj4/2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A26F06F
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551537; cv=none; b=H2arj8aoK9wCqMjJrE/P72eQqe1EazeyQh6nfBiErCEn1bdMJhG9THsePEK4R2DSKN8tgNGgSKQGqLtZNWk7+gaMPz/DrO6tCDOFWgIX/4x0ooQW3fj28Y707lzVmKkjLkOoePkjhjVzxlAB7Gda+qFoauwTFn6s621dSNDQSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551537; c=relaxed/simple;
	bh=HFn1spOv4KPR4R1zHjTL4BDpzlPynxVt+ZjcueLDXCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fcJifqhrxwBG82nq4GiG8yBFcuwoX1pwy+qSi6MxZXTIQrMssttpcSrP5tcTQZOc27CsNm9HdFnZ6lMIRog+3/savqjqFwshhE918/8le7o/8Pqv+PUuULyjdW2g04yS1lnIVNmJwt+VIjIH7pchjWF8VUJ/u1GVSnknndSVdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4paj4/2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff93902762so55570287b3.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551533; x=1707156333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3FWGTV10qie8rRiz9nelg+HW9vFOvPrRVG9vffZcTs=;
        b=g4paj4/287fNNvwYS7k+HS4qAaVswZNsu8T+4cLZSy+eXyl6tD/ouoK2Wslz4zIX/m
         KBU8+2MLvR5WGs25D+LZ6xTtUWnHlKt54Xp1ELBSJKyQiziiMoWi7Ybi3Y5hSGr7vh44
         m2yTCoTwZ0LVLM9uEfgM45GyIoYkj0s6e4wURlotgBff5NfWo5b6RakFS1OV+RqViXFU
         uOmx1wLzQtZiuD5Q5zRr+JATpaq2jnXNnzxA9VQfCWsGaT6ejCZ6a0KQurR66r1skaRa
         OirpC0RIU3yegLWVK+yZT7tXuwsWWvrIPtVxcxtYmwCPB8/ZMfj9yv5p2eh8+3nEwK9P
         ecyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551533; x=1707156333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3FWGTV10qie8rRiz9nelg+HW9vFOvPrRVG9vffZcTs=;
        b=pByZiPvPhVjdg5b2dbyYuNffrGypAOM53fOe+pnVF89Og4+m0OBPo7JHaZZAHoKAuD
         OV8bZXv3Lu+HkG+BWVAjYIcIBiczOeNISxP1hq9ka7cUgutaL5sBvVyIeSC3GHsfx32t
         mPB0+78/wnVIcakfkxpC/RseRUrRCTbE/ZUFi969FS8fqwfIrDeNUCN07gavijg/e5pY
         7h2OCG/pd9w1F1o054L/0YVOZGt6uRkMnrD8d6/4I/DOAAExVXHe6Ih7QbjhP41lxUtc
         JWeqprUwx9iTmhbCag80ymAsXRyViZbC9KksSvwgawJVC/KIrSebLR4V39sFsMOxMANV
         KYBA==
X-Gm-Message-State: AOJu0YxxupSbmsEQ4AJSvUech2DNJI6j9q4UqUjrxo+rhdMD4KxqehFK
	7lB5n++4cOVJfel9jghw7BPiurtIf9EoMl+ZQdBNT3vpC08roGIymhMR7ceDhQffhwVTeg==
X-Google-Smtp-Source: AGHT+IGVcq2pXpU6LfBnSbe3eFllbMwA7mlv7HhvFLN60TO62ZHJfEf419ADavLY79oFrfTS/Z1//fuD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:ed4:b0:5d8:4274:bae2 with SMTP id
 cs20-20020a05690c0ed400b005d84274bae2mr2074182ywb.6.1706551533566; Mon, 29
 Jan 2024 10:05:33 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:05 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7925; i=ardb@kernel.org;
 h=from:subject; bh=M0vxsf0gTqIKMZpFhFJ2BBWB91v5R63xIeoeRQ3uSVE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i4vMAZebr19uPjtNTGWy4aWMzFNMrYUL3pafZBPbu
 /6AHf+KjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRHYUM/0zmcif/jDiQ3vfl
 ukmjmedu7Q9+7mufCvEZl7/vklXvs2D4Z7mhl60oe8btsotvDwd9qtTNC7TYFrvMi1F2Z/gmS/V oNgA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-23-ardb+git@google.com>
Subject: [PATCH v3 02/19] x86/boot: Move mem_encrypt= parsing to the decompressor
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

This involves a pair of new xloadflags in the setup header to indicate
that a) mem_encrypt= was provided, and b) whether it was set to on or
off. What this actually means in terms of default behavior when the
command line parameter is omitted is left up to the existing logic -
this permits the same flags to be reused if the need arises.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c         | 22 ++++++++++
 arch/x86/include/uapi/asm/bootparam.h   |  2 +
 arch/x86/lib/Makefile                   | 13 ------
 arch/x86/mm/mem_encrypt_identity.c      | 45 +++-----------------
 drivers/firmware/efi/libstub/x86-stub.c |  6 +++
 5 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b99e08e6815b..d63a2dc7d0b1 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -357,6 +357,26 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 	return entry;
 }
 
+/*
+ * Set the memory encryption xloadflag based on the mem_encrypt= command line
+ * parameter, if provided. If not, the consumer of the flag decides what the
+ * default behavior should be.
+ */
+static void set_mem_encrypt_flag(struct setup_header *hdr)
+{
+	hdr->xloadflags &= ~(XLF_MEM_ENCRYPTION | XLF_MEM_ENCRYPTION_ENABLED);
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT)) {
+		int on = cmdline_find_option_bool("mem_encrypt=on");
+		int off = cmdline_find_option_bool("mem_encrypt=off");
+
+		if (on || off)
+			hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+		if (on > off)
+			hdr->xloadflags |= XLF_MEM_ENCRYPTION_ENABLED;
+	}
+}
+
 /*
  * The compressed kernel image (ZO), has been moved so that its position
  * is against the end of the buffer used to hold the uncompressed kernel
@@ -387,6 +407,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
+	set_mem_encrypt_flag(&boot_params_ptr->hdr);
+
 	sanitize_boot_params(boot_params_ptr);
 
 	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..316784e17d38 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -38,6 +38,8 @@
 #define XLF_EFI_KEXEC			(1<<4)
 #define XLF_5LEVEL			(1<<5)
 #define XLF_5LEVEL_ENABLED		(1<<6)
+#define XLF_MEM_ENCRYPTION		(1<<7)
+#define XLF_MEM_ENCRYPTION_ENABLED	(1<<8)
 
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
index 7f72472a34d6..06466f6d5966 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -43,7 +43,6 @@
 
 #include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/sev.h>
 
@@ -95,10 +94,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-static char sme_cmdline_off[] __initdata = "off";
-
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -504,11 +499,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __init sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	char buffer[16];
 	bool snp;
 	u64 msr;
 
@@ -570,42 +563,18 @@ void __init sme_enable(struct boot_params *bp)
 		msr = __rdmsr(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
+
+		if (bp->hdr.xloadflags & XLF_MEM_ENCRYPTION) {
+			if (bp->hdr.xloadflags & XLF_MEM_ENCRYPTION_ENABLED)
+				sme_me_mask = me_mask;
+		} else if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT)) {
+			sme_me_mask = me_mask;
+		}
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
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
-	asm ("lea sme_cmdline_off(%%rip), %0"
-	     : "=r" (cmdline_off)
-	     : "p" (sme_cmdline_off));
-
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		sme_me_mask = me_mask;
-
-	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
-				     ((u64)bp->ext_cmd_line_ptr << 32));
-
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		goto out;
-
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
-		sme_me_mask = 0;
-
-out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
 		cc_vendor = CC_VENDOR_AMD;
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..66e336cca0cc 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -879,6 +879,12 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_ARCH_HAS_MEM_ENCRYPT) && efi_mem_encrypt) {
+		hdr->xloadflags |= XLF_MEM_ENCRYPTION;
+		if (efi_mem_encrypt > 0)
+			hdr->xloadflags |= XLF_MEM_ENCRYPTION_ENABLED;
+	}
+
 	status = efi_decompress_kernel(&kernel_entry);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to decompress kernel\n");
-- 
2.43.0.429.g432eaa2c6b-goog


