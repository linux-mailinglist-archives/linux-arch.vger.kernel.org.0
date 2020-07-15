Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7FD220EA9
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGOODw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGOODw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 10:03:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B3C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 07:03:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so3132963pgq.1
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KCbXhY3buvKTYcnZx2YmNOrnrb84retJ2GQkK6OGptM=;
        b=A0NUmCxjYWq/p++O+3geeLdTHdtbnpRc4vAqEkMCoHVsn1iWS6eB5uPkkkSIGwGtQu
         7ybMhoEWOTR2dC01ZdOV3492evLoq7C4FpOKabCwXvo6mjRf+svabx4FcAz9nJUt0ItU
         K/cB9Uqm81tHVxU2j4j3ueyrzeTTf+8ckXzHY2e2ZJp6OpLgBMxrdvt6X5F83U+tGlBp
         4TTedTmBK5SbKcYrWz/xbSRQKBd/j7ftwvtG8tB9vUhATbTG0KtEGOXQnH3jbP0fE/hc
         pTUQeNf2d+p23RKkdxXdUEliBS7fkNDM4LBRpriB9zyVBk356ncBQzM2hDwRtIdmo1pE
         nxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KCbXhY3buvKTYcnZx2YmNOrnrb84retJ2GQkK6OGptM=;
        b=ieXE+1CVXMWzKXF7dYz79alUW/qP2bUWGFIDYUUX693AzRgneeQz9jBWC/hRO8cIZj
         QTtVV+fLtnjLKOTmu79lmJDldHgItfXbpatl3/zTbPsPAQtRcspnGXOru6w4UrTq8eUl
         paGUAYr0IouXyIS28ksh+Qg5UFiGmXBf6KPNwf1j9glo4AoyE1VAMyFJ8gLumRwHIUtJ
         J42F/6Z0xIxHac9gL560cYiYZwqKxCcAcp4nSFBPpFRVcDg6k0Mne4N4Z4nsOV3hs9xo
         uHnT0w+9mQwGYZ70Duzu1Uvgb7CDS1SAhQfSzqGEzbjgH6n/1TVkuDZ4N1GwQ/P3Cld4
         hdAw==
X-Gm-Message-State: AOAM531WSyNPzSe3uieLbNLIIai6zvNxhKCTxJyB6nxMKutFDcjxc+u7
        pyIg91eudpCvCd37FQbfrqOt/Q==
X-Google-Smtp-Source: ABdhPJwV027sukJtXM1zTUUNhkvdPz4xdnE3yMXEvZe3+73XT5bXd39rCOmy47iA6yhrYxOMVerfjw==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr8397637pga.313.1594821831166;
        Wed, 15 Jul 2020 07:03:51 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g7sm2212380pfh.210.2020.07.15.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:03:49 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:03:49 -0700 (PDT)
X-Google-Original-Date: Wed, 15 Jul 2020 07:03:47 PDT (-0700)
Subject:     Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
In-Reply-To: <20200715104246.GA3143299@google.com>
CC:     kernel@esmil.dk, guoren@kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Will Deacon <willdeacon@google.com>
Message-ID: <mhng-4a6c3dd9-b035-49c8-9e92-e881c0d1027c@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 15 Jul 2020 03:42:46 PDT (-0700), Will Deacon wrote:
> On Tue, Jul 14, 2020 at 11:45:11PM -0700, Palmer Dabbelt wrote:
>> > > > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
>> > > > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
>> > > > > > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
>> > > > > > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
>> > > > > > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
>> > > > > > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
>> > > > > > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
>> > > > > > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
>> > > > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
>> > > > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
>> > > > > > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
>> > > > > > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
>> > > > > > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
>> > > > > > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
>> > > >
>> > > > Hmm.. the problem is that preemption is *not* disabled when
>> > > > smp_processor_id is called, right?
>> > >
>> > > Yes!
>> > >
>> > > smp_processor_id is defined as:
>> > >
>> > >  * This is the normal accessor to the CPU id and should be used
>> > >  * whenever possible.
>> > >  *
>> > >  * The CPU id is stable when:
>> > >  *
>> > >  *  - IRQs are disabled;
>> > >  *  - preemption is disabled;
>> > >  *  - the task is CPU affine.
>> > >  *
>> > >  * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
>> > >  * when smp_processor_id() is used when the CPU id is not stable.
>> > >
>> > > So regmap_write->regmap_mmio_write should be PREEMPT disabled in
>> > > sifive_gpio_probe().
>> >
>> > Ah! Sorry, now I think I understand. So you're saying that the real
>> > problem is that the driver framework should have disabled preemption
>> > before calling any .probe functions, but for some reason that doesn't
>> > happen on RISC-V?
>>
>> I think it's actually an issue with the generic mmiowb stuff and that we should
>> just elide the check.  I'm adding Will, for context.  I'll send out a patch.
>
> Hmm. Although I _think_ something like the diff below ought to work, are you
> sure you want to be doing MMIO writes in preemptible context? Setting
> '.disable_locking = true' in 'sifive_gpio_regmap_config' implies to me that
> you should be handling the locking within the driver itself, and all the
> other regmap writes are protected by '&gc->bgpio_lock'.

I guess my goal here was to avoid fixing the drivers: it's one thing if it's
just broken SiFive drivers, as they're all a bit crusty, but this is blowing up
for me in the 8250 driver on QEMU as well.  At that point I figured there'd be
an endless stream of bugs around this and I'd rather just.

> Given that riscv is one of the few architectures needing an implementation
> of mmiowb(), doing MMIO in a preemptible section seems especially dangerous
> as you have no way to ensure completion of the writes without adding an
> mmiowb() to the CPU migration path (i.e. context switch).

I was going to just stick one in our context switching code unconditionally.
While we could go track cumulative writes outside the locks, the mmiowb is
essentially free for us because the one RISC-V implementation treats all fences
the same way so the subsequent store_release would hold all this up anyway.

I think the right thing to do is to add some sort of arch hook right about here

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cfd71d61aa3c..14b4f8b7433f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3212,6 +3212,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	prev_state = prev->state;
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
+	finish_arch_pre_release(prev);
 	finish_task(prev);
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();

but I was just going to stick it in switch_to for now... :).  I guess we could
also roll the fence up into yet another one-off primitive for the scheduler,
something like

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9a2fbf98fd6f..9dcc35d37a99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3074,7 +3074,7 @@ static inline void finish_task(struct task_struct *prev)
         *
         * Pairs with the smp_cond_load_acquire() in try_to_wake_up().
         */
-       smp_store_release(&prev->on_cpu, 0);
+       smp_store_release_and_mmiowb(&prev->on_cpu, 0);
 #endif
 }

but in the long term we'd probably want to elide the unnecessary mmiowb()s
which would result in some accounting code.

>
> Will
>
> --->8
>
> diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> index 9439ff037b2d..5698fca3bf56 100644
> --- a/include/asm-generic/mmiowb.h
> +++ b/include/asm-generic/mmiowb.h
> @@ -27,7 +27,7 @@
>  #include <asm/smp.h>
>
>  DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> -#define __mmiowb_state()       this_cpu_ptr(&__mmiowb_state)
> +#define __mmiowb_state()       raw_cpu_ptr(&__mmiowb_state)
>  #else
>  #define __mmiowb_state()       arch_mmiowb_state()
>  #endif /* arch_mmiowb_state */
> @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>  static inline void mmiowb_set_pending(void)
>  {
>         struct mmiowb_state *ms = __mmiowb_state();
> -       ms->mmiowb_pending = ms->nesting_count;
> +
> +       if (likely(ms->nesting_count))
> +               ms->mmiowb_pending = ms->nesting_count;

Ya, that's one of the earlier ideas I had, but I decided it doesn't actually do
anything: if we're scheduleable then we know that pending and count are zero,
thus the check isn't necessary.  It made sense late last night and still does
this morning, but I haven't had my coffee yet.

I'm kind of tempted to just declare "mmiowb() is fast on RISC-V, so let's do it
unconditionally everywhere it's necessary".  IIRC that's essentially true on
the existing implementation, as it'll get rolled up to any upcoming fence
anyway.  It seems like building any real machine that relies on the orderings
provided by mmiowb is going to have an infinate rabbit hole of bugs anyway, so
in that case we'd just rely on the hardware to elide the now unnecessary fences
so we'd just be throwing static code size at this wacky memory model and then
forgetting about it.

I'm going to send out a patch set that does all the work I think is necessary
to avoid fixing up the various drivers, with the accounting code to avoid
mmiowbs all over our port.  I'm not sure I'm going to like it, but I guess we
can argue as to exactly how ugly it is :)


>  }
>
>  static inline void mmiowb_spin_lock(void)
