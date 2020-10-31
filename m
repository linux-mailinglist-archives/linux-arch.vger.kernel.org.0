Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A832A1AC1
	for <lists+linux-arch@lfdr.de>; Sat, 31 Oct 2020 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJaVdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 31 Oct 2020 17:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgJaVdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 31 Oct 2020 17:33:52 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6B720853;
        Sat, 31 Oct 2020 21:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604180031;
        bh=a949fi3JWCiOsIfB/oXLlGSJaTnnNYCIyox+iEaG/3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FmxLv/JX6BAYBbl58Wkol2prTj8sKl9cvxus7OmDo+6URnNTLmGqZ06GE9zo4BHaB
         iXhqDXTppGvvGbmmfODkn8e10A9CmYm2o8DPHq6nDPdkB1ghH/QP2hswGJSP45Izjn
         hBxXJsrdmGoAujywpsoLUpU9+3792RN4eIWY5h0o=
Received: by mail-qt1-f173.google.com with SMTP id p45so6745899qtb.5;
        Sat, 31 Oct 2020 14:33:50 -0700 (PDT)
X-Gm-Message-State: AOAM530phMDMs7NbEYVeHpjHR6yY98D7PX3+9oSP8hR7TfnJ5xD76Ar9
        SbKny+x4Qac9cu0BnDzo+1WVOf3QO+ljyuylyeA=
X-Google-Smtp-Source: ABdhPJyD/4AcE03j7HIaN207+kO4IYyQ0WkWkrWDUSbNUToIdPZlRv7YWwHuIabdMaXmtCngmEmV1ORQEwrjBUGk+Sk=
X-Received: by 2002:ac8:4808:: with SMTP id g8mr8036830qtq.18.1604180029997;
 Sat, 31 Oct 2020 14:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de>
 <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
 <87sg9vl59i.fsf@nanos.tec.linutronix.de> <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
 <CAK8P3a3FyKTHDSAPCyP8e7UA0LN3OvAatNK_vQ3tnBsdbou4sA@mail.gmail.com> <20201031160539.Horde.n5yNbG9LoUSWqtuPQW_h3w1@messagerie.c-s.fr>
In-Reply-To: <20201031160539.Horde.n5yNbG9LoUSWqtuPQW_h3w1@messagerie.c-s.fr>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 31 Oct 2020 22:33:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3uY0ASRGcPi-OZdRyL_xLY81nJfu+O6z-Ovxu9YCR4dQ@mail.gmail.com>
Message-ID: <CAK8P3a3uY0ASRGcPi-OZdRyL_xLY81nJfu+O6z-Ovxu9YCR4dQ@mail.gmail.com>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michal Simek <monstr@monstr.eu>,
        Chris Zankel <chris@zankel.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul McKenney <paulmck@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, Mel Gorman <mgorman@suse.de>,
        David Airlie <airlied@linux.ie>,
        Christoph Hellwig <hch@lst.de>, linux-csky@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Ben Segall <bsegall@google.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xtensa@linux-xtensa.org, Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 31, 2020 at 4:04 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> > There are also some users on 10+ year old 32-bit netbooks or
> > business laptops, both x86 and Apple G4.
> > The longest-lived 32-bit embedded systems with large memory
> > (other than Arm) are probably NXP QorIQ P20xx/P40xx used in
> > military VME bus systems, and low-end embedded systems based
> > on Vortex86.
> > I'm less worried about all of these because upstream kernel
> > support for ppc32 and x86-32 is already bitrotting and they will
> > likely get stuck on the last working kernel before the
> > TI/Renesas/NXP Arm systems do.
> >
>
> Upstream kernel support for ppc32 is bitrotting, seriously ? What do
> you mean exactly ?

I was thinking more of the platform support: out of the twelve
32-bit platforms in arch/powerpc/platforms/, your 8xx is the only
one listed as 'maintained' or 'supported' in the maintainers list,
and that seems to accurately describe the current state.

Freescale seems to have practically stopped contributing to any of
their 32-bit platforms in 2016 after the NXP acquisition and no longer
employing either of the maintainers. Similarly, Ben seems to have
stopped working on powermac in 2016, which was ten years after
the last 32-bit hardware shipped for that platform.

> ppc32 is actively supported, with recent addition of support of
> hugepages, kasan, uaccess protection, VMAP stack, etc ...

That is good to hear, I didn't know about these additions.
What platforms are people using to develop these? Is this
mainly your 8xx work, or is there ongoing development for
platforms that need highmem?

         Arnd
