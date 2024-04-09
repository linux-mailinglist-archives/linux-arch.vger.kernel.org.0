Return-Path: <linux-arch+bounces-3519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A289DDF6
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB29DB28B0F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 15:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDAA132802;
	Tue,  9 Apr 2024 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zzKXP78O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55481130E2E
	for <linux-arch@vger.kernel.org>; Tue,  9 Apr 2024 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674906; cv=none; b=JUcRPpLcRiuJivqLgQYjSyJR7EyP+8H+YaF5Iq5iDDfZiR2k7Yu6VrmSyeLMNfTvlQUvM6ss0poLnkytRJpc9crSUfoe0DC3ouXiqZVbV0r2CnRMsFs8mG+WFSU0T9+L2HCLtsPIalt1BhLNgIx2jptKAqI3yjj0EbOhYFe8Pfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674906; c=relaxed/simple;
	bh=7xZ8SeIpLR8unxHGJ2waGwWOo71Rkq91p6J16D7wil4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EaYH0dmecicqSqbrHQdPmkX1qcpLK2euCtUljUID9Ff2dp6z0hq0RLI7iC1RzKJ+UD5MvQRE3kgvhw+CZfCEDeh5PF2AEJlLIHodbVklMkmmaym5WpwJyI/nX5Olfzh4gbXOrShGlmo6JGVWK4w9yxTXnxAs2ilXXYv3BitMHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zzKXP78O; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41663448bcbso12034665e9.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Apr 2024 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712674903; x=1713279703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcRm/bqwNQMHH+e8ox8c6p1gyU6LuJWVGjxyAVGlxGQ=;
        b=zzKXP78OGssbn49YEx7ASSJKAkICUMbvHjA3xWaeNcMV6IJ8hJ/VvHNNOctzWtKIgF
         qPjKG3NJmwT0Foc6BBG2AYBZlGcyfD4Wsk3d7JFZMIa2ATp7O2S1udYEOCPN7IYqpxxz
         1lma/Ey+DYN0ikCaXQGL86WQWLXVY3nXKUKLcUhDT2I/E+ZwCl0BMxio8Xr3TXitrKs0
         reDh9/xLqOwxbnOIFmXiXhyrmI/1AWHiZtPpjMfOR1agNIuL7wHJktMeuWLvSJLFl+ku
         KazRILdeVd7+OV1MH911NdhsLeKKrs6N9MjWj6SMK/+i0+RtrsFdqFtj6ock2bxjO0RU
         0fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674903; x=1713279703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcRm/bqwNQMHH+e8ox8c6p1gyU6LuJWVGjxyAVGlxGQ=;
        b=q+dcTxU+sbTMmeW/Gp07x1gbwVxb4JbZDymcveKzaTY70H0Tn9hG4qSCJQEfB6dJrK
         uZcQ5HlOVb1lI/YIwdrRFBQJDmTmOwhk78RKh8vbrQAx652Hw/dgqM6gcqP5TnXT7I8p
         lLyKif6F4B4tbYZua0uxLTwaV0GXQdCxDtLTHx5lpOkiQ+isyt5tzuZujAZX7KvzMYZq
         XDFkmpMzSqBxS5c71pGOsEyLzlDoTbRoTkCNogBAX8Cbp83CBUHu42RWRBOC6WQKN3Tz
         EOpjOspgu59eqUtqFcgqm4UkAgFPlYzJNtWN4f4el0NJjx4zTestTHmCYt08j8nSZi2M
         UCHg==
X-Forwarded-Encrypted: i=1; AJvYcCVntJTqQqFxnoIhFw/sXqenctsEMHL8j7Mh7en02WkQeWfinUtIywxqYN8EEqLmnmh+cszm2gp4EMG7sQNMI1g3Ac6u8hdj0t+NAA==
X-Gm-Message-State: AOJu0YykuMm3x4G5I2Ro30vsrFd96GtTUs+80os7COOtAgj1FKcJYEFT
	fzDhffXJwqkAghT5ES7RoBzmPJLVWgeFhAx2wNbadrJ95FI79X2VOrQnh8f0MVAAY3K/hQ==
X-Google-Smtp-Source: AGHT+IHvCKu1YErbunDRlQQT1mQ2V1BPeNyzIW3NN67RkKNkrJSZrXol+cAxMIkYVKNsmKpsmezyOCuk
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3151:b0:416:99bb:f71e with SMTP id
 h17-20020a05600c315100b0041699bbf71emr167934wmo.1.1712674902801; Tue, 09 Apr
 2024 08:01:42 -0700 (PDT)
Date: Tue,  9 Apr 2024 17:01:34 +0200
In-Reply-To: <20240409150132.4097042-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409150132.4097042-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5349; i=ardb@kernel.org;
 h=from:subject; bh=bi9e/PWpqNvBy6Iv3Xzt+OhmpfAYnnfD/65oU75l2lY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU00wk8x2uq7Idudy4Er3V7GfTVv3fhVhfl+pYyr8bq5W
 pza3qkdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJrJBj+Vzh1v1rY5nenQeF3
 +LO6+ZzNoXNf3OCeUfvT7/6kuw/2sjL8DzHhWPYp7+qG/U3cfEeiLQsO33qZ+urhTdYVrx/ru1r ycgIA
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409150132.4097042-6-ardb+git@google.com>
Subject: [PATCH v2 1/3] kallsyms: Avoid weak references for kallsyms symbols
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

kallsyms is a directory of all the symbols in the vmlinux binary, and so
creating it is somewhat of a chicken-and-egg problem, as its non-zero
size affects the layout of the binary, and therefore the values of the
symbols.

For this reason, the kernel is linked more than once, and the first pass
does not include any kallsyms data at all. For the linker to accept
this, the symbol declarations describing the kallsyms metadata are
emitted as having weak linkage, so they can remain unsatisfied. During
the subsequent passes, the weak references are satisfied by the kallsyms
metadata that was constructed based on information gathered from the
preceding passes.

Weak references lead to somewhat worse codegen, because taking their
address may need to produce NULL (if the reference was unsatisfied), and
this is not usually supported by RIP or PC relative symbol references.

Given that these references are ultimately always satisfied in the final
link, let's drop the weak annotation, and instead, provide fallback
definitions in the linker script that are only emitted if an unsatisfied
reference exists.

While at it, drop the FRV specific annotation that these symbols reside
in .rodata - FRV is long gone.

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # Boot
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20230504174320.3930345-1-ardb%40kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 19 +++++++++++++
 kernel/kallsyms.c                 |  6 ----
 kernel/kallsyms_internal.h        | 30 ++++++++------------
 3 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f7749d0f2562..e8449be62058 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -448,11 +448,30 @@
 #endif
 #endif
 
+/*
+ * Some symbol definitions will not exist yet during the first pass of the
+ * link, but are guaranteed to exist in the final link. Provide preliminary
+ * definitions that will be superseded in the final link to avoid having to
+ * rely on weak external linkage, which requires a GOT when used in position
+ * independent code.
+ */
+#define PRELIMINARY_SYMBOL_DEFINITIONS					\
+	PROVIDE(kallsyms_addresses = .);				\
+	PROVIDE(kallsyms_offsets = .);					\
+	PROVIDE(kallsyms_names = .);					\
+	PROVIDE(kallsyms_num_syms = .);					\
+	PROVIDE(kallsyms_relative_base = .);				\
+	PROVIDE(kallsyms_token_table = .);				\
+	PROVIDE(kallsyms_token_index = .);				\
+	PROVIDE(kallsyms_markers = .);					\
+	PROVIDE(kallsyms_seqs_of_names = .);
+
 /*
  * Read only Data
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
+	PRELIMINARY_SYMBOL_DEFINITIONS					\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 18edd57b5fe8..22ea19a36e6e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -325,12 +325,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	unsigned long symbol_start = 0, symbol_end = 0;
 	unsigned long i, low, high, mid;
 
-	/* This kernel should never had been booted. */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
-		BUG_ON(!kallsyms_addresses);
-	else
-		BUG_ON(!kallsyms_offsets);
-
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
 	high = kallsyms_num_syms;
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 27fabdcc40f5..85480274fc8f 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -5,27 +5,21 @@
 #include <linux/types.h>
 
 /*
- * These will be re-linked against their real values
- * during the second link stage.
+ * These will be re-linked against their real values during the second link
+ * stage. Preliminary values must be provided in the linker script using the
+ * PROVIDE() directive so that the first link stage can complete successfully.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[];
+extern const int kallsyms_offsets[];
+extern const u8 kallsyms_names[];
 
-/*
- * Tell the compiler that the count isn't in the small data section if the arch
- * has one (eg: FRV).
- */
-extern const unsigned int kallsyms_num_syms
-__section(".rodata") __attribute__((weak));
-
-extern const unsigned long kallsyms_relative_base
-__section(".rodata") __attribute__((weak));
+extern const unsigned int kallsyms_num_syms;
+extern const unsigned long kallsyms_relative_base;
 
-extern const char kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const char kallsyms_token_table[];
+extern const u16 kallsyms_token_index[];
 
-extern const unsigned int kallsyms_markers[] __weak;
-extern const u8 kallsyms_seqs_of_names[] __weak;
+extern const unsigned int kallsyms_markers[];
+extern const u8 kallsyms_seqs_of_names[];
 
 #endif // LINUX_KALLSYMS_INTERNAL_H_
-- 
2.44.0.478.gd926399ef9-goog


