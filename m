Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E013EB110
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 09:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbhHMHGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 03:06:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbhHMHGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 03:06:00 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDy9C-1mMB0z0Pa8-00A27F for <linux-arch@vger.kernel.org>; Fri, 13 Aug
 2021 09:05:33 +0200
Received: by mail-wr1-f47.google.com with SMTP id r6so11911452wrt.4
        for <linux-arch@vger.kernel.org>; Fri, 13 Aug 2021 00:05:33 -0700 (PDT)
X-Gm-Message-State: AOAM532c4jUMTpeHtWNfoCgjFDem2dEYSVFlUo2QG5sV5vG1b1wN+6pI
        79ySqtzKB5XBAs6XRzX/cvqhpMjk4NfAwMzMrr0=
X-Google-Smtp-Source: ABdhPJwFkFv5gpRllMp8r2qHrZu5/LnW66GbTGCcFTZhJSxauoPNE2lkjjvjBEnKmcmlSUyWLrd2+XU9GJY7+NmwvDw=
X-Received: by 2002:adf:fd89:: with SMTP id d9mr1298259wrr.361.1628838332715;
 Fri, 13 Aug 2021 00:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com> <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
In-Reply-To: <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Aug 2021 09:05:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
Message-ID: <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:k9p1CQteevfUrhuQV2TqbJ6Y1P3Yn/RkkP6feMvazhS5YAJ2mDe
 rpBErB4eWfWpT0loE1eMUlVyFSSWWcK+/r2ZEhNZCilU9yA9VcgbV4CYzfXJwCt2ZIze7Uw
 kzIGLntVY/jvZhYSTcjVt90KvYNBje4BgwhSduxiUEvFfyH5Y9PODJFxP3xaNBk6sT4eXrE
 TEWiblArYnBTLJsHMz7UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8cMHmibkU8M=:WtEHyi+d3FArtz5sKRCTo9
 BEUScFvi+l9sAIBUZB1iCqH3gtJG+m3LUOr+m6aA65UbdeCAvBgxUBr5ywnI9Lna6T699pZZ2
 wMhPPZurPCuG/iFooP6Qd4m9dh65XsXJa3Zetqqb0xWLaYh6WGTY2dz+/6linRNmkpp4ouCXq
 L4ovExsDKpNFR59PdYIzgPXTHMuBkG4yHqmAqo2Kj1NdgNaq6ozJ9icfD2/GgknLXw3DLU+Zy
 IPoyZA6v+OnmQLAPaDuIQkxRY6ZSSnRQABQCh/CwCYuk2DwkXB2rKA8NT5JX7XDMYCOAiidog
 IljMFOUlT4EBXGz+FAeu+VC9jkmxNoFUp2wJYQHSAwBwGuJXCvlyBmSMBIgNO2mjg+iVoCMFg
 tF7zMvh80wthfPEJpWag6LGPijLf/tNSqAsPIOaR00QEUhSFU+0oYytyEuwf4IlnTXSA59x47
 ++XW91Rpi8ViJnBWW84GexPSePtvm8IkaqGG1JUH+xUvvJ1QcAZhe1g5ddMHeLlReaf6U9Y/y
 bg/vp/jDHzP4yjbabyUO/a7lfVinNQ0xfOuxzx380mZDCj7G1MLTcqnRojr5+Nf8mQ/QlaBMF
 jr5Nswa8EfHOWV3PX40E3VaLA/sQdMTTIi/jhs8tf410NUoO9l7g2jfWnDFJlV3bPyjMvpFC5
 RCuF2itxBW+WbmTZTpmF8zN4E6Q897UZ9mnDTmsnKynIHfd3DTcav4bET+DouNWw6grCfq/UV
 49FBrJTr6UvgLQ+laISbxuEU2nTNsdruTB69QB5HLZTfpwwKrsxt8HV3oU2bXKeRt62wDWSFO
 QcRgGmpntmNSlgaIlRDCDCgc33kQqp+5wbdn13iPmW6KD6bn9njrUvVkSnrSHY5ktIq/ETmrM
 CZ2/5U7okkp+GPu/4cuarMUX6sbaXsOw+RDpJNlBbAmIpfOBej7VkJWJ3ELGf6oukHlo6AZYD
 LMFjQWTZ0cuF7HK9yiY+fzBmB4XSBWgKZ8r7KZ/VafNXQn5NcYC+i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 13, 2021 at 5:30 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Thu, Aug 12, 2021 at 8:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > +#ifdef CONFIG_VA_BITS_40
> > > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> > > > > +#endif
> > > > > +#ifdef CONFIG_VA_BITS_48
> > > > > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> > > > > +#endif
> > > >
> > > > Why would the CPU have fewer VA bits than the page table layout allows?
> > > PAGESIZE is configurable, so the range a PGD can cover is various, and
> > > VA40/VA48 is not exactly 40bit/48bit, but 40bit/48bit in maximum.
> >
> > Do you mean the page size is not a compile-time constant in this case?
> >
> > What are the combinations you can support? Is this a per-task setting
> > or detected at boot time?
> Page size is a compile-time configuration. Maybe you or maybe me get
> lost here.:)
> What I want to do here:
> 1, I want to provide VA40 and VA48 for user-space.
> 2, CPU's VA bits may be 32, 36, 40, 48 or other values (so we need
> (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits)) or something similar).
> 3, The range a PGD can cover depends on PAGE SIZE (so it cannot
> exactly equals to 40/48).

I still don't see what is special about 40 and 48. From what I can tell,
you have two constraints: the maximum address space size for
the kernel configuration based on the page size and number of
page table levels, and the capabilities of the CPU as described
in the CPUCFG1 register.

What is the point of introducing an arbitrary third compile-time
limit here rather than calculating it from the page page size?

> > I would suggest you don't plan to ever add LPX32 in this case, it
> > has never really caught on for any of the architectures that support
> > it other than mips, and even there I don't think it is used much
> > any more.
> >
> > It's certainly easier to have fewer ABI options.
> LPX32 is just a placeholder now, and maybe a placeholder for ever. :)

Ok, fair enough.


       Arnd
