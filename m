Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C16F7156
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 19:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjEDRna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRn3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 13:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92912F
        for <linux-arch@vger.kernel.org>; Thu,  4 May 2023 10:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1EB1612E7
        for <linux-arch@vger.kernel.org>; Thu,  4 May 2023 17:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC1DC433D2;
        Thu,  4 May 2023 17:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683222207;
        bh=ihjmSvs/qLkudOIBOH6YAA4nlt8DLXtiyZ5DxYWf3cQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jDVQGeskZtkUxtJLc+LNhJGKgDriZl4AP0XdSU64kJkVLWXqm/px85+Js4kUAdg+V
         OkAamhHXdvVxrlN6huYNra6Q3JGoBUzJGtWGSx6d6otI0iB6/8sk3UJVCQr8ySnFCD
         AILXEioAAQDQTvQ4J8HgB6L6JB8e+C3VzzBIaTkK43WDXlbZIQ0FUR/S99eYOzgopd
         ani8SQlKnC+4R8yQaHSXQ9OiR+UOOsunZ91ihRGsttsQ0LpXG/S1bre1NtVuQU8nUB
         WproENnf666AbOJsylxQL/rwZKicPxcI9RRJdoFGQniyXb41hNhYX0KRPA8NS6FQUf
         GhEWCQniUOcJg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH] kallsyms: Avoid weak references for kallsyms symbols
Date:   Thu,  4 May 2023 19:43:20 +0200
Message-Id: <20230504174320.3930345-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=ardb@kernel.org; h=from:subject; bh=ihjmSvs/qLkudOIBOH6YAA4nlt8DLXtiyZ5DxYWf3cQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISX43Y5vH/hC18QUPSk5qMpy2c9qZbzOWtNUV79IC7HS7 ydWp03vKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNxNmJk+Mw6d+vr4qRqpWeW Du+zFCMFzohUdq6JUrWZu1JlAnPfTIb/UX3deos0v99T55/JynUr3PSo8yTDuCdLZf44N78+Ypf PDwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Fangrui Song <maskray@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/asm-generic/vmlinux.lds.h |  9 +++++++
 kernel/kallsyms.c                 |  6 -----
 kernel/kallsyms_internal.h        | 25 +++++++-------------
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed341d..dd42c0fcad2b519f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -460,6 +460,15 @@
  */
 #define RO_DATA(align)							\
 	. = ALIGN((align));						\
+	PROVIDE(kallsyms_addresses = .);				\
+	PROVIDE(kallsyms_offsets = .);					\
+	PROVIDE(kallsyms_names = .);					\
+	PROVIDE(kallsyms_num_syms = .);					\
+	PROVIDE(kallsyms_relative_base = .);				\
+	PROVIDE(kallsyms_token_table = .);				\
+	PROVIDE(kallsyms_token_index = .);				\
+	PROVIDE(kallsyms_markers = .);					\
+	PROVIDE(kallsyms_seqs_of_names = .);				\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 77747391f49b66cb..5b16009ee53aa05b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -331,12 +331,6 @@ static unsigned long get_symbol_pos(unsigned long addr,
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
index 27fabdcc40f57931..cf4124dbcc5b6d0e 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -8,24 +8,17 @@
  * These will be re-linked against their real values
  * during the second link stage.
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
2.39.2

