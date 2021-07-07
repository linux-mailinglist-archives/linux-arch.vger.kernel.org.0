Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EE03BE38C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGGHbF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 03:31:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:41033 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhGGHbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 03:31:05 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mgw7n-1lXBGs2lWn-00hNow for <linux-arch@vger.kernel.org>; Wed, 07 Jul
 2021 09:28:23 +0200
Received: by mail-wr1-f41.google.com with SMTP id d2so1908805wrn.0
        for <linux-arch@vger.kernel.org>; Wed, 07 Jul 2021 00:28:23 -0700 (PDT)
X-Gm-Message-State: AOAM533nE4fu3ZONZhLoiu25VvzGBwlOn/Bvpcl+Dcjj0fNCU3nsvfRk
        XDXcWFFq5k+icz5qMXw7235S/hoCud8RMmGnjEo=
X-Google-Smtp-Source: ABdhPJxsUgAH1CkTFj6ejnQ02/kmlaCxj4lV4bBqNGUcrcq+j/so4Py3s172LjsDh6Y5SDW29pBef79uEBiTS8wZuRI=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr27139936wri.286.1625642903292;
 Wed, 07 Jul 2021 00:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <CAK8P3a0o1bniPG+pocGtMGV-RVEGVJrQDLmz6SyZ-2NGcq2WnQ@mail.gmail.com> <CAAhV-H7Cq10OcQMAGCODoByy+3z7_TQv9vASH0AMt+v2dtrp9A@mail.gmail.com>
In-Reply-To: <CAAhV-H7Cq10OcQMAGCODoByy+3z7_TQv9vASH0AMt+v2dtrp9A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Jul 2021 09:28:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2a8R+pMZykCP5zFCPUzRqdPiBpJuCkmQdMuzL+34DFuw@mail.gmail.com>
Message-ID: <CAK8P3a2a8R+pMZykCP5zFCPUzRqdPiBpJuCkmQdMuzL+34DFuw@mail.gmail.com>
Subject: Re: [PATCH 00/19] arch: Add basic LoongArch support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Chen Zhu <zhuchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:HnBpKsmiV0wDT6PtUqhqaUnTSkjAMHWrfCfrJPlUIV0ywsUR7FH
 sWz46XiZQyPJZAqdnuwwqNVnohmdHDVjXEgs/+dD+sw1JvOpL9B4xrzgSTWtqrkRPZAAcm2
 WD+QjfwOi5z83/Vt2+pFAyrgTQ7fyO25pMBcU8NWSbhGHLR46Yew5lN03wJXxlU1IrwuZiP
 +9vuzoEvA4hPhzgl5fb1Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dZgP40owpaA=:tGE/cX53Dos4dfXx+Fq1Ak
 9w2HbZ3YdBrMiiEXGPU/WppZFgY0MlPGiFZJZcq1zOj3+DkHJgBDF23710iYTincCbjl2PueR
 vOni+n1/tHMga9jYkXvbKOCm6g4JRZ00lnRqE/k63rS5tyiN3ZbQR3vSRkRvEt/Bw4vun0tkH
 OpHGVQfID9WuCN5bJ52lz3iOPZrF9RVpH5zhora9ww9k5qGY/nUCqm0esFnXvnszhv8p8WiOy
 YNKJq53teXIWpn0oao5m0jF6byUsq7YcaIB5WjDnTL1wywQDA+GzWPOOeFF6Vjnd8fzy0acH/
 XFqoKN7zBuGxuGVrUz+hIR4UL3hMd51GA6Qh/JBwJcEK8p2FH3oKUAz3Ral/b5emjImamvHBc
 Vi0juktFbffj6XfinkvHFI3rcL+q4aj2uiVXRz2avy09WEkrlzQ7lkjxOfDRtyKNOZ06eM5G1
 sed9zOUcjrdnBCpWXmBiVkDg32D4V+84KFQ4AGngprKBZNcKYw7xML4uyzQQBVCIvTMNQO81E
 itvFSWoM0U++vEmwn8nyYJUO5GSEe7umDjCSFTScXxrIZWdlw4Zc1vXJC1lMkbBBCT0lo0vTz
 0ZxWsQWYTZ01AiMp6xOu+MN/ZDSo9Wq1G8pMN5DQZpJxllvB2qn73aUifZOqjcrgkWC2IwH4w
 nFdp5yyZq34pnoY1bwo8qod/OiUY/S/wHMhO0vh4Vnfl3nw951RyayRujElUHws4Aqd4eVtLN
 O9e8cPr0C1hRZjXAnbx0MnK5z4kaqyS3SzuOa5ogKczokckk5kS6hkOZk+oxKZf91YuivaYiz
 1y7JqU1WruMkNcA9tTFg52Ote5HfR7zGv/b6zqmE9ObAjSU3QsP4gfvtRgNokSQbPcCo7aoxq
 GqhjfDQadiDswXH3JuFlmgoFz5oAVinee7t4sc3+btGhXGam/kS/Xgb4TeIbhMscyiFLF2o5r
 hOO00U+0g/2ymhcX1CQRvoaLFzvdb+qzy5SdaaG+U1qIaX4g24th6
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 7, 2021 at 5:04 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > 3. 32-bit support: There are small bits of code for 32-bit support everywhere
> >    throughout the code base, but there is also code that does not look like
> >    it would work in that configuration. I would suggest you split out all 32-bit
> >    code into a separate patch, the way you have done for SMP and NUMA
> >    support. That way it can be reviewed separately, or deferred until when
> >    you actually add support for a 32-bit platform. Please also clarify which
> >    modes you plan to support: should every 64-bit kernel be able to run
> >    LA32R and LA32S user space binaries, or do you require running the same
> >    instruction set in both kernel and user space as RISC-V does?
> >    Do you plan to have MIPS N32 style user space on 64-bit kernels?
> No N32 style user space in our current plan, but the 64-bit kernel is
> supposed to run 32-bit applications in the near future.

Ok, sounds good. Adding compat support for a native 32-bit ABI has gotten
a lot easier over time.

On that note, what are the requirements to the kernel for supporting LBT
with aarch64/mips/x86 tasks? Does this involve handling the system calls
(ioctl in particular) for those architectures in the kernel as well, or do you
expect this to be done entirely in user space?

The same topic has come up in the past, as there are at least three projects
that need support for emulating foreign-architecture system calls (qemu,
fex and tango). If there is sufficient demand, we may end up generalizing the
kernel's compat layer to support multiple such ABIs instead of just native
and compat.

> > 4. Toolchain sources: I see you only have binaries for an older gcc-8.3
> >     release and no sources so far. I assume you are already busy porting
> >     the internal patches to the latest gcc and will post that soon, but my
> >     feeling is that the kernel port should not get merged until we have a
> >     confirmation from the toolchain maintainers that they plan to merge
> >     support for their following release. We should however make sure that
> >     your kernel port is completely reviewed and can just get merged once
> >     we get there.
>
> Toolchain is maintained by other developers, it will be open source of
> course, I hope it won't be too late. :)

Right, I meant 'you' as in someone @loongson.cn, not necessarily you
personally.

> > 5. Platform support: You have copied the underlying logic from arch/mips,
> >     but that still uses a method where most platforms (not the new
> >     "generic" version) are mutually exclusive. Since you only support
> >     one platform right now, it would be best to just simplify it to the point
> >     where no platform specific code is needed in arch/loongarch/ and
> >     it just works. If you add 32-bit support later on, that obviously requires
> >     making a choice between two or three incompatible options.
>
> I will improve it, and I will need some help for this.

It should be mostly covered by the comments I made on the individual
comments already, but let me know if you have more specific questions.

       Arnd
