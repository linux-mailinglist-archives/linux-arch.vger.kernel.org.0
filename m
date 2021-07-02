Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F653BA24F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 16:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGBOrZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 10:47:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54256 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhGBOrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 10:47:25 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3BAF20B83F6;
        Fri,  2 Jul 2021 07:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3BAF20B83F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625237092;
        bh=COfBRLi+BJ3qGAqOVgLUX0fhQNuQxKTydWlChw0BlLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tRGwEHasZTX06Egu9Ww7uR8RabiaJLr5vR4tlDPOfGgBdAE0IHk7ehSVCVKdwfsTX
         nDL34TDk/hAMHQ9GJhkVTEsbQH2mo7XE3c2M1Me7rIrRLOXwxwAPWBfJvYSqg0z0Re
         dE3HS528+HtMzM0UXqVixjAMR5aSPvt46WJVMjwM=
Received: by mail-pl1-f180.google.com with SMTP id l19so450209plg.6;
        Fri, 02 Jul 2021 07:44:52 -0700 (PDT)
X-Gm-Message-State: AOAM533bsPXci+LPKoOpKHNWaY8umg8/tkK2V6aEPpJiPLJHHcfxla5j
        XJhAbT1+3r4zVs4xSHOepXhNzjLxXkW5aWy7wJ8=
X-Google-Smtp-Source: ABdhPJzWnpiLuYZjxkaOt2GXQN8Y0htWvRKauf64n9pu1ITllRnRm87jqyOrrR0TIYSKM6zsEhBaReTnfjD2r+YVp+g=
X-Received: by 2002:a17:902:70c4:b029:129:45cd:aa90 with SMTP id
 l4-20020a17090270c4b029012945cdaa90mr123959plt.43.1625237092188; Fri, 02 Jul
 2021 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
 <20210702123153.14093-2-mcroce@linux.microsoft.com> <0e0fa030-8995-b930-5e22-954349a0b82e@codethink.co.uk>
In-Reply-To: <0e0fa030-8995-b930-5e22-954349a0b82e@codethink.co.uk>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 2 Jul 2021 16:44:16 +0200
X-Gmail-Original-Message-ID: <CAFnufp1H4fzOHcinAgS0nnStSqLcALKAtk0QYkrnkQvwAx=BNA@mail.gmail.com>
Message-ID: <CAFnufp1H4fzOHcinAgS0nnStSqLcALKAtk0QYkrnkQvwAx=BNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/string: optimized memcpy
To:     Ben Dooks <ben.dooks@codethink.co.uk>
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
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 2, 2021 at 4:37 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 02/07/2021 13:31, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Rewrite the generic memcpy() to copy a word at time, without generating
> > unaligned accesses.
> >
> > The procedure is made of three steps:
> > First copy data one byte at time until the destination buffer is aligned
> > to a long boundary.
> > Then copy the data one long at time shifting the current and the next long
> > to compose a long at every cycle.
> > Finally, copy the remainder one byte at time.
> >
> > This is the improvement on RISC-V:
> >
> > original aligned:      75 Mb/s
> > original unaligned:    75 Mb/s
> > new aligned:          114 Mb/s
> > new unaligned:                107 Mb/s
> >
> > and this the binary size increase according to bloat-o-meter:
> >
> > Function     old     new   delta
> > memcpy        36     324    +288
> >
> >
> > Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> > ---
> >   lib/string.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 77 insertions(+), 3 deletions(-)
>
> Doesn't arch/riscv/lib/memcpy.S also exist for an architecture
> optimised version? I would have thought the lib/string.c version
> was not being used?
>
>

Yes, but this series started as C replacement for the assembly one,
which generates unaligned accesses.
Unfortunately the existing RISC-V processors can't handle unaligned
accesses, so they are emulated with a terrible slowdown.
Then, since there wasn't any riscv specific code, it was proposed as
generic code:

Discussion: https://lore.kernel.org/linux-riscv/20210617152754.17960-1-mcroce@linux.microsoft.com/

-- 
per aspera ad upstream
