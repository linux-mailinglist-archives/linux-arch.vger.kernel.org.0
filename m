Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92F05BCB54
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiISL7i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiISL7h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 07:59:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAAB10FC;
        Mon, 19 Sep 2022 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNJykaajNGSUnYywN9R7hRPV8WnJzioOZeSYuIwMLL8=; b=v4IYEVZn1r6bcOev3ZKb2JWvyz
        OsrznONVcuJ76ILzsbOsHS9mT3IChSB+4qYaOLtmdSzT2DAz86f5FH3/A6eRcNsxf7s5pTaTdvdgG
        fXMa4qDQRbbMJsX5XaH//Kf3VJUjEAuVI4LGU6QQL7rrnD2B9PQPJGGPNmb7cdW7fpglGcsTGyNFU
        66eCvvgOih3TqaYkKrsyze0xGc034DPpaSnTkHjvFcmW3DnIuAqpPH8yworjJXq0Bq1ZlRJac/s03
        W3kVntIhxuOId3a0QtXfXvODTWhRG7OV5OrT2+uRQkQQwAghXZyRuH6u+3BU48Q0z946P4nBwI+4l
        Xwq2MAIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaFQU-004fuR-3e; Mon, 19 Sep 2022 11:59:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26912300202;
        Mon, 19 Sep 2022 13:58:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39FC02BA49034; Mon, 19 Sep 2022 13:58:53 +0200 (CEST)
Date:   Mon, 19 Sep 2022 13:58:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 06/11] entry: Prevent DEBUG_PREEMPT warning
Message-ID: <YyhZfUi17TEaOLWv@hirez.programming.kicks-ass.net>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-7-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918155246.1203293-7-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 18, 2022 at 11:52:41AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When DEBUG_PREEMPT=y,
> 	exit_to_user_mode_prepare
> 	->tick_nohz_user_enter_prepare
> 	  ->tick_nohz_full_cpu(smp_processor_id())
> 	    ->smp_processor_id()
> 	      ->debug_smp_processor_id()
> 		->check preempt_count() then:
> 
> [    5.717610] BUG: using smp_processor_id() in preemptible [00000000]
> code: S20urandom/94
> [    5.718111] caller is debug_smp_processor_id+0x24/0x38
> [    5.718417] CPU: 1 PID: 94 Comm: S20urandom Not tainted
> 6.0.0-rc3-00010-gfd0a0d619c63-dirty #238
> [    5.718886] Hardware name: riscv-virtio,qemu (DT)
> [    5.719136] Call Trace:
> [    5.719281] [<ffffffff800055fc>] dump_backtrace+0x2c/0x3c
> [    5.719566] [<ffffffff80ae6cb0>] show_stack+0x44/0x5c
> [    5.720023] [<ffffffff80aee870>] dump_stack_lvl+0x74/0xa4
> [    5.720557] [<ffffffff80aee8bc>] dump_stack+0x1c/0x2c
> [    5.721033] [<ffffffff80af65c0>]
> check_preemption_disabled+0x104/0x108
> [    5.721538] [<ffffffff80af65e8>] debug_smp_processor_id+0x24/0x38
> [    5.722001] [<ffffffff800aee30>] exit_to_user_mode_prepare+0x48/0x178
> [    5.722355] [<ffffffff80af5bf4>] irqentry_exit_to_user_mode+0x18/0x30
> [    5.722685] [<ffffffff80af5c70>] irqentry_exit+0x64/0xa4
> [    5.722953] [<ffffffff80af52f4>] do_page_fault+0x1d8/0x544
> [    5.723291] [<ffffffff80003310>] ret_from_exception+0x0/0xb8
> 
> (Above is found in riscv platform with generic_entry)
> 
> The smp_processor_id() needs irqs disable or preempt_disable, so use
> preempt dis/in protecting the tick_nohz_user_enter_prepare().
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  kernel/entry/common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 063068a9ea9b..36e4cd50531c 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -194,8 +194,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  
>  	lockdep_assert_irqs_disabled();

    Observe ^^^^

>  
> +	preempt_disable();
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
> +	preempt_enable();

This makes no sense; if IRQs are disabled, check_preemption_disabled()
should bail early per:

	if (irqs_disabled())
		goto out;
