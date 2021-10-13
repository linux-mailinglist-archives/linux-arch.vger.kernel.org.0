Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC8B42C830
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhJMSAG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238365AbhJMR75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Oct 2021 13:59:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE80C061769
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d23so3071421pgh.8
        for <linux-arch@vger.kernel.org>; Wed, 13 Oct 2021 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0v5zgaNa83f9AuzQ/blhmCEtXoKIIed9gMaMemt8JlU=;
        b=VlOOG8DzVhr/2BK75cck54oQ8iA+zN/CTP+1r0Io184jYHAR7/YgN6/7eY+it2pUVJ
         eZEIJE8R4ec+S1ppElq+hhEdzoj9equrNraxuudXL+qJFgSGxS8lLckg4Y48gJRU3B5Y
         mD2/csF8XEaxpc0tVhjYCct5QZv9bkjG5DW7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0v5zgaNa83f9AuzQ/blhmCEtXoKIIed9gMaMemt8JlU=;
        b=u01iFQFbY5ui5OYYDpyw2aQTvJ/b8b1ntKqZgNebdi/cOwnocRG1mU2oDOwaIrxfgJ
         hS+JZ72a4cyVYBCmJVbbVDYihzAd8QqfVbseSdVQ7br81Nmna2Nln08WiEEwTZ2ObnXw
         BX1fIIOC1E2Df40zVawgvQbSVKAgu8Y4Ta/F8VJkL7P7auwIDnNBmvd+39GWX5kMqv8A
         bFh4QiZVn8HlR1Ra5jJD8zcspZL4oncAIxHJL/Q+QdGf1nleKiGZmmBtIV90nvYvB9tk
         vIf2U2B4+RJhDlwuOBirM94ftJdrfbIGfnf1a9VZc/46VC751eaLMmcxdjfDGHCRQZsl
         7sKg==
X-Gm-Message-State: AOAM531yW0Z792a/rueVMWKrLlkMqVhLAYu25d1N7HyjvvUO+zP1ZVF3
        46kwIzl/dspvadUpFADkTDPIWA==
X-Google-Smtp-Source: ABdhPJw004U6L0D+18VMWEbk6cdAUXpiATvAxyqBQ5pBK7yOvWvr8jvwE6iWRj65Hb/v6NdTOzvd+A==
X-Received: by 2002:aa7:9ec6:0:b0:44d:6650:c1ff with SMTP id r6-20020aa79ec6000000b0044d6650c1ffmr430977pfq.15.1634147872953;
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm171783pgn.72.2021.10.13.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 10:57:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] x86/tools/relocs: Support >64K section headers
Date:   Wed, 13 Oct 2021 10:57:39 -0700
Message-Id: <20211013175742.1197608-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013175742.1197608-1-keescook@chromium.org>
References: <20211013175742.1197608-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5891; i=keescook@chromium.org; h=from:subject; bh=0cl+0Q9TemQRuQNHUlHXCWH24NyrqX+rsH/tprTSAfM=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBhZx4VX84HrL/hk4UwuTN9MqL5dCY9q+zsf5xeCNOf py+mN1KJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYWceFQAKCRCJcvTf3G3AJjsuD/ ioh8hRwFLYDNKhSJXklcSdmFbPWb/fL/vJZmbrOlTTndRbKIggguRR3NdVdz/gXZ7ZxopnxE0goAqv xn5APnzQrHZb8FLDBmYP34IgnN3/shqNo4mWMllAemPw8E7SPBNJ6wFnWhkTBmEpIdSN4sxnQjtpKb xopgHurwMp7Ajrb9g+/7hEK4+qhz2K+zW3nV3u2yxwmxT5iXtldI9KZ1eIDae7Ty2Na3wWCF8UlmvR 8kkDqQRyIRE3n52GcpEr7FnmBRX0DGvwzw4WhXs1dFSr9DRA3SAT3dJnp0aER2XQzYGtqfPBap0UCg G215RJVlwicFdavCR2ah5RUuRJc+pxnr787+tZ0To9y+1lOqToGTO8Cu5VO48GAfzrM9OG9SrOFQAU W0FyN6HPv+VoaOANDZde/BieolBvj0K+q8THRm232TlBLaCknsZWE/W71+Ff+0CoxfH2zURQVd5RJ/ zXE/tJpuosIvt2/2QJz1iPNm692DWmONLD0l2n1iCPQ1jG96NXq5Mx3WxUglDnt0ALmW4OPqlD96R1 oxIjSNWQWQz/yBbhItconRS3l3Qk25ZsHbNfedf1+fHzIzMMDdT6zZwO8M1LNK/xTUtthr8LmMMp1W lFq1nkk8yxtkYIFFI+MAgar5prIP70n+vNUS9O8jJfV8qJWa0FgCW+ttSr
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

While the relocs tool already supports finding the total number of
section headers if vmlinux exceeds 64K sections, it fails to read the
extended symbol table to get section header indexes for symbols, causing
incorrect symbol table indexes to be used when there are > 64K symbols.

Parse the ELF file to read the extended symbol table info, and then
replace all direct references to st_shndx with calls to sym_index(),
which will determine whether the value can be read directly or whether
the value should be pulled out of the extended table.

This is needed for future FGKASLR support, which uses a separate section
per function.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/tools/relocs.c | 103 ++++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d387..3f5d39768287 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -14,6 +14,10 @@
 static Elf_Ehdr		ehdr;
 static unsigned long	shnum;
 static unsigned int	shstrndx;
+static unsigned int	shsymtabndx;
+static unsigned int	shxsymtabndx;
+
+static int sym_index(Elf_Sym *sym);
 
 struct relocs {
 	uint32_t	*offset;
@@ -35,6 +39,7 @@ struct section {
 	Elf_Shdr       shdr;
 	struct section *link;
 	Elf_Sym        *symtab;
+	Elf32_Word     *xsymtab;
 	Elf_Rel        *reltab;
 	char           *strtab;
 };
@@ -268,7 +273,7 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 		name = sym_strtab + sym->st_name;
 	}
 	else {
-		name = sec_name(sym->st_shndx);
+		name = sec_name(sym_index(sym));
 	}
 	return name;
 }
@@ -338,6 +343,23 @@ static uint64_t elf64_to_cpu(uint64_t val)
 #define elf_xword_to_cpu(x)	elf32_to_cpu(x)
 #endif
 
+static int sym_index(Elf_Sym *sym)
+{
+	Elf_Sym *symtab = secs[shsymtabndx].symtab;
+	Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return sym->st_shndx;
+
+	/* calculate offset of sym from head of table. */
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
+
+	return elf32_to_cpu(xsymtab[index]);
+}
+
 static void read_ehdr(FILE *fp)
 {
 	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
@@ -471,31 +493,60 @@ static void read_strtabs(FILE *fp)
 static void read_symtabs(FILE *fp)
 {
 	int i,j;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		if (sec->shdr.sh_type != SHT_SYMTAB) {
+		int num_syms;
+
+		switch (sec->shdr.sh_type) {
+		case SHT_SYMTAB_SHNDX:
+			sec->xsymtab = malloc(sec->shdr.sh_size);
+			if (!sec->xsymtab) {
+				die("malloc of %" FMT " bytes for xsymtab failed\n",
+				    sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %" FMT " failed: %s\n",
+				    sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
+			    != sec->shdr.sh_size) {
+				die("Cannot read extended symbol table: %s\n",
+				    strerror(errno));
+			}
+			shxsymtabndx = i;
+			continue;
+
+		case SHT_SYMTAB:
+			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
+
+			sec->symtab = malloc(sec->shdr.sh_size);
+			if (!sec->symtab) {
+				die("malloc of %" FMT " bytes for symtab failed\n",
+				    sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %" FMT " failed: %s\n",
+				    sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
+			    != sec->shdr.sh_size) {
+				die("Cannot read symbol table: %s\n",
+				    strerror(errno));
+			}
+			for (j = 0; j < num_syms; j++) {
+				Elf_Sym *sym = &sec->symtab[j];
+
+				sym->st_name  = elf_word_to_cpu(sym->st_name);
+				sym->st_value = elf_addr_to_cpu(sym->st_value);
+				sym->st_size  = elf_xword_to_cpu(sym->st_size);
+				sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
+			}
+			shsymtabndx = i;
+			continue;
+
+		default:
 			continue;
-		}
-		sec->symtab = malloc(sec->shdr.sh_size);
-		if (!sec->symtab) {
-			die("malloc of %" FMT " bytes for symtab failed\n",
-			    sec->shdr.sh_size);
-		}
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %" FMT " failed: %s\n",
-			    sec->shdr.sh_offset, strerror(errno));
-		}
-		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
-		    != sec->shdr.sh_size) {
-			die("Cannot read symbol table: %s\n",
-				strerror(errno));
-		}
-		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Sym); j++) {
-			Elf_Sym *sym = &sec->symtab[j];
-			sym->st_name  = elf_word_to_cpu(sym->st_name);
-			sym->st_value = elf_addr_to_cpu(sym->st_value);
-			sym->st_size  = elf_xword_to_cpu(sym->st_size);
-			sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
 		}
 	}
 }
@@ -762,7 +813,9 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	return (sym->st_shndx == per_cpu_shndx) &&
+	int shndx = sym_index(sym);
+
+	return (shndx == per_cpu_shndx) &&
 		strcmp(symname, "__init_begin") &&
 		strcmp(symname, "__per_cpu_load") &&
 		strncmp(symname, "init_per_cpu_", 13);
@@ -1095,7 +1148,7 @@ static int do_reloc_info(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		sec_name(sec->shdr.sh_info),
 		rel_type(ELF_R_TYPE(rel->r_info)),
 		symname,
-		sec_name(sym->st_shndx));
+		sec_name(sym_index(sym)));
 	return 0;
 }
 
-- 
2.30.2

