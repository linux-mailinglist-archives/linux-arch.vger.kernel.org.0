Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209D94F54C3
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiDFE7k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 00:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581719AbiDEXkl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 19:40:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0C11D12E1;
        Tue,  5 Apr 2022 15:01:23 -0700 (PDT)
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhDEq-1oFqx13bTG-00eJ4Z; Wed, 06 Apr 2022 00:01:21 +0200
Received: by mail-wm1-f49.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso485139wmn.1;
        Tue, 05 Apr 2022 15:01:21 -0700 (PDT)
X-Gm-Message-State: AOAM5300eiaCt/GtOz/aubRrywsWYVyMuDLdTp9jsHShOkvyKhaE0mgR
        /wiL/umcHCNPuP8z09fR4YdnJRO2u3yrLk2MsQw=
X-Google-Smtp-Source: ABdhPJwpFnYfoC7W3fhpROG/ZwOFBskHRE+B4cQmOeYyUSah/jNs/fMR9Xj0LBcXz7SwKs3p7LpOSW2RcQmAA/Xxjtc=
X-Received: by 2002:a05:600c:1e0b:b0:38c:9ac5:b486 with SMTP id
 ay11-20020a05600c1e0b00b0038c9ac5b486mr4749875wmb.71.1649196081307; Tue, 05
 Apr 2022 15:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <Yib9F5SqKda/nH9c@infradead.org> <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org> <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <20220405212653.GA2482665@roeck-us.net>
In-Reply-To: <20220405212653.GA2482665@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Apr 2022 00:01:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a396EkfQtmkwo80eB9i7F37S=mvrHtCLXhGDhHBczYK3g@mail.gmail.com>
Message-ID: <CAK8P3a396EkfQtmkwo80eB9i7F37S=mvrHtCLXhGDhHBczYK3g@mail.gmail.com>
Subject: Re: [RFC PULL] remove arch/h8300
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YAVQNNcAXh4zzzDjixKV+kUQcHg9sTVLitxta6O69hcECI9N+Nq
 xPjCNVaXHMzup+hhPUBM/FjLqs+LHd6BsvuaUnm6epY3yYcNURfSJEZh2LFrJJ8F2rnw0lM
 e+rJGaB0LxkjYdaymOM61/OL3RUUNJhlcbz58+mX7PcBNlmuNzbi75BMoxwDynUUy6voxdd
 fr87HBByJy53ijczdeiGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y2dgxKOtI+Q=:5FEI8ymlVfjdirIKzYNHfl
 nSLBDWEVYozCOYOEoRvGrRHyjHmn35lssSOgGMcGjCpvgxgc1ZuEVSH6TDFt6p3a3NzmeUY4w
 JmY9R5HPRtl0ZxsB7qUPprWMLbJRRcEUepghPx5aT5141/EbRMqT7G3XZZOOjZ8TqkWwNcR6s
 aecevbp9a+hOqTGwUw5OVcTIV+JSRnRjYf8aUrMz50ABYSnKxa8LBe6pY1wV2POovZWkOJCHU
 DeZSUIfFN0g/qJq6PlKl06iN/1ay8z0aFyolmp2A7z5cvhPVyw1sg2qmth5U4jfb/YRtCebFL
 QRgWEVby4rVydig+BTx/oA1OgSwq2KxETrp5MBTfPp5dj+sPNC/nPPEvGIdCk5WWELDGmjEYm
 GPFVOWC29pXMP8n5/ZJxmvzNQLLQHoX7PIJWS6WkT6NeO5Tx8pj7s4Ecgbwt7W/tUJb/zXifk
 3VNfOdF/uG0N9r4zC0netx9sFrvrIf0w51sHtAWgZcF7V2M6MtysL+4UqEle/zcmU/c0IIxzW
 ff3SMFQvf/lFNdz9iRLwc4nusKcxM+5KcQT67lKdkSFetfFwS7UBiyx8tenXYdUdd0JvVksf2
 FzAxoP2NybyAHtxBr/V22xJTANbCliuoAuN2Mfs+IbNGAgTQMCBAqohUH5at7lrXbY+24OprV
 DkNA1E3aL6EhcdUp7rThZvH5pMlvDYTx8dUlKm/X/gaAjqGbZ+bH/24Bs8sIJVRM2TS2YZxhr
 UDRHzeAZtSy81A3Vof0ZOcu9CCpDHYRTWBgFOj92tyKXjtMHl+5XZJ2mjfozgPXxJUZepj0lT
 w7rG3idkgvU22wIxXp8e/ZJqp74xSxN1nlPpngKz4e9tQGKy0Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 5, 2022 at 11:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Apr 04, 2022 at 03:07:06PM +0200, Arnd Bergmann wrote:
> >
> > Should we garbage-collect some of the other nommu platforms where
> > we're here? Some of them are just as stale:
> >
> > 1. xtensa nommu has does not compile in mainline and as far as I can
> > tell never did
> >    (there was https://github.com/jcmvbkbc/linux-xtensa/tree/xtensa-5.6-esp32,
> > which
> >    worked at some point, but I don't think there was enough interest
> > to get in merged)
>
> Hmm, I build and test nommu_kc705_defconfig in my test system.

What toolchain do you use for this? Max already pointed out my mistake
regarding xtensa, which I thought does not build at all, but just needs
a toolchain specific to the cpu.

> > 2. arch/sh Hitachi/Renesas sh2 (non-j2) support appears to be in a similar state
> >     to h8300, I don't think anyone would miss it
> >
> > 8<----- This may we where we want to draw the line ----
> >
> > 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
> > changes, but I think
> >     Rich still cares about it and wants to add J32 support (with MMU)
> > in the future
> >
> > 4. m68k Dragonball, Coldfire v2 and Coldfire v3 are just as obsolete as SH2 as
> >    hardware is concerned, but Greg Ungerer keeps maintaining it, along with the
> >    newer Coldfire v4 (with MMU)
> >
> > 5. K210 was added in 2020. I assume you still want to keep it.
> >
> > 7. Arm32 has several Cortex-M based platforms that are mainly kept for
> >     legacy users (in particular stm32) or educational value.
> >
> I do build and test mps2_defconfig with qemu's mps2-an385 emulation.
>
> I am not saying that those are actively used, and I don't mind dropping
> them, but they do still work.

To clarify, the list was sorted based on what I expected to be the least to
most actively maintained ones, with the stm32 clearly being in use,
and above it in the the list somewhat less.

         Arnd
