Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC1E5BD997
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 03:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiITBpV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiITBpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 21:45:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860140BFC;
        Mon, 19 Sep 2022 18:45:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE393B82358;
        Tue, 20 Sep 2022 01:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6EAC43143;
        Tue, 20 Sep 2022 01:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663638315;
        bh=hM4ARRwu7HP3L22Jz7ahem9ASH5TM4RTeIReN46ib0A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GK+KksYrXL4Ui2VP52zrPYdiVEstBK3nMfuUi+rtYNamsgNKbqqaulzkhPWE6zjdr
         ycq9HWRHSg5D86Y5TGLNjonhwqX6bJ9musEyBzhR5wSmnyB2jUaYShH8CZlwQlV+Yi
         ywibChefBfA6DMNmzn30SwPqghkoqKyCWk4e8tTSkHvMKYm+ObAP7CFdZQecJeEc2E
         z24ZLh9N6C+/KVRayNZ5wpITp77mGFC3Jo+R/Kt5bf9KhL9OzLWrwOFPeOdNJGMVRs
         EaWR2IK622Dhd8tuIFSJyjQ9K07AKl4m16ACYYFqXNlKVHCc+GRAm2zI6UjA39C81g
         9qN8Vbu4saG7A==
Received: by mail-oi1-f177.google.com with SMTP id t62so1859521oie.10;
        Mon, 19 Sep 2022 18:45:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf2sn03VwI+RPnEDCetbwn3r1Fv1toZbO8A4j9uk0Ky4U3TcQrQZ
        7vevGweLQo6fvcC8sIB9tQPcWNaG+pHGn6O8zP4=
X-Google-Smtp-Source: AMsMyM7uitoWQ2wP2lLplABVBobqc5ORHtBKx+vIP5fl4T3iv6x3SGzJf91sDczKyJfzzmEFljNZDO3ZNZVx2oQu7Jc=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr513697oiw.112.1663638314437; Mon, 19
 Sep 2022 18:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-7-guoren@kernel.org>
 <YyhZfUi17TEaOLWv@hirez.programming.kicks-ass.net>
In-Reply-To: <YyhZfUi17TEaOLWv@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Sep 2022 09:45:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQxfuHVe=drT3tMCK4prULR5iPS6F++HTokswjD2yRZZQ@mail.gmail.com>
Message-ID: <CAJF2gTQxfuHVe=drT3tMCK4prULR5iPS6F++HTokswjD2yRZZQ@mail.gmail.com>
Subject: Re: [PATCH V5 06/11] entry: Prevent DEBUG_PREEMPT warning
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 19, 2022 at 7:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Sep 18, 2022 at 11:52:41AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When DEBUG_PREEMPT=y,
> >       exit_to_user_mode_prepare
> >       ->tick_nohz_user_enter_prepare
> >         ->tick_nohz_full_cpu(smp_processor_id())
> >           ->smp_processor_id()
> >             ->debug_smp_processor_id()
> >               ->check preempt_count() then:
> >
> > [    5.717610] BUG: using smp_processor_id() in preemptible [00000000]
> > code: S20urandom/94
> > [    5.718111] caller is debug_smp_processor_id+0x24/0x38
> > [    5.718417] CPU: 1 PID: 94 Comm: S20urandom Not tainted
> > 6.0.0-rc3-00010-gfd0a0d619c63-dirty #238
> > [    5.718886] Hardware name: riscv-virtio,qemu (DT)
> > [    5.719136] Call Trace:
> > [    5.719281] [<ffffffff800055fc>] dump_backtrace+0x2c/0x3c
> > [    5.719566] [<ffffffff80ae6cb0>] show_stack+0x44/0x5c
> > [    5.720023] [<ffffffff80aee870>] dump_stack_lvl+0x74/0xa4
> > [    5.720557] [<ffffffff80aee8bc>] dump_stack+0x1c/0x2c
> > [    5.721033] [<ffffffff80af65c0>]
> > check_preemption_disabled+0x104/0x108
> > [    5.721538] [<ffffffff80af65e8>] debug_smp_processor_id+0x24/0x38
> > [    5.722001] [<ffffffff800aee30>] exit_to_user_mode_prepare+0x48/0x178
> > [    5.722355] [<ffffffff80af5bf4>] irqentry_exit_to_user_mode+0x18/0x30
> > [    5.722685] [<ffffffff80af5c70>] irqentry_exit+0x64/0xa4
> > [    5.722953] [<ffffffff80af52f4>] do_page_fault+0x1d8/0x544
> > [    5.723291] [<ffffffff80003310>] ret_from_exception+0x0/0xb8
> >
> > (Above is found in riscv platform with generic_entry)
> >
> > The smp_processor_id() needs irqs disable or preempt_disable, so use
> > preempt dis/in protecting the tick_nohz_user_enter_prepare().
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  kernel/entry/common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> > index 063068a9ea9b..36e4cd50531c 100644
> > --- a/kernel/entry/common.c
> > +++ b/kernel/entry/common.c
> > @@ -194,8 +194,10 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >
> >       lockdep_assert_irqs_disabled();
>
>     Observe ^^^^
Thanks! I would enable PROVE_LOCKING for test.

>
> >
> > +     preempt_disable();
> >       /* Flush pending rcuog wakeup before the last need_resched() check */
> >       tick_nohz_user_enter_prepare();
> > +     preempt_enable();
>
> This makes no sense; if IRQs are disabled, check_preemption_disabled()
> should bail early per:
>
>         if (irqs_disabled())
>                 goto out;
Ditto.


-- 
Best Regards
 Guo Ren
