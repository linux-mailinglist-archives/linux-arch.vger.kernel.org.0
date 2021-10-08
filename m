Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A4B42621E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Oct 2021 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhJHBm1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Oct 2021 21:42:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39732 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhJHBm0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Oct 2021 21:42:26 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8EF5320B8008;
        Thu,  7 Oct 2021 18:40:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EF5320B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1633657231;
        bh=Uk4hsfUUKYFmUtqCHOODW8RFQjUlKMvlkgUPBoS4mqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtaH4zpKj0zBee2ooDR3Y8HnvwAbd36ZaagCT3jYRxZbi2KloGleAcfgt4cz3txjR
         5MN9q5cTwDSRFFeuBY0YLQ1Sf42Pntn+VWH3hxSWX2yaYtVqpFtQ084tQhuU8SwC//
         W5yfk39B8ZBuJyz66G5WZewL2iMPtCHTPKd4nOyE=
Received: by mail-pg1-f170.google.com with SMTP id s75so1584827pgs.5;
        Thu, 07 Oct 2021 18:40:31 -0700 (PDT)
X-Gm-Message-State: AOAM533sh0oTLbospZzhY8CKA2RcHAPV5POb2KWGmdsqCA1LmXnlR004
        47b1kb9TyK3qrpVpRpUBWovlEiKF4+zKPbSgwa8=
X-Google-Smtp-Source: ABdhPJzQe0p9b3+f2tqDQVpw2zXSsKab+YeHU+cOp7MfVNG/GVkQKHDCVHnhgj28yt/ktMP0O6WPP+N4pivUA+OePMg=
X-Received: by 2002:a62:7656:0:b0:44c:591b:5a42 with SMTP id
 r83-20020a627656000000b0044c591b5a42mr7600293pfc.57.1633657231110; Thu, 07
 Oct 2021 18:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210919192104.98592-1-mcroce@linux.microsoft.com> <mhng-1ef62a9c-06e5-43cf-a4ec-8c18111e79d3@palmerdabbelt-glaptop>
In-Reply-To: <mhng-1ef62a9c-06e5-43cf-a4ec-8c18111e79d3@palmerdabbelt-glaptop>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 8 Oct 2021 03:39:55 +0200
X-Gmail-Original-Message-ID: <CAFnufp0Uud7a3WW0n2tsgDk2Wa7b63=vNmRjsqswa0qyB+Efvg@mail.gmail.com>
Message-ID: <CAFnufp0Uud7a3WW0n2tsgDk2Wa7b63=vNmRjsqswa0qyB+Efvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] riscv: optimized mem* functions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 8, 2021 at 3:26 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 19 Sep 2021 12:21:01 PDT (-0700), mcroce@linux.microsoft.com wrot=
e:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Replace the assembly mem{cpy,move,set} with C equivalent.
> >
> > Try to access RAM with the largest bit width possible, but without
> > doing unaligned accesses.
> >
> > A further improvement could be to use multiple read and writes as the
> > assembly version was trying to do.
> >
> > Tested on a BeagleV Starlight with a SiFive U74 core, where the
> > improvement is noticeable.
> >
> > v3 -> v4:
> > - incorporate changes from proposed generic version:
> >   https://lore.kernel.org/lkml/20210617152754.17960-1-mcroce@linux.micr=
osoft.com/
> >
> > v2 -> v3:
> > - alias mem* to __mem* and not viceversa
> > - use __alias instead of a tail call
> >
> > v1 -> v2:
> > - reduce the threshold from 64 to 16 bytes
> > - fix KASAN build
> > - optimize memset
> >
> > Matteo Croce (3):
> >   riscv: optimized memcpy
> >   riscv: optimized memmove
> >   riscv: optimized memset
> >
> >  arch/riscv/include/asm/string.h |  18 ++--
> >  arch/riscv/kernel/Makefile      |   1 -
> >  arch/riscv/kernel/riscv_ksyms.c |  17 ----
> >  arch/riscv/lib/Makefile         |   4 +-
> >  arch/riscv/lib/memcpy.S         | 108 ----------------------
> >  arch/riscv/lib/memmove.S        |  64 -------------
> >  arch/riscv/lib/memset.S         | 113 -----------------------
> >  arch/riscv/lib/string.c         | 154 ++++++++++++++++++++++++++++++++
> >  8 files changed, 164 insertions(+), 315 deletions(-)
> >  delete mode 100644 arch/riscv/kernel/riscv_ksyms.c
> >  delete mode 100644 arch/riscv/lib/memcpy.S
> >  delete mode 100644 arch/riscv/lib/memmove.S
> >  delete mode 100644 arch/riscv/lib/memset.S
> >  create mode 100644 arch/riscv/lib/string.c
>
> Thanks.  These generally look good, but they're failing to build for me.
> I'm getting errors along the lines of
>
>     arch/riscv/lib/string.c:89:7: error: inlining failed in call to =E2=
=80=98always_inline=E2=80=99 =E2=80=98memcpy=E2=80=99: function body can be=
 overwritten at link time
>        89 | void *memcpy(void *dest, const void *src, size_t count) __wea=
k __alias(__memcpy);      |       ^~~~~~
>     arch/riscv/lib/string.c:99:10: note: called from here
>        99 |   return memcpy(dest, src, count);
>           |          ^~~~~~~~~~~~~~~~~~~~~~~~
>
> I'm still a bit behind on email so I'm going to keep going through
> patches, but if there's no v5 by the time I get back here then I'll take
> a look.

I've sent a v5 here:

https://lore.kernel.org/linux-riscv/20210929172234.31620-1-mcroce@linux.mic=
rosoft.com/

Regards,
--=20
per aspera ad upstream
