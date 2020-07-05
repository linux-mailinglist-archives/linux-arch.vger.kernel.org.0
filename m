Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8C214D3E
	for <lists+linux-arch@lfdr.de>; Sun,  5 Jul 2020 16:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGEOvU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Jul 2020 10:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgGEOvU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jul 2020 10:51:20 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 719A92073E
        for <linux-arch@vger.kernel.org>; Sun,  5 Jul 2020 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593960679;
        bh=LxBZTJANNJdPomcTrtcPVv1//sorAgNSAm12j74xRCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DAz4u9F2p62ma6a0lH0wfl4UtCoEANXz/ZXoqXnCjF7jZC2BL6hPwXDfrHyyuG+hJ
         M5PzYO6uopv634sV9DsS1V2Kqimokx5rNi+oeaXC916NOPgsumUJ86wAj1z5bW8LKQ
         2RF13xOt0qZVW+Tkg9boErzARr7ogdcHdXVI7dfM=
Received: by mail-lf1-f50.google.com with SMTP id g139so21130163lfd.10
        for <linux-arch@vger.kernel.org>; Sun, 05 Jul 2020 07:51:19 -0700 (PDT)
X-Gm-Message-State: AOAM530ZSZDHOhO3GNvbtSZP1dYZcveaT4v4OmzEKbCCeHpFHF1XKOa9
        A6EGUXidnfCEzHKYdGCDCzsutVQgrPkaA56Hmus=
X-Google-Smtp-Source: ABdhPJyBmTFcDzykIlFA0+IHy5zcT/roqfhnYAJ17ytE4YfElPz4jfUL7wv37GCNNDxncBzcZtCFX85JteFCXjjhZl4=
X-Received: by 2002:a19:e56:: with SMTP id 83mr27222210lfo.212.1593960677727;
 Sun, 05 Jul 2020 07:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200705142640.279439-1-kernel@esmil.dk> <CAJF2gTSi+2qxfzWxa5xvZnyJBFi5WcdSc-LDrqavB-hZ9-e9-Q@mail.gmail.com>
In-Reply-To: <CAJF2gTSi+2qxfzWxa5xvZnyJBFi5WcdSc-LDrqavB-hZ9-e9-Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 5 Jul 2020 22:51:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRr=7_S5M5Y71Fxx66o6fvv1NN=d9nWiUqnAqHFHiu3Cw@mail.gmail.com>
Message-ID: <CAJF2gTRr=7_S5M5Y71Fxx66o6fvv1NN=d9nWiUqnAqHFHiu3Cw@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
To:     Emil Renner Berthing <kernel@esmil.dk>
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

Sorry:  Use atomic_set, not atomic read,
seams like:
 +       atomic_set(&ms->mmiowb_pending, ms->nesting_count);

But you need still deal with these for atomic
struct mmiowb_state {
        u16     nesting_count;
        u16     mmiowb_pending;
};

On Sun, Jul 5, 2020 at 10:43 PM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Emil,
>
> On Sun, Jul 5, 2020 at 10:27 PM Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > Without this enabling CONFIG_PREEMPT and CONFIG_DEBUG_PREEMPT
> > results in many errors like this on the HiFive Unleashed
> > RISC-V board:
> >
> > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> > caller is regmap_mmio_write32le+0x1c/0x46
> > CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3-hfu+ #1
> > Call Trace:
> > [<ffffffe000201f6e>] walk_stackframe+0x0/0x7a
> > [<ffffffe0005b290e>] dump_stack+0x6e/0x88
> > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > [<ffffffe0005c4c26>] check_preemption_disabled+0xa4/0xaa
> > [<ffffffe00047365e>] regmap_mmio_write32le+0x18/0x46
> > [<ffffffe0004737c8>] regmap_mmio_write+0x26/0x44
> > [<ffffffe0004715c4>] regmap_write+0x28/0x48
> > [<ffffffe00043dccc>] sifive_gpio_probe+0xc0/0x1da
> > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > [<ffffffe000469054>] platform_drv_probe+0x24/0x52
> > [<ffffffe000467e16>] really_probe+0x92/0x21a
> > [<ffffffe0004683a8>] device_driver_attach+0x42/0x4a
> > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > [<ffffffe0004683f0>] __driver_attach+0x40/0xac
> > [<ffffffe0004683ac>] device_driver_attach+0x46/0x4a
> > [<ffffffe000466a3e>] bus_for_each_dev+0x3c/0x64
> > [<ffffffe000467118>] bus_add_driver+0x11e/0x184
> > [<ffffffe00046889a>] driver_register+0x32/0xc6
> > [<ffffffe00000e5ac>] gpiolib_sysfs_init+0xaa/0xae
> > [<ffffffe0000019ec>] do_one_initcall+0x50/0xfc
> > [<ffffffe00000113e>] rdinit_setup+0x22/0x26
> > [<ffffffe000001bea>] kernel_init_freeable+0x152/0x1da
> > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
> > [<ffffffe0005c4d36>] kernel_init+0xa/0x11a
> > [<ffffffe0005c4d28>] rest_init+0xde/0xe2
> > [<ffffffe000200ff6>] ret_from_syscall_rejected+0x8/0xc
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> > This patch fixes it, but my guess is that it's not the right
> > fix. Do anyone have a better idea?
> >
> >  include/asm-generic/mmiowb.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> > index 9439ff037b2d..31a21cdfbbcf 100644
> > --- a/include/asm-generic/mmiowb.h
> > +++ b/include/asm-generic/mmiowb.h
> > @@ -34,8 +34,12 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> >
> >  static inline void mmiowb_set_pending(void)
> >  {
> > -       struct mmiowb_state *ms = __mmiowb_state();
> > +       struct mmiowb_state *ms;
> > +
> > +       get_cpu();
> > +       ms = __mmiowb_state();
> >         ms->mmiowb_pending = ms->nesting_count;
> > +       put_cpu();
> >  }
>
> #define __mmiowb_state()        this_cpu_ptr(&__mmiowb_state)
>
> The ptr is a fixed address, so don't worry about the change, and just
> use an atomic_read is enough.
> static inline void mmiowb_set_pending(void)
> {
>         struct mmiowb_state *ms = __mmiowb_state();
> -       ms->mmiowb_pending = ms->nesting_count;
> +      ms->mmiowb_pending = atomic_read(ms->nesting_count);
> }
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
