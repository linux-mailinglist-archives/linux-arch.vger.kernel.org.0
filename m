Return-Path: <linux-arch+bounces-2573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60B85D72F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E01284F70
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8F4F1EE;
	Wed, 21 Feb 2024 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2K7H1zwZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3D4653C
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515368; cv=none; b=IXXAroQWFArtitgPID6bIPyKb1/K83isAMrZnLJDNuygV4LiVBYZmQ3wd8l93DmZH/4Kvy/s6/bGglUrHK1Eh9nTEnmaZ0FzL+PdH5miWvxemO9Ovkn7LDNUhop8fyMaAuITFVDOL3eUoNBY9xgwFDL4CpMEAD9/MN1HEEVJIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515368; c=relaxed/simple;
	bh=S4NGlxmVOhrQxFAGepaTMi748KWyZv6XTKqvhleJQH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FJE6LI/C/1sikmKRhot1ic9JJN0NKQ2e57LQU3nR6HiRQUdT8YAepNpXc6AKwvc5xGu6wYQNTiYEpyRSVn77zCzM/R9xldd5Goy9cddpIWX7SPkr382f4rQS6hE61sbHqmE78NlGRzsJR9cVZ2QNLLUeqSeQsr/JgUd9+89PIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2K7H1zwZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd703b721dso8062396276.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515365; x=1709120165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDNgWt2lMCvtDV/Eee3l1XVOGlo7HH2KTDyTgOKacbQ=;
        b=2K7H1zwZl0vFaFPvHMejHvtynLCkQpNjp3UKFPJZAcQLBNUk6me4SvoKFC4msMmEaq
         QnpHyx4Q9PhD+VU4ekPAO4X4oGIvKS2Rhh1I8vO+op/tVD6VvIfcK0F8QIcyKs2bseqv
         UQsYM+iIzmye5YgZJ8Fa2VxgACLA+Fq3furFBNvNX5tjS5AhQcDCccmJBdjWUwsY8gWe
         jyqxqequwv708IZ0ABe3lL6PDuqbuHDHaQUC1mNTfGb7WrqxLIDHwcs1R5uzKTTjwIDk
         oY9rC+eZeBFdywZfKfuxFDZ5pXd1q9lbOOgvweN5R3gBS4l+bNTPs4WdBKC04XyVREXP
         f6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515365; x=1709120165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDNgWt2lMCvtDV/Eee3l1XVOGlo7HH2KTDyTgOKacbQ=;
        b=K/MciYgV/xLBlj9MSKrGATuG4Z/O85pEHLdqfu2IlwQokymwNXmL/3fDVnYXHscJe2
         YJO2lADRaU1fq8qw5hxDVMjuVfriZajSHIL19iI+X4fj9ieNH6sKJaBzyh6JfaY0nZvL
         JWYDz429PCGnKqOKpGS5SeaBzW8jENI+0JnrsdvmO538t065vScsOCDbK0blW70CAIeR
         f12+nx3vVUJgt0g1v7jHYVcOk4IcWSRDxbEKoeVEE0cHnQmXiM0EwxAEfLlCNOqfd/qY
         gumyl9B7T2rQydwE3df/bH0WrvEmYNTUPnmtJlyKdyngSSXjECtDOP9Y9cVmhjx02+Dc
         zoxg==
X-Forwarded-Encrypted: i=1; AJvYcCVPPjff4bNPSJut6wJE85C7XjYEcHX2H88w1Hqw6Jllt1UMIvi9nF9f4tsdupWXf45sYlBA6IRGpK7RVdZrTgu1wu7ZED6TCAo87A==
X-Gm-Message-State: AOJu0YyiwSX93n19lMrRto/LDJvBZnCeErlcOC5FVOGQAbbUFyQ3dwsN
	lQdHLEDWFcetSfqG2KQtmUGzW/QWrITnhJGh9QxUJdxB37sMBFxK/UyMA6W6Lw3jVxaaUg==
X-Google-Smtp-Source: AGHT+IFhpgIhEs1BafVqx8hBrbXu8CGHvJj+vLnI/OyC/WbrQpMf4RUpSxtl9/ueDS8OO3okKbO6rzXC
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1887:b0:dc2:2ace:860 with SMTP id
 cj7-20020a056902188700b00dc22ace0860mr1032065ybb.2.1708515365485; Wed, 21 Feb
 2024 03:36:05 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:20 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7014; i=ardb@kernel.org;
 h=from:subject; bh=oEjbaEakolZKtY3/OEd7gfiAzx2qVYvdQU90/PQTOX8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/S+hVVb/nl/wOGHDrbkl6L3ogmRx+xl7VtflzZl9w
 MeTPedVRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI08+MDM2+pjLOKhaPn23+
 vvn/+rBYbvHl1ddYdgu4yZ2MOD1fZC7Db1bvuq+H0+5u/XZwi+wn3u/3lEuvn9p5VYfP68zHM77 ZPcwA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-31-ardb+git@google.com>
Subject: [PATCH v5 13/16] x86/boot: Move mem_encrypt= parsing to the decompressor
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
index 7ddcf960e92a..0180fbbcc940 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -43,7 +43,6 @@
 
 #include <asm/setup.h>
 #include <asm/sections.h>
-#include <asm/cmdline.h>
 #include <asm/coco.h>
 #include <asm/init.h>
 #include <asm/sev.h>
@@ -96,9 +95,6 @@ struct sme_populate_pgd_data {
  */
 static char sme_workarea[2 * PMD_SIZE] __section(".init.scratch");
 
-static char sme_cmdline_arg[] __initdata = "mem_encrypt";
-static char sme_cmdline_on[]  __initdata = "on";
-
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -505,11 +501,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 
 void __head sme_enable(struct boot_params *bp)
 {
-	const char *cmdline_ptr, *cmdline_arg, *cmdline_on;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	char buffer[16];
 	u64 msr;
 
 	/* Check for the SME/SEV support leaf */
@@ -549,6 +543,9 @@ void __head sme_enable(struct boot_params *bp)
 
 	/* Check if memory encryption is enabled */
 	if (feature_mask == AMD_SME_BIT) {
+		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
+			return;
+
 		/*
 		 * No SME if Hypervisor bit is set. This check is here to
 		 * prevent a guest from trying to enable SME. For running as a
@@ -568,31 +565,8 @@ void __head sme_enable(struct boot_params *bp)
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
2.44.0.rc0.258.g7320e95886-goog


