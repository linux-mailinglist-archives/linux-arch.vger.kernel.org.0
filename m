Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C952E336E0F
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCKImv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 11 Mar 2021 03:42:51 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCKImW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 03:42:22 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS3r9-1l9WAJ1WnL-00TVFD; Thu, 11 Mar 2021 09:42:20 +0100
Received: by mail-oi1-f169.google.com with SMTP id d20so22318721oiw.10;
        Thu, 11 Mar 2021 00:42:19 -0800 (PST)
X-Gm-Message-State: AOAM532HYypQyDtHTT8ecNnNJRwiaKcAHhwsUnG7O+wqdE0UzDaVBwZQ
        heMiY8w86sh8cZsmrGvdkaMYCI+4BzyXrPJdz0M=
X-Google-Smtp-Source: ABdhPJw0KtsLD5mW4MfRrfYgVjcEGOdTXZu9D7NdBG3jZg8HvDppDRmR8vUGXG+YVlxNPnM5Hk4ZbDjA/u/ZDR28oc4=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr5663752oie.4.1615452138884;
 Thu, 11 Mar 2021 00:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20210225080453.1314-1-alex@ghiti.fr> <20210225080453.1314-3-alex@ghiti.fr>
 <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com> <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
 <CAK8P3a3mVDwJG6k7PZEKkteszujP06cJf8Zqhq43F0rNsU=h4g@mail.gmail.com> <236a9788-8093-9876-a024-b0ad0d672c72@ghiti.fr>
In-Reply-To: <236a9788-8093-9876-a024-b0ad0d672c72@ghiti.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Mar 2021 09:42:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1+vSoEBqHPzj9S07B7h-Xuwvccpsh1pnn+1xJmS3UdbA@mail.gmail.com>
Message-ID: <CAK8P3a1+vSoEBqHPzj9S07B7h-Xuwvccpsh1pnn+1xJmS3UdbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QMP26k/nK+H+ZHkdP9mo8opGr8UAg8kFikYIqnkNzgShTT3VZEQ
 hmFFyGu1QCvztiRcLVVERX21CltcD8gc5uiI+o6hIDusSopvhlPvTJcdQASD+tKJmJUW/M3
 UHrVB7XCF7NA0ZKF1Y9gYUO5kg+DP9cr9yyBX0gdXU4JEHLAsX25dUL/kyGc+fnySst/YDt
 jHbqlOI1jG6X88hNR5aCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RH4E7qcfGzs=:gfQ8It08fa6DbGyiO5hrLQ
 QFcSFNT7b4lzc0lELnFdcphHKN2QBSHUuvKjGc9SRlBOKqyURmqy1wYSNfVf+/nvTgl3rhBTg
 OpD1XeJyU08qKxhJw3NDZW1ebdGObjiOMDy94sjV7fKFEHlzuclCycyUqA6PzVNK+1QZTgiwg
 IcRmiHpEywG+IoWay5/uN2pszOfLMXZTPXNoU69w6qXNLJom7NcbmtzXpaLLzKOvehwtnwbqx
 bR111Ko3I9sXNW8HmhXVRaBBFNgXWOlpqkUyhtCz8cPDqiXST6YDPasQxJTEoKWV3nk8xKq79
 ZCHeLUXIJ3/og/Z1HJ6xbrR6ltjOYx4Zus0WzUi9AkDm7uec8LfNC0KP3DtBXk+pQ9e+XOC9z
 TkQ0FCV5Pn5ue2sH/xQOojYOOlHgLQ/M1FHRJAqkfulgDfSInnUCo1j5dm2ZyRM3PbS7pxvbC
 X6ydWdsLRk+0ROHq6tStli4as8acJt2kE1ZCMJpVkiYNjNoXkJ1AW1UPjM/ZTLH9l6d/MZTar
 5hdfQDZAa4QSEg3sfnZGG8sXzGqAWk2dBVFOjFTFUtt
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 8:12 PM Alex Ghiti <alex@ghiti.fr> wrote:
> Le 3/10/21 à 6:42 AM, Arnd Bergmann a écrit :
> > On Thu, Feb 25, 2021 at 12:56 PM Alex Ghiti <alex@ghiti.fr> wrote:
> >>
> >> Le 2/25/21 à 5:34 AM, David Hildenbrand a écrit :
> >>>                    |            |                  |         |> +
> >>> ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
> >>>> +   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
> >>>> +   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
> >>>> +   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
> >>>> +   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB |
> >>>> vmalloc/ioremap space
> >>>> +   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB |
> >>>> direct mapping of all physical memory
> >>>
> >>> ^ So you could never ever have more than 126 GB, correct?
> >>>
> >>> I assume that's nothing new.
> >>>
> >>
> >> Before this patch, the limit was 128GB, so in my sense, there is nothing
> >> new. If ever we want to increase that limit, we'll just have to lower
> >> PAGE_OFFSET, there is still some unused virtual addresses after kasan
> >> for example.
> >
> > Linus Walleij is looking into changing the arm32 code to have the kernel
> > direct map inside of the vmalloc area, which would be another place
> > that you could use here. It would be nice to not have too many different
> > ways of doing this, but I'm not sure how hard it would be to rework your
> > code, or if there are any downsides of doing this.
>
> This was what my previous version did: https://lkml.org/lkml/2020/6/7/28.
>
> This approach was not welcomed very well and it fixed only the problem
> of the implementation of relocatable kernel. The second issue I'm trying
> to resolve here is to support both 3 and 4 level page tables using the
> same kernel without being relocatable (which would introduce performance
> penalty). I can't do it when the kernel mapping is in the vmalloc region
> since vmalloc region relies on PAGE_OFFSET which is different on both 3
> and 4 level page table and that would then require the kernel to be
> relocatable.

Ok, I see.

I suppose it might work if you moved the direct-map to the lowest
address and the vmalloc area (incorporating the kernel mapping,
modules, pio, and fixmap at fixed addresses) to the very top of the
address space, but you probably already considered and rejected
that for other reasons.

         Arnd
