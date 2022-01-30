Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98134A35FC
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 12:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbiA3Lgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 06:36:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354655AbiA3Lgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 30 Jan 2022 06:36:44 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkpjD-1mX4CN3OxT-00mKSp; Sun, 30 Jan 2022 12:36:41 +0100
Received: by mail-oi1-f182.google.com with SMTP id t199so4771640oie.10;
        Sun, 30 Jan 2022 03:36:39 -0800 (PST)
X-Gm-Message-State: AOAM5314Ox/BEinCAcq0fPV8cd3GKJu05gn1BFnwkD48soO66bExzH/x
        8G4HgiWAuS46vCuxnRu+Kuk18wAjT0tMlFKJAdM=
X-Google-Smtp-Source: ABdhPJx02/VRPT+lHqxP4cUEJpaptHk8IWYJlq+IlqFxgivaG7fXilNMey5++lAxG71rgAwjbfrXcV/NpMPlqrdhT2Y=
X-Received: by 2002:aca:f03:: with SMTP id 3mr10491465oip.102.1643542598876;
 Sun, 30 Jan 2022 03:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-7-guoren@kernel.org>
 <CAK8P3a3_kVB78-26sxdsEjb3MMcco6U55tc7siCBFZbJjyH6Sw@mail.gmail.com> <CAJF2gTThb8_-T0iOFVZoJrvZqeFvjfWB+AdFyOwtGhN9aG-MQQ@mail.gmail.com>
In-Reply-To: <CAJF2gTThb8_-T0iOFVZoJrvZqeFvjfWB+AdFyOwtGhN9aG-MQQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 30 Jan 2022 12:36:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3A9AMyv7ABRpUgrTo3sg+SogoDSG5cudR87iK+PifU4g@mail.gmail.com>
Message-ID: <CAK8P3a3A9AMyv7ABRpUgrTo3sg+SogoDSG5cudR87iK+PifU4g@mail.gmail.com>
Subject: Re: [PATCH V4 06/17] riscv: compat: Add basic compat date type implementation
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qz/9sgDzB4qJJ3+Q/QIzZPuO+2NXM74KRntuyUyYRQ6Q82LLX8q
 5m29nqq7hI8NgdOZpUSJcmmhtHRIaNk2664vaZqMavt08hkwW5EB1iMikbNA0WaUy2hhFZW
 igASxu07SEzkAuRIeHvw81hHl/RErbhtZDDstsb1vbS0ZVogd98vpQsePnLahyxNWuQp2bZ
 fycIk65CN+YPTIDl0XsEg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t6t6eCcbCi0=:Ildz/xss/+/vz9314TtGHP
 p5xqRwsnhPF3BEgXuo72mHm3SouliMJOMjEvy06dYOOOxKhBk7kIJ0NVWx12x28p4hTxr6nBJ
 am7cCa2hw3wgUy/feRRX3NWojL9VDQ5Fw6NCmV3r/YusXy22pT47+k5M6r5aUhfXEYqeqGSsw
 Y9v7pDKL2ALNfeLqHVGjT4xzKZ0WkLPJrDrK4A8GTNm6f3S1GOIhQ+BKj64VZHIf7i0mW5oT5
 TJO0Cj/t9V4yPslgS/NIlpkP47wHVodUff0PF11I1MEr2cq+bAWdt7qAnNxdiTW3F8Dffwk4R
 FFNyz+pPAAceRtzIU5QcvEuE0zp3WuI+fK6Wu5OG7NOBozw81m5nRGjvyZZX++JKM1ci+hQ3S
 /JfLmJB5sfe+mAneuIluhOlS7o2CuXVtM/P0wyK5v12Z6Uexb8RDLS60CA7x6Vo9iKW50d2OG
 B1KuYUEbfT9nB92Pgpv2ozKCKfBB7Vo0szwOZ3jRRTYXVKeH8Q/us0q3fki7ugaTe0y0FdV2G
 m3gdHN6Y0kJAuzIJttE3nKkrV3CevGA4sbuPZqCJz6J6LXS0RD9wqDM/HyaBgb0rqPUQAzkqV
 htNDhdQuRIYl+kgf6GTl/e8rjsAa1Dj7QMwrjq1MFCIQsNC80wG05KAdWIumyb8uz2e5Z3l/D
 6XGRsL33Gd0/9s/3IQbzaOnMmwRlLOE09sqaD3njZZ1Yd5eEwbgqcKke7tAM8iRlx+EridEVX
 eYpBI/r5xhKQh9yl+dcvKf5UrxnVn1xOXlztxuXdcpXaJ4jdnIG21kYM4naOoPbo/60N6dMvP
 8dcM6MZQKj3xzQ4TEqXkBGxkqXUBxDLeBRXF+tmuq6oFu4Dyn0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30, 2022 at 6:47 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Jan 30, 2022 at 5:56 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jan 29, 2022 at 1:17 PM <guoren@kernel.org> wrote:
> > > +
> > > +#define COMPAT_RLIM_INFINITY   0x7fffffff
> > >
> > > +#define F_GETLK64      12
> > > +#define F_SETLK64      13
> > > +#define F_SETLKW64     14
> >
> > These now come from the generic definitions I think. The flock definitions
> > are just the normal ones,
> Yes, it could be removed after Christoph Hellwig's patch merged.

Rgiht, I keep forgetting that this is a separate series, so this is fine.

> > and AFAICT the RLIM_INIFINITY definition here
> > is actually wrong and should be the default 0xffffffffu to match the
> > native (~0UL) definition.
> Yes, native rv32 used ~0UL, although its task_size is only 2.4GB.

The rlimit range has very little to do with the virtual memory address
limits, it is used for a number of other things that are typically more
limited in practice.

> I would remove #define COMPAT_RLIM_INFINITY   0x7fffffff

Ok.

       Arnd
