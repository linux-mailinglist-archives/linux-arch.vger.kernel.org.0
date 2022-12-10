Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EE0648FEA
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 18:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiLJRNL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 12:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLJRMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 12:12:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89696FAC1;
        Sat, 10 Dec 2022 09:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26040B808C6;
        Sat, 10 Dec 2022 17:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A98C433EF;
        Sat, 10 Dec 2022 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670692365;
        bh=m/A9xb4bgo9ywaAF/nOHCziALkNLqcaygAT8lXBG3nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeeNJhEbXHCd22P0FaF7aDDoNNpMS0T9bUbALYV/NEJUscxOPCCx6JPhA0HWNkjjy
         HGNgm7atV6l+x915q+3DSCeZVRe7az9IC4YroX0CpiQ0+5N9mmiPlrA8j6DlqtZKE1
         BpEzTsH28wSUmGvyZACDdkfNCpUEMEUgXvx9p2EKUbisPbh1LRB8eSgHrAZPRfGJaX
         643TQM1YhHt2W+mSeM5M7ISR2+XQupJMGnCmgvLcU4t7LZiOcVGAZMxI7fuCNdIrXL
         33123H+jHIJ+TUMU0MkkJ3Ff6UaMkSRpfPB1ntB5T46SaaGmLNZ0DXD74X37lvzsWu
         v24Jm6+Jda67g==
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
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V11 3/7] riscv: entry: Add noinstr to prevent instrumentation inserted
Date:   Sat, 10 Dec 2022 12:11:37 -0500
Message-Id: <20221210171141.1120123-4-guoren@kernel.org>
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

From: Guo Ren <guoren@linux.alibaba.com>

Without noinstr the compiler is free to insert instrumentation (think
all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
yet ready to run this early in the entry path, for instance it could
rely on RCU which isn't on yet, or expect lockdep state. (by peterz)

Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Tested-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/traps.c | 4 ++--
 arch/riscv/mm/fault.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f3e96d60a2ff..f7fa973558bc 100644
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
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d86f7cebd4a7..b26f68eac61c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -204,7 +204,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
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

