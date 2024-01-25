Return-Path: <linux-arch+bounces-1571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8F83C0E6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDE928937A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754F50A86;
	Thu, 25 Jan 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njdh4tba"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85F750240
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182378; cv=none; b=MulRl5tjFlK8Dsd0leJoOcfc3h75CpIVTiPYZO8KfM5wFGTA7PwcluWcElN+Yy32NN8i+ydaNZkTDMHkLBhN/5/VVItmaZSOl9LiMouxfOnRWMEnj6NA4PvAO+CgpqMhi1BaS6mZukaAzFrwVu8jhYO1JYoiFTEsK1rB+MvwaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182378; c=relaxed/simple;
	bh=41EXYz3mcc8Vxgzcxev3T2T3Rr4GLVQmC/0jE8NwM34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PRyfrvPSqZ46dl/jxXFlCl9hQ03dpUFN0pJQWRv7PP9C+iPrLivCOlnHqMhtC0bBEkNUDpqhPbPXoDASPY6K86kZK5kykSfVSD0+ITic+5onsFvZ9EVbfYzTKxlUiAmdRVC0c07eyX9YoNVWCvSvvk6e6N+syOQhjVWHdCY4L7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njdh4tba; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-db410931c23so9244893276.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182376; x=1706787176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSEZZ/0t08iakeLHf9HEgGlamVuM6vmU/omnMXoH+gg=;
        b=njdh4tbarh0hJvKdHJYXVa8LTHL02BxJG+LEfl2lNC0V6mNaB9aAbWCY1lwLpXz/ZL
         GbqY/VmSt0Qg7VpIBMnI4VjoEyYvZd7t16ouhicQaLPrG6PDj52Eqa2JXrH8MrYhr0AC
         F/n9scY1skCG34p/iSNvOyrBlbRwV+MjWFhXu4n4hHQGh4hug6g3tpOwdduoi7M1MMF9
         W5Upg2lOeO9TmaTqSmgadSwtvUScUJjnY5sute9IP6fHrXQEckuvP9UFuBcZRrEO/urS
         aoadYIxZJImkUSY8QVH3koPhAjR58A4pRmDIF7kDY9NluFPl0m7/UPDtkCf7JIZGLtWa
         AmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182376; x=1706787176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSEZZ/0t08iakeLHf9HEgGlamVuM6vmU/omnMXoH+gg=;
        b=ulyk6ha7O79y4TUXkzCR2/0ZuWLdwN3HA997PeVjlhcoZ7Kiub73cZoOcdsGox2TbP
         LarS0Iy0MlOenpqnNb/T8DnAxR6CbVedOKMosi9TgUj0fQltNC+B6RQt715bVxNekhZm
         IETCXe1dHAOGX9Fhrt51/BDpWWPXVB/u5vAhbq3RIn0anN28E0nLz8xYmj7avnteATpU
         dtAcmQYTVkym70iC7sxt0VrDNU8tb8gqIU20CgEo5IO6B4Y4cuLDuHpMEOiDe3Pv5Z6g
         VYSLCs3FBiK3jidfZn49nvLi20jlFEo2+nbuAfJ2KtSJVEdVNXuAk85Bw+mv94uwJbfq
         pPnQ==
X-Gm-Message-State: AOJu0YxdsMRVtxrXMLRPIci6HLS2iVgNbkOWluBayW15v0o1X8ZT+ipt
	4I2zoNKhOeLnfKkI2Qx118ZGEbJ69pvgHgsrnChxsxlBWPCA+iMWCsGRWh1INYx6Au9Riw==
X-Google-Smtp-Source: AGHT+IG6j5stYS4q8sJ3wfMC0gMeDb6MvTSx5RF0yUkFip+ir4SyA6vV6wCd3hBGjIdbMiFtXSaTmTqM
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:8109:0:b0:dc6:2054:fc89 with SMTP id
 o9-20020a258109000000b00dc62054fc89mr414899ybk.0.1706182375798; Thu, 25 Jan
 2024 03:32:55 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:27 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4814; i=ardb@kernel.org;
 h=from:subject; bh=0AOJ+7yJMsTHEXzL59P9/MB+D3g7SPvsSd6W4QSdt0M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT67MQxsNb1ovWb7mSqJZ/WSa+7OSkT4dXRPoecD6f1
 L31yWTZjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRWzsYGb5Hrwr9yGUna5jX
 eeYPq01uI+MhQ/EPm7SE/nF9ucPfbMHIcOqFglAV+8ky/etHlfnvzAu56+T1Qk69aEvZj5WZ+xe vZQYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-27-ardb+git@google.com>
Subject: [PATCH v2 08/17] asm-generic: Add special .pi.text section for
 position independent code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add a special .pi.text section that architectures will use to carry code
that can be called while the kernel is executing from a different
virtual address than its link time address. This is typically needed by
very early boot code that executes from a 1:1 mapping, and may need to
call into other code to perform preparatory tasks that must be completed
before switching to the kernel's ordinary virtual mapping.

Note that this implies that the code in question cannot generally be
instrumented safely, and so the contents are combined with the existing
.noinstr.text section, making .pi.text a proper subset of the former.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  3 +++
 include/linux/init.h              | 12 +++++++++
 scripts/mod/modpost.c             |  5 +++-
 tools/objtool/check.c             | 26 ++++++++------------
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5dd3a61d673d..70c9767cac5a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -553,6 +553,9 @@
 		__cpuidle_text_start = .;				\
 		*(.cpuidle.text)					\
 		__cpuidle_text_end = .;					\
+		__pi_text_start = .;					\
+		*(.pi.text)						\
+		__pi_text_end = .;					\
 		__noinstr_text_end = .;
 
 /*
diff --git a/include/linux/init.h b/include/linux/init.h
index 3fa3f6241350..214f6315aaec 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -55,6 +55,17 @@
 #define __exitdata	__section(".exit.data")
 #define __exit_call	__used __section(".exitcall.exit")
 
+/*
+ * __pitext should be used to mark code that can execute correctly from a
+ * different virtual offset than the kernel was linked at. This is used for
+ * code that is called extremely early during boot.
+ *
+ * Note that this is incompatible with KAsan, which applies an affine
+ * translation to the virtual address to obtain the shadow address which is
+ * strictly tied to the kernel's virtual address space.
+ */
+#define __pitext	__section(".pi.text") __no_sanitize_address
+
 /*
  * modpost check for section mismatches during the kernel build.
  * A section mismatch happens when there are references from a
@@ -92,6 +103,7 @@
 
 /* For assembly routines */
 #define __HEAD		.section	".head.text","ax"
+#define __PITEXT	.section	".pi.text","ax"
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 795b21154446..962d00df47ab 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -813,9 +813,12 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define INIT_SECTIONS      ".init.*"
 
-#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
+#define ALL_PI_TEXT_SECTIONS  ".pi.text", ".pi.text.*"
+#define ALL_NON_PI_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
+#define ALL_TEXT_SECTIONS  ALL_NON_PI_TEXT_SECTIONS, ALL_PI_TEXT_SECTIONS
+
 enum mismatch {
 	TEXTDATA_TO_ANY_INIT_EXIT,
 	XXXINIT_TO_SOME_INIT,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..af8f23a96037 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -389,6 +389,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".noinstr.text") ||
 		    !strcmp(sec->name, ".entry.text") ||
 		    !strcmp(sec->name, ".cpuidle.text") ||
+		    !strncmp(sec->name, ".pi.text", 8) ||
 		    !strncmp(sec->name, ".text..__x86.", 13))
 			sec->noinstr = true;
 
@@ -4234,23 +4235,16 @@ static int validate_noinstr_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	int warnings = 0;
+	static char const *noinstr_sections[] = {
+		".noinstr.text", ".entry.text", ".cpuidle.text", ".pi.text",
+	};
 
-	sec = find_section_by_name(file->elf, ".noinstr.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
-	}
-
-	sec = find_section_by_name(file->elf, ".entry.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
-	}
-
-	sec = find_section_by_name(file->elf, ".cpuidle.text");
-	if (sec) {
-		warnings += validate_section(file, sec);
-		warnings += validate_unwind_hints(file, sec);
+	for (int i = 0; i < ARRAY_SIZE(noinstr_sections); i++) {
+		sec = find_section_by_name(file->elf, noinstr_sections[i]);
+		if (sec) {
+			warnings += validate_section(file, sec);
+			warnings += validate_unwind_hints(file, sec);
+		}
 	}
 
 	return warnings;
-- 
2.43.0.429.g432eaa2c6b-goog


