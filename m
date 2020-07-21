Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539D12281E8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgGUOVm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOVl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:21:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FCBC061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:21:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x83so17333846oif.10
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3blU9DE8kAEI9eRjgIJ+1oJjjf2jq7rcjTXCotUTV0=;
        b=g7kYPNqCJeG7iBoiEnGjyi4KCe4WoyCjqsV1kdm3NIv5sBs5jAeEu/qe9czw4EjRrz
         nlKfX5ktHhKPSVkEbMDwT7mac5RCbOhP82cULp58/fF7sXBSXYviqx+BX2qPI04vlZFs
         whaiUYZmS/BbSHReAfAbd1yXLoRJdzPCGLTyL//ZmoKb8RWYJihJcPu0Fkv4fmhmeTJ8
         cdOKOgZPNKyry49qMDHPAi8fXClu/+uprYNnOmhmXZTuuUd9lXFfrnqjo+EKMtHnuiJQ
         gj3C7CgsVzYf+Y/zcS2c2w+SPC4B20v/HBqhvah0cU0sOC7hTPf+ji027y5LdPtDT9Ka
         izQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3blU9DE8kAEI9eRjgIJ+1oJjjf2jq7rcjTXCotUTV0=;
        b=QSgZGy83rcpMb3Vl/L9gS+2PBQrZmkCSwDEpZ0wxXHEzGrTLSGacF0HVriRZ5684E0
         a6eCB+8fceHeSaEY4mMdZz7f7yACYib14jrC+xNOUkc+27QEeM7mLhhK3GBCGqrZOkH7
         o4eoajBMpDgLaT52ICyiGesJLKb3EGmBwsmGJyOC2NL+oMa8zoW1FEH7X4YZN8wLtZsM
         9wv2q0J67m8a0cSJHFOZv+Dl4eXhp9413od7SDsGCsSmOYmNmLqqz3Zjh/ajHKLmn+yl
         N932pfuuZoa1Uyze46cJ5H0ZipsFHTUrj14r+tniomDsnYJFeh30HIYRyF+jhKjsJOTv
         DbIA==
X-Gm-Message-State: AOAM533uO/ZCCmh4PZqjDPtM4ctC9S0mIFESsObOhRGTtWhfE+Y2zTDG
        CIfeBB7o8VnyvLTa3GBc2AH1UqHwUZXZgekkduvrqg==
X-Google-Smtp-Source: ABdhPJwNZUqfNDQerHr3EqfvlG+Rz1k6hPzGDgniqSjwMQBNUioBFz7zDlQiMLxKNo4ePlQ722PQD5sl45gvdNdco+A=
X-Received: by 2002:aca:cf4f:: with SMTP id f76mr3216158oig.172.1595341300634;
 Tue, 21 Jul 2020 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com> <20200721103016.3287832-5-elver@google.com>
 <20200721140929.GB10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200721140929.GB10769@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jul 2020 16:21:29 +0200
Message-ID: <CANpmjNNCrz+d6FOWCkC68NKO3PFToY1seRRKVQmn_KHa4D07hA@mail.gmail.com>
Subject: Re: [PATCH 4/8] kcsan: Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 21 Jul 2020 at 16:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 21, 2020 at 12:30:12PM +0200, Marco Elver wrote:
> > Add missing CONFIG_KCSAN_IGNORE_ATOMICS checks for the builtin atomics
> > instrumentation.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Added to this series, as it would otherwise cause patch conflicts.
> > ---
> >  kernel/kcsan/core.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 4633baebf84e..f53524ea0292 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -892,14 +892,17 @@ EXPORT_SYMBOL(__tsan_init);
> >       u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
> >       u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
> >       {                                                                                          \
> > -             check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);                      \
> > +             if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> > +                     check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC);              \
> >               return __atomic_load_n(ptr, memorder);                                             \
> >       }                                                                                          \
> >       EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
> >       void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
> >       void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
> >       {                                                                                          \
> > -             check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC); \
> > +             if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> > +                     check_access(ptr, bits / BITS_PER_BYTE,                                    \
> > +                                  KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);                    \
> >               __atomic_store_n(ptr, v, memorder);                                                \
> >       }                                                                                          \
> >       EXPORT_SYMBOL(__tsan_atomic##bits##_store)
> > @@ -908,8 +911,10 @@ EXPORT_SYMBOL(__tsan_init);
> >       u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
> >       u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
> >       {                                                                                          \
> > -             check_access(ptr, bits / BITS_PER_BYTE,                                            \
> > -                          KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> > +             if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> > +                     check_access(ptr, bits / BITS_PER_BYTE,                                    \
> > +                                  KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> > +                                          KCSAN_ACCESS_ATOMIC);                                 \
> >               return __atomic_##op##suffix(ptr, v, memorder);                                    \
> >       }                                                                                          \
> >       EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
> > @@ -937,8 +942,10 @@ EXPORT_SYMBOL(__tsan_init);
> >       int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
> >                                                             u##bits val, int mo, int fail_mo)    \
> >       {                                                                                          \
> > -             check_access(ptr, bits / BITS_PER_BYTE,                                            \
> > -                          KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> > +             if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> > +                     check_access(ptr, bits / BITS_PER_BYTE,                                    \
> > +                                  KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> > +                                          KCSAN_ACCESS_ATOMIC);                                 \
> >               return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
> >       }                                                                                          \
> >       EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
> > @@ -949,8 +956,10 @@ EXPORT_SYMBOL(__tsan_init);
> >       u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
> >                                                          int mo, int fail_mo)                    \
> >       {                                                                                          \
> > -             check_access(ptr, bits / BITS_PER_BYTE,                                            \
> > -                          KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC);    \
> > +             if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS))                                      \
> > +                     check_access(ptr, bits / BITS_PER_BYTE,                                    \
> > +                                  KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> > +                                          KCSAN_ACCESS_ATOMIC);                                 \
> >               __atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
> >               return exp;                                                                        \
> >       }                                                                                          \
>
>
> *groan*, that could really do with a bucket of '{', '}'. Also, it is
> inconsistent in style with the existing use in
> DEFINE_TSAN_VOLATILE_READ_WRITE() where the define causes an early
> return.

Sadly we can't do an early return because we must always execute what
comes after the check. Unlike normal read/write instrumentation, TSAN
instrumentation for builtin atomics replaces the atomic with a call
into the runtime, and the runtime must also execute the atomic.

I'll add the {}.

Thanks,
-- Marco
