Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7FC220553
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 08:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGOGpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGpN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 02:45:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E518C061755
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 23:45:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l6so1980561plt.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 23:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UQyUA0ubFfxJmMbUnrymb8WI75k70w0u5d2M/oPKj6Q=;
        b=PNnTMFUaDmQdTMCr60s6MfOSKKoEQ/DKzp868LN+TIIFkgglr0MOVHKmjJtbMqmkOW
         PfuK1JiGS+WSaKtMlhsSix9IBoJw9L46Bm2MggFDU+Qn5FL1MbH9g+aBF+V8DNLiYq/7
         NaPPldghEKanAcYTmDWFcQjEsbUv5VpBpZ18rrNrtjqbnvRnVI7Wu9x6tzIw+VbH37n+
         DE6p4pzT11ikM+DyTgEYK3mTZBWQ5u8SvsOmvPnyVcq4jx5F48eR+2N+/k70MH7kP+NI
         9Q4Xgu0WQMhm961/5NycmlKvhz59aDN9GHWq3xgTFKy+Z033YSYJIgiMEf+Ht4nq3Ley
         CJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UQyUA0ubFfxJmMbUnrymb8WI75k70w0u5d2M/oPKj6Q=;
        b=LL3qoDHVxWQJ+P1qnc0YBeePfZ98LshuKkEUr19rK1RP/opd5pgP7LDjBW8l3HScGm
         goy60GjDXEevtAGKXkY9A8dsS/BsnOUpD5eme/ggDKk/g136fDAR0itz54mXN2waSXIk
         /7hUKSb3jTGwv2lzJ5//rbHu9dc4NMJH4J5PcwLI2FrFG79XsLV+JjbS9vqMizKZNhrU
         X4p6gEM24fngdjsqSo7d0xr08rMhRN+UkrOxKu7J6YaTVbQUkv15BqfPWtHJWy9BDaot
         S4Bd68GfPFrVB67/Jis0iPO/b3Sb+NRh9CqggVDVKGVOjLdMRC0oT8PbiMVqxCEZ3TYI
         dTQA==
X-Gm-Message-State: AOAM533hSvVyDtFhVfUH8S+9c+tjox/udPUMkPejrqrvexcZYDVGJENC
        ePZUNBE4r+pQWBUy/foaufmvPA==
X-Google-Smtp-Source: ABdhPJwu0FzKuHfaAToD93LPsAJTFBqyDv6gPZzwiaevlrxB11POmiHnzDDtwjI6+tlPJ4ZiGI8Mcg==
X-Received: by 2002:a17:90a:3770:: with SMTP id u103mr9225390pjb.102.1594795512617;
        Tue, 14 Jul 2020 23:45:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p1sm4473115pja.2.2020.07.14.23.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:45:11 -0700 (PDT)
Date:   Tue, 14 Jul 2020 23:45:11 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Jul 2020 23:45:07 PDT (-0700)
Subject:     Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
In-Reply-To: <CANBLGcw8nVvshaOxiBO3zSpjE2oEmWE7C4vuvDXYheRdFVLK0A@mail.gmail.com>
CC:     guoren@kernel.org, linux-riscv@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Will Deacon <willdeacon@google.com>, kernel@esmil.dk
Message-ID: <mhng-09237735-4773-4f28-bfb6-b619f1dd4e09@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 06 Jul 2020 01:08:24 PDT (-0700), kernel@esmil.dk wrote:
> On Mon, 6 Jul 2020 at 02:48, Guo Ren <guoren@kernel.org> wrote:
>> On Mon, Jul 6, 2020 at 1:09 AM Emil Renner Berthing <kernel@esmil.dk> wrote:
>> >
>> > On Sun, 5 Jul 2020 at 17:52, Guo Ren <guoren@kernel.org> wrote:
>> > > On Sun, Jul 5, 2020 at 11:03 PM Emil Renner Berthing <kernel@esmil.dk> wrote:
>> > > > On Sun, 5 Jul 2020 at 16:44, Guo Ren <guoren@kernel.org> wrote:
>> > > > >
>> > > > > Hi Emil,
>> > > > >
>> > > > > On Sun, Jul 5, 2020 at 10:27 PM Emil Renner Berthing <kernel@esmil.dk> wrote:
>> > > > > >
>> > > > > > Without this enabling CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT
>> > > > > > results in many errors like this on the HiFive Unleashed
>> > > > > > RISC-V board:
>> > > > > >
>> > > > > > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>> > > > > > caller is regmap_mmio_write32le+0x1c/0x46
>> > > > > > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
>> > > > > > Call Trace:
>> > > > > > [<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
>> > > > > > [<ffffffe0005b290e>] dump_stack+0x6e/0x88
>> > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
>> > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
>> > > > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
>> > > > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
>> > > > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
>> > > > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
>> > > > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
>> > > > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
>> > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
>> > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
>> > > > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
>> > > > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
>> > > > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
>> > > > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
>> > > > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
>> > > > > > [<ffffffe000001bea>] kernel_init_freeable+0x152/0x1da
>> > > > > > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
>> > > > > > [<ffffffe0005c4d36>] kernel_init+0xa/0x11a
>> > > > > > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
>> > > > > > [<ffffffe000200ff6>] ret_from_syscall_rejected+0x8/0xc
>> > > > > >
>> > > > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> > > > > > ---
>> > > > > > This patch fixes it, but my guess is that it's not the right
>> > > > > > fix. Do anyone have a better idea?
>> > > > > >
>> > > > > >  include/asm-generic/mmiowb.h | 6 +++++-
>> > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
>> > > > > >
>> > > > > > diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
>> > > > > > index 9439ff037b2d..31a21cdfbbcf 100644
>> > > > > > --- a/include/asm-generic/mmiowb.h
>> > > > > > +++ b/include/asm-generic/mmiowb.h
>> > > > > > @@ -34,8 +34,12 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
>> > > > > >
>> > > > > >  static inline void mmiowb_set_pending(void)
>> > > > > >  {
>> > > > > > -       struct mmiowb_state *ms = __mmiowb_state();
>> > > > > > +       struct mmiowb_state *ms;
>> > > > > > +
>> > > > > > +       get_cpu();
>> > > > > > +       ms = __mmiowb_state();
>> > > > > >         ms->mmiowb_pending = ms->nesting_count;
>> > > > > > +       put_cpu();
>> > > > > >  }
>> > > > >
>> > > > > #define __mmiowb_state()        this_cpu_ptr(&__mmiowb_state)
>> > > > >
>> > > > > The ptr is a fixed address, so don't worry about the change, and just
>> > > > > use an atomic_read is enough.
>> > > > > static inline void mmiowb_set_pending(void)
>> > > > > {
>> > > > >         struct mmiowb_state *ms = __mmiowb_state();
>> > > > > -       ms->mmiowb_pending = ms->nesting_count;
>> > > > > +      ms->mmiowb_pending = atomic_read(ms->nesting_count);
>> > > > > }
>> > > >
>> > > > You may be right, but it doesn't fix the BUG. As far as I can tell it
>> > > > happens in __mmiowb_state() which expands through this_cpu_ptr and
>> > > > arch_raw_cpu_ptr to SHIFT_PERCPU_PTR(ptr, __my_cpu_offset), where
>> > > > __my_cpu_offset is per_cpu_offset(smp_processor_id()) and with
>> > > > CONFIG_DEBUG_PREEMPT smp_processor_id is actually
>> > > > debug_smp_processor_id, which eventually checks that preemption is
>> > > > disabled in check_preemption_disabled.
>> > > Thx for explaining.
>> > >
>> > > Seems we need to find who disable preemption during:
>> > > > > > [<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
>> > > > > > [<ffffffe0005b290e>] dump_stack+0x6e/0x88
>> > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
>> > > > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
>> > > > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
>> > > > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
>> > > > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
>> > > > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
>> > > > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
>> > > > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
>> > > > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
>> > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
>> > > > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
>> > > > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
>> > > > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
>> > > > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
>> > > > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
>> > > > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
>> >
>> > Hmm.. the problem is that preemption is *not* disabled when
>> > smp_processor_id is called, right?
>>
>> Yes!
>>
>> smp_processor_id is defined as:
>>
>>  * This is the normal accessor to the CPU id and should be used
>>  * whenever possible.
>>  *
>>  * The CPU id is stable when:
>>  *
>>  *  - IRQs are disabled;
>>  *  - preemption is disabled;
>>  *  - the task is CPU affine.
>>  *
>>  * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
>>  * when smp_processor_id() is used when the CPU id is not stable.
>>
>> So regmap_write->regmap_mmio_write should be PREEMPT disabled in
>> sifive_gpio_probe().
>
> Ah! Sorry, now I think I understand. So you're saying that the real
> problem is that the driver framework should have disabled preemption
> before calling any .probe functions, but for some reason that doesn't
> happen on RISC-V?

I think it's actually an issue with the generic mmiowb stuff and that we should
just elide the check.  I'm adding Will, for context.  I'll send out a patch.

>> > > do_one_initcall's preempt_count = 0
>> > > (gdb) bt
>> > > #0  do_one_initcall (fn=0xffffffe000003b0e
>> > > <trace_init_flags_sys_exit>) at init/main.c:1190
>> > > #1  0xffffffe000001f20 in do_pre_smp_initcalls () at ./include/linux/init.h:131
>> > >
>> > > #2  kernel_init_freeable () at init/main.c:1494
>> > > #3  0xffffffe0009d6ea6 in kernel_init (unused=<optimized out>) a
>> > >    t init/main.c:1399
>> > > #4  0xffffffe000201c2a in handle_exception () at arch/riscv/kernel/entry.S:188
>> > > Backtrace stopped: frame did not save the PC
>> > > (gdb) p *(struct task_struct*)$tp
>> > > $2 = {thread_info = {flags = 0, preempt_count = 0,
>> > >
>> > > Can you debug like this ? to see which function's preempt_count = 0 in
>> > > your backtrace.
>> >
>> > I'm sorry, I'm not exactly sure what you mean by this, but it seems to
>> > happen multiple places in writel-like functions. Both at probe time in
>> > sifive_gpio_probe and sifive_spi_probe and when the spi driver is
>> > running. Here is the full log:
>> >
>> I mean Use jtag + gdb to detect  preempt_count = 0 in parent function.
>> I do this in qemu :)
>>
>> If couldn't use jtag, then just add printk preempt_count trace, or kgdb.
>
> Right, thanks. I'll look into it.
