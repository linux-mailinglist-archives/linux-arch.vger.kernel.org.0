Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C9269ED73
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 04:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBVDbB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 22:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjBVDbA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 22:31:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C64305EF;
        Tue, 21 Feb 2023 19:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CE561200;
        Wed, 22 Feb 2023 03:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67812C4339E;
        Wed, 22 Feb 2023 03:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677036657;
        bh=YqOQcx7krUe87k6vBeiLe+HR095OSbjNEu/uluKhLMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6160hfcKH01BiNRi4e+qr/N58FoomeLjiCUX7L8MAxJK1UflNFYnO/sSQhci37UW
         nnXKpGANVGHDCmP5YMek6z3zbRhK1sRA2En66Vp2kZITdBtdvegcFMCe+Xyczuuoye
         sXpOHTRE7IkuB/JKtbit9njwr4iYGeOg/UH4eGdPy5k0OXm9RiaeIjgjK0+qaMszZH
         sZVUZW4mXbHQeo3p8WkeknGAE8P4uqbT6+Hs532rkWXDm5bNEhVb60vHso+7C1KeEE
         v+5rp6LUgjBhRHkPkDy1cRjxmg8rI37PiszFIVC/eiEAQSnQR9Gl4cKlKXxeA3Cjgm
         BbGL2IVVhkLew==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V17 1/7] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Tue, 21 Feb 2023 22:30:15 -0500
Message-Id: <20230222033021.983168-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230222033021.983168-1-guoren@kernel.org>
References: <20230222033021.983168-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 include/linux/compiler_types.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 7c1afe0f4129..0a2ca5755be7 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -231,12 +231,19 @@ struct ftrace_likely_data {
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

