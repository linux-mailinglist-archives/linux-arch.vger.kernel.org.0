Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC768A8AC
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 08:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjBDHDp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Feb 2023 02:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBDHDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Feb 2023 02:03:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BF3EC59;
        Fri,  3 Feb 2023 23:03:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A03FC60AE9;
        Sat,  4 Feb 2023 07:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E97C4339B;
        Sat,  4 Feb 2023 07:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675494209;
        bh=TdYTdj6H5Qbtgmh1te0rA9iZLTDxbWp//XNrh7RF5Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8vbs+VUtzvlJ2vvbxB76f+LNomu7o+U0Pha7BjVBdJ6DT+ubQ0tS0sUzveuWRFTC
         4XXSZLa57CozUxPd8BX8/ajPbJsntR2huXGXb9ibui0p8bkW+1ADVb8XVMDQG8Wza/
         TyQxzKsQb/39/HWTfHnWCRl0wd0Q2GhnOFWgX94Da+MLXrAkrHx7I9vGv6lxZA11On
         dn4MZlPJQlbjweTdlSQwcU16Ujpkq22vf2u4wXudLlGawqRos8adB4dWqY76VXkmHf
         3TdV9CHU79xyxadG4mCAkVdwfwPDmjW5NhDGlLT5OG9FDhgEIj4IgTwtnIgZCl4wFG
         m5wFXwRq3fX8w==
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
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V16 3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
Date:   Sat,  4 Feb 2023 02:02:09 -0500
Message-Id: <20230204070213.753369-4-guoren@kernel.org>
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

