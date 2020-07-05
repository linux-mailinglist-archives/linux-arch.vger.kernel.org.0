Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF52214E1D
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jul 2020 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgGERJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jul 2020 13:09:42 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36738 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgGERJm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 13:09:42 -0400
Received: by mail-yb1-f193.google.com with SMTP id h39so17900717ybj.3
        for <linux-arch@vger.kernel.org>; Sun, 05 Jul 2020 10:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqrIsD/+DhZxsJ0s7XS6GJj8C2xkbTBOo6Vkkw2WKr0=;
        b=psLAvpjxothva7FzfvGr8ER1oOpsD/K/8ScTFSC9Utfby3CN2jStzqmjNXo59ePend
         7jMcUyBOok/rpTrcvLQBBvsFhd3lZ6hIEN00lTRuAwLILUpLwzOWwMl56/dIYosAfkeO
         ti9lAJ7QH4wAuYFpJv0qTUd+8KV6Qt+Fxd7QWQ481TOzzPF8TZIEBxGTfFVU9XeLyQ5B
         augbya7KVdvRdeaKG5HVqKEWfFIQUq6Tsi57Z7Dv2X5YmaOp2QrS3XBCQinmAzOCKaYb
         RHcA/bucEMymApBFWdUlqgGnWxejiEhCocmS6z9rjOsdJiXxyO71VnpaUG48edlmS9Lu
         qv9Q==
X-Gm-Message-State: AOAM530Rb0jDfD1I2DI97kNJnIlslMBpQ2olYCIQDDNoABD+FBz6OPnk
        mriPyb+VrNl+8PdSlSg1+6IC50JxP0JK5GGcUyE=
X-Google-Smtp-Source: ABdhPJyq+nMOp4OUHhSksYCJGlxvd/VEBmjAI1VW9Iqf9OvhlJdY/6c9ngqsEv8hfI5J41Jt4b3XQ7kL2mHyIoI7tEE=
X-Received: by 2002:a25:4603:: with SMTP id t3mr63127632yba.471.1593968981078;
 Sun, 05 Jul 2020 10:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200705142640.279439-1-kernel@esmil.dk> <CAJF2gTSi+2qxfzWxa5xvZnyJBFi5WcdSc-LDrqavB-hZ9-e9-Q@mail.gmail.com>
 <CANBLGcxWuO=xGfwwKPp7Faw1ZU=Z3p37KbopgQnB5HLg=CXTdg@mail.gmail.com> <CAJF2gTQhax2ZR8fvfm-HwK2wZinXoVRS8Var5y1AkrinDFHzUQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQhax2ZR8fvfm-HwK2wZinXoVRS8Var5y1AkrinDFHzUQ@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sun, 5 Jul 2020 19:09:29 +0200
Message-ID: <CANBLGcx1BeMTMBTS4YQUN=qrQqg9g3A_tw_F7xRngY0Lh9VGrQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 5 Jul 2020 at 17:52, Guo Ren <guoren@kernel.org> wrote:
> On Sun, Jul 5, 2020 at 11:03 PM Emil Renner Berthing <kernel@esmil.dk> wrote:
> > On Sun, 5 Jul 2020 at 16:44, Guo Ren <guoren@kernel.org> wrote:
> > >
> > > Hi Emil,
> > >
> > > On Sun, Jul 5, 2020 at 10:27 PM Emil Renner Berthing <kernel@esmil.dk> wrote:
> > > >
> > > > Without this enabling CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT
> > > > results in many errors like this on the HiFive Unleashed
> > > > RISC-V board:
> > > >
> > > > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> > > > caller is regmap_mmio_write32le+0x1c/0x46
> > > > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
> > > > Call Trace:
> > > > [<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
> > > > [<ffffffe0005b290e>] dump_stack+0x6e/0x88
> > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
> > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
> > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
> > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
> > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
> > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
> > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
> > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
> > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
> > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
> > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
> > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
> > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
> > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > > > [<ffffffe000001bea>] kernel_init_freeable+0x152/0x1da
> > > > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
> > > > [<ffffffe0005c4d36>] kernel_init+0xa/0x11a
> > > > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
> > > > [<ffffffe000200ff6>] ret_from_syscall_rejected+0x8/0xc
> > > >
> > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > ---
> > > > This patch fixes it, but my guess is that it's not the right
> > > > fix. Do anyone have a better idea?
> > > >
> > > >  include/asm-generic/mmiowb.h | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> > > > index 9439ff037b2d..31a21cdfbbcf 100644
> > > > --- a/include/asm-generic/mmiowb.h
> > > > +++ b/include/asm-generic/mmiowb.h
> > > > @@ -34,8 +34,12 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> > > >
> > > >  static inline void mmiowb_set_pending(void)
> > > >  {
> > > > -       struct mmiowb_state *ms = __mmiowb_state();
> > > > +       struct mmiowb_state *ms;
> > > > +
> > > > +       get_cpu();
> > > > +       ms = __mmiowb_state();
> > > >         ms->mmiowb_pending = ms->nesting_count;
> > > > +       put_cpu();
> > > >  }
> > >
> > > #define __mmiowb_state()        this_cpu_ptr(&__mmiowb_state)
> > >
> > > The ptr is a fixed address, so don't worry about the change, and just
> > > use an atomic_read is enough.
> > > static inline void mmiowb_set_pending(void)
> > > {
> > >         struct mmiowb_state *ms = __mmiowb_state();
> > > -       ms->mmiowb_pending = ms->nesting_count;
> > > +      ms->mmiowb_pending = atomic_read(ms->nesting_count);
> > > }
> >
> > You may be right, but it doesn't fix the BUG. As far as I can tell it
> > happens in __mmiowb_state() which expands through this_cpu_ptr and
> > arch_raw_cpu_ptr to SHIFT_PERCPU_PTR(ptr, __my_cpu_offset), where
> > __my_cpu_offset is per_cpu_offset(smp_processor_id()) and with
> > CONFIG_DEBUG_PREEMPT smp_processor_id is actually
> > debug_smp_processor_id, which eventually checks that preemption is
> > disabled in check_preemption_disabled.
> Thx for explaining.
>
> Seems we need to find who disable preemption during:
> > > > [<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
> > > > [<ffffffe0005b290e>] dump_stack+0x6e/0x88
> > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
> > > > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > > > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
> > > > [<ffffffe0004715c4>] regmap_write+0x28/0x48
> > > > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
> > > > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > > > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
> > > > [<ffffffe000467e16>] really_probe+0x92/0x21a
> > > > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
> > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
> > > > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > > > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
> > > > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
> > > > [<ffffffe00046889a>] driver_register+0x32/0xc6
> > > > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
> > > > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc

Hmm.. the problem is that preemption is *not* disabled when
smp_processor_id is called, right?

> do_one_initcall's preempt_count = 0
> (gdb) bt
> #0  do_one_initcall (fn=0xffffffe000003b0e
> <trace_init_flags_sys_exit>) at init/main.c:1190
> #1  0xffffffe000001f20 in do_pre_smp_initcalls () at ./include/linux/init.h:131
>
> #2  kernel_init_freeable () at init/main.c:1494
> #3  0xffffffe0009d6ea6 in kernel_init (unused=<optimized out>) a
>    t init/main.c:1399
> #4  0xffffffe000201c2a in handle_exception () at arch/riscv/kernel/entry.S:188
> Backtrace stopped: frame did not save the PC
> (gdb) p *(struct task_struct*)$tp
> $2 = {thread_info = {flags = 0, preempt_count = 0,
>
> Can you debug like this ? to see which function's preempt_count = 0 in
> your backtrace.

I'm sorry, I'm not exactly sure what you mean by this, but it seems to
happen multiple places in writel-like functions. Both at probe time in
sifive_gpio_probe and sifive_spi_probe and when the spi driver is
running. Here is the full log:

http://sprunge.us/rgfC3r

/Emil
