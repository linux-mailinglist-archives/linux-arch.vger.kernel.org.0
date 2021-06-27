Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC84D3B509D
	for <lists+linux-arch@lfdr.de>; Sun, 27 Jun 2021 02:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhF0AW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Jun 2021 20:22:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhF0AW7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Jun 2021 20:22:59 -0400
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED67620B83FE;
        Sat, 26 Jun 2021 17:20:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED67620B83FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624753236;
        bh=ql5M5jaT8pEIRhBidjp+VT0YSsjiH7tSOsIK7C/7Q1A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdPBliyU2S4zT7al69YcjdoyXCckr9cj78nC4Bct308BQxhK+N+dSyGqxNx9cw5F0
         5XwmCa92jlo70M4ocmpZWgAUcMPGUhWP7qf6xBTvpEP4OelKgYYXIVZ8BVxxCU0yjx
         ZMTDKxSN7y4CR64uq6hmNs8n0Sbtcfgmeu0J67Yc=
Received: by mail-pl1-f181.google.com with SMTP id o3so1647553plg.4;
        Sat, 26 Jun 2021 17:20:35 -0700 (PDT)
X-Gm-Message-State: AOAM5305/9Pa7YomHNknHAHJxn3ZNxRtSL/i1Ec6VAp5SGB2FMhhPLHf
        3D2+H27gpXBJ/L4srWJTsaydlOeeBHzW9mUzJ40=
X-Google-Smtp-Source: ABdhPJzR9XJThrU5IbGCcpYuM0v/cOsYB9rbLs2VQsUc4Y01I33kg2bqpRGVazOix/d1o8l6hZVA62FD9tp2xG5ntbg=
X-Received: by 2002:a17:90a:a60f:: with SMTP id c15mr7478784pjq.187.1624753235319;
 Sat, 26 Jun 2021 17:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210625010200.362755-1-mcroce@linux.microsoft.com> <CAKwvOd=rzoCFtUPrB+Hh8ZneGJwKc_2jW=QN6apb4T033r+kYg@mail.gmail.com>
In-Reply-To: <CAKwvOd=rzoCFtUPrB+Hh8ZneGJwKc_2jW=QN6apb4T033r+kYg@mail.gmail.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sun, 27 Jun 2021 02:19:59 +0200
X-Gmail-Original-Message-ID: <CAFnufp160uvpqNowZpDdOY4bSN1NJ5j81nYcX=9+rW9WZHfXcQ@mail.gmail.com>
Message-ID: <CAFnufp160uvpqNowZpDdOY4bSN1NJ5j81nYcX=9+rW9WZHfXcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] lib/string: optimized mem* functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 25, 2021 at 7:45 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Jun 24, 2021 at 6:02 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Rewrite the generic mem{cpy,move,set} so that memory is accessed with
> > the widest size possible, but without doing unaligned accesses.
> >
> > This was originally posted as C string functions for RISC-V[1], but as
> > there was no specific RISC-V code, it was proposed for the generic
> > lib/string.c implementation.
> >
> > Tested on RISC-V and on x86_64 by undefining __HAVE_ARCH_MEM{CPY,SET,MOVE}
> > and HAVE_EFFICIENT_UNALIGNED_ACCESS.
> >
> > Further testing on big endian machines will be appreciated, as I don't
> > have such hardware at the moment.
>
> Hi Matteo,
> Neat patches.  Do you have you any benchmark data showing the claimed
> improvements? Is it worthwhile to define these only when
> CC_OPTIMIZE_FOR_PERFORMANCE/CC_OPTIMIZE_FOR_PERFORMANCE_O3 are
> defined, not CC_OPTIMIZE_FOR_SIZE? I'd be curious to know the delta in
> ST_SIZE of these functions otherwise.
>

I compared the current versions with the new one with bloat-o-meter,
the kernel grows by ~400 bytes on x86_64 and RISC-V

x86_64

$ scripts/bloat-o-meter vmlinux.orig vmlinux
add/remove: 0/0 grow/shrink: 4/1 up/down: 427/-6 (421)
Function                                     old     new   delta
memcpy                                        29     351    +322
memset                                        29     117     +88
strlcat                                       68      78     +10
strlcpy                                       50      57      +7
memmove                                       56      50      -6
Total: Before=8556964, After=8557385, chg +0.00%

RISC-V

$ scripts/bloat-o-meter vmlinux.orig vmlinux
add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
Function                                     old     new   delta
memcpy                                        36     324    +288
memset                                        32     148    +116
strlcpy                                      116     132     +16
strscpy_pad                                   84      96     +12
strlcat                                      176     164     -12
memmove                                       76      52     -24
Total: Before=1225371, After=1225767, chg +0.03%

I will post benchmarks made on a RISC-V machine which can't handle
unaligned accesses, and it will be the first user of the new
functions.

> For big endian, you ought to be able to boot test in QEMU.  I think
> you'd find out pretty quickly if any of the above had issues.
> (Enabling KASAN is probably also a good idea for a test, too). Check
> out
> https://github.com/ClangBuiltLinux/boot-utils
> for ready made images and scripts for launching various architectures
> and endiannesses.
>

Will do!

-- 
per aspera ad upstream
