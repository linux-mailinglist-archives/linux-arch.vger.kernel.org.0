Return-Path: <linux-arch+bounces-1787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49288411AD
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96B81C23997
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404B415958D;
	Mon, 29 Jan 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rMRqhsR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491015957F
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551555; cv=none; b=B5bsZFOdxaY/cmpydUvpFcueezTlrR9BmBkC3om+4qAzVvXFhXsoU95TKOKFHJoRNwdcID8qEf3lTbdD72iseclU9nARFp7kok+q5zGa/yRSkWlM6wgww/zqIpJWgOmE887brDxAtAb1wfmYwZXO3FdeJGRxgAz6RqAMF7QES5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551555; c=relaxed/simple;
	bh=UonHlMqjgEJH+56iHsla4J1Fp0ovIjuTCcCNqIOSjk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qltc/y02OhKu3H9nKGjvMZo/UPVrj4+r7xnuow8XyGq5mWTKl0jLQjd23Z017LhqZ5xGGw9Fosj+rMQbDAjV2Y0WwDQq3NC4Oqq/owZjPOrAflyTgSCSKaz7p4ZzsXvmBCFVddZM9InWe3ZsbRhSqWNfi+opSThyETfDJypb17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rMRqhsR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2358dce6bso4251512276.3
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551552; x=1707156352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap19tN/uXJaW7OWqMmvQ4dnQyY/I7jMfOfg7BtI2vyw=;
        b=3rMRqhsRr2ILZhU63uvdDZ7A2+TChb4YsKFPIn7heDCsYkCjhFfVsS5IMhxrrkTjqT
         xxpwSSVVivQq2m1dmUx/+bFxjMPI3WnccFpX58jOUg9+cxRK1GJjK3EZi0HvnfCK9rTz
         t/21YIcOUjwe+eJJaypUp8gfwY7gIz/wMZi8WNjGPIxK4AFKpx9Z0NN2P3pgV1bFC+2P
         eqHE/FY2hjNjdFfIhHGFQ/UWM9lrExQg1vCqH5EUB0f2/9rzFl4R6a+9ACDamKmeEm1R
         Y8plQSf9z81FWXQI6ax/nbAqIoqVtgJQWhCJusOSloA622t6K7dZo33zzQy7zuIrjk2Q
         BMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551552; x=1707156352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap19tN/uXJaW7OWqMmvQ4dnQyY/I7jMfOfg7BtI2vyw=;
        b=DGBXM7FTZ0pdTBWhVIHQ09glCLLcgDwvTcVYuvIz7Z8L+RUsyV7Ez3tJcWtcmhMdwn
         bKQNwQt7EtmTS3lxt0jPiIHqSqdAmzHp+pMmcZe6L/hzByAeA6cfrnq2ZaSkznT5K2vJ
         MaipdY+bXyUBJ34I6a/fra7EZOmgbHXD0awN7xEO1Wmz591sQniHLKs1rzEfKZn/AvIL
         bBijIFQoyp/xCB2xNbpQA24LVEk6C05gc4U3V/EpevR5PbdOl4ErgiiK2jTUW1XENg8E
         eFSTM4NcUjzhd/lFV9PtGUmsrFxnczstleVBiqGF3FmYp2B95EFXJIgEXkEacEwJCZQ2
         4+mQ==
X-Gm-Message-State: AOJu0Yz5lxsNwQ4XCXeXh5/UXhElLhjxf7HjZ+9FbMFh20LRUDQaSJK7
	Xdh8hbnSrrOiYmjXIZbMyV9xegNW3eRkgIoFpjgXWbLEtorVnFAppNsCsADIaNZ2dy+iqQ==
X-Google-Smtp-Source: AGHT+IFdlkgRmOLuPYQ4HYGJOcfOyvmrF8pJsjH+7Ju2xNGTWiYFEILGYxiFeCWVd7IhoWiApQSqZNZJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1b01:b0:dc2:3619:e94e with SMTP id
 eh1-20020a0569021b0100b00dc23619e94emr414348ybb.6.1706551552670; Mon, 29 Jan
 2024 10:05:52 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:13 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4822; i=ardb@kernel.org;
 h=from:subject; bh=Kb1Zn5CHQVUPzxgeHo6uRlzKgwc2NWlyfd+RzWsJs24=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i1tSpVekMhqlzlrlfb/JMsl/O//tz/rfnvtxfTN9K
 xfxQaivo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkX5Lhv5OomU7pjraIyH/7
 ztt9/Of40YFDqmqzV+W3Fp85b/RspRj+yorzxqrcmK60VSHRPl6b5eeETAbXibMsFrfufP7hcKI IBwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-31-ardb+git@google.com>
Subject: [PATCH v3 10/19] asm-generic: Add special .pi.text section for
 position independent code
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
index 3fa3f6241350..85bb701b664c 100644
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
+#define __pitext	__section(".pi.text") __no_sanitize_address notrace
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


