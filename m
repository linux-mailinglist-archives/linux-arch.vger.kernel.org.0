Return-Path: <linux-arch+bounces-7401-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398D986253
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A341F27616
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4017B400;
	Wed, 25 Sep 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTSA4YDK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA09D42067
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276521; cv=none; b=E6BIb4+AHiSzHIOII5FQwIzRopc+S8UwWw5hbQOXi1os+bw83+dbGB0MeNdlNwVa27psFrayRbcRMjJgLYYhD81DPz3y92tCs7yyj5KBLCoVWnlRoAjO9NrDKxo8qSYrawGfltC9nqiZiLaaM4jKf2TciD08GsOf0g0jQljwHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276521; c=relaxed/simple;
	bh=IaHPxWGMSEwaCkkyiwAlKMa55WaS/Witb8KJx2+NTs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JmtfmKlLbU3q2wltd1g5Jm53b907bb+k2eCmOjGbR8PIhkb2hk84pqPAJzFml59fHjLAa3kFolfbZp3dbP8/WVR3IuRB7t+Z228BLX7MOgE5l8Fbtm95cUMfE/6eMevbSq+61hvIWkJRunm8IUbA6FxWqeMtSANGYKwYdMawJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTSA4YDK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cdeac2da6so56845075e9.2
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276517; x=1727881317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pz/XW8QSYpyjnMJx025a43dGrFFSpzR/yo2KpiqoalU=;
        b=VTSA4YDKPJq1jicr67xqWdf4nwClspY8JM5dgJH0R0KYTHBFQtSarPIlLjm8RovvY+
         /WMs/aqv2AFWG0V251GZWw9pSQ0RH8AIZqSPeWyV1Z3typUzTchSPU2lPWmZcePbsI+u
         TpFvyzTWgLqj34v4YzyLOYJKEdSzkbTTUT7u5mIhIZND2Eew8i3CNmUmg8NYjjhDAP3s
         jxv033QZTJfALqXF1tnT5npGZ1q9cqBK8SIvq2Kl+IfPO8W+IVczRgntZcoRujZ7ccaI
         hMkprLVVGdMQa2gKRcG71lSGCiVmb0a8RcFwqAP22v6Wrz+B0ZZeK1XBf3HdNGvjraJp
         FrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276517; x=1727881317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz/XW8QSYpyjnMJx025a43dGrFFSpzR/yo2KpiqoalU=;
        b=td3aGrqLQquAbjB60pFUhSiDGdgpABBzBEOipG0LOnB7ewaoQ7Oy6Fl6ABdY/4YCHq
         jZ/tHCr090O2DXtbbueauQ/LuI6J+Noo2k1KHQpnrp4n1XbAKgyytpYK/qduJqniCwRO
         dLXxTFP0t97JAweSfB+k2Te6pdNVYkRIacxToNFQWRdfVMOWlSzf5VcWGTF05UODLCG/
         A2vYk366L672OvD5hWwKkpVH3gRuks6jomAN6TEuTPQ7jkxH9DaHaFO20MIST9sLvasj
         sI6Bm/GWZXzR+RmVXxBy7P99+ARC2fs06ur7MG6Vk+XKJ5RK6iEXO//Hbr+rh17GeO//
         JeAw==
X-Forwarded-Encrypted: i=1; AJvYcCW71ZXc7MwZVvdA4tuHqDL4HNgRxuT+/CAWKj5XTEOIQ67JTt80lD3jHsVfVpb04Vwc/BjNM+ieGQ45@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPRVgMQCRnSAd3qyn7oq/SkkolFBRvpMUdjL0J95ad6lFJcvd
	gHsBsu50l6EDNAtsMFXj+X1CLnwdvsfwo0PPA5jmmB/iXkBeqOpKCyKbVzGKKcj0HzvK7w==
X-Google-Smtp-Source: AGHT+IEbq9+/MTLELU3OXPlyueW+j2FWZvgN6ZakUbbc2SrTEQmlnuellku1ZjQlO+1N3OhIaNIzAxHq
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:5119:b0:42c:b4ca:768c with SMTP id
 5b1f17b1804b1-42e961360edmr149855e9.3.1727276516881; Wed, 25 Sep 2024
 08:01:56 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:03 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10814; i=ardb@kernel.org;
 h=from:subject; bh=yS/zV/W3xopSyE4a8OCITK3fowdcfQuYvJXmy9tih3c=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6obs5pM9GZf2VnAvYlrokLT1Ituly6LWzTERkUrrD
 f6oTr3QUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYSz8/wm0VimXuGXXdnV+M6
 5qSfrfdnXGBIb3j5Z7LmafMTK97PMWD4K1PcmbbV2I3veafe8+rETfcetx2VnGN1t1r8BK+RQaQ qCwA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-33-ardb+git@google.com>
Subject: [RFC PATCH 03/28] x86/tools: Use mmap() to simplify relocs host tool
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

Instead of relying on fseek() and fread() to traverse the vmlinux file
when processing the ELF relocations, mmap() the whole thing and use
memcpy() or direct references where appropriate:
- the executable and section headers are byte swabbed before use if the
  host is big endian, so there, the copy is retained;
- the strtab and extended symtab are not byte swabbed so there, the
  copies are replaced with direct references into the mmap()'ed region.

This substantially simplifies the code, and makes it much easier to
refer to other file contents directly. This will be used by a subsequent
patch to handle GOTPCREL relocations.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/tools/relocs.c | 145 ++++++++------------
 arch/x86/tools/relocs.h |   2 +
 2 files changed, 62 insertions(+), 85 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c101bed61940..35a73e4aa74d 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -37,15 +37,17 @@ static struct relocs		relocs64;
 #endif
 
 struct section {
-				Elf_Shdr       shdr;
-				struct section *link;
-				Elf_Sym        *symtab;
-				Elf32_Word     *xsymtab;
-				Elf_Rel        *reltab;
-				char           *strtab;
+				Elf_Shdr         shdr;
+				struct section   *link;
+				Elf_Sym          *symtab;
+				const Elf32_Word *xsymtab;
+				Elf_Rel          *reltab;
+				const char       *strtab;
 };
 static struct section		*secs;
 
+static const void		*elf_image;
+
 static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 /*
  * Following symbols have been audited. There values are constant and do
@@ -291,7 +293,7 @@ static Elf_Sym *sym_lookup(const char *symname)
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		long nsyms;
-		char *strtab;
+		const char *strtab;
 		Elf_Sym *symtab;
 		Elf_Sym *sym;
 
@@ -354,7 +356,7 @@ static uint64_t elf64_to_cpu(uint64_t val)
 static int sym_index(Elf_Sym *sym)
 {
 	Elf_Sym *symtab = secs[shsymtabndx].symtab;
-	Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
+	const Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
 	unsigned long offset;
 	int index;
 
@@ -368,10 +370,9 @@ static int sym_index(Elf_Sym *sym)
 	return elf32_to_cpu(xsymtab[index]);
 }
 
-static void read_ehdr(FILE *fp)
+static void read_ehdr(void)
 {
-	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
-		die("Cannot read ELF header: %s\n", strerror(errno));
+	memcpy(&ehdr, elf_image, sizeof(ehdr));
 	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0)
 		die("No ELF magic\n");
 	if (ehdr.e_ident[EI_CLASS] != ELF_CLASS)
@@ -414,60 +415,48 @@ static void read_ehdr(FILE *fp)
 
 
 	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
-		Elf_Shdr shdr;
-
-		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-			die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
-
-		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read initial ELF section header: %s\n", strerror(errno));
+		const Elf_Shdr *shdr = elf_image + ehdr.e_shoff;
 
 		if (shnum == SHN_UNDEF)
-			shnum = elf_xword_to_cpu(shdr.sh_size);
+			shnum = elf_xword_to_cpu(shdr->sh_size);
 
 		if (shstrndx == SHN_XINDEX)
-			shstrndx = elf_word_to_cpu(shdr.sh_link);
+			shstrndx = elf_word_to_cpu(shdr->sh_link);
 	}
 
 	if (shstrndx >= shnum)
 		die("String table index out of bounds\n");
 }
 
-static void read_shdrs(FILE *fp)
+static void read_shdrs(void)
 {
+	const Elf_Shdr *shdr = elf_image + ehdr.e_shoff;
 	int i;
-	Elf_Shdr shdr;
 
 	secs = calloc(shnum, sizeof(struct section));
 	if (!secs)
 		die("Unable to allocate %ld section headers\n", shnum);
 
-	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-		die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
-
-	for (i = 0; i < shnum; i++) {
+	for (i = 0; i < shnum; i++, shdr++) {
 		struct section *sec = &secs[i];
 
-		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%ld: %s\n", i, shnum, strerror(errno));
-
-		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
-		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
-		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr.sh_flags);
-		sec->shdr.sh_addr      = elf_addr_to_cpu(shdr.sh_addr);
-		sec->shdr.sh_offset    = elf_off_to_cpu(shdr.sh_offset);
-		sec->shdr.sh_size      = elf_xword_to_cpu(shdr.sh_size);
-		sec->shdr.sh_link      = elf_word_to_cpu(shdr.sh_link);
-		sec->shdr.sh_info      = elf_word_to_cpu(shdr.sh_info);
-		sec->shdr.sh_addralign = elf_xword_to_cpu(shdr.sh_addralign);
-		sec->shdr.sh_entsize   = elf_xword_to_cpu(shdr.sh_entsize);
+		sec->shdr.sh_name      = elf_word_to_cpu(shdr->sh_name);
+		sec->shdr.sh_type      = elf_word_to_cpu(shdr->sh_type);
+		sec->shdr.sh_flags     = elf_xword_to_cpu(shdr->sh_flags);
+		sec->shdr.sh_addr      = elf_addr_to_cpu(shdr->sh_addr);
+		sec->shdr.sh_offset    = elf_off_to_cpu(shdr->sh_offset);
+		sec->shdr.sh_size      = elf_xword_to_cpu(shdr->sh_size);
+		sec->shdr.sh_link      = elf_word_to_cpu(shdr->sh_link);
+		sec->shdr.sh_info      = elf_word_to_cpu(shdr->sh_info);
+		sec->shdr.sh_addralign = elf_xword_to_cpu(shdr->sh_addralign);
+		sec->shdr.sh_entsize   = elf_xword_to_cpu(shdr->sh_entsize);
 		if (sec->shdr.sh_link < shnum)
 			sec->link = &secs[sec->shdr.sh_link];
 	}
 
 }
 
-static void read_strtabs(FILE *fp)
+static void read_strtabs(void)
 {
 	int i;
 
@@ -476,20 +465,11 @@ static void read_strtabs(FILE *fp)
 
 		if (sec->shdr.sh_type != SHT_STRTAB)
 			continue;
-
-		sec->strtab = malloc(sec->shdr.sh_size);
-		if (!sec->strtab)
-			die("malloc of %" FMT " bytes for strtab failed\n", sec->shdr.sh_size);
-
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
-			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
-
-		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
-			die("Cannot read symbol table: %s\n", strerror(errno));
+		sec->strtab = elf_image + sec->shdr.sh_offset;
 	}
 }
 
-static void read_symtabs(FILE *fp)
+static void read_symtabs(void)
 {
 	int i, j;
 
@@ -499,16 +479,7 @@ static void read_symtabs(FILE *fp)
 
 		switch (sec->shdr.sh_type) {
 		case SHT_SYMTAB_SHNDX:
-			sec->xsymtab = malloc(sec->shdr.sh_size);
-			if (!sec->xsymtab)
-				die("malloc of %" FMT " bytes for xsymtab failed\n", sec->shdr.sh_size);
-
-			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
-				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
-
-			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
-				die("Cannot read extended symbol table: %s\n", strerror(errno));
-
+			sec->xsymtab = elf_image + sec->shdr.sh_offset;
 			shxsymtabndx = i;
 			continue;
 
@@ -519,11 +490,7 @@ static void read_symtabs(FILE *fp)
 			if (!sec->symtab)
 				die("malloc of %" FMT " bytes for symtab failed\n", sec->shdr.sh_size);
 
-			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
-				die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
-
-			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
-				die("Cannot read symbol table: %s\n", strerror(errno));
+			memcpy(sec->symtab, elf_image + sec->shdr.sh_offset, sec->shdr.sh_size);
 
 			for (j = 0; j < num_syms; j++) {
 				Elf_Sym *sym = &sec->symtab[j];
@@ -543,12 +510,13 @@ static void read_symtabs(FILE *fp)
 }
 
 
-static void read_relocs(FILE *fp)
+static void read_relocs(void)
 {
 	int i, j;
 
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
+		const Elf_Rel *reltab = elf_image + sec->shdr.sh_offset;
 
 		if (sec->shdr.sh_type != SHT_REL_TYPE)
 			continue;
@@ -557,19 +525,12 @@ static void read_relocs(FILE *fp)
 		if (!sec->reltab)
 			die("malloc of %" FMT " bytes for relocs failed\n", sec->shdr.sh_size);
 
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
-			die("Seek to %" FMT " failed: %s\n", sec->shdr.sh_offset, strerror(errno));
-
-		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp) != sec->shdr.sh_size)
-			die("Cannot read symbol table: %s\n", strerror(errno));
-
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
 			Elf_Rel *rel = &sec->reltab[j];
-
-			rel->r_offset = elf_addr_to_cpu(rel->r_offset);
-			rel->r_info   = elf_xword_to_cpu(rel->r_info);
+			rel->r_offset = elf_addr_to_cpu(reltab[j].r_offset);
+			rel->r_info   = elf_xword_to_cpu(reltab[j].r_info);
 #if (SHT_REL_TYPE == SHT_RELA)
-			rel->r_addend = elf_xword_to_cpu(rel->r_addend);
+			rel->r_addend = elf_xword_to_cpu(reltab[j].r_addend);
 #endif
 		}
 	}
@@ -591,7 +552,7 @@ static void print_absolute_symbols(void)
 
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		char *sym_strtab;
+		const char *sym_strtab;
 		int j;
 
 		if (sec->shdr.sh_type != SHT_SYMTAB)
@@ -633,7 +594,7 @@ static void print_absolute_relocs(void)
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		struct section *sec_applies, *sec_symtab;
-		char *sym_strtab;
+		const char *sym_strtab;
 		Elf_Sym *sh_symtab;
 		int j;
 
@@ -725,7 +686,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 
 	/* Walk through the relocations */
 	for (i = 0; i < shnum; i++) {
-		char *sym_strtab;
+		const char *sym_strtab;
 		Elf_Sym *sh_symtab;
 		struct section *sec_applies, *sec_symtab;
 		int j;
@@ -1177,12 +1138,24 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
 	     int show_reloc_info)
 {
+	int fd = fileno(fp);
+	struct stat sb;
+	void *p;
+
+	if (fstat(fd, &sb))
+		die("fstat() failed\n");
+
+	elf_image = p = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (p == MAP_FAILED)
+		die("mmap() failed\n");
+
 	regex_init(use_real_mode);
-	read_ehdr(fp);
-	read_shdrs(fp);
-	read_strtabs(fp);
-	read_symtabs(fp);
-	read_relocs(fp);
+
+	read_ehdr();
+	read_shdrs();
+	read_strtabs();
+	read_symtabs();
+	read_relocs();
 
 	if (ELF_BITS == 64)
 		percpu_init();
@@ -1203,4 +1176,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	}
 
 	emit_relocs(as_text, use_real_mode);
+
+	munmap(p, sb.st_size);
 }
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 4c49c82446eb..7a509604ff92 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -16,6 +16,8 @@
 #include <endian.h>
 #include <regex.h>
 #include <tools/le_byteshift.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
 
 __attribute__((__format__(printf, 1, 2)))
 void die(char *fmt, ...) __attribute__((noreturn));
-- 
2.46.0.792.g87dc391469-goog


