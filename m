Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6666141FD5F
	for <lists+linux-arch@lfdr.de>; Sat,  2 Oct 2021 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhJBRWr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Oct 2021 13:22:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42962 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhJBRWq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Oct 2021 13:22:46 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by linux.microsoft.com (Postfix) with ESMTPSA id AB94820B4843;
        Sat,  2 Oct 2021 10:21:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB94820B4843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1633195260;
        bh=pWCqFFkYasORJJMiOzE5VQLaiyHxduAqYZzlCIytLqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LyKrWMc38OVWl2j9tIYxU3ZFOduqLihYwvTtN171qiIhb3+T9MTX0va4g/YVFU62x
         XHX/SCETWaXXuR9pGbnaHiejpw9tyr1vCA5lpM5q7KyOAUE5ovJjUjvCHFheHtzO6d
         w2HUr0aShPeR9dZOpCNqrEpn531swZTi1scougEw=
Received: by mail-pg1-f174.google.com with SMTP id m21so12420505pgu.13;
        Sat, 02 Oct 2021 10:21:00 -0700 (PDT)
X-Gm-Message-State: AOAM531Ex9cSTd1a8iAhTIp5KzO6PMIMXBR5d5JXofCXn0uoCXNkt86J
        SeFtl2LvKyl48L5uf1/rppQM+CcxQrSrxu3enE8=
X-Google-Smtp-Source: ABdhPJwRgcg38SDaLtejzUC7b3vUQaLoXhosdn0Luf4+osGEZjiBK/kt73FsWwkr6Ivx47XCMUrE42724JxbuCOWnTQ=
X-Received: by 2002:a65:528a:: with SMTP id y10mr3603950pgp.103.1633195260173;
 Sat, 02 Oct 2021 10:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210929172234.31620-1-mcroce@linux.microsoft.com>
 <20210929172234.31620-2-mcroce@linux.microsoft.com> <20211001112354.GA10720@duo.ucw.cz>
In-Reply-To: <20211001112354.GA10720@duo.ucw.cz>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Sat, 2 Oct 2021 19:20:24 +0200
X-Gmail-Original-Message-ID: <CAFnufp3uD7Wx=TnHYFaHBCy3mQu08zvv2NO=dws=tOMkKTpKCA@mail.gmail.com>
Message-ID: <CAFnufp3uD7Wx=TnHYFaHBCy3mQu08zvv2NO=dws=tOMkKTpKCA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] riscv: optimized memcpy
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 1, 2021 at 1:23 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Write a C version of memcpy() which uses the biggest data size allowed,
> > without generating unaligned accesses.
> >
> > The procedure is made of three steps:
> > First copy data one byte at time until the destination buffer is aligned
> > to a long boundary.
> > Then copy the data one long at time shifting the current and the next u8
> > to compose a long at every cycle.
> > Finally, copy the remainder one byte at time.
> >
> > On a BeagleV, the TCP RX throughput increased by 45%:
> >
> > before:
> >
> > $ iperf3 -c beaglev
> > Connecting to host beaglev, port 5201
> > [  5] local 192.168.85.6 port 44840 connected to 192.168.85.48 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec  76.4 MBytes   641 Mbits/sec   27    624 KBytes
> > [  5]   1.00-2.00   sec  72.5 MBytes   608 Mbits/sec    0    708 KBytes
> >
> > after:
> >
> > $ iperf3 -c beaglev
> > Connecting to host beaglev, port 5201
> > [  5] local 192.168.85.6 port 44864 connected to 192.168.85.48 port 5201
> > [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> > [  5]   0.00-1.00   sec   109 MBytes   912 Mbits/sec   48    559 KBytes
> > [  5]   1.00-2.00   sec   108 MBytes   902 Mbits/sec    0    690
> > KBytes
>
> That's really quite cool. Could you see if it is your "optimized
> unaligned" copy doing the difference?>
>
> +/* convenience union to avoid cast between different pointer types */
> > +union types {
> > +     u8 *as_u8;
> > +     unsigned long *as_ulong;
> > +     uintptr_t as_uptr;
> > +};
> > +
> > +union const_types {
> > +     const u8 *as_u8;
> > +     unsigned long *as_ulong;
> > +     uintptr_t as_uptr;
> > +};
>
> Missing consts here?
>
> Plus... this is really "interesting" coding style. I'd just use casts
> in kernel.
>

Yes, the one for as_ulong is missing.

By using casts I had to use too many of them, making repeated
assignments in every function.
This is basically the same, with less code :)

Cheers,
-- 
per aspera ad upstream
