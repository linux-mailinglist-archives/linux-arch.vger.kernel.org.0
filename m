Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7B3AA3E0
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhFPTJU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 15:09:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40004 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhFPTJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 15:09:20 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D4FD820B6C50;
        Wed, 16 Jun 2021 12:07:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4FD820B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623870433;
        bh=pMMmTT3PXQgTrevuxlj2F3JLlcd4EM9l6Fepj29X/Bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=et5fmwABi16nTifeqv5owKDbpO8Upojx4jogULjH35iG+VU2qzgIOkQSB+40B0esG
         Wam6aYGNXbuJ3uQm6BvTW69sFa4xi4qmwEIBwkn8G5wv6OmR+8OomBdF99AwSZvJc1
         Uf510fCV9WWV72wjblSHguWSQzdzsPUtxfXw9eOo=
Received: by mail-pf1-f182.google.com with SMTP id p13so3021834pfw.0;
        Wed, 16 Jun 2021 12:07:13 -0700 (PDT)
X-Gm-Message-State: AOAM531oszfqMbna3A53N1neh5zAbBL8+6I7kkBR9p1OJ6K17L7M1EhD
        GirYLhPt57YmA1CjaYGTSvs0IwTzaAuAHMlQ1kI=
X-Google-Smtp-Source: ABdhPJx9sD4Hv60I5h6KAYTe91Zo1s5HoDH8VwMli9/OBjeUKnpAHtllS55ebWXOgWb1A5g5i1Y5vWiMz6iFCmYlJ6k=
X-Received: by 2002:a05:6a00:24d0:b029:2ed:c309:8b0f with SMTP id
 d16-20020a056a0024d0b02902edc3098b0fmr1281204pfv.41.1623870433450; Wed, 16
 Jun 2021 12:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com>
 <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com> <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
 <CANBLGcxi2mEA5MnV-RL2zFpB2T+OytiHyOLKjOrMXgmAh=fHAw@mail.gmail.com>
 <CAEUhbmX_wsfU9FfRJoOPE0gjUX=Bp7OZWOZDyMNfO6=M-fX_0A@mail.gmail.com>
 <20210616040132.7fbdf6fe@linux.microsoft.com> <db7a011867a742528beb6ec17b692842@AcuMS.aculab.com>
In-Reply-To: <db7a011867a742528beb6ec17b692842@AcuMS.aculab.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 16 Jun 2021 21:06:37 +0200
X-Gmail-Original-Message-ID: <CAFnufp2OiF6-ta5og9u-foKDT2fqE171NvfowFkUr2jc4KJEDQ@mail.gmail.com>
Message-ID: <CAFnufp2OiF6-ta5og9u-foKDT2fqE171NvfowFkUr2jc4KJEDQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     David Laight <David.Laight@aculab.com>
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Gary Guo <gary@garyguo.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 16, 2021 at 10:24 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Matteo Croce
> > Sent: 16 June 2021 03:02
> ...
> > > > That's a good idea, but if you read the replies to Gary's original
> > > > patch
> > > > https://lore.kernel.org/linux-riscv/20210216225555.4976-1-gary@garyguo.net/
> > > > .. both Gary, Palmer and David would rather like a C-based version.
> > > > This is one attempt at providing that.
> > >
> > > Yep, I prefer C as well :)
> > >
> > > But if you check commit 04091d6, the assembly version was introduced
> > > for KASAN. So if we are to change it back to C, please make sure KASAN
> > > is not broken.
> > >
> ...
> > Leaving out the first memcpy/set of every test which is always slower, (maybe
> > because of a cache miss?), the current implementation copies 260 Mb/s when
> > the low order bits match, and 114 otherwise.
> > Memset is stable at 278 Mb/s.
> >
> > Gary's implementation is much faster, copies still 260 Mb/s when euqlly placed,
> > and 230 Mb/s otherwise. Memset is the same as the current one.
>
> Any idea what the attainable performance is for the cpu you are using?
> Since both memset and memcpy are running at much the same speed
> I suspect it is all limited by the writes.
>
> 272MB/s is only 34M writes/sec.
> This seems horribly slow for a modern cpu.
> So is this actually really limited by the cache writes to physical memory?
>
> You might want to do some tests (userspace is fine) where you
> check much smaller lengths that definitely sit within the data cache.
>

I get similar results in userspace, this tool write to RAM with
variable data width:

root@beaglev:~/src# ./unalign_check 1 0 1
size:           1 Mb
write size:      8 bit
unalignment:    0 byte
elapsed time:   0.01 sec
throughput:     124.36 Mb/s

# ./unalign_check 1 0 8
size:           1 Mb
write size:      64 bit
unalignment:    0 byte
elapsed time:   0.00 sec
throughput:     252.12 Mb/s

> It is also worth checking how much overhead there is for
> short copies - they are almost certainly more common than
> you might expect.
> This is one problem with excessive loop unrolling - the 'special
> cases' for the ends of the buffer start having a big effect
> on small copies.
>

I too believe that they are much more common than long ones.
Indeed, I wish to reduce the MIN_THRESHOLD value from 64 to 32 or even 16.
Or having it dependend on the word size, e.g. sizeof(long) * 2.

Suggestions?

> For cpu that support misaligned memory accesses, one 'trick'
> for transfers longer than a 'word' is to do a (probably) misaligned
> transfer of the last word of the buffer first followed by the
> transfer of the rest of the buffer (overlapping a few bytes at the end).
> This saves on conditionals and temporary values.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

Regards,
-- 
per aspera ad upstream
