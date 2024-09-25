Return-Path: <linux-arch+bounces-7402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03898625A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEEC1C27501
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03391898FF;
	Wed, 25 Sep 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fD083jGZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F345176FA5
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276524; cv=none; b=KXyv9Erz0NWTH/1KyTz0n9vh2roB84iFH9cHrC5SQFuTauYWQ00fXWoo7NrIsXf1bWi8qVNFamby4wIp3k69p7R6ToEmR3XNgnZzcEt/xDPt12SjTa8iRyHnSUk1fLpztutmeJzcCtMoKXNhXJDC5AuC52piJSCexJZzjmhAaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276524; c=relaxed/simple;
	bh=9IeQ5D389OP3YsIvppVdXgRHsSH2R2gh2yLL82bpmwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bAVQaI3iWfEhjrCLFBMlw/FtcDt01ZT+FkVsZxch4OIry9y09iLJT9sLGA6CjE6SWz5Kpt7G1igAxwqijwRFdYiMdY8BmmelVz0qN75rS9NB2ceb03I3vUSkXYVD3QhD4CHR8eZPEZuSWPzA7irswb5XcVRcSiL05cbeh/oyPEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fD083jGZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4f52a4069so118664987b3.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276520; x=1727881320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DA1xJ7QlyinRe20ykWBw1TGfZPAZZ2L4ow9I41mAh9Y=;
        b=fD083jGZz5kclsqEGn0PeXYqDSpGLWOYSTCBb8UAAsRPYt9jF3ZHXRYkabS7r5p0PA
         zvrYXsm1ABv3UhphJZ73GbBTQBMwKVmgv/xaOswaVzaJTp74idKtxPJPUhWKfkdVD1V4
         5H3BVHpyBN2A2YOhjdjT5bTCZaHh2WTossr029pVLDkZoqCc5HoWGkkG9/UqdRcwQCAP
         Q4nvwkc+Yk9pRZO9zVsotNFXOCQsvyRQykfBSqsjR6lMT/WpX0ZyIiiD7H1qshH3klIC
         h91KxOdk5sAPFbd3CDMEvK76txrNKLWUkhQlfQsgCEfv6NPfOuy+mJHCnxs9POxEdn3c
         83OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276520; x=1727881320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA1xJ7QlyinRe20ykWBw1TGfZPAZZ2L4ow9I41mAh9Y=;
        b=VRMfPXBq3L6G3xjCuGNrTZA1CR2JEFeOZJsOgyVXlQN1/7oYVe6DiGBSewmD8Mf3AJ
         BGBLc6cBTPmmE2U3biTpaZBCHxuZgcptXVT4h1QGd9asuYymFUfKCoJQMHOVEoCEG+lQ
         ENQJsSklgeN8LD5xRDRak9DX4exUkOxG0u8IQwiZF9chQpUl/wnQ6vi0DvdpEuwsydP2
         JIZVJFyLTIqkbsgOX+ZV32NV3f2eSRh1qed92+WudgcD1C+SfNTirBPKCEtaJmG23r1S
         bk0XkKkdJfR4aR1VB+b56Ad0eQrfUC1bzN2JVQd2eK8peO5dkTNmxGvMcAR0wtjaEat6
         HRtw==
X-Forwarded-Encrypted: i=1; AJvYcCXWxtBNk7bX/NiG7fyxVxEAoagqHFdiSQQX1mpdPYNoHfER+VtKsC2mKo3M+eZ9WzCqBG53hXpSni0B@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1DquJ4JcFXd6VtLlToLqA4dNaKa324SqovjHtm9H22AqzCok
	0f9pj8nJMblGw8P1jnfk2UBPXhcxJSxy/qHyoVNCMoRW4Ly5/YhzPMshwBmeUSU+YFiyBg==
X-Google-Smtp-Source: AGHT+IEVIf0RcL61TjfNJbSKcMrFRGT1L5gz2hG55UguzadiqCTtHCs2NniTQT5w6cgRQkWXw9cPp9k2
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a81:77c4:0:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6e21d0e8b05mr227547b3.0.1727276519796; Wed, 25 Sep 2024
 08:01:59 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:04 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6485; i=ardb@kernel.org;
 h=from:subject; bh=xSyMofrsI8W/QeJfcidSH2VUWxFZ3VEJOcPkUtiBlzY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6sYKk4m5xZLyVelenm+8zuTMnXPA0faQXMTl3XV33
 iYnS2/oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMRz2b4p2z7TbK64+yiCfEm
 LE6n5/75udhiw87M0k896bfk2oo/BTL8U20uvRe5bfeVZc9kGMJfb1kvfTNqJu/W1Zs+sddu+hR pywYA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-34-ardb+git@google.com>
Subject: [RFC PATCH 04/28] x86/boot: Permit GOTPCREL relocations for x86_64 builds
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

Some of the early x86_64 startup code is written in C, and executes in
the early 1:1 mapping of the kernel, which is not the address it was
linked at, and this requires special care when accessing global
variables. This is currently being dealt with on an ad-hoc basis,
primarily in head64.c, using explicit pointer fixups, but it would be
better to rely on the compiler for this, by using -fPIE to generate code
that can run at any address, and uses RIP-relative accesses to refer to
global variables.

While it is possible to avoid most GOT based symbol references that the
compiler typically emits when running in -fPIE mode, by using 'hidden'
visibility, there are cases where the compiler will always rely on the
GOT, for instance, for weak external references (which may remain
unsatisfied at link time).

This means the build may produce a small number of GOT entries
nonetheless. So update the reloc processing host tool to add support for
this, and place the GOT in the .text section rather than discard it.

Note that multiple GOT based references to the same symbol will share a
single GOT entry, and so naively emitting a relocation for the GOT entry
each time a reference to it is encountered could result in duplicates.
Work around this by relying on the fact that the relocation lists are
sorted, and deduplicate 64-bit relocations as they are emitted by
comparing each entry with the previous one.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                 |  4 +++
 arch/x86/kernel/vmlinux.lds.S     |  5 +++
 arch/x86/tools/relocs.c           | 33 ++++++++++++++++++--
 include/asm-generic/vmlinux.lds.h |  7 +++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 801fd85c3ef6..6b3fe6e2aadd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -192,6 +192,10 @@ else
         KBUILD_CFLAGS += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
         KBUILD_RUSTFLAGS += -Ccode-model=kernel
+
+        # Don't emit relaxable GOTPCREL relocations
+        KBUILD_AFLAGS_KERNEL += -Wa,-mrelax-relocations=no
+        KBUILD_CFLAGS_KERNEL += -Wa,-mrelax-relocations=no
 endif
 
 #
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e874f..7f060d873f75 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -20,6 +20,9 @@
 #define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
+#ifdef CONFIG_X86_64
+#define GOT_IN_RODATA
+#endif
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
@@ -464,10 +467,12 @@ SECTIONS
 	 * Sections that should stay zero sized, which is safer to
 	 * explicitly check instead of blindly discarding.
 	 */
+#ifdef CONFIG_X86_32
 	.got : {
 		*(.got) *(.igot.*)
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+#endif
 
 	.plt : {
 		*(.plt) *(.plt.*) *(.iplt)
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 35a73e4aa74d..880f0f2e465e 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -223,6 +223,8 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_JUMP_SLOT),
 		REL_TYPE(R_X86_64_RELATIVE),
 		REL_TYPE(R_X86_64_GOTPCREL),
+		REL_TYPE(R_X86_64_GOTPCRELX),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 		REL_TYPE(R_X86_64_32),
 		REL_TYPE(R_X86_64_32S),
 		REL_TYPE(R_X86_64_16),
@@ -843,6 +845,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
+	case R_X86_64_GOTPCREL:
 		/*
 		 * References to the percpu area don't need to be adjusted.
 		 */
@@ -861,6 +864,31 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			break;
 		}
 
+		if (r_type == R_X86_64_GOTPCREL) {
+			Elf_Shdr *s = &secs[sec->shdr.sh_info].shdr;
+			unsigned file_off = offset - s->sh_addr + s->sh_offset;
+
+			/*
+			 * GOTPCREL relocations refer to instructions that load
+			 * a 64-bit address via a 32-bit relative reference to
+			 * the GOT.  In this case, it is the GOT entry that
+			 * needs to be fixed up, not the immediate offset in
+			 * the opcode. Note that the linker will have applied an
+			 * addend of -4 to compensate for the delta between the
+			 * relocation offset and the value of RIP when the
+			 * instruction executes, and this needs to be backed out
+			 * again. (Addends other than -4 are permitted in
+			 * principle, but make no sense in practice so they are
+			 * not supported.)
+                         */
+			if (rel->r_addend != -4) {
+				die("invalid addend (%ld) for %s relocation: %s\n",
+				    rel->r_addend, rel_type(r_type), symname);
+				break;
+			}
+			offset += 4 + (int32_t)get_unaligned_le32(elf_image + file_off);
+		}
+
 		/*
 		 * Relocation offsets for 64 bit kernels are output
 		 * as 32 bits and sign extended back to 64 bits when
@@ -870,7 +898,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		if ((int32_t)offset != (int64_t)offset)
 			die("Relocation offset doesn't fit in 32 bits\n");
 
-		if (r_type == R_X86_64_64)
+		if (r_type == R_X86_64_64 || r_type == R_X86_64_GOTPCREL)
 			add_reloc(&relocs64, offset);
 		else
 			add_reloc(&relocs32, offset);
@@ -1085,7 +1113,8 @@ static void emit_relocs(int as_text, int use_real_mode)
 
 		/* Now print each relocation */
 		for (i = 0; i < relocs64.count; i++)
-			write_reloc(relocs64.offset[i], stdout);
+			if (!i || relocs64.offset[i] != relocs64.offset[i - 1])
+				write_reloc(relocs64.offset[i], stdout);
 
 		/* Print a stop */
 		write_reloc(0, stdout);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 19ec49a9179b..cc14d780c70d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -443,6 +443,12 @@
 #endif
 #endif
 
+#ifdef GOT_IN_RODATA
+#define GOT_RODATA	*(.got .igot*)
+#else
+#define GOT_RODATA
+#endif
+
 /*
  * Read only Data
  */
@@ -454,6 +460,7 @@
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
+		GOT_RODATA						\
 		BOUNDED_SECTION_BY(__tracepoints_ptrs, ___tracepoints_ptrs) \
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
-- 
2.46.0.792.g87dc391469-goog


