Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F15A5C30
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 08:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiH3Gxx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 02:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiH3Gxq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 02:53:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2796BD116;
        Mon, 29 Aug 2022 23:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72E1FB816A6;
        Tue, 30 Aug 2022 06:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95177C43141;
        Tue, 30 Aug 2022 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661842423;
        bh=6jVazXBqfWdKpxDWhL1vnDZxpkMfN57CDtGrBVFvRs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5PrLREEw9ieJXHk2T6r8fNSMm4hqpEggsRJrXPWuFPl7+oJKfH/xBCo0A6FJO0y2
         t9K5uxEE398h542YOD7o2yTfT4WHu83D6O1abG132Tc4bQAupCKANNBSa193HMsikz
         4M3nENDu9L/3n8h3C0uJfXqbSAkKm+orfEcMHOgDUj056bJn4i+7AKEbgu317hT+U3
         3aqhj2tDhdw86//1qF+BA6svknF5okzAHkY4nNxbm4KxsHyWfDR9AJ+3fwLF8hBKQj
         DIDDu38CXvQN9Ac3hF/lVAAzTDYfnjIUHHuFPh1gUncCU4gVLx3CzOPt9r0MIDKxVd
         ZacRoVho/xM/A==
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
Subject: [PATCH 2/3] openrisc: ptrace: Remove duplicate operation
Date:   Tue, 30 Aug 2022 02:53:15 -0400
Message-Id: <20220830065316.3924938-3-guoren@kernel.org>
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
 arch/openrisc/kernel/ptrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index b971740fc2aa..cc53fa676706 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -132,7 +132,6 @@ void ptrace_disable(struct task_struct *child)
 	pr_debug("ptrace_disable(): TODO\n");
 
 	user_disable_single_step(child);
-	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 }
 
 long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
-- 
2.36.1

