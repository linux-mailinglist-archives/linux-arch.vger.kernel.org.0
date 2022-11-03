Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC95617803
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 08:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiKCHwd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKCHwG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 03:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E8AE42;
        Thu,  3 Nov 2022 00:51:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F9CD61D96;
        Thu,  3 Nov 2022 07:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BD4C433B5;
        Thu,  3 Nov 2022 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667461916;
        bh=thj4lp5B0J2/kj7Zi1BMTTtT9fAnJMteMKwuLQ0ArOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs/rTcwC+DQAPidMQn4I/9p0tuontVe/HkUXbdIhBHehZjXAN3dnplDZpeRsitHbG
         WK9Rfs3CvTDdj5LJhjIAH07dG4wyx7sDQBcDfAUxnBx+z/qKt+ZZUCewSg39pOuqtn
         9aDpUfzgCssnGxO46IVML9BXdulablwNn5J2QhNjMd9jU8clnJk6L1nCGVcSD6aGDu
         Hoj2yVDFQ2J6/rwBcORqo9F1O+EJRCFWEZgcveJy1K/z0Na7qIZnVk7IhbNyhpXuxw
         SmpQ6VBzKiKNS9E9FbSLALlF8bQhKlfUFRC+j6XOJZlOzzU8/EVHEbxlfaqGKxMx/M
         5yiVJtOkDfYCg==
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
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH -next V8 04/14] riscv: ptrace: Remove duplicate operation
Date:   Thu,  3 Nov 2022 03:50:37 -0400
Message-Id: <20221103075047.1634923-5-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221103075047.1634923-1-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The TIF_SYSCALL_TRACE is controlled by a common code, see
kernel/ptrace.c and include/linux/thread.h.

clear_task_syscall_work(child, SYSCALL_TRACE);

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 arch/riscv/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 2ae8280ae475..44f4b1ca315d 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -212,7 +212,6 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 
 void ptrace_disable(struct task_struct *child)
 {
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 long arch_ptrace(struct task_struct *child, long request,
-- 
2.36.1

