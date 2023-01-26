Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1DB67D304
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjAZRZx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 12:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjAZRZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 12:25:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587206A732;
        Thu, 26 Jan 2023 09:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E87DA6187E;
        Thu, 26 Jan 2023 17:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA97C4339B;
        Thu, 26 Jan 2023 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674753948;
        bh=DNY322/iimzurqg2rAQmkk32JHcSLTVqr6N5got/hZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBYm0SICw9FAXa+VBtN3eixi1dGhdbI9x+fSiqCd41ynJjBaO3mtszt31bCrGvE0j
         VgIRDwCo1aHd6VyRdut69X9Qi1MV0p4o3mqbQvLiH398DJgba332QZHoP8bo9AzUrV
         CrhF9XH45VE2sJ8FL526PzWm/FEpRKeJdhgL2Nv+OqXrRKhGBfZQEWQH5y7EMbOq2I
         VVXQjRHScFSB9c2ygtB6L37YiaKfmJXr1SyjJHcEaNpavTLjSyGEW778M7Vj4rT3tV
         wsNGRe7DPaq4n6cI7AW8XAaNTwCKbjWcEUtzwkLdlKSx7yFwzQdTAEMPTCnqPHjS5x
         4HlMc5xuapmrQ==
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
        Oleg Nesterov <oleg@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH -next V15 2/7] riscv: ptrace: Remove duplicate operation
Date:   Thu, 26 Jan 2023 12:25:11 -0500
Message-Id: <20230126172516.1580058-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126172516.1580058-1-guoren@kernel.org>
References: <20230126172516.1580058-1-guoren@kernel.org>
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

The TIF_SYSCALL_TRACE is controlled by a common code, see
kernel/ptrace.c and include/linux/thread_info.h.

clear_task_syscall_work(child, SYSCALL_TRACE);

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
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

