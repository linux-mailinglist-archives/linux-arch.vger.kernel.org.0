Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4439B5A5C32
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 08:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiH3Gxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 02:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiH3Gxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 02:53:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A331CBD116;
        Mon, 29 Aug 2022 23:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2878CE1792;
        Tue, 30 Aug 2022 06:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C028C433B5;
        Tue, 30 Aug 2022 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661842416;
        bh=ezCJz3zzII/UaKvcXNSbmcajv11zXu7NIaCF1ULUtp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3amRcUQDjcf2J5Fgpm3U2izv3yA9NBy7nxMxatvsZT6tZWH3Rv9dQGtrjH3iNkPE
         g6KyXSsfC/QLHSFUlf3IUv5+Vfh0AVJGPh5B8XP/13LvC1JxSH2AEqY4TAjFgDMhOt
         AS0BwAQwYQJwQ8z8KNiqh3xod+STWMH9o+hwivFoZq7RQCb10x+P565pwYgOgJl59G
         gjJI+WEJLyooY/K9536qNkXfUBIbivFBJ+BTi3q5eadkie5Q/E0dtzMU5gpdgyy2Z/
         CftmJ3I3bk4yFCtql/IygZNvGqnuuCDfY9wzgM1PhTXU0Cx8xMIXsaEyLjA9FHpb8w
         WEGB8pxdmmp3Q==
From:   guoren@kernel.org
To:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, shorne@gmail.com,
        guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/3] riscv: ptrace: Remove duplicate operation
Date:   Tue, 30 Aug 2022 02:53:14 -0400
Message-Id: <20220830065316.3924938-2-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830065316.3924938-1-guoren@kernel.org>
References: <20220830065316.3924938-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

