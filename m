Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E5D9608
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405892AbfJPPx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 11:53:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40783 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405890AbfJPPx7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 11:53:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so20568094ota.7
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ES8PPxqISv6le2aU+Na1jJhECeSWLsXBsBUpCljFmNc=;
        b=oO69GKlEUEmZWfog28/tduGmrNxTECrWedf44ep3BiJWADibe3BtF/qSPOt+lHQnrd
         HMZ/O6vy/oZ1Mn29CFgrBvva1cxYf0fsP2Iv2I85mFP+PSSHxMWS5bWwvJtAkW4KeQ4X
         zHsZ4zn4Ud3sy3FtVlyWWHfups+bSfs5dcKPEQoYxyP86YUHE43Ssz5B42ovDjgprbuJ
         QoImASQ3r2C39DI1HTT9w7MtYoLRwjzHESnKd/q21EZ4qeAz9arZ/6uRGqW264QE2D9u
         M4kZpDAKBF3fk3pugbmFA+dNIL07VCSKkOnXhdXNc50ltBiqs8ufauu0rzHnctKYwyTf
         J+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ES8PPxqISv6le2aU+Na1jJhECeSWLsXBsBUpCljFmNc=;
        b=ZoXiC9g2UUptjsD/PF2hcjEza8lMq9hZTBU6Npehta/3dF/DInbXOWai21M3Fo9lhY
         PqFHH3eQPfof6JvG9UXYDGUZS8zOV+KMcVqs/ulYAvTBEGJti7r/Vontr+P7wGIaZzGC
         OBIFVqXiSpVu1KbkdxoAX83byctwlwfYGJK3rCZPKJ/Obu7PbPkZqIqayjxO44SkFK1c
         vWhapxDqE1tBhl00qwsMuUyY0zxZG98LzuZM8N0pElvFtKlU12r55tzuCu1RKUZrrsFY
         9GVssLHLFt5SDcor3sxADGaywU5mrgTFWfE5DomKnQ+YZoQ3DrUiMSr4VJksrW7wPlgg
         9yGA==
X-Gm-Message-State: APjAAAW7pYVG73CjjO3pfmlyJi+eB0/0pek3BSwX1Pe7laVFDNQq6o4W
        5xCTrigAijKAZh/x/G6vXf0S4RLUj4ghasdoH8jzAA==
X-Google-Smtp-Source: APXvYqy/bEpTtLLHRnuZTAKQyMKjVxdlLHEt24tIzExwmKRAvwqnmZoQehyCbZB5w1Ds0iSmKpp3CZhKegjg3ge7PUQ=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr8514934otk.2.1571241237486;
 Wed, 16 Oct 2019 08:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-2-elver@google.com>
 <20191016151643.GC46264@lakrids.cambridge.arm.com>
In-Reply-To: <20191016151643.GC46264@lakrids.cambridge.arm.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 16 Oct 2019 17:53:45 +0200
Message-ID: <CANpmjNNctoVsUc+VbJ_RAMgLxcbvjq55gK1NdE0G0muMdv1+Ng@mail.gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>, ard.biesheuvel@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>,
        Daniel Lustig <dlustig@nvidia.com>,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Oct 2019 at 17:16, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 2c2e56bd8913..34a1d9310304 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1171,6 +1171,13 @@ struct task_struct {
> >  #ifdef CONFIG_KASAN
> >       unsigned int                    kasan_depth;
> >  #endif
> > +#ifdef CONFIG_KCSAN
> > +     /* See comments at kernel/kcsan/core.c: struct cpu_state. */
> > +     int                             kcsan_disable;
> > +     int                             kcsan_atomic_next;
> > +     int                             kcsan_atomic_region;
> > +     bool                            kcsan_atomic_region_flat;
> > +#endif
>
> Should these be unsigned?

I prefer to keep them int, as they can become negative (rather than
underflow with unsigned), if we e.g. have unbalanced
kcsan_enable_current etc. Since we do not need the full unsigned range
(these values should stay relatively small), int is more than enough.

> > +/*
> > + * Per-CPU state that should be used instead of 'current' if we are not in a
> > + * task.
> > + */
> > +struct cpu_state {
> > +     int disable; /* disable counter */
> > +     int atomic_next; /* number of following atomic ops */
> > +
> > +     /*
> > +      * We use separate variables to store if we are in a nestable or flat
> > +      * atomic region. This helps make sure that an atomic region with
> > +      * nesting support is not suddenly aborted when a flat region is
> > +      * contained within. Effectively this allows supporting nesting flat
> > +      * atomic regions within an outer nestable atomic region. Support for
> > +      * this is required as there are cases where a seqlock reader critical
> > +      * section (flat atomic region) is contained within a seqlock writer
> > +      * critical section (nestable atomic region), and the "mismatching
> > +      * kcsan_end_atomic()" warning would trigger otherwise.
> > +      */
> > +     int atomic_region;
> > +     bool atomic_region_flat;
> > +};
> > +static DEFINE_PER_CPU(struct cpu_state, this_state) = {
> > +     .disable = 0,
> > +     .atomic_next = 0,
> > +     .atomic_region = 0,
> > +     .atomic_region_flat = 0,
> > +};
>
> These are the same as in task_struct, so I think it probably makes sense
> to have a common structure for these, e.g.
>
> | struct kcsan_ctx {
> |       int     disable;
> |       int     atomic_next;
> |       int     atomic_region;
> |       bool    atomic_region_flat;
> | };
>
> ... which you then place within task_struct, e.g.
>
> | #ifdef CONFIG_KCSAN
> |       struct kcsan_ctx        kcsan_ctx;
> | #endif
>
> ... and here, e.g.
>
> | static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx);
>
> That would simplify a number of cases below where you have to choose one
> or the other, as you can choose the pointer, then handle the rest in a
> common way.
>
> e.g. for:
>
> > +static inline bool is_atomic(const volatile void *ptr)
> > +{
> > +     if (in_task()) {
> > +             if (unlikely(current->kcsan_atomic_next > 0)) {
> > +                     --current->kcsan_atomic_next;
> > +                     return true;
> > +             }
> > +             if (unlikely(current->kcsan_atomic_region > 0 ||
> > +                          current->kcsan_atomic_region_flat))
> > +                     return true;
> > +     } else { /* interrupt */
> > +             if (unlikely(this_cpu_read(this_state.atomic_next) > 0)) {
> > +                     this_cpu_dec(this_state.atomic_next);
> > +                     return true;
> > +             }
> > +             if (unlikely(this_cpu_read(this_state.atomic_region) > 0 ||
> > +                          this_cpu_read(this_state.atomic_region_flat)))
> > +                     return true;
> > +     }
> > +
> > +     return kcsan_is_atomic(ptr);
> > +}
>
> ... you could have something like:
>
> | struct kcsan_ctx *kcsan_get_ctx(void)
> | {
> |       return in_task() ? &current->kcsan_ctx : this_cpu_ptr(kcsan_cpu_ctx);
> | }
> |
> | static inline bool is_atomic(const volatile void *ptr)
> | {
> |       struct kcsan_ctx *ctx = kcsan_get_ctx();
> |       if (unlikely(ctx->atomic_next > 0) {
> |               --ctx->atomic_next;
> |               return true;
> |       }
> |       if (unlikely(ctx->atomic_region > 0 || ctx->atomic_region_flat))
> |               return true;
> |
> |       return kcsan_is_atomic(ptr);
> | }
>
> ... avoiding duplicating the checks for task/irq contexts.
>
> It's not clear to me how either that or the original code works if a
> softirq is interrupted by a hardirq. IIUC most of the fields should
> remain stable over that window, since the hardirq should balance most
> changes it makes before returning, but I don't think that's true for
> atomic_next. Can't that be corrupted from the PoV of the softirq
> handler?

As you say, these fields should balance. So far I have not observed
any issues. For atomic_next I'm not concerned as it is an
approximation either way (see seqlock patch), and it's fine if there
is a small error.

> [...]
>
> > +void kcsan_begin_atomic(bool nest)
> > +{
> > +     if (nest) {
> > +             if (in_task())
> > +                     ++current->kcsan_atomic_region;
> > +             else
> > +                     this_cpu_inc(this_state.atomic_region);
> > +     } else {
> > +             if (in_task())
> > +                     current->kcsan_atomic_region_flat = true;
> > +             else
> > +                     this_cpu_write(this_state.atomic_region_flat, true);
> > +     }
> > +}
>
> Assuming my suggestion above wasn't bogus, this can be:
>
> | void kcsan_begin_atomic(boot nest)
> | {
> |       struct kcsan_ctx *ctx = kcsan_get_ctx();
> |       if (nest)
> |               ctx->atomic_region++;
> |       else
> |               ctx->atomic_region_flat = true;
> | }
>
> > +void kcsan_end_atomic(bool nest)
> > +{
> > +     if (nest) {
> > +             int prev =
> > +                     in_task() ?
> > +                             current->kcsan_atomic_region-- :
> > +                             (this_cpu_dec_return(this_state.atomic_region) +
> > +                              1);
> > +             if (prev == 0) {
> > +                     kcsan_begin_atomic(true); /* restore to 0 */
> > +                     kcsan_disable_current();
> > +                     WARN(1, "mismatching %s", __func__);
> > +                     kcsan_enable_current();
> > +             }
> > +     } else {
> > +             if (in_task())
> > +                     current->kcsan_atomic_region_flat = false;
> > +             else
> > +                     this_cpu_write(this_state.atomic_region_flat, false);
> > +     }
> > +}
>
> ... similarly:
>
> | void kcsan_end_atomic(bool nest)
> | {
> |       struct kcsan_ctx *ctx = kcsan_get_ctx();
> |
> |       if (nest)
> |               if (ctx->kcsan_atomic_region--) {
> |                       kcsan_begin_atomic(true); /* restore to 0 */
> |                       kcsan_disable_current();
> |                       WARN(1, "mismatching %s"\ __func__);
> |                       kcsan_enable_current();
> |               }
> |       } else {
> |               ctx->atomic_region_flat = true;
> |       }
> | }
>
> > +void kcsan_atomic_next(int n)
> > +{
> > +     if (in_task())
> > +             current->kcsan_atomic_next = n;
> > +     else
> > +             this_cpu_write(this_state.atomic_next, n);
> > +}
>
> ... and:
>
> | void kcsan_atomic_nextint n)
> | {
> |       kcsan_get_ctx()->atomic_next = n;
> | }

Otherwise, yes, this makes much more sense and I will just introduce
the struct and integrate the above suggestions for v2.

Many thanks,
-- Marco
