Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E85BBED0
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIRPxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIRPx3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:53:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692B1EAE1;
        Sun, 18 Sep 2022 08:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40DF1B81057;
        Sun, 18 Sep 2022 15:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF6C43141;
        Sun, 18 Sep 2022 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663516403;
        bh=EeFFIvXN/JwkcVumnFfZeBxR0r/LWWg4dvb3hMk4ymM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afPhU5jyxS2Rz2EnygNlwkVLKecIlTwICH1n2aN6dEG7FcrMRRwwFWN7GGv8kQ1kP
         qO8AIbteSWxbAmbeTyF7HkZGFY1OHD/Ifw6C1TM4cBhX+1rIRHsm4tKbCXILx89beC
         pAxSPkTHmXyJRiNVlwAmQv1XTB/dppABVLhjIjJHYor3R1XyFNYLNBcYciIugxcaT7
         z82nUYpExR0MDiPjTtU68Tf6x087+p9Df06wfpBF4IycG5Wy/O0NSjwKtOY8/hlK0i
         ibKvP1+8jvBVnvKACcvCo2DBgxfe4ySkr2jnglwONoRTPUH4j/XWvTyksZhn98k9JA
         wBgkGqj61Uxvw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 05/11] riscv: traps: Add noinstr to prevent instrumentation inserted
Date:   Sun, 18 Sep 2022 11:52:40 -0400
Message-Id: <20220918155246.1203293-6-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220918155246.1203293-1-guoren@kernel.org>
References: <20220918155246.1203293-1-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

Without noinstr the compiler is free to insert instrumentation (think
all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
yet ready to run this early in the entry path, for instance it could
rely on RCU which isn't on yet, or expect lockdep state. (by peterz)

Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 4 ++--
 arch/riscv/mm/fault.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 635e6ec26938..588e17c386c6 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -92,9 +92,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
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
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f2fbd1400b7c..c7829289e806 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -203,7 +203,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
  */
-asmlinkage void do_page_fault(struct pt_regs *regs)
+asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
 {
 	struct task_struct *tsk;
 	struct vm_area_struct *vma;
-- 
2.36.1

