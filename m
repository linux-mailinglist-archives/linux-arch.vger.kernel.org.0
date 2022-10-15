Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EFA5FF9E2
	for <lists+linux-arch@lfdr.de>; Sat, 15 Oct 2022 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJOLuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Oct 2022 07:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJOLug (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Oct 2022 07:50:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A82980D;
        Sat, 15 Oct 2022 04:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C3B6B8093B;
        Sat, 15 Oct 2022 11:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0FBC433D6;
        Sat, 15 Oct 2022 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665834627;
        bh=+RHLFV5pzLwomxBWNfwElTQCJrr1T7IUJgGRxuyfbig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFDk/wKL8L2heHLUL+JFQdLtovwC9yEN0lZn8EGMy9/otFEGsIiBALQeSDD5H0uE/
         3+y7t7yVe4qhEvCp0UugE1uJSYvaVJg3HJLC2Tk7cMBywJw74RH32RsBnHSXk3csvE
         95k+JsoE2+iG/WRjAA0Kgoyv5O6sJ7NjvhKTELr9lKgqCSIisSPcqHwWp221kFj5ad
         8uiX3WSSYs0obeZi9vDEozxWgv+77BAhhcj1s9hfepa64V/eOzl5t2mhDAS2VHhwB/
         fj7xb20+tAs12T3G6g5TLOA7zbsuVb8Bo4veLjzFKwbyCRtewNhG5bTOH+mO71B3Fe
         rUtj2bAv4acfA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH V7 04/12] compiler_types.h: Add __noinstr_section() for noinstr
Date:   Sat, 15 Oct 2022 07:46:54 -0400
Message-Id: <20221015114702.3489989-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221015114702.3489989-1-guoren@kernel.org>
References: <20221015114702.3489989-1-guoren@kernel.org>
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

And it will be extended for C entry code.

Cc: Borislav Petkov <bp@alien8.de>
Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/compiler_types.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index eb0466236661..4cf5c90c51d2 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -231,11 +231,13 @@ struct ftrace_likely_data {
 #endif
 
 /* Section for code which can't be instrumented at all */
-#define noinstr								\
-	noinline notrace __attribute((__section__(".noinstr.text")))	\
-	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
+#define __noinstr_section(section)				\
+	noinline notrace __section(section) __no_profile	\
+	__no_kcsan __no_sanitize_address __no_sanitize_coverage	\
 	__no_sanitize_memory
 
+#define noinstr __noinstr_section(".noinstr.text")
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
-- 
2.36.1

