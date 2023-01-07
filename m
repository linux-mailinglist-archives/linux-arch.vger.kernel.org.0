Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40A4660E52
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jan 2023 12:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjAGLjn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Jan 2023 06:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjAGLjT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2023 06:39:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9C97DE02;
        Sat,  7 Jan 2023 03:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43DBD60BDE;
        Sat,  7 Jan 2023 11:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EF7C433EF;
        Sat,  7 Jan 2023 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673091554;
        bh=TdYTdj6H5Qbtgmh1te0rA9iZLTDxbWp//XNrh7RF5Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBCATk/63WxwRQqasJFEj3FSWQeV6o0mq4mAlY2V18XfOsn7HfebXmoA8NYTnM8Lw
         LSGV229T2/Ngo8BMUCXdCYct0+UI2q6YOsqWqqPOEszDcV7MPgWHgBWpcf+VlUZf62
         pB5BRMxfacEGXpyDsCfKu14tqNDyzPcdkctixmwusaGL3ncOTvDCsDZs+o4j2d+e2I
         oVAi60a9JX6ErXJKzYzEEp3H09VOnBrg97zBvgWgjaYOkn/okB3lURaQ4lsEmzdfS9
         zzGI+O4dpeF7MA4V3AkDYWzFO0ia4fN40mbPJRFDEk4cmpjPhAJHhhPAk5CivQvRZ9
         46ln3KSlKbvVg==
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
Subject: [PATCH -next V13 3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
Date:   Sat,  7 Jan 2023 06:38:34 -0500
Message-Id: <20230107113838.3969149-4-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230107113838.3969149-1-guoren@kernel.org>
References: <20230107113838.3969149-1-guoren@kernel.org>
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

