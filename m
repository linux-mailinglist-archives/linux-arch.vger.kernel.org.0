Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9D220FCD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgGOOsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGOOsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 10:48:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32CC061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 07:48:10 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so5888128wmj.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZyFp2ZwNj27+Pm86N/oRm7EnGf00LSdqUmM2ahChaug=;
        b=LmX9hblCupQDIq8vRiIIJVKj9lrmYJye5uhwLazH2TUdoBf7KfeGipdNZK113XcKLp
         XSTmwIlzx0ljbwXHgC7z+FNQ8DTmxDLQogDyadpNmrt71emc3K+JE+440kVnDf8cDFXK
         4dtJoB+Tk658icw9fAYxk40RWrjvp71wyE55uxvMej1bLo4ZBA6k74EIZBPJ0P1wg9Pv
         TCBoDfBBs+/WkCgyyCZ1BaVNBakmTmUDarTt07osC2iZ4M61S/BYVy0eKt1k9pGsz+92
         vSAUH0qcuhecpH/+puTsXR/un3IvScQE8KqFLdF9VPjq4khYNjyd8s6QpTgLwdTUNLDa
         btTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyFp2ZwNj27+Pm86N/oRm7EnGf00LSdqUmM2ahChaug=;
        b=qQQySH5uywGfmFGUZgYLr1xVtsNNTh+prJ+nocDQTkZVV7ekS2fBoGfOobyzasaPhJ
         u3XCOobqzSmF7vW3QVMGAxw/lEqCz4MV7ZyiisBbCbB64Ur0QoLbhrUvbMiSnFMsp8fg
         XCU/qW1CEdgfv0vE1pj5kMKsiMc9F01H246J+Feuh5gj1lIDeGJtvRvCyj1bop1Du6Ow
         Oz7nZhX8qJcb5pIMypVCp+PUmhEQVfqQDwKuA57qTb0vyyXAUMP1D2LpV1ImDzXj01vp
         34fshhV8XbYWN8Xa2GHiapGQRwgljsKYspwojxLN7QO3HwZ/6koI5UgidD70SamJ5AIT
         nAPQ==
X-Gm-Message-State: AOAM532koNaPwuv/DKaWh/DlzgkJQJkqaSY0PO1dGf+fU6s2FVNSzuMD
        aR5IHjvyBVLuaNqWDMv7CNOXTQ==
X-Google-Smtp-Source: ABdhPJwp1OCWItGy798FROjyLWVrh5ZNFOkjVWpcV143keOkgdHsNPw7qCTTCoDn7ukNUC/TnkOXgA==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr8828226wma.18.1594824488859;
        Wed, 15 Jul 2020 07:48:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a833])
        by smtp.gmail.com with ESMTPSA id 129sm3823702wmd.48.2020.07.15.07.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:48:08 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:48:06 +0100
From:   Will Deacon <willdeacon@google.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     kernel@esmil.dk, guoren@kernel.org,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic/mmiowb: Get cpu in mmiowb_set_pending
Message-ID: <20200715144806.GA3443108@google.com>
References: <20200715104246.GA3143299@google.com>
 <mhng-4a6c3dd9-b035-49c8-9e92-e881c0d1027c@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-4a6c3dd9-b035-49c8-9e92-e881c0d1027c@palmerdabbelt-glaptop1>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 15, 2020 at 07:03:49AM -0700, Palmer Dabbelt wrote:
> On Wed, 15 Jul 2020 03:42:46 PDT (-0700), Will Deacon wrote:
> > Hmm. Although I _think_ something like the diff below ought to work, are you
> > sure you want to be doing MMIO writes in preemptible context? Setting
> > '.disable_locking = true' in 'sifive_gpio_regmap_config' implies to me that
> > you should be handling the locking within the driver itself, and all the
> > other regmap writes are protected by '&gc->bgpio_lock'.
> 
> I guess my goal here was to avoid fixing the drivers: it's one thing if it's
> just broken SiFive drivers, as they're all a bit crusty, but this is blowing up
> for me in the 8250 driver on QEMU as well.  At that point I figured there'd be
> an endless stream of bugs around this and I'd rather just.

Right, and my patch should solve that.

> > Given that riscv is one of the few architectures needing an implementation
> > of mmiowb(), doing MMIO in a preemptible section seems especially dangerous
> > as you have no way to ensure completion of the writes without adding an
> > mmiowb() to the CPU migration path (i.e. context switch).
> 
> I was going to just stick one in our context switching code unconditionally.
> While we could go track cumulative writes outside the locks, the mmiowb is
> essentially free for us because the one RISC-V implementation treats all fences
> the same way so the subsequent store_release would hold all this up anyway.
> 
> I think the right thing to do is to add some sort of arch hook right about here
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cfd71d61aa3c..14b4f8b7433f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3212,6 +3212,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
> 	prev_state = prev->state;
> 	vtime_task_switch(prev);
> 	perf_event_task_sched_in(prev, current);
> +	finish_arch_pre_release(prev);
> 	finish_task(prev);
> 	finish_lock_switch(rq);
> 	finish_arch_post_lock_switch();
> 
> but I was just going to stick it in switch_to for now... :).  I guess we could
> also roll the fence up into yet another one-off primitive for the scheduler,
> something like

What does the above get you over switch_to()?

> > diff --git a/include/asm-generic/mmiowb.h b/include/asm-generic/mmiowb.h
> > index 9439ff037b2d..5698fca3bf56 100644
> > --- a/include/asm-generic/mmiowb.h
> > +++ b/include/asm-generic/mmiowb.h
> > @@ -27,7 +27,7 @@
> >  #include <asm/smp.h>
> > 
> >  DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> > -#define __mmiowb_state()       this_cpu_ptr(&__mmiowb_state)
> > +#define __mmiowb_state()       raw_cpu_ptr(&__mmiowb_state)
> >  #else
> >  #define __mmiowb_state()       arch_mmiowb_state()
> >  #endif /* arch_mmiowb_state */
> > @@ -35,7 +35,9 @@ DECLARE_PER_CPU(struct mmiowb_state, __mmiowb_state);
> >  static inline void mmiowb_set_pending(void)
> >  {
> >         struct mmiowb_state *ms = __mmiowb_state();
> > -       ms->mmiowb_pending = ms->nesting_count;
> > +
> > +       if (likely(ms->nesting_count))
> > +               ms->mmiowb_pending = ms->nesting_count;
> 
> Ya, that's one of the earlier ideas I had, but I decided it doesn't actually do
> anything: if we're scheduleable then we know that pending and count are zero,
> thus the check isn't necessary.  It made sense late last night and still does
> this morning, but I haven't had my coffee yet.

What it does is prevent preemptible writeX() from trashing the state on
another CPU, so I think it's a valid fix. I agree that it doesn't help
you if you need mmiowb(), but then that _really_ should only be needed if
you're holding a spinlock. If you're doing concurrent lockless MMIO you
deserve all the pain you get.

I don't get why you think the patch does nothing, as it will operate as
expected if writeX() is called with preemption disabled, which is the common
case.

> I'm kind of tempted to just declare "mmiowb() is fast on RISC-V, so let's do it
> unconditionally everywhere it's necessary".  IIRC that's essentially true on
> the existing implementation, as it'll get rolled up to any upcoming fence
> anyway.  It seems like building any real machine that relies on the orderings
> provided by mmiowb is going to have an infinate rabbit hole of bugs anyway, so
> in that case we'd just rely on the hardware to elide the now unnecessary fences
> so we'd just be throwing static code size at this wacky memory model and then
> forgetting about it.

If you can do that, that's obviously the best approach.

> I'm going to send out a patch set that does all the work I think is necessary
> to avoid fixing up the various drivers, with the accounting code to avoid
> mmiowbs all over our port.  I'm not sure I'm going to like it, but I guess we
> can argue as to exactly how ugly it is :)

Ok.

Will
