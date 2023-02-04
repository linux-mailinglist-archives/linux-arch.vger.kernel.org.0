Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1A68A8A8
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBDHDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 02:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjBDHDM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 02:03:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0851DB94;
        Fri,  3 Feb 2023 23:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDD560917;
        Sat,  4 Feb 2023 07:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A48C4339E;
        Sat,  4 Feb 2023 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675494189;
        bh=YqOQcx7krUe87k6vBeiLe+HR095OSbjNEu/uluKhLMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8KA3ZA1hhMqEu+tI6Z8FSQm7L/FGKauZbpLMV+Phc6ePXF/JYuG+H6QW6faK39Qt
         wGeO6PJ+wvwNHzGpx9dqbnFxEch0iOxaskMzAaT2efIuMr6KBE4DHDnl1XhC0zHWj2
         1F6wvJdZxkXNMEBnT3sw39PYU8ofbFOyiAZqAnUAy6q0vMJVC+iLVobN+MS9Vbx8t8
         v2+bpgihmJipnAVKTjwDmjCiA8YrzKk3djbrnWugwFK5W/vgZClzyoHuRzUtUSGGRu
         RC/gLBCmH1RM+Vxt87WVQ1CWDTOTm0R5ToDRX/57coPl04xmF/99XGoRq75ue/29Wz
         4I5oX4MiBDrtQ==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org,
        miguel.ojeda.sandonis@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V16 1/7] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Sat,  4 Feb 2023 02:02:07 -0500
Message-Id: <20230204070213.753369-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230204070213.753369-1-guoren@kernel.org>
References: <20230204070213.753369-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

