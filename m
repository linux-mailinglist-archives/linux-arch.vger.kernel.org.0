Return-Path: <linux-arch+bounces-5663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8E93E953
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 22:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6811F21682
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2024 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365D7CF34;
	Sun, 28 Jul 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cbw9W6ak"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AC47BAFF
	for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722198661; cv=none; b=eiuvu+Zuw7KVrluHJIyzIofc1jJlfrlBlur1IzGydYWE2UetX/dSRBRbhZBk32jaIem691ysXkhcNDbof3IyB3pEXttXObGHHOaoJ9bG7mHsMib7S3MdP+7M6xLfY4SmLrcPC2tDbTIk1c+oJNxBWAlYCWOM5uFtp6KYOu53JyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722198661; c=relaxed/simple;
	bh=beGZIYM3TPtatxrKmLYPAD0/CJjAgMIMbsJ074Ik9tg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnd4WnDd9ND5ZbX7kTZxD/nr6NymcgQiKZZ5IkmUtD8S16I1rVN7dIafADMbBT5P7qHg4Hn4n0T0o+A7iBE3wFLDFe0km/AOv8GuFRGQ6peRXLoNnmfaw/hW18ymIRCZ2GjvOqM+TjzY4rF+ZyQjOlrvp706xlQ2Bd+DfBlQPyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xur.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cbw9W6ak; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xur.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b2ac67a53so2573657276.0
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2024 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722198659; x=1722803459; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nypg1QHLbTqa/1p2hSGPQd9/Gf8EHrTdP6hUDec9EdE=;
        b=Cbw9W6akg0cNIlC5zMjJAlxlLpwYzGB4rcfnqydC9Jze3jMb2XKqKzGywKdmsn/ijN
         c6MhSTyYHyEAmibBRh9dGqbOGFNum3nck1HFGOVA7duZoxDFns+AxrCKucm4tkyTgn6m
         K5oHXQhhQKUpCdP93JbAk3kYLeo5iMoJBXN9Y3pakzBjoBT63FrRkzA2GaanOCaXXENX
         ykkQGAP9vfGLVmDJaQgxg7lJ/Z1gxWfVIwXRrq8pzDMJggfmixLuHZZNFaZLeASdGd9I
         oiWiiteyOxAjMHTIhX6t1izT/TlPofqhWVMWpGZyvre1tO/+TyFNyfOSed1VXklQ6SqX
         nsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722198659; x=1722803459;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nypg1QHLbTqa/1p2hSGPQd9/Gf8EHrTdP6hUDec9EdE=;
        b=ntbZfZmmTzEkqd8hGKN/Qf6DlcyKAQ2y4WzmBXE1llTClo/qi82uA1ItRqBWxjjUWs
         kzjrPJgeZBFoncGJMJKO2sV51exWbK4iGr6UiKqEfCh28SypZI2x7r/LgakEnKaVD96i
         AiDAzfKAvelYuvNMyf7ib4QtXmYGJRcWHrW4Bw5xiMfv7VPOYq8sZBALV73n3nfxk/p5
         NyqN5SpEqv3+fSZ3r7ECY9zlO6ggSguHDoiECC83IMW0QxVW6c2BnnFbN9WNndTJ1Qfu
         37ZrPUrqCGi4/UfsXoIBEMFZcRRnCqs5MLDWioM7E6x00WfdCvDBbJY67M8snpRzcvxX
         My7g==
X-Forwarded-Encrypted: i=1; AJvYcCWmv05zH/VkknYgfXdY3MRi4tR8IGP6vja6JXdCkJXmnMawQkjx43qHR1YrSyIQQCb2j28qf16pYTNqabbsRAhMJTlYODnViYzCeg==
X-Gm-Message-State: AOJu0YycNgzWt6mP+crSCTga1xE1eTRNZb2o93XQtQLJFucxNdoUMXFI
	af97hrEr4oE5aiVfKponpB0a1HqpWZ4Q9Z29ea2Jcxc8hYrcfMyOxe6evt07QXwIRw==
X-Google-Smtp-Source: AGHT+IGhcfBcAn7qASZpEvCq18PhN0EBXHuUDxWLgxYpaHcb/kQ/zFsB5MAYY4oJLzn0xh4JiWgv4U8=
X-Received: from xur.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2330])
 (user=xur job=sendgmr) by 2002:a25:6844:0:b0:e0b:3432:73d4 with SMTP id
 3f1490d57ef6-e0b5560e6b3mr58714276.1.1722198659209; Sun, 28 Jul 2024 13:30:59
 -0700 (PDT)
Date: Sun, 28 Jul 2024 13:29:57 -0700
In-Reply-To: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240728203001.2551083-5-xur@google.com>
Subject: [PATCH 4/6] AutoFDO: Enable -ffunction-sections for the AutoFDO build
From: Rong Xu <xur@google.com>
To: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Enable -ffunction-sections by default for the AutoFDO build.

With -ffunction-sections, the compiler places each function in its own
section named .text.function_name instead of placing all functions in
the .text section. In the AutoFDO build, this allows the linker to
utilize profile information to reorganize functions for improved
utilization of iCache and iTLB.

Co-developed-by: Han Shen <shenhan@google.com>
Signed-off-by: Han Shen <shenhan@google.com>
Signed-off-by: Rong Xu <xur@google.com>
Suggested-by: Sriraman Tallam <tmsriram@google.com>
---
 include/asm-generic/vmlinux.lds.h | 37 ++++++++++++++++++++++++-------
 scripts/Makefile.autofdo          |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f3de66bda293..97c8399e5532 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,18 +95,25 @@
  * With LTO_CLANG, the linker also splits sections by default, so we need
  * these macros to combine the sections during the final link.
  *
+ * With LTO_CLANG, the linker also splits sections by default, so we need
+ * these macros to combine the sections during the final link.
+ *
  * RODATA_MAIN is not used because existing code already defines .rodata.x
  * sections to be brought in with rodata.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
+#else
+#define TEXT_MAIN .text
+#endif
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
-#define TEXT_MAIN .text
 #define DATA_MAIN .data
 #define SDATA_MAIN .sdata
 #define RODATA_MAIN .rodata
@@ -577,6 +584,20 @@
 		__cpuidle_text_end = .;					\
 		__noinstr_text_end = .;
 
+#ifdef CONFIG_AUTOFDO_CLANG
+#define TEXT_HOT							\
+		__hot_text_start = .;					\
+		*(.text.hot .text.hot.*)				\
+		__hot_text_end = .;
+#define TEXT_UNLIKELY							\
+		__unlikely_text_start = .;				\
+		*(.text.unlikely .text.unlikely.*)			\
+		__unlikely_text_end = .;
+#else
+#define TEXT_HOT *(.text.hot .text.hot.*)
+#define TEXT_UNLIKELY *(.text.unlikely .text.unlikely.*)
+#endif
+
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -585,13 +606,14 @@
  * code elimination or function-section is enabled. Match these symbols
  * first when in these builds.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
+#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
+defined(CONFIG_AUTOFDO_CLANG)
 #define TEXT_TEXT							\
 		*(.text.asan.* .text.tsan.*)				\
 		*(.text.unknown .text.unknown.*)			\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
@@ -599,9 +621,9 @@
 #else
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text.hot.*)				\
+		TEXT_HOT						\
 		*(TEXT_MAIN .text.fixup)				\
-		*(.text.unlikely .text.unlikely.*)			\
+		TEXT_UNLIKELY						\
 		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
@@ -609,7 +631,6 @@
 	MEM_KEEP(init.text*)
 #endif
 
-
 /* sched.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
diff --git a/scripts/Makefile.autofdo b/scripts/Makefile.autofdo
index 882fa7e801ba..f765bd9e81d7 100644
--- a/scripts/Makefile.autofdo
+++ b/scripts/Makefile.autofdo
@@ -5,7 +5,7 @@
 CFLAGS_AUTOFDO_CLANG := -fdebug-info-for-profiling -mllvm -enable-fs-discriminator=true -mllvm -improved-fs-discriminator=true
 
 ifdef CLANG_AUTOFDO_PROFILE
-CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE)
+CFLAGS_AUTOFDO_CLANG += -fprofile-sample-use=$(CLANG_AUTOFDO_PROFILE) -ffunction-sections
 endif
 
 ifdef CONFIG_LTO_CLANG
-- 
2.46.0.rc1.232.g9752f9e123-goog


