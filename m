Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B911A666EE8
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 11:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjALKBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 05:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjALKAk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 05:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1FA25EA;
        Thu, 12 Jan 2023 01:59:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 889B5B81DF9;
        Thu, 12 Jan 2023 09:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E868C433D2;
        Thu, 12 Jan 2023 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673517567;
        bh=TdYTdj6H5Qbtgmh1te0rA9iZLTDxbWp//XNrh7RF5Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQWzZ88LaYJ0PFPrPx9eOnoBxUSeN8/kBCYwJN8YenKdcBxGSnv3j8njsTpAX6p0P
         gFClgJY2E7WFpj5BuxaJheWD/j/YWyX2o4aD3NL/dMUchsM37hyi4YUnekdSezmFuA
         1RQLmvvhTublszcENMciVH1fpqyxFnzH5DwZdKRu+lCdLILlhnvwbn/tLSpXdJUeja
         Pp0+qSxgbSD1B+WOJyfrR9pUPQnYJ3f3s35MBl23u/+QlqqNN4mVIiDeShSbdsgTbh
         PHyPYWlS+J287n/mvr0bWdP3m2yWPdB9nBwBdwIiMhQJo+UnqNTbyR7XTXBsJQVnDF
         PLXI5+z7BUo4Q==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V14 3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
Date:   Thu, 12 Jan 2023 04:58:44 -0500
Message-Id: <20230112095848.1464404-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230112095848.1464404-1-guoren@kernel.org>
References: <20230112095848.1464404-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

Without noinstr the compiler is free to insert instrumentation (think
all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
yet ready to run this early in the entry path, for instance it could
rely on RCU which isn't on yet, or expect lockdep state. (by peterz)

Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 549bde5c970a..96ec76c54ff2 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 }
 
 #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
-#define __trap_section		__section(".xip.traps")
+#define __trap_section __noinstr_section(".xip.traps")
 #else
-#define __trap_section
+#define __trap_section noinstr
 #endif
 #define DO_ERROR_INFO(name, signo, code, str)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
-- 
2.36.1

