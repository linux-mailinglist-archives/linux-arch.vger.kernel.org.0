Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB20367E7C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbhDVKSJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhDVKSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 06:18:08 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37509C06174A
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 03:17:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso8670188otp.7
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2021 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gsWkNJIVwwQTgMpqGzbaIUC/BfooyEOt1c03CyO1cY=;
        b=nyhWc3nG16c5O7B6dKi3NLerpDx5GqVjW+Qclbscghcf8oR9qZpmNp+w/Q7RVYm2Ai
         KskmX3pdAVoxtxJx6AFVSC5ZLN7rDB/oYhB6pjj4c/iMKbF9M+/0rEg2ultB/5WMeETK
         pMn0nr5Pv3+uO7smK4g0KQ6ccBcqGigtyhBPUNkPIdAPdJhuNveeF28QzymwnaqCnLMB
         jdtX5jFHxADLR64TQ3C0KTO/jZQLoIZ24ZAxNjHaVr6qfKXQoWjqkNzNiZgevpphukoQ
         qHmcHLJqprq7flb559GGD7AbSQOIjA6T3bMld5w3xhIPZglPfcAs8Uccxn83EbPWmrw6
         vrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gsWkNJIVwwQTgMpqGzbaIUC/BfooyEOt1c03CyO1cY=;
        b=dqW/mQmRMRBnw4cDVltMVPUYVn/HVwo25RU3YysBPz/ZusDhGAh4X7Y2YeMGb2TF56
         IWW8/vjoNmueEcT+R7soJbLtFAoNyCv5avdlbQx7ktKl4DULiNZev/+qgDUmiMJPZtws
         M8HXBTP8rzaBITRVTdbobfW1sSWhamavMpq9/JY/uEw0pHjEz9mpwJLkiAIGOH21A4yh
         UzK782YwLvOWLoZ5N88YiUOr4clThPAi1Y7t8GzT8bOwC0gGl+4MR1IjZOMH9ZnqvDWu
         wuVu8lQoYOyHzCrs2F0S7FDGt/rvGuaBKojXYjWZV0HyKkCJNTo71eixI3cQGnzId1kT
         d9Dw==
X-Gm-Message-State: AOAM5335WZT1HbUHA056VOUskpOGSS6E/1IA6YKtu3hwIp8c4++ygclR
        XjAbRUGMKs/04D5GSTWynHHAKLovMtpWpRKQNkeaFA==
X-Google-Smtp-Source: ABdhPJxE0Q9zjfZ2NyvLvVX/ipAnmDUW+kGMT83HQSuGBnKtxTQRMuOnT8fvNvc4WWAEH2PyCVnl8mQRX05kY3DubhQ=
X-Received: by 2002:a05:6830:241b:: with SMTP id j27mr2248529ots.17.1619086652316;
 Thu, 22 Apr 2021 03:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210422064437.3577327-1-elver@google.com> <d480a4f56d544fb98eb1cdd62f44ae91@AcuMS.aculab.com>
In-Reply-To: <d480a4f56d544fb98eb1cdd62f44ae91@AcuMS.aculab.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 22 Apr 2021 12:17:20 +0200
Message-ID: <CANpmjNNjkQdziFZDkPy5EnwCF+VyBWKXEwCDgNpxHGZd+BLQag@mail.gmail.com>
Subject: Re: [PATCH tip 1/2] signal, perf: Fix siginfo_t by avoiding u64 on
 32-bit architectures
To:     David Laight <David.Laight@aculab.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "glider@google.com" <glider@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christian@brauner.io" <christian@brauner.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pcc@google.com" <pcc@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 22 Apr 2021 at 11:48, David Laight <David.Laight@aculab.com> wrote:
>
> From: Marco Elver
> > Sent: 22 April 2021 07:45
> >
> > On some architectures, like Arm, the alignment of a structure is that of
> > its largest member.
>
> That is true everywhere.
> (Apart from obscure ABI where structure have at least 4 byte alignment!)

For instance, x86 didn't complain, nor did m68k. Both of them have
compile-time checks for the layout (I'm adding those for Arm
elsewhere).

> > This means that there is no portable way to add 64-bit integers to
> > siginfo_t on 32-bit architectures, because siginfo_t does not contain
> > any 64-bit integers on 32-bit architectures.
>
> Uh?
>
> The actual problem is that adding a 64-bit aligned item to the union
> forces the union to be 8 byte aligned and adds a 4 byte pad before it
> (and possibly another one at the end of the structure).

Yes, which means there's no portable way (without starting to add
attributes that are outside the C std) to add 64-bit integers to
siginfo_t without breaking the ABI on 32-bit architectures.

> > In the case of the si_perf field, word size is sufficient since there is
> > no exact requirement on size, given the data it contains is user-defined
> > via perf_event_attr::sig_data. On 32-bit architectures, any excess bits
> > of perf_event_attr::sig_data will therefore be truncated when copying
> > into si_perf.
>
> Is that right on BE architectures?

We effectively do

  u64 sig_data = ...;
  unsigned long si_perf = sig_data;

Since the user decides what to place into perf_event_attr::sig_data,
whatever ends up in si_perf is fully controllable by the user, who
knows which arch they're on. So I do not think this is a problem.

> > Since this field is intended to disambiguate events (e.g. encoding
> > relevant information if there are more events of the same type), 32 bits
> > should provide enough entropy to do so on 32-bit architectures.
>
> What is the size of the field used to supply the data?
> The size of the returned item really ought to match.

It's u64, but because perf_event_attr wants fixed size fields, this
can't change.

> Much as I hate __packed, you could add __packed to the
> definition of the structure member _perf.
> The compiler will remove the padding before it and will
> assume it has the alignment of the previous item.
>
> So it will never use byte accesses.

Sure __packed works for Arm. But I think there's no precedent using
this on siginfo_t, possibly for good reasons? I simply can't find
evidence that this is portable on *all* architectures and for *all*
possible definitions of siginfo_t, including those that live in things
like glibc.

Can we confirm that __packed is fine to add to siginfo_t on *all*
architectures for *all* possible definitions of siginfo_t? I currently
can't. And given it's outside the scope of the C standard (as of C11
we got _Alignas, but that doesn't help I think), I'd vote to not
venture too far for code that should be portable especially things as
important as siginfo_t, and has definitions *outside* the kernel (I
know we do lots of non-standard things, but others might not).

Thanks,
-- Marco

>         David
>
> >
> > For 64-bit architectures, no change is intended.
> >
> > Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >
> > Note: I added static_assert()s to verify the siginfo_t layout to
> > arch/arm and arch/arm64, which caught the problem. I'll send them
> > separately to arm&arm64 maintainers respectively.
> > ---
> >  include/linux/compat.h                                | 2 +-
> >  include/uapi/asm-generic/siginfo.h                    | 2 +-
> >  tools/testing/selftests/perf_events/sigtrap_threads.c | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/compat.h b/include/linux/compat.h
> > index c8821d966812..f0d2dd35d408 100644
> > --- a/include/linux/compat.h
> > +++ b/include/linux/compat.h
> > @@ -237,7 +237,7 @@ typedef struct compat_siginfo {
> >                                       u32 _pkey;
> >                               } _addr_pkey;
> >                               /* used when si_code=TRAP_PERF */
> > -                             compat_u64 _perf;
> > +                             compat_ulong_t _perf;
> >                       };
> >               } _sigfault;
> >
> > diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> > index d0bb9125c853..03d6f6d2c1fe 100644
> > --- a/include/uapi/asm-generic/siginfo.h
> > +++ b/include/uapi/asm-generic/siginfo.h
> > @@ -92,7 +92,7 @@ union __sifields {
> >                               __u32 _pkey;
> >                       } _addr_pkey;
> >                       /* used when si_code=TRAP_PERF */
> > -                     __u64 _perf;
> > +                     unsigned long _perf;
> >               };
> >       } _sigfault;
> >
> > diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c
> > b/tools/testing/selftests/perf_events/sigtrap_threads.c
> > index 9c0fd442da60..78ddf5e11625 100644
> > --- a/tools/testing/selftests/perf_events/sigtrap_threads.c
> > +++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
> > @@ -44,7 +44,7 @@ static struct {
> >  } ctx;
> >
> >  /* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
> > -#define TEST_SIG_DATA(addr) (~(uint64_t)(addr))
> > +#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
> >
> >  static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
> >  {
> > --
> > 2.31.1.498.g6c1eba8ee3d-goog
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
