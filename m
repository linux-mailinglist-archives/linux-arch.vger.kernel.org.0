Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B4835E046
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 15:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhDMNlD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 09:41:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhDMNlC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 09:41:02 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFspV-1lKUFV2kEp-00HKYu; Tue, 13 Apr 2021 15:40:38 +0200
Received: by mail-wm1-f46.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so10695300wma.3;
        Tue, 13 Apr 2021 06:40:38 -0700 (PDT)
X-Gm-Message-State: AOAM531+oW4QWY9rmgkAP8JYax/5jPvGFLNY/4jFsx47e8+T1egF6AsK
        koLan2Qx2M97hKV++jbMkgF2QyFS+x8GwLLAnhA=
X-Google-Smtp-Source: ABdhPJwEFuFOX1cIJyv+wf/LzZj/jLsoqxMQrsK8XrmqUm4AEpHO3tmFdoRGFPNI1B+ED9nfbkBvZAjUJDC9jEoCv0w=
X-Received: by 2002:a1c:6382:: with SMTP id x124mr84828wmb.142.1618321238316;
 Tue, 13 Apr 2021 06:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210413115439.1011560-1-schnelle@linux.ibm.com>
 <CAK8P3a1WTZOYpJ2TSjnbytQJWgtfwkQ8bXXdnqCnOn6ugJqN_w@mail.gmail.com>
 <84ab737edbe13d390373850bf317920b3a486b87.camel@linux.ibm.com>
 <CAK8P3a2NR2nhEffFQJdMq2Do_g2ji-7p3+iWyzw+aXD6gov05w@mail.gmail.com> <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
In-Reply-To: <11ead5c2c73c42cbbeef32966bc7e5c2@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Apr 2021 15:40:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
Message-ID: <CAK8P3a3PK9zyeP4ymELtc2ZYnymECoACiigw9Za+pvSJpCk5=g@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     David Laight <David.Laight@aculab.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+77MIqxUBwJc8Ialmfk81vRWp69RAP0fFmqy1CijwrAAaKnH6LJ
 /WeHsORDJvYG0t2Wqcxx7p3hP6Nt4/mD0gwzeeLtHGuLOjq+0l9hGEJOZA97AZQjby51OGB
 +1IWnD2fLnOnXZgvWfP2TaxSIvjW6uDm5d/v97KtgZk6/JLeYy2bYg36kxV9L/MmhH3QxJP
 5SdJo2SN7+My3gbWblIsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6x9Gj/kvg/4=:tMi8M+W0rth4kAR2q2QWUx
 V5qkDe+vFRtxZjxbFA+cXIgU2v+lRFvemmX1AIJgZwKYQPFfI01vaIKgLCwnVz8JpYaFYkzDr
 JRSl1IdD4Z8ar+suERvbhnnaGwMCy+zFiGr4zJXdI/Iq15JJb2YRNqteghFUbNeQIKH/oLLnz
 8hbOLuTvvlZ/EjvWT4IoCQLURyFlORM/gnNrZJg5qUG7o+AY47Dq6steLPQnbrLD5NeT1MsrS
 aCHFuIkc4Zwm8wQS2/Qi2ktTCtE18zSeAc+GSY13s/avR0DuGMGGDiddrp0MMUPYAm8QUXbNw
 Ngp568CMHZ4MZmHlCgai1OB0Plsug3KawRnOhagmLcbSkm5blwzu7XwtVRdiL9xvE9jJOtc6H
 td/NusDssIQKNRmxZg2c296Dx665NhI6IF07jg8tFtCMoBthvD9dF10pqjGRCUgpDb1pMCgAg
 H4wIyWyLd7YGsfWAqVM697D95bAoVDlC1SJAHWfTzQ9t9PO1NZq04tfDSRgOTPXyYhJNPhreS
 II9A+LxfEQzHosP2WSGI6IoXQ57uSlyLYpy/RKVNSjzwf1jIIxnAT9AdKuTiGE4RKeRyygCnj
 Gl6a5Uop8NFUKojC0Z8Y6gEqZrTx3QhzYK6TF5ZTLMqKCdLv+DhcrVkWBb8eUccHl77w8HjaJ
 wlIs=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 13, 2021 at 3:06 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 13 April 2021 13:58
> ...
> > The remaining ones (csky, m68k, sparc32) need to be inspected
> > manually to see if they currently support PCI I/O space but in
> > fact use address zero as the base (with large resources) or they
> > should also turn the operations into a NOP.
>
> I'd expect sparc32 to use an ASI to access PCI IO space.
> I can't quite remember whether IO space was supported at all.

I see this bit in arch/sparc/kernel/leon_pci.c

 * PCI Memory and Prefetchable Memory is direct-mapped. However I/O Space is
 * accessed through a Window which is translated to low 64KB in PCI space, the
 * first 4KB is not used so 60KB is available.
...
        pci_add_resource_offset(&resources, &info->io_space,
                                info->io_space.start - 0x1000);

which means that there is I/O space, which gets accessed through whichever
method readb() uses. Having the offset equal to the resource means that
the '(void *)0' start is correct.

As this leaves only two others, I checked those as well:

csky does not actually have a PCI host bridge driver at the moment, so
we don't care about breaking port access on it it, and I would suggest
leaving I/O port access disabled. (Added Guo Ren to Cc for confirmation).

m68k only supports PCI on coldfire M54xx, and this variant does set
a PCI_IOBASE after all. The normal MMU based m68k have no PCI
and do define their out inb/outb/..., so nothing changes for them.

To summarize: only sparc32 needs to set PCI_IOBASE to zero, everyone
else should just WARN_ONCE() or return 0xff/0xffff/0xffffffff.

        Arnd
