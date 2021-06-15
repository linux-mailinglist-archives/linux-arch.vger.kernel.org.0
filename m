Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101AB3A813D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFONrc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:47:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37894 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhFONr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:47:29 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9BF3420B6AEE;
        Tue, 15 Jun 2021 06:45:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BF3420B6AEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623764724;
        bh=7UULkM9VpH3Wm7vWsgwZVD3p39+NvKKLXs8u9XWsGBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oq4u01Z10/CBCJu1HPj1Vvu1ftm2kYNH8idZjB5WxkhgjgnbVMq39iDdAuuSQLAKZ
         VpLVpJEDIigDfAepMNu7TJYWdwBEnpDnzMtuRsyP711OYly94uxU2aKOYJp+2iOD13
         muGQXPdC0UaG2FxC5mIDCKB+7DBU9tQHsbH7EBnM=
Received: by mail-pg1-f170.google.com with SMTP id w31so8981943pga.6;
        Tue, 15 Jun 2021 06:45:24 -0700 (PDT)
X-Gm-Message-State: AOAM531vgRD2KSxrHohSGbWTI+4qqhm4tf4GxHppwEDyTSeik/fwiDDT
        1N3bQ2ZTd6+YLPf6CK0LoESRwNXlFVL9ITMPLrM=
X-Google-Smtp-Source: ABdhPJyzNMA1hikc4GzmgcUaRxwOH9kITpR2EgDgak8cpnVdiiCAfUiybdtEp1A5PpHdPahqGVJBiDJhevSMLxRuI3Q=
X-Received: by 2002:a63:1703:: with SMTP id x3mr22496302pgl.421.1623764724145;
 Tue, 15 Jun 2021 06:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com> <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
In-Reply-To: <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 15 Jun 2021 15:44:48 +0200
X-Gmail-Original-Message-ID: <CAFnufp208bY29Zs9w7OtMtK0vcFOs1OosO2U6tJzm6ju-Awe4g@mail.gmail.com>
Message-ID: <CAFnufp208bY29Zs9w7OtMtK0vcFOs1OosO2U6tJzm6ju-Awe4g@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     David Laight <David.Laight@aculab.com>
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 3:18 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Bin Meng
> > Sent: 15 June 2021 14:09
> >
> > On Tue, Jun 15, 2021 at 4:57 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> ...
> > > I'm surprised that the C loop:
> > >
> > > > +             for (; count >= bytes_long; count -= bytes_long)
> > > > +                     *d.ulong++ = *s.ulong++;
> > >
> > > ends up being faster than the ASM 'read lots' - 'write lots' loop.
> >
> > I believe that's because the assembly version has some unaligned
> > access cases, which end up being trap-n-emulated in the OpenSBI
> > firmware, and that is a big overhead.
>
> Ah, that would make sense since the asm user copy code
> was broken for misaligned copies.
> I suspect memcpy() was broken the same way.
>
> I'm surprised IP_NET_ALIGN isn't set to 2 to try to
> avoid all these misaligned copies in the network stack.
> Although avoiding 8n+4 aligned data is rather harder.
>

That's up to the network driver, indeed I have a patch already for the
BeagleV one:

https://lore.kernel.org/netdev/20210615012107.577ead86@linux.microsoft.com/T/

> Misaligned copies are just best avoided - really even on x86.
> The 'real fun' is when the access crosses TLB boundaries.
>

-- 
per aspera ad upstream
