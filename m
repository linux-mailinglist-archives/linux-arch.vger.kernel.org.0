Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20E3C3737
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jul 2021 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhGJXLM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jul 2021 19:11:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60098 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJXLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jul 2021 19:11:12 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by linux.microsoft.com (Postfix) with ESMTPSA id 37D0120B83DE;
        Sat, 10 Jul 2021 16:08:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37D0120B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625958506;
        bh=iI1FMzdW4VlFjZv/Q84Kju2c7nRPfQ1D8g1ol/lad8o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqjRWbf+6qAnSEecmFTGrkQ4qqom1FTAb4ksGZNiN/l9ybsufLXb2fdmnzUrOn9iv
         VBotjDq18WMYTO+9tBtHZ/zAyPyDXG6RpSXXdccx3qppBIcdzo235HmRRnOdJyb2Cx
         F/SmxbSFCSiPaQgRH9gpclsfiL4ksZfbm2VKdfLc=
Received: by mail-pg1-f169.google.com with SMTP id t9so14044877pgn.4;
        Sat, 10 Jul 2021 16:08:26 -0700 (PDT)
X-Gm-Message-State: AOAM5323W1aUkn6WK13g07xhdTPQu2JUHvsIItidNpxTBjzoxKRk2Zoa
        TtDtho/7FLhSoFJNr37MsSU/i8EUhV3OXuwzQBc=
X-Google-Smtp-Source: ABdhPJyBa7wMiayi1ErSAh3ldGm6dx2ZY5JoyPvQw5M4KtTZ2dOOWv17h2lZwMrUOjEQAXpV+yA5JCGWg7/gJP9llqY=
X-Received: by 2002:a62:5b81:0:b029:32a:dfe:9bb0 with SMTP id
 p123-20020a625b810000b029032a0dfe9bb0mr4818627pfb.0.1625958505677; Sat, 10
 Jul 2021 16:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210702123153.14093-1-mcroce@linux.microsoft.com> <20210710143109.fd5062902ef4d5d59e83f5bb@linux-foundation.org>
In-Reply-To: <20210710143109.fd5062902ef4d5d59e83f5bb@linux-foundation.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sun, 11 Jul 2021 01:07:49 +0200
X-Gmail-Original-Message-ID: <CAFnufp1d+FH1K5QAx+Z=KvMUvrveJAVnjJJc8xoDCn2wmzUOoQ@mail.gmail.com>
Message-ID: <CAFnufp1d+FH1K5QAx+Z=KvMUvrveJAVnjJJc8xoDCn2wmzUOoQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] lib/string: optimized mem* functions
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 10, 2021 at 11:31 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri,  2 Jul 2021 14:31:50 +0200 Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
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
> > These are the performances of memcpy() and memset() of a RISC-V machine
> > on a 32 mbyte buffer:
> >
> > memcpy:
> > original aligned:      75 Mb/s
> > original unaligned:    75 Mb/s
> > new aligned:          114 Mb/s
> > new unaligned:                107 Mb/s
> >
> > memset:
> > original aligned:     140 Mb/s
> > original unaligned:   140 Mb/s
> > new aligned:          241 Mb/s
> > new unaligned:                241 Mb/s
>
> Did you record the x86_64 performance?
>
>
> Which other architectures are affected by this change?

x86_64 won't use these functions because it defines __HAVE_ARCH_MEMCPY
and has optimized implementations in arch/x86/lib.
Anyway, I was curious and I tested them on x86_64 too, there was zero
gain over the generic ones.

The only architecture which will use all the three function will be
riscv, while memmove() will be used by arc, h8300, hexagon, ia64,
openrisc and parisc.
Keep in mind that memmove() isn't anything special, it just calls
memcpy() when possible (e.g. buffers not overlapping), and fallbacks
to the byte by byte copy otherwise.

In future we can write two functions, one which copies forward and
another one which copies backward, and call the right one depending on
the buffers position.
Then, we could alias memcpy() and memmove(), as proposed by Linus:

https://bugzilla.redhat.com/show_bug.cgi?id=638477#c132

Regards,
-- 
per aspera ad upstream
