Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770793DFD4E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhHDIwn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 04:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235216AbhHDIwm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Aug 2021 04:52:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 194F160F6F;
        Wed,  4 Aug 2021 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628067150;
        bh=0iArU+ki2EYLRkNMmkYJbqoFHfcp+tUcOVzag8zIBck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nobG9Gllv7N13jdGBP2jfG+ONsBdT6IEGWHjH/Oco3P/JFwCN0PDsDGkujbmZMAWe
         BjdWUIvxBxnrqLftwh2D1cgQCKWkSUFW+wAM8uCwY04CZqKsKvZXc8GshDWm8MEyHO
         aVcxw8Jd9apy8lEE+nRmqu0UieVsEssGfDd0ytPsynRejgJwh38QPDeGuT8XvI3VEX
         dbH27biK1A5t4lHo3eKTfkopJBkymdBCTrrmItFkO0/OsoHYpCRVLJ/oSTmosIqe0M
         knvdgIaQWoWde1rvTUFyE1H4qcwsPEQq4w4hxLwZ1Ozu4YIXbvRS+we8YRaSMCJfbC
         9rSgjWs9x5jIA==
Received: by mail-wm1-f42.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso3385465wms.1;
        Wed, 04 Aug 2021 01:52:30 -0700 (PDT)
X-Gm-Message-State: AOAM53316txzQsabJyuRzstgjNIjWx3j/mN2e5Pet6S6rU6yhrf7gNmp
        q8aHFyJk9bzV7zWYqIh27p3NT+j5FX2aBfpYPLg=
X-Google-Smtp-Source: ABdhPJwRBm+5B/otZTXkzrYbrncm3ie0XIHr+qNno/ecewugZENntEn3MDOC/UJz0gQwsZXJwdMVY0wo/wfqtPO74RM=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr17262306wmq.43.1628067148644;
 Wed, 04 Aug 2021 01:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
In-Reply-To: <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 Aug 2021 10:52:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
Message-ID: <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     John Garry <john.garry@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 4, 2021 at 9:55 AM John Garry <john.garry@huawei.com> wrote:
>
> On 03/08/2021 13:15, Arnd Bergmann wrote:
> >> That seems reasonable. And asm-generic io.h should be ifdef'ed by
> >> HAS_IOPORT. In your patch you had it under CONFIG_IOPORT - was that
> >> intentional?
> > No, that was a typo. Thanks for pointing this out.
> >
> >> On another point, I noticed SCSI driver AHA152x depends on ISA, but is
> >> not an isa driver - however it does use port IO. Would such dependencies
> >> need to be changed to depend on HAS_IOPORT?
> > I'm not sure what you mean here. As far as I can tell, AHA152x is an ISA
> > driver in the sense that it is a driver for ISA add-on cards. However, it
> > is not a 'struct isa_driver' in the sense that AHA1542 is, AHA152x  is even
> > older and uses the linux-2.4 style initialization using a module_init()
> > function that does the probing.
>
> ok, fine. So I just wonder what the ISA kconfig dependency gets us for
> aha152x. I experimented by removing the kconfig dependency and enabling
> for the arm64 (which does not have CONFIG_ISA) std defconfig and it
> built fine.

The point of CONFIG_ISA is to only build drivers for ISA add-on cards
on architectures that can have such slots. For ISA drivers in particular,
we don't want them to be loaded on machines that don't have them
because of the various ways this can cause trouble with hardwired
port and irq numbers.

> >> Yeah, that sounds the same as what I was thinking. Maybe IOPORT_NATIVE
> >> could work as a name. I would think that only x86/ia64 would define it.
> >> A concern though is that someone could argue that is a functional
> >> dependency, rather than just a build dependency.
> > You can have those on a number of platforms, such as early
> > PowerPC CHRP or pSeries systems, a number of MIPS workstations
> > including recent Loongson machines, and many Alpha platforms.
> >
>
> hmmm... if some machines under an arch support "native" port IO and some
> don't, then if we use a common multi-platform defconfig which defines
> HARDCODED_IOPORT, then we still build for platforms without "native"
> port IO, which is not ideal.

Correct, but that's not a problem I'm trying to solve at this point. The
machines that have those are extremely rare, so almost all configurations
that one would encounter in practice do not suffer from it, and solving it
reliably would be really hard.

       Arnd
