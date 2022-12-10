Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A3648FE5
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 18:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLJRMe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 12:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiLJRMd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 12:12:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7EBC9A;
        Sat, 10 Dec 2022 09:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB036B808C6;
        Sat, 10 Dec 2022 17:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBF9C43398;
        Sat, 10 Dec 2022 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670692349;
        bh=W3STfz+q/HLqif/5T6LkLEIliEWH5xJbJ52wW/3KA+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fc/PhVhqgWiTfb7inOg5nhG7idSarUYNdjr5+JsyWZaWhu2JLmRGII6Dvkg78yQr0
         z9PyN+tcQxjR2MYrmzjUEGdfJyUjhJURoZo7wNpKbE+mq3FOTDpdj8CJb1ssCqqEJu
         +JGApwuPZBqqdF5BgGLGN6nv8PsTDFCj6h/UfeYRUc7s065I/CzXo9uyYmlvd1wHAi
         SVPzpcBAuVdZ5yXt5e9Gtzyy0DczmJapggV40LSB0Eg4Cj2YXVVXuPGVfZdK0LsIuT
         BT4yHB/QtXdFdcTvnoTNyCn8R4pctZwTcnxetP9t+Fq6fbVGIMqJy2EQWd5ySK9VP5
         lRSjAIXJEAIAg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH -next V11 1/7] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Sat, 10 Dec 2022 12:11:35 -0500
Message-Id: <20221210171141.1120123-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221210171141.1120123-1-guoren@kernel.org>
References: <20221210171141.1120123-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Using __noinstr_section() doesn't automatically disable all
instrumentations on the section. Inhibition for some
instrumentations requires extra code. I.E. KPROBES explicitly
avoids instrumenting on .noinstr.text.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index eb0466236661..41e4faa4cd95 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -230,12 +230,19 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
-/* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+/*
+ * Using __noinstr_section() doesn't automatically disable all instrumentations
+ * on the section.  Inhibition for some instrumentations requires extra code.
+ * I.E. KPROBES explicitly avoids instrumenting on .noinstr.text.
+ */
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_profile	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage	\
 	__no_sanitize_memory
 
+/* Section for code which can't be instrumented at all */
+#define noinstr __noinstr_section(".noinstr.text")
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
2.36.1

