Return-Path: <linux-arch+bounces-7426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773B986345
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F881F26769
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C021A0720;
	Wed, 25 Sep 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ongWkgeN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9719F499
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276586; cv=none; b=dTjG7I5NFtodMjYi46erETkfAAmZZrMIv7yVlzrtK8q5RzF/H7GcZD5jes426oFvgZlK3Q4oWMvUIgWPJh+zc19qhirj0gp4sULtTfqhYuJHcq/Z+dQ/S3O/emS9BhnB/VlyP+mh+rDLY+Cmd6Vb3cnTu/a8mGMsUtbt58AsOsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276586; c=relaxed/simple;
	bh=YvM9TRdamHMMVDaQnr/PY1VL/3cpzPBrLHBshWo7LWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgdP2f482bmgcLnOgYqYzg/C9ivV670sn6Z4+ppZfWyxYu59KWvx92zlceysUPHQsBYcLy1Ow85kljfA5wE/fXFfl5Dy2KNWbPHNFS2ImLrnUfEZWISM86ERM9M2VAvTCFMJ+TUQbLd0EmpjL3y6MOoUZpIjjzXqGgm6I3mXgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ongWkgeN; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb857fc7dso52579845e9.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276581; x=1727881381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/fxT1DdHMwMyeW8np4BBTWW8phQCD6XQ4SETP482c8=;
        b=ongWkgeNEUsXO/yFix7MO/NjZ2xvYjoDtIUAZporkb9MuWeyH9GspZlyxNuptzMS9z
         27Wcx+k6toKj75Lqn7eTnYkTBw2H2B/ooJKtEmb4PCjaA7tabdO0KaZ0MASZ2VwCe6tF
         dCZWRxhB0Df0qIrum8EqqV+z13+lw9hhfUWtEGwpL0BsUWnrImwdQkmrlVuWFiGfgQHl
         eZS6XOrp4ju9m/p48G2u5gOy3ga2/DqLQRrgaaVl4yJsa7a2bT7kHX5MYA4LyuWo4zSD
         gRzCcLC+XGFxdW9bdOm28v1dXeZRvGrlwwA3ODwA2n6vokwpU4qtgvNJ+5kk0Dpe76FB
         qzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276581; x=1727881381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/fxT1DdHMwMyeW8np4BBTWW8phQCD6XQ4SETP482c8=;
        b=qBRYlfpZ80fCCz3ClMeKKBDQ8KP3fna88W+cfsLacy67R0RK97+WtszRLoex5GGFcV
         Qho1//KKp7QDW57JJNxRnGLiKJjVXWK0DC5SC7JkuvOstYueRpow1NlZkx4Lfsm7EUBy
         8MuoZwi/zkp5ziOI3i4LN1cxZvzirfE4V4uHu/QjrffvYmIivugA5CxppwW+Z0MBKVdj
         HGufCxCenpz5tc+tgv+UmXGHHUW0TTzvGl+E165rimEsJ6+xpiDGEgQyQhFc/M6LqSoF
         OGBLlkAFGpcT9mivK+Njrx6exXaaIjqk5F3n9x7m+gzL8jrrGC03uSYSNGzw4U32C+EU
         azjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6NDay46dI7CuJpOKtzA0nmBT7l8xk2hu1ScyNakJl4PA6DvVOzwNP4p0+xFsrs+CLfuUGqWMpaN8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2u9l8u2139Gjcrzd64IXbwUsyobTFYueZXVEJOJJsFZFnY2tO
	kIIkaYoxJzbm0XzJ8QKUi/AtU96WjsOpTI9yo7JE7pE+38H2grgmh6AJYp9xMU05tbddzA==
X-Google-Smtp-Source: AGHT+IH1WYrW/UKZ6ngnkIpIsR2dgkaJ0zFY0ft3XgXQ0QWdCfqsR4NIFZKbE/zMO6K3p2uoWgwYBDA5
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:5709:b0:42c:a879:3d0f with SMTP id
 5b1f17b1804b1-42e960af3c0mr226185e9.0.1727276581262; Wed, 25 Sep 2024
 08:03:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:28 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=11373; i=ardb@kernel.org;
 h=from:subject; bh=vOsRO/wusTOgSIMrTbPQkuvbTEvedgqm5gFKQyyQ6LE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6uU7KcXh52pbo2UXaeZq6U587fAt6o/qk6KOindLu
 xmSJDk6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwES8vjP8D6r8/Whqj0Ue89/g
 jLlev1knyS9cOWlNtI5Y6rLiT9GiiYwMF5pPLt85df5ck61Kskef/1wi37sr+6Xjrf+r3xWdTEj U5wUA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-58-ardb+git@google.com>
Subject: [RFC PATCH 28/28] x86/tools: Drop x86_64 support from 'relocs' tool
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

The relocs tool is no longer used on vmlinux, which is the only 64-bit
ELF executable that it used to operate on in the 64-bit build. (It is
still used for parts of the decompressor)

So drop the 64-bit handling - it is dead code now.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/tools/Makefile        |   2 +-
 arch/x86/tools/relocs.c        | 178 +-------------------
 arch/x86/tools/relocs.h        |   9 +-
 arch/x86/tools/relocs_64.c     |  18 --
 arch/x86/tools/relocs_common.c |  11 +-
 5 files changed, 9 insertions(+), 209 deletions(-)

diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 7278e2545c35..f7d12a9dccfc 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -40,7 +40,7 @@ $(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/arch
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
 hostprogs	+= relocs
-relocs-objs     := relocs_32.o relocs_64.o relocs_common.o
+relocs-objs     := relocs_32.o relocs_common.o
 PHONY += relocs
 relocs: $(obj)/relocs
 	@:
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 22c2d3f07a57..ff5578e63ff8 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -28,12 +28,7 @@ struct relocs {
 static struct relocs		relocs16;
 static struct relocs		relocs32;
 
-#if ELF_BITS == 64
-static struct relocs		relocs64;
-# define FMT PRIu64
-#else
 # define FMT PRIu32
-#endif
 
 struct section {
 				Elf_Shdr         shdr;
@@ -86,10 +81,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__end_rodata_aligned|"
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
-#if ELF_BITS == 64
-	"__per_cpu_load|"
-	"__end_rodata_hpage_align|"
-#endif
 	"__vvar_page|"
 	"_end)$"
 };
@@ -210,27 +201,6 @@ static const char *rel_type(unsigned type)
 {
 	static const char *type_name[] = {
 #define REL_TYPE(X) [X] = #X
-#if ELF_BITS == 64
-		REL_TYPE(R_X86_64_NONE),
-		REL_TYPE(R_X86_64_64),
-		REL_TYPE(R_X86_64_PC64),
-		REL_TYPE(R_X86_64_PC32),
-		REL_TYPE(R_X86_64_GOT32),
-		REL_TYPE(R_X86_64_PLT32),
-		REL_TYPE(R_X86_64_COPY),
-		REL_TYPE(R_X86_64_GLOB_DAT),
-		REL_TYPE(R_X86_64_JUMP_SLOT),
-		REL_TYPE(R_X86_64_RELATIVE),
-		REL_TYPE(R_X86_64_GOTPCREL),
-		REL_TYPE(R_X86_64_GOTPCRELX),
-		REL_TYPE(R_X86_64_REX_GOTPCRELX),
-		REL_TYPE(R_X86_64_32),
-		REL_TYPE(R_X86_64_32S),
-		REL_TYPE(R_X86_64_16),
-		REL_TYPE(R_X86_64_PC16),
-		REL_TYPE(R_X86_64_8),
-		REL_TYPE(R_X86_64_PC8),
-#else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
 		REL_TYPE(R_386_PC32),
@@ -246,7 +216,6 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_386_PC8),
 		REL_TYPE(R_386_16),
 		REL_TYPE(R_386_PC16),
-#endif
 #undef REL_TYPE
 	};
 	const char *name = "unknown type rel type name";
@@ -312,19 +281,9 @@ static uint32_t elf32_to_cpu(uint32_t val)
 #define elf_half_to_cpu(x)	elf16_to_cpu(x)
 #define elf_word_to_cpu(x)	elf32_to_cpu(x)
 
-#if ELF_BITS == 64
-static uint64_t elf64_to_cpu(uint64_t val)
-{
-        return le64_to_cpu(val);
-}
-# define elf_addr_to_cpu(x)	elf64_to_cpu(x)
-# define elf_off_to_cpu(x)	elf64_to_cpu(x)
-# define elf_xword_to_cpu(x)	elf64_to_cpu(x)
-#else
 # define elf_addr_to_cpu(x)	elf32_to_cpu(x)
 # define elf_off_to_cpu(x)	elf32_to_cpu(x)
 # define elf_xword_to_cpu(x)	elf32_to_cpu(x)
-#endif
 
 static int sym_index(Elf_Sym *sym)
 {
@@ -515,10 +474,7 @@ static void print_absolute_symbols(void)
 	int i;
 	const char *format;
 
-	if (ELF_BITS == 64)
-		format = "%5d %016"PRIx64" %5"PRId64" %10s %10s %12s %s\n";
-	else
-		format = "%5d %08"PRIx32"  %5"PRId32" %10s %10s %12s %s\n";
+	format = "%5d %08"PRIx32"  %5"PRId32" %10s %10s %12s %s\n";
 
 	printf("Absolute symbols\n");
 	printf(" Num:    Value Size  Type       Bind        Visibility  Name\n");
@@ -559,10 +515,7 @@ static void print_absolute_relocs(void)
 	int i, printed = 0;
 	const char *format;
 
-	if (ELF_BITS == 64)
-		format = "%016"PRIx64" %016"PRIx64" %10s %016"PRIx64"  %s\n";
-	else
-		format = "%08"PRIx32" %08"PRIx32" %10s %08"PRIx32"  %s\n";
+	format = "%08"PRIx32" %08"PRIx32" %10s %08"PRIx32"  %s\n";
 
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
@@ -694,104 +647,6 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 	}
 }
 
-#if ELF_BITS == 64
-
-static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
-		      const char *symname)
-{
-	unsigned r_type = ELF64_R_TYPE(rel->r_info);
-	ElfW(Addr) offset = rel->r_offset;
-	int shn_abs = (sym->st_shndx == SHN_ABS) && !is_reloc(S_REL, symname);
-
-	if (sym->st_shndx == SHN_UNDEF)
-		return 0;
-
-	switch (r_type) {
-	case R_X86_64_NONE:
-		/* NONE can be ignored. */
-		break;
-
-	case R_X86_64_PC32:
-	case R_X86_64_PLT32:
-		/*
-		 * PC relative relocations don't need to be adjusted.
-		 *
-		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
-		 */
-		break;
-
-	case R_X86_64_PC64:
-		/*
-		 * Only used by jump labels
-		 */
-		break;
-
-	case R_X86_64_32:
-	case R_X86_64_32S:
-	case R_X86_64_64:
-	case R_X86_64_GOTPCREL:
-		if (shn_abs) {
-			/*
-			 * Whitelisted absolute symbols do not require
-			 * relocation.
-			 */
-			if (is_reloc(S_ABS, symname))
-				break;
-
-			die("Invalid absolute %s relocation: %s\n", rel_type(r_type), symname);
-			break;
-		}
-
-		if (r_type == R_X86_64_GOTPCREL) {
-			Elf_Shdr *s = &secs[sec->shdr.sh_info].shdr;
-			unsigned file_off = offset - s->sh_addr + s->sh_offset;
-
-			/*
-			 * GOTPCREL relocations refer to instructions that load
-			 * a 64-bit address via a 32-bit relative reference to
-			 * the GOT.  In this case, it is the GOT entry that
-			 * needs to be fixed up, not the immediate offset in
-			 * the opcode. Note that the linker will have applied an
-			 * addend of -4 to compensate for the delta between the
-			 * relocation offset and the value of RIP when the
-			 * instruction executes, and this needs to be backed out
-			 * again. (Addends other than -4 are permitted in
-			 * principle, but make no sense in practice so they are
-			 * not supported.)
-                         */
-			if (rel->r_addend != -4) {
-				die("invalid addend (%ld) for %s relocation: %s\n",
-				    rel->r_addend, rel_type(r_type), symname);
-				break;
-			}
-			offset += 4 + (int32_t)get_unaligned_le32(elf_image + file_off);
-		}
-
-		/*
-		 * Relocation offsets for 64 bit kernels are output
-		 * as 32 bits and sign extended back to 64 bits when
-		 * the relocations are processed.
-		 * Make sure that the offset will fit.
-		 */
-		if ((int32_t)offset != (int64_t)offset)
-			die("Relocation offset doesn't fit in 32 bits\n");
-
-		if (r_type == R_X86_64_64 || r_type == R_X86_64_GOTPCREL)
-			add_reloc(&relocs64, offset);
-		else
-			add_reloc(&relocs32, offset);
-		break;
-
-	default:
-		die("Unsupported relocation type: %s (%d)\n", rel_type(r_type), r_type);
-		break;
-	}
-
-	return 0;
-}
-
-#else
-
 static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 		      const char *symname)
 {
@@ -902,8 +757,6 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym, const
 	return 0;
 }
 
-#endif
-
 static int cmp_relocs(const void *va, const void *vb)
 {
 	const uint32_t *a, *b;
@@ -939,17 +792,10 @@ static void emit_relocs(int as_text, int use_real_mode)
 	int (*write_reloc)(uint32_t, FILE *) = write32;
 	int (*do_reloc)(struct section *sec, Elf_Rel *rel, Elf_Sym *sym, const char *symname);
 
-#if ELF_BITS == 64
-	if (!use_real_mode)
-		do_reloc = do_reloc64;
-	else
-		die("--realmode not valid for a 64-bit ELF file");
-#else
 	if (!use_real_mode)
 		do_reloc = do_reloc32;
 	else
 		do_reloc = do_reloc_real;
-#endif
 
 	/* Collect up the relocations */
 	walk_relocs(do_reloc);
@@ -959,11 +805,7 @@ static void emit_relocs(int as_text, int use_real_mode)
 
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
-#if ELF_BITS == 64
-	sort_relocs(&relocs64);
-#else
 	sort_relocs(&relocs16);
-#endif
 
 	/* Print the relocations */
 	if (as_text) {
@@ -984,16 +826,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 		for (i = 0; i < relocs32.count; i++)
 			write_reloc(relocs32.offset[i], stdout);
 	} else {
-#if ELF_BITS == 64
-		/* Print a stop */
-		write_reloc(0, stdout);
-
-		/* Now print each relocation */
-		for (i = 0; i < relocs64.count; i++)
-			if (!i || relocs64.offset[i] != relocs64.offset[i - 1])
-				write_reloc(relocs64.offset[i], stdout);
-#endif
-
 		/* Print a stop */
 		write_reloc(0, stdout);
 
@@ -1027,12 +859,6 @@ static void print_reloc_info(void)
 	walk_relocs(do_reloc_info);
 }
 
-#if ELF_BITS == 64
-# define process process_64
-#else
-# define process process_32
-#endif
-
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
 	     int show_reloc_info)
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 7a509604ff92..ef9eec96bd62 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -32,10 +32,7 @@ enum symtype {
 	S_NSYMTYPES
 };
 
-void process_32(FILE *fp, int use_real_mode, int as_text,
-		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
-void process_64(FILE *fp, int use_real_mode, int as_text,
-		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+void process(FILE *fp, int use_real_mode, int as_text,
+	     int show_absolute_syms, int show_absolute_relocs,
+	     int show_reloc_info);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_64.c b/arch/x86/tools/relocs_64.c
deleted file mode 100644
index 9029cb619cb1..000000000000
--- a/arch/x86/tools/relocs_64.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "relocs.h"
-
-#define ELF_BITS 64
-
-#define ELF_MACHINE             EM_X86_64
-#define ELF_MACHINE_NAME        "x86_64"
-#define SHT_REL_TYPE            SHT_RELA
-#define Elf_Rel                 Elf64_Rela
-
-#define ELF_CLASS               ELFCLASS64
-#define ELF_R_SYM(val)          ELF64_R_SYM(val)
-#define ELF_R_TYPE(val)         ELF64_R_TYPE(val)
-#define ELF_ST_TYPE(o)          ELF64_ST_TYPE(o)
-#define ELF_ST_BIND(o)          ELF64_ST_BIND(o)
-#define ELF_ST_VISIBILITY(o)    ELF64_ST_VISIBILITY(o)
-
-#include "relocs.c"
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index 6634352a20bc..167985ecd544 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -72,14 +72,9 @@ int main(int argc, char **argv)
 		die("Cannot read %s: %s", fname, strerror(errno));
 	}
 	rewind(fp);
-	if (e_ident[EI_CLASS] == ELFCLASS64)
-		process_64(fp, use_real_mode, as_text,
-			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
-	else
-		process_32(fp, use_real_mode, as_text,
-			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+	process(fp, use_real_mode, as_text,
+		show_absolute_syms, show_absolute_relocs,
+		show_reloc_info);
 	fclose(fp);
 	return 0;
 }
-- 
2.46.0.792.g87dc391469-goog


