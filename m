Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601A821D69A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGMNTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 09:19:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40381 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgGMNTy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 09:19:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id c25so9465262otf.7;
        Mon, 13 Jul 2020 06:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SATb1dq9lhpVtePq4rLhojB0Hr7gHjZG7fllFCUlzZU=;
        b=f2YEiG3A91itYOB8sMDinMP/Z6LnlM8JlmpGB7lno6H2neYczPpYWa6/0pebzR2IfR
         waW7XkaIkFFL1viwxchFsKggdq2opuP/I17DqLEwloSKb1DK2EzARUk4ZQ2CsUZgqQ9B
         uxqVfm2ZYx548h+UfnxVcofAtCAl5PdcOzFxT0IhHaNqHZTgm/vFN9gyuyW45UOB6Kjr
         N6b0hmWisvbTzn0lmP1/SKTMtpB+jDWk4r+Fl5KvbYQCIxSpdzelI0UKgjSuJv3qMrK5
         vlPk6swiN5ElZ9S7h8FPB3pHf1u5PjicYT+790J7bz1diEk5q3V116Q29ORjiaWm24Ae
         HBpQ==
X-Gm-Message-State: AOAM530ejyjCCkaa4K1eqyi7pL5YG4CWM+QPlKnqQReZkkeAMVvnPlpR
        0pTnvaVIVT/OWTA3Z8eR3EG0+Z5HauFNcVcjBvzCDd9K
X-Google-Smtp-Source: ABdhPJxrDHVPb8cSNkcVN2tMRT9a1iKussPsrWGym59W6ecTQuAg4tTKmjvM3pVTLMwzznFcAu0e7d72NIcQofeksAI=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr57441798otp.250.1594646393513;
 Mon, 13 Jul 2020 06:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de>
 <20200713122148.GA51007@lakrids.cambridge.arm.com>
In-Reply-To: <20200713122148.GA51007@lakrids.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 15:19:42 +0200
Message-ID: <CAMuHMdUCmEeU0G9wkUxZKm5tC9YoB-KXSSCLKwpSia746Myebw@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

On Mon, Jul 13, 2020 at 2:21 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jul 10, 2020 at 03:57:05PM +0200, Christoph Hellwig wrote:
> > Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> > done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> > documents the intent of these calls better, and will allow stubbing the
> > functions out easily for kernels builds that do not allow address space
> > overrides in the future.
>
> > diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
> > index 191e75a6bb249e..30471549e1e224 100644
> > --- a/arch/m68k/include/asm/tlbflush.h
> > +++ b/arch/m68k/include/asm/tlbflush.h
> > @@ -13,13 +13,13 @@ static inline void flush_tlb_kernel_page(void *addr)
> >       if (CPU_IS_COLDFIRE) {
> >               mmu_write(MMUOR, MMUOR_CNL);
> >       } else if (CPU_IS_040_OR_060) {
> > -             mm_segment_t old_fs = get_fs();
> > -             set_fs(KERNEL_DS);
> > +             mm_segment_t old_fs = force_uaccess_begin();
> > +
>
> This used to set KERNEL_DS, and now it sets USER_DS, which looks wrong
> superficially.

Thanks for noticing, and sorry for missing that myself.

The same issue is present for SuperH:

    -               set_fs(KERNEL_DS);
    +               oldfs = force_uaccess_begin();

So the patch description should be:

    "Add helpers to wraper the get_fs/set_fs magic for undoing any damage
     done by set_fs(USER_DS)."

and leave alone users setting KERNEL_DS?

> If the new behaviour is fine it suggests that the old behaviour was
> wrong, or that this is superfluous and could go entirely.
>
> Geert?

Nope, on m68k, TLB cache operations operate on the current address space.
Hence to flush a kernel TLB entry, you have to switch to KERNEL_DS first.

If we're guaranteed to be already using KERNEL_DS, I guess the
address space handling can be removed.  But can we be sure?


> >               __asm__ __volatile__(".chip 68040\n\t"
> >                                    "pflush (%0)\n\t"
> >                                    ".chip 68k"
> >                                    : : "a" (addr));
> > -             set_fs(old_fs);
> > +             force_uaccess_end(old_fs);
> >       } else if (CPU_IS_020_OR_030)
> >               __asm__ __volatile__("pflush #4,#4,(%0)" : : "a" (addr));
>
> > +/*
> > + * Force the uaccess routines to be wired up for actual userspace access,
> > + * overriding any possible set_fs(KERNEL_DS) still lingering around.  Undone
> > + * using force_uaccess_end below.
> > + */
> > +static inline mm_segment_t force_uaccess_begin(void)
> > +{
> > +     mm_segment_t fs = get_fs();
> > +
> > +     set_fs(USER_DS);
> > +     return fs;
> > +}
> > +
> > +static inline void force_uaccess_end(mm_segment_t oldfs)
> > +{
> > +     set_fs(oldfs);
> > +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
