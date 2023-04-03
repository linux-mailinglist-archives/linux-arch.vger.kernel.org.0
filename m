Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0CA6D41D6
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjDCKUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 06:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjDCKUU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 06:20:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D2A12875;
        Mon,  3 Apr 2023 03:19:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A5C41063;
        Mon,  3 Apr 2023 03:20:37 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.57.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18E933F840;
        Mon,  3 Apr 2023 03:19:50 -0700 (PDT)
Date:   Mon, 3 Apr 2023 11:19:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 01/10] locking/atomic: Add missing cast to try_cmpxchg()
 fallbacks
Message-ID: <ZCqoRNU8EJhKJVEu@FVFF77S0Q05N>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
 <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
 <ZB3QtDYuWdpiD5qk@FVFF77S0Q05N>
 <CAFULd4aFUF5k=QJD8tDp4qzm2iBF7=rNvp1SJWrg44X5hTFxtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aFUF5k=QJD8tDp4qzm2iBF7=rNvp1SJWrg44X5hTFxtQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 26, 2023 at 09:28:38PM +0200, Uros Bizjak wrote:
> On Fri, Mar 24, 2023 at 5:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Mar 24, 2023 at 04:14:22PM +0000, Mark Rutland wrote:
> > > On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> > > > On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > >
> > > > > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > > > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> > > > >
> > > > > Can you give an example of where we are passing an incompatible pointer?
> > > >
> > > > An example is patch 10/10 from the series, which will fail without
> > > > this fix when fallback code is used. We have:
> > > >
> > > > -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> > > > +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> > > >
> > > > where rb->head is defined as:
> > > >
> > > > typedef struct {
> > > >    atomic_long_t a;
> > > > } local_t;
> > > >
> > > > while offset is defined as 'unsigned long'.
> > >
> > > Ok, but that's because we're doing the wrong thing to start with.
> > >
> > > Since local_t is defined in terms of atomic_long_t, we should define the
> > > generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
> > > have a mismatch between 'long *' and 'unsigned long *', but then we can fix
> > > that in the callsite:
> > >
> > >       while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))
> >
> > Sorry, that should be:
> >
> >         while (!local_try_cmpxchg(&rb->head, (long *)&offset, head))
> 
> The fallbacks are a bit more complicated than above, and are different
> from atomic_try_cmpxchg.
> 
> Please note in patch 2/10, the falbacks when arch_try_cmpxchg_local
> are not defined call arch_cmpxchg_local. Also in patch 2/10,
> try_cmpxchg_local is introduced, where it calls
> arch_try_cmpxchg_local. Targets (and generic code) simply define (e.g.
> :
> 
> #define local_cmpxchg(l, o, n) \
>        (cmpxchg_local(&((l)->a.counter), (o), (n)))
> +#define local_try_cmpxchg(l, po, n) \
> +       (try_cmpxchg_local(&((l)->a.counter), (po), (n)))
> 
> which is part of the local_t API. Targets should either define all
> these #defines, or none. There are no partial fallbacks as is the case
> with atomic_t.

Whether or not there are fallbacks is immaterial.

In those cases, architectures can just as easily write C wrappers, e.g.

long local_cmpxchg(local_t *l, long old, long new)
{
	return cmpxchg_local(&l->a.counter, old, new);
}

long local_try_cmpxchg(local_t *l, long *old, long new)
{
	return try_cmpxchg_local(&l->a.counter, old, new);
}

> The core of the local_h API is in the local.h header. If the target
> doesn't define its own local.h header, then asm-generic/local.h is
> used that does exactly what you propose above regarding the usage of
> atomic functions.
> 
> OTOH, when the target defines its own local.h, then the above
> target-dependent #define path applies. The target should define its
> own arch_try_cmpxchg_local, otherwise a "generic" target-dependent
> fallback that calls target arch_cmpxchg_local applies. In the case of
> x86, patch 9/10 enables new instruction by defining
> arch_try_cmpxchg_local.
> 
> FYI, the patch sequence is carefully chosen so that x86 also exercises
> fallback code between different patches in the series.
> 
> Targets are free to define local_t to whatever they like, but for some
> reason they all define it to:
> 
> typedef struct {
>     atomic_long_t a;
> } local_t;

Yes, which is why I used atomic_long() above.

> so they have to dig the variable out of the struct like:
> 
> #define local_cmpxchg(l, o, n) \
>      (cmpxchg_local(&((l)->a.counter), (o), (n)))
> 
> Regarding the mismatch of 'long *' vs 'unsigned long *': x86
> target-specific code does for try_cmpxchg:
> 
> #define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock) \
> ({ \
> bool success; \
> __typeof__(_ptr) _old = (__typeof__(_ptr))(_pold); \
> __typeof__(*(_ptr)) __old = *_old; \
> __typeof__(*(_ptr)) __new = (_new); \
> 
> so, it *does* cast the "old" pointer to the type of "ptr". The generic
> code does *not*. This difference is dangerous, since the compilation
> of some code involving try_cmpxchg will compile OK for x86 but will
> break for other targets that use try_cmpxchg fallback templates (I was
> the unlucky one that tripped on this in the past). Please note that
> this problem is not specific to the proposed local_try_cmpxchg series,
> but affects the existing try_cmpxchg API.

I understand the problem of arch code differing from generic code, and that we
want to have *a* consistent behaviour for hte API.

What I'm saying is that the behaviour we should aim for is where the 'old'
pointer has a specific type (long), and we always require that, as we do for
the various atomic_*() APIs of which local_*() is a cousin.

> Also, I don't think that "fixing" callsites is the right thing to do.

Why? What's wrong with doing that?

The documentation in Documentation/core-api/local_ops.rst says:

    The ``local_t`` type is defined as an opaque ``signed long``

So the obvious and least surprising thing is for the local_*() functions to use
'long' for values and 'long *' for pointers to values.

Requiring a cast in a few places is not the end of the world.

> The generic code should follow x86 and cast the "old" pointer to the
> type of "ptr" inside the fallback.

Why?

I disagree, and think it's far better to be strict by default. That way,
accidental usage of the wrong type will be caught by the compiler, and if
someone *really* wants to use a differently type then can use a cast in the
callsite, which makes it really obvious when that is happening.

I appreciate that may require some preparatory cleanup, but I think that's a
small price to pay for having this in a clearer and more maintainable state.

> > The fundamenalthing I'm trying to say is that the
> > atomic/atomic64/atomic_long/local/local64 APIs should be type-safe, and for
> > their try_cmpxchg() implementations, the type signature should be:
> >
> >         ${atomictype}_try_cmpxchg(${atomictype} *ptr, ${inttype} *old, ${inttype} new)
> 
> This conversion should be performed also for the cmpxchg family of
> functions, if desired at all. try_cmpxchg fallback is just cmpxchg
> with some extra code around.

FWIW, I agree that we *should* make try_cmpxchg() check that ptr and old
pointer are the same type.

However, I don't think that's a prerequisite for doing so for
local_try_cmpxchg().

Plese make local_try_cmpxchg() have a proper type-safe C prototype, as we do
with the atomic*_try_cmpxchg() APIs.

Thanks,
Mark,
