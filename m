Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C645E5BBED2
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIRPyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIRPxa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C71EC4D;
        Sun, 18 Sep 2022 08:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D526006F;
        Sun, 18 Sep 2022 15:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF75C4347C;
        Sun, 18 Sep 2022 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663516408;
        bh=djdpWanOi4zWPI5MvBREvmwhOSv3FwS45ovTz/HZSl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfCosz0tEYKD25aaVLOYyBJvJG3AIHXJ0umANml2aOl8rUbGHeMhSPdLG2pki7eDq
         dNlGJo3NOYRF+IxXbm9AXmIgyyq+Rbnq+o714vDzCAbPen8yyfTaGt+Hudwd6iEF3a
         AAfGXlBsDCGFDuxDSNcH1rbTR5/+srnfZWS0c991EHQo80nPXq0gZTo/3ULUhlu0LU
         JixujdzO1sN3PXWnM3WPpDluQ/FVDasCswD3BL5meCMxvhZOwaqGDhj4Y5pRvBCbhg
         pGEBfF57UmqPi/TKV0drZF2L/nO7U8yjwAN8qDJ36yDR+fmAyHGKPEVeTq5h8wEIJ5
         B4gtT8vYRk/vw==
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
Subject: [PATCH V5 06/11] entry: Prevent DEBUG_PREEMPT warning
Date:   Sun, 18 Sep 2022 11:52:41 -0400
Message-Id: <20220918155246.1203293-7-guoren@kernel.org>
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

When DEBUG_PREEMPT=y,
	exit_to_user_mode_prepare
	->tick_nohz_user_enter_prepare
	  ->tick_nohz_full_cpu(smp_processor_id())
	    ->smp_processor_id()
	      ->debug_smp_processor_id()
		->check preempt_count() then:

[    5.717610] BUG: using smp_processor_id() in preemptible [00000000]
code: S20urandom/94
[    5.718111] caller is debug_smp_processor_id+0x24/0x38
[    5.718417] CPU: 1 PID: 94 Comm: S20urandom Not tainted
6.0.0-rc3-00010-gfd0a0d619c63-dirty #238
[    5.718886] Hardware name: riscv-virtio,qemu (DT)
[    5.719136] Call Trace:
[    5.719281] [<ffffffff800055fc>] dump_backtrace+0x2c/0x3c
[    5.719566] [<ffffffff80ae6cb0>] show_stack+0x44/0x5c
[    5.720023] [<ffffffff80aee870>] dump_stack_lvl+0x74/0xa4
[    5.720557] [<ffffffff80aee8bc>] dump_stack+0x1c/0x2c
[    5.721033] [<ffffffff80af65c0>]
check_preemption_disabled+0x104/0x108
[    5.721538] [<ffffffff80af65e8>] debug_smp_processor_id+0x24/0x38
[    5.722001] [<ffffffff800aee30>] exit_to_user_mode_prepare+0x48/0x178
[    5.722355] [<ffffffff80af5bf4>] irqentry_exit_to_user_mode+0x18/0x30
[    5.722685] [<ffffffff80af5c70>] irqentry_exit+0x64/0xa4
[    5.722953] [<ffffffff80af52f4>] do_page_fault+0x1d8/0x544
[    5.723291] [<ffffffff80003310>] ret_from_exception+0x0/0xb8

(Above is found in riscv platform with generic_entry)

The smp_processor_id() needs irqs disable or preempt_disable, so use
preempt dis/in protecting the tick_nohz_user_enter_prepare().

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 kernel/entry/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 063068a9ea9b..36e4cd50531c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -194,8 +194,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	lockdep_assert_irqs_disabled();
 
+	preempt_disable();
 	/* Flush pending rcuog wakeup before the last need_resched() check */
 	tick_nohz_user_enter_prepare();
+	preempt_enable();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
-- 
2.36.1

