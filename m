Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8713EA4B2
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhHLMac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:30:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbhHLMac (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:30:32 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxmBc-1n2Ot13qk2-00zFQd for <linux-arch@vger.kernel.org>; Thu, 12 Aug
 2021 14:30:05 +0200
Received: by mail-wm1-f51.google.com with SMTP id f12-20020a05600c4e8c00b002e6bdd6ffe2so1208924wmq.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:30:05 -0700 (PDT)
X-Gm-Message-State: AOAM533TPB2JdTT5WxVcntBJVFzcJb2MzbDVsuUm03kALQVuiKjW77+D
        nD9T07056gpmsDMKWimEKhN2vfDjcI0YtTHOGHw=
X-Google-Smtp-Source: ABdhPJzWDmHQbxgdpvoxCzlg4GfNik7ak0+iwV7w0GBwBY6vvu320Ygsp2m4eQq3jxBhYD08EDtPOgDZH22vpdlMS2g=
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr15028288wmm.120.1628771405577;
 Thu, 12 Aug 2021 05:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-8-chenhuacai@loongson.cn> <CAK8P3a3FJSX6U9i0KYDKGVgPxi=OnrJJg73d74=KOkbEBoVa+g@mail.gmail.com>
 <YOQ50HDzj0+y00sR@hirez.programming.kicks-ass.net> <CAAhV-H767tTTCpR26x3hNN2BrWDyfe4z6p0gsgS4TSiXLu6=Hw@mail.gmail.com>
In-Reply-To: <CAAhV-H767tTTCpR26x3hNN2BrWDyfe4z6p0gsgS4TSiXLu6=Hw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Aug 2021 14:29:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0gDhL0SUo-RvR00GAi1cOTox_S759uEC7gr0yLkr=+JQ@mail.gmail.com>
Message-ID: <CAK8P3a0gDhL0SUo-RvR00GAi1cOTox_S759uEC7gr0yLkr=+JQ@mail.gmail.com>
Subject: Re: [PATCH 07/19] LoongArch: Add process management
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ZeEYaRk8wnRHM0oGNmo6gd7h+pCe65yCV1wswtk7e9RMi088m4s
 NdyRFUv7qsQ0AwqJPpquW+A/ftXDSwld7p1s7XQDg9sJzR1gLRzcYQHJ0+0du6uBzMBDZIg
 k+e2mb7vLupyo9T3/iJ+hgY5PTBOJ8BXkdcvsp/1JMn3zgVCq+Wx88q3EYAsAHVu7/tkDDu
 Jx11EajVpql+uVA3d7PmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lovaYUx6YEw=:w/XtnfwQtQd+zDZfFVc4Th
 rMwO/+OrgMA9mojdfiRw+R0PIz5gRK6OOYnkkNXqCCnk9WcS7Sq60n1H+SbEEFoc/OrHTF+8i
 YWvnDqTnSB3yaL16mIT58BsRRYIEstdxocZL1Q107y3nut1eDC91ITdXO1+cxPVqJKHonM7K0
 0YiHf0tCTgZv4H5w/nWzjI+VZK1/4UDmitEU7Zk1WRq6blVx9KiccAuMZj8A2YxD/AeMrJUgM
 GnGHy7DkbEg3rGJH5t/Xb+O9pGOH7FXyZDW6tvk9FUxMWEPnwNay1AE+8q3d9lRY26IAIpgPS
 8MZ2s1yRIw4FnTseBrazdsoiWsVXsvtUwAbUlv60Kgpzo5lGDoLMjkPtdPz/WTYOr580pAdjT
 4wXt0xzYEaEI3Q1ibGliYTC1M5m43B1F1V5scr29ntt4AjfpHE+y5KSDplAhMW0e/Qum0SDGp
 2se+TVI86ZV7XTEuwtHjUUXEX9EDEswixKz6fH91epbLPsNwJRLI9t60Ckh31WLw/aLRTSHG1
 WYh6WjyPepzhmyekcW4cza/QVhiRQPn9O4Or6Ne9nLWYo/cf/9lXD9i37C/VFz6bmWFAXfUY5
 FTQev+Ptp0oJ9Rg6KslHNK79mQ4oeWimipkKseBIDUQjlsWiNLobGIEAqfRtPbc5GdmWbb4sD
 phQ65uQOQkSRfHWsoc0Ig0lnBfGdQ1zVUZK0VPUhNk+JQRoI9unVsshpwP0FwGE18/SGTdHAL
 zOuY5K0dpDI9lregtcFbkkdMWCjZoIRUag+wGHX+2evsyIGit4z/WdbSi/5d+SfQ6Ityb79Ns
 KYb7eMZ335fesQfA4YVF8gZPYFpu43+4Wws8ZXPbxVUOcfLRgEpXc5wqKsfknUFYEAY8WDj
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 12, 2021 at 1:17 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 7:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 06, 2021 at 12:16:37PM +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > > +void arch_cpu_idle(void)
> > > > +{
> > > > +       local_irq_enable();
> > > > +       __arch_cpu_idle();
> > > > +}
> > >
> > > This looks racy: What happens if an interrupt is pending and hits before
> > > entering __arch_cpu_idle()?
> >
> > They fix it up in their interrupt handler by moving the IP over the
> > actual IDLE instruction..
> >
> > Still the above is broken in that local_irq_enable() will have all sorts
> > of tracing, but RCU is disabled at this point, so it is still very much
> > broken.
> This is a sad story, the idle instruction cannot execute with irq
> disabled, we can only copy ugly code from MIPS.

Maybe you can avoid that tracing problem if you move the irq-enable
and subsequent need_resched() check into the assembler code.

Another option would be to have the actual idle logic implemented
in firmware that runs at a higher privilege level and provides a
hypercall interface to the kernel with the normal behavior (
enter with irq disabled, wait until irq).

       Arnd
