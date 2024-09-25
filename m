Return-Path: <linux-arch+bounces-7425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB698633D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834ED1F21C54
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29819F431;
	Wed, 25 Sep 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0NPhHKb/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944919E7D8
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276582; cv=none; b=UQ2ilG7dAeNDTdvecrJyKZNzdPSXdVe3LQzjH+OTcfEuepm4NGp2JE9Btq+dzgSY3nY95pvGnHXpaON1G6GL04zrem6+GJjtGPyR1zDY6+zd8IbLrfMKrlgCioxA0a+hAfAWSDKut19yl/7kaZPzJ1CGA5dPzbVbYL+Z0e5NLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276582; c=relaxed/simple;
	bh=uKiTAUlG9Mzz44mB3boSUKqgle05lQ6M72q35xSoV8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8sxy6rCCwaG9AMd45JLoqSebkNPxAoTAiuDPlK+tLsqYVN1RFeOu/H83JrGH0QvzfU0kR3Tjiy5FWwwo7mMk/g4b5AKl1NSWwY/8yjbjZr7uZpZdmsG1PrQBcDyXuPf8DHZ3Fa3bSOMGg20Sc3wk//GtymVMaYW5UFIFayNoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0NPhHKb/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1cfb9d655eso9910738276.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276579; x=1727881379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IM+8uvbpUOTrNblc27FtujIjdoMKE18YT3ThvhmVkQ=;
        b=0NPhHKb/cB/kfABblGRV87mUbtOZiQ23xWBDVA4HKp3uVw/kISmKVdEXt12DJP8dql
         ut/iLHxjOOdNKfnlTVxEX5MLgMxy5HYPkt3YCbypmOPElZsYPLhriYBBnUdBnGxOBEO5
         1oAoWwxxAE2VIhc/CbQQ+GEasKU102YSFcTts6c/dTqRKr+dxqDcOTdnYLkU4sKTVeVo
         y+Sr/Tc0sbK7/dKsfaelzVw9bAg383vIObPIgncNdAnX+C0dZIILFIYQHFI+2v+8egWi
         YR7Cup7w/rNQGSyVrAEd6v5/sAVknsYO8d3RTlxQxOQ0SnAW85zzNVb9wt5CwXgx0tOY
         J3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276579; x=1727881379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IM+8uvbpUOTrNblc27FtujIjdoMKE18YT3ThvhmVkQ=;
        b=VeN19XPd2dqV9lhO6kd2RaTDNt/xsdGCSr4KugT1Wmy8oyg08auG9r8PxwaSqMAWqh
         AcaO+OGmoFZw3acpUNHipAWKdLxCQm+uFgoAfkjekNHUZklPPFF3NKaCyhlBa7g8adVi
         DI5F24lwD0WufGl3YjRKke1d3v+Q2p6IFRM1fp+qeGtJaaNNNGv5zjzalzflGFXzpOZl
         1E3Dd5QSaQqTJtokFokQ48HFaIH77TdurFzeBYV1VHhRjWs5z+Rx7Ty4aYIDlX1t8hDp
         QbcVXJgs77Ty9yBZQH58HKdy0qTpUtcRBAZEjb9/0OIgXuIIw0xtBq/mrEbVwsk0je4U
         S8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/lpnxTkzmr0uTxxKh0M+j+EcSQnZL1Am3tHFNhonz5sc/IFWiRrTOJt1pTC+ySwwOibMwjqetEflY@vger.kernel.org
X-Gm-Message-State: AOJu0YyCErw7VAS9+gzrrerheiBjoUZczyyNmuhZWV19Z2diy4AnHfsJ
	3Y00k7sNmULPj2CRKE79c3hePu0njPo7OUOezwtVXDGOJjC7k+2IjZBzn9UsYPOzqM009A==
X-Google-Smtp-Source: AGHT+IHCtqA+oNLQfmXqpM//kOUUkVuRiayEu9UAQA8X933VnnJ2JGMGIKXjp5QscVvSLG685e3KtDKL
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:1782:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e24da39b0c3mr17940276.10.1727276578847; Wed, 25 Sep 2024
 08:02:58 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:27 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4280; i=ardb@kernel.org;
 h=from:subject; bh=Qfoxr/CYN1brA02vZLn1djUOVE7sfU2DhAxM/gB47SE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6qUIX51znF3nJyzZfmoB13+eT2d+37/IY95y8cys2
 5n+JYzJHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAifvYMv5jZZ0me+ya2VVnU
 Ozku0cJESLKOW+VHtMSKvW8vdx2dKMfIsJzzq0hJkqFDXdOunnmqwir812MtQuf0H13yi9n0fe8 DLgA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-57-ardb+git@google.com>
Subject: [RFC PATCH 27/28] x86/kernel: Switch to PIE linking for the core kernel
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Build the kernel as a Position Independent Executable (PIE). This
results in more efficient relocation processing for the virtual
displacement of the kernel (for KASLR). More importantly, it instructs
the linker to generate what is actually needed (a program that can be
moved around in memory before execution), which is better than having to
rely on the linker to create a position dependent binary that happens to
tolerate being moved around after poking it in exactly the right manner.

Note that this means that all codegen should be compatible with PIE,
including Rust objects, so this needs to switch to the small code model
with the PIE relocation model as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                        |  2 +-
 arch/x86/Makefile                       | 11 +++++++----
 arch/x86/boot/compressed/misc.c         |  2 ++
 arch/x86/kernel/vmlinux.lds.S           |  5 +++++
 drivers/firmware/efi/libstub/x86-stub.c |  2 ++
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 54cb1f14218b..dbb4d284b0e1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2187,7 +2187,7 @@ config RANDOMIZE_BASE
 # Relocation on x86 needs some additional build support
 config X86_NEED_RELOCS
 	def_bool y
-	depends on RANDOMIZE_BASE || (X86_32 && RELOCATABLE)
+	depends on X86_32 && RELOCATABLE
 
 config PHYSICAL_ALIGN
 	hex "Alignment value to which kernel should be aligned"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 83d20f402535..c1dcff444bc8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -206,9 +206,8 @@ else
                 PIE_CFLAGS-$(CONFIG_SMP) += -mstack-protector-guard-reg=gs
         endif
 
-        # Don't emit relaxable GOTPCREL relocations
-        KBUILD_AFLAGS_KERNEL += -Wa,-mrelax-relocations=no
-        KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no $(PIE_CFLAGS-y)
+        KBUILD_CFLAGS_KERNEL	+= $(PIE_CFLAGS-y)
+        KBUILD_RUSTFLAGS_KERNEL	+= -Ccode-model=small -Crelocation-model=pie
 endif
 
 #
@@ -264,12 +263,16 @@ else
 LDFLAGS_vmlinux :=
 endif
 
+ifdef CONFIG_X86_64
+ldflags-pie-$(CONFIG_LD_IS_LLD)	:= --apply-dynamic-relocs
+ldflags-pie-$(CONFIG_LD_IS_BFD)	:= -z call-nop=suffix-nop
+LDFLAGS_vmlinux			+= --pie -z text $(ldflags-pie-y)
+
 #
 # The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
 # the linker to force 2MB page size regardless of the default page size used
 # by the linker.
 #
-ifdef CONFIG_X86_64
 LDFLAGS_vmlinux += -z max-page-size=0x200000
 endif
 
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 89f01375cdb7..79e3ffe16f61 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -495,6 +495,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		error("Destination virtual address changed when not relocatable");
 #endif
 
+	boot_params_ptr->kaslr_va_shift = virt_addr - LOAD_PHYSICAL_ADDR;
+
 	debug_putstr("\nDecompressing Linux... ");
 
 	if (init_unaccepted_memory()) {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f7e832c2ac61..d172e6e8eaaf 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -459,6 +459,11 @@ xen_elfnote_phys32_entry_offset =
 
 	DISCARDS
 
+	/DISCARD/ : {
+		*(.dynsym .gnu.hash .hash .dynamic .dynstr)
+		*(.interp .dynbss .eh_frame .sframe)
+	}
+
 	/*
 	 * Make sure that the .got.plt is either completely empty or it
 	 * contains only the lazy dispatch entries.
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f8e465da344d..5c03954924fe 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -912,6 +912,8 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 	if (status != EFI_SUCCESS)
 		return status;
 
+	boot_params_ptr->kaslr_va_shift = virt_addr - LOAD_PHYSICAL_ADDR;
+
 	entry = decompress_kernel((void *)addr, virt_addr, error);
 	if (entry == ULONG_MAX) {
 		efi_free(alloc_size, addr);
-- 
2.46.0.792.g87dc391469-goog


