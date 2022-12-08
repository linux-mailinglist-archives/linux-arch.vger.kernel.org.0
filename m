Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F61646758
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 03:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLHC7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 21:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLHC65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 21:58:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092E8950C8;
        Wed,  7 Dec 2022 18:58:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B72B821FF;
        Thu,  8 Dec 2022 02:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F3DC433D6;
        Thu,  8 Dec 2022 02:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670468332;
        bh=fcNRUbmbqoevqmCMcSREDYQEKvN34Jrs3zIaqY83b2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtpQyaZrIX7BpMrkVOUXb/dLH5wHwvILNQj0ZNeWEX0WewbK+GV5442bXm4HSlPVp
         j+O8Y1A8H+fZoo33jkGT2r00z28ARK2VLMsoxFG0y/yzotwqtNDkb+DCvParqVcdlk
         IbNcT7yi/xMmgX53+iM28lxkHBJC+BQAWQNdE51zozEG1Dqp2Mj7h+gQkYgMC0OWWD
         m6+OqvYmeryTZGst96He3ibVPNOe65KfsEpmV10hABtqDFYMIY0KuAqNFbwy/srBC9
         CM5by982YMKshTMtpVvAOCYZi2mVVj8S6oJuOhRQP1zhJDlLkBcaa9UgjoLKDy0sfS
         7TKOsxhAbiXHA==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH -next V10 02/10] riscv: ptrace: Remove duplicate operation
Date:   Wed,  7 Dec 2022 21:58:08 -0500
Message-Id: <20221208025816.138712-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221208025816.138712-1-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
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

The TIF_SYSCALL_TRACE is controlled by a common code, see
kernel/ptrace.c and include/linux/thread_info.h

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

