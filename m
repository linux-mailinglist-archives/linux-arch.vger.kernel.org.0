Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2711B10936F
	for <lists+linux-arch@lfdr.de>; Mon, 25 Nov 2019 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKYSWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Nov 2019 13:22:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40823 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfKYSWq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 13:22:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id d22so14016702oic.7
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 10:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3f1B+bHfH90fvGHAmWwv4t4e/DGz9pyOLoZyxejttE=;
        b=W+isNVQpb4OtG2cL/xWLFDjZyq6LmTyBTSQIACYBzLsXAg7ZfAQ4uA8hJLEJZkAQvR
         TgBNQzYzkb5M0ljvRH2epUV6bTsUxVx8BnxHlFDg6MkuvL+4d75Ld9YUaVtR1Js2F/4H
         zChoIppozN/5gzmEQb9FfCc0HUru9cfOOQT/qwK/677oikzCLla4FzzYCrgkDOE/A23x
         sbqZlSjy8ce/I240GNHFCyYvHZBNMvLL5pOcV+jk/Hth3goy4yJuLRRIDJbZ+5dW9mzk
         8+oq27CBgu6UxNPHN5fwzCCFnn/FrmjVMLlfBTptb0+y9bbkW2NY50L7SDJ1YDZpCTxz
         cD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3f1B+bHfH90fvGHAmWwv4t4e/DGz9pyOLoZyxejttE=;
        b=fBpxWyLVot4pzK/TwI1/N9BS4Or4PgmXe4EzKo/YgzitprUZ/U0BA6/HO96USwz/+k
         /UfJgrRjoZEurIsGkk18oOhFSIglI09fdbJWVSCFQTC02ZAYa8RSexSaODRxSo89bVpR
         jToguwh0xcoyHfcr9O3PAfb1QElBi8CxKjzWbMj4tpT0s2nypIROoqOKgJmV3d2TQH7t
         KJTpEqzT/KYvRF6894vNQg59kKTurGrYr/MtivmCKhX0Z2ZcJfmKZ8ZBczkgCu7VQDNF
         ToIrpZ0zpk4HQB2RqQTihUYhkGjK/cb2WLRTu/n2aYsTkNHhRLwssceNcI3rFYjiP3Q1
         t/oQ==
X-Gm-Message-State: APjAAAUGxmorHQcXHPMb815Wy1pwvBKIEFF/NyhRUAGIshNhYYf/ZMGF
        y5QqdFZRE9qDls6p6cL5wg4lfKze+sesmUJbf3lr6A==
X-Google-Smtp-Source: APXvYqwHz8wg59uBPCvC5qwKg3JakEPy7nDZ88d+AWEbjzzzK7deLd48GGvSPh2HOqF/G86rCBKMTAwUCqNvn7xfFBM=
X-Received: by 2002:aca:618a:: with SMTP id v132mr136789oib.155.1574706164774;
 Mon, 25 Nov 2019 10:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20191122154221.247680-1-elver@google.com> <20191125173756.GF32635@lakrids.cambridge.arm.com>
In-Reply-To: <20191125173756.GF32635@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Nov 2019 19:22:33 +0100
Message-ID: <CANpmjNMLEYdW0kaLAiO9fQN1uC7bW6K08zZRG=GG7vq4fBn+WA@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/atomic: Prefer __always_inline for wrappers
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 25 Nov 2019 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Nov 22, 2019 at 04:42:20PM +0100, Marco Elver wrote:
> > Prefer __always_inline for atomic wrappers. When building for size
> > (CC_OPTIMIZE_FOR_SIZE), some compilers appear to be less inclined to
> > inline even relatively small static inline functions that are assumed to
> > be inlinable such as atomic ops. This can cause problems, for example in
> > UACCESS regions.
>
> From looking at the link below, the problem is tat objtool isn't happy
> about non-whiteliested calls within UACCESS regions.
>
> Is that a problem here? are the kasan/kcsan calls whitelisted?

We whitelisted all the relevant functions.

The problem it that small static inline functions private to the
compilation unit do not get inlined when CC_OPTIMIZE_FOR_SIZE=y (they
do get inlined when CC_OPTIMIZE_FOR_PERFORMANCE=y).

For the runtime this is easy to fix, by just making these small
functions __always_inline (also avoiding these function call overheads
in the runtime when CC_OPTIMIZE_FOR_SIZE).

I stumbled upon the issue for the atomic ops, because the runtime uses
atomic_long_try_cmpxchg outside a user_access_save() region (and it
should not be moved inside). Essentially I fixed up the runtime, but
then objtool still complained about the access to
atomic64_try_cmpxchg. Hence this patch.

I believe it is the right thing to do, because the final inlining
decision should *not* be made by wrappers. I would think this patch is
the right thing to do irrespective of KCSAN or not.

> > By using __always_inline, we let the real implementation and not the
> > wrapper determine the final inlining preference.
>
> That sounds reasonable to me, assuming that doesn't end up significantly
> bloating the kernel text. What impact does this have on code size?

It actually seems to make it smaller.

x86 tinyconfig:
- vmlinux baseline: 1316204
- vmlinux with patches: 1315988 (-216 bytes)

> > This came up when addressing UACCESS warnings with CC_OPTIMIZE_FOR_SIZE
> > in the KCSAN runtime:
> > http://lkml.kernel.org/r/58708908-84a0-0a81-a836-ad97e33dbb62@infradead.org
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/asm-generic/atomic-instrumented.h | 334 +++++++++++-----------
> >  include/asm-generic/atomic-long.h         | 330 ++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |   6 +-
> >  scripts/atomic/gen-atomic-long.sh         |   2 +-
> >  4 files changed, 336 insertions(+), 336 deletions(-)
>
> Do we need to do similar for gen-atomic-fallback.sh and the fallbacks
> defined in scripts/atomic/fallbacks/ ?

I think they should be, but I think that's debatable. Some of them do
a little more than just wrap things. If we want to make this
__always_inline, I would do it in a separate patch independent from
this series to not stall the fixes here.

What do you prefer?

> [...]
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index 8b8b2a6f8d68..68532d4f36ca 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -84,7 +84,7 @@ gen_proto_order_variant()
> >       [ ! -z "${guard}" ] && printf "#if ${guard}\n"
> >
> >  cat <<EOF
> > -static inline ${ret}
> > +static __always_inline ${ret}
>
> We should add an include of <linux/compiler.h> to the preamble if we're
> explicitly using __always_inline.

Will add in v2.

> > diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
> > index c240a7231b2e..4036d2dd22e9 100755
> > --- a/scripts/atomic/gen-atomic-long.sh
> > +++ b/scripts/atomic/gen-atomic-long.sh
> > @@ -46,7 +46,7 @@ gen_proto_order_variant()
> >       local retstmt="$(gen_ret_stmt "${meta}")"
> >
> >  cat <<EOF
> > -static inline ${ret}
> > +static __always_inline ${ret}
>
> Likewise here

Will add in v2.

Thanks,
-- Marco
