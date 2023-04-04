Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F506D62A5
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjDDNUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjDDNUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 09:20:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4499A4688;
        Tue,  4 Apr 2023 06:20:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED0B3D75;
        Tue,  4 Apr 2023 06:20:07 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7773F762;
        Tue,  4 Apr 2023 06:19:21 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:19:19 +0100
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
Message-ID: <ZCwj19okhYNRN8er@FVFF77S0Q05N.cambridge.arm.com>
References: <20230305205628.27385-1-ubizjak@gmail.com>
 <20230305205628.27385-2-ubizjak@gmail.com>
 <ZB2v+avNt52ac/+w@FVFF77S0Q05N>
 <CAFULd4ZCgxDYnyy--qdgKoAo_y7MbNSaQdbdBFefnFuMoM2OYw@mail.gmail.com>
 <ZB3MR8lGbnea9ui6@FVFF77S0Q05N>
 <ZB3QtDYuWdpiD5qk@FVFF77S0Q05N>
 <CAFULd4aFUF5k=QJD8tDp4qzm2iBF7=rNvp1SJWrg44X5hTFxtQ@mail.gmail.com>
 <ZCqoRNU8EJhKJVEu@FVFF77S0Q05N>
 <CAFULd4ZUnbtDYXBBbuTJnq9wLSf5cZTc=hUPxg6-8KRNA7YVeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4ZUnbtDYXBBbuTJnq9wLSf5cZTc=hUPxg6-8KRNA7YVeQ@mail.gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 02:24:38PM +0200, Uros Bizjak wrote:
> On Mon, Apr 3, 2023 at 12:19 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Sun, Mar 26, 2023 at 09:28:38PM +0200, Uros Bizjak wrote:
> > > On Fri, Mar 24, 2023 at 5:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Fri, Mar 24, 2023 at 04:14:22PM +0000, Mark Rutland wrote:
> > > > > On Fri, Mar 24, 2023 at 04:43:32PM +0100, Uros Bizjak wrote:
> > > > > > On Fri, Mar 24, 2023 at 3:13 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > >
> > > > > > > On Sun, Mar 05, 2023 at 09:56:19PM +0100, Uros Bizjak wrote:
> > > > > > > > Cast _oldp to the type of _ptr to avoid incompatible-pointer-types warning.
> > > > > > >
> > > > > > > Can you give an example of where we are passing an incompatible pointer?
> > > > > >
> > > > > > An example is patch 10/10 from the series, which will fail without
> > > > > > this fix when fallback code is used. We have:
> > > > > >
> > > > > > -       } while (local_cmpxchg(&rb->head, offset, head) != offset);
> > > > > > +       } while (!local_try_cmpxchg(&rb->head, &offset, head));
> > > > > >
> > > > > > where rb->head is defined as:
> > > > > >
> > > > > > typedef struct {
> > > > > >    atomic_long_t a;
> > > > > > } local_t;
> > > > > >
> > > > > > while offset is defined as 'unsigned long'.
> > > > >
> > > > > Ok, but that's because we're doing the wrong thing to start with.
> > > > >
> > > > > Since local_t is defined in terms of atomic_long_t, we should define the
> > > > > generic local_try_cmpxchg() in terms of atomic_long_try_cmpxchg(). We'll still
> > > > > have a mismatch between 'long *' and 'unsigned long *', but then we can fix
> > > > > that in the callsite:
> > > > >
> > > > >       while (!local_try_cmpxchg(&rb->head, &(long *)offset, head))
> > > >
> > > > Sorry, that should be:
> > > >
> > > >         while (!local_try_cmpxchg(&rb->head, (long *)&offset, head))
> > >
> > > The fallbacks are a bit more complicated than above, and are different
> > > from atomic_try_cmpxchg.
> > >
> > > Please note in patch 2/10, the falbacks when arch_try_cmpxchg_local
> > > are not defined call arch_cmpxchg_local. Also in patch 2/10,
> > > try_cmpxchg_local is introduced, where it calls
> > > arch_try_cmpxchg_local. Targets (and generic code) simply define (e.g.
> > > :
> > >
> > > #define local_cmpxchg(l, o, n) \
> > >        (cmpxchg_local(&((l)->a.counter), (o), (n)))
> > > +#define local_try_cmpxchg(l, po, n) \
> > > +       (try_cmpxchg_local(&((l)->a.counter), (po), (n)))
> > >
> > > which is part of the local_t API. Targets should either define all
> > > these #defines, or none. There are no partial fallbacks as is the case
> > > with atomic_t.
> >
> > Whether or not there are fallbacks is immaterial.
> >
> > In those cases, architectures can just as easily write C wrappers, e.g.
> >
> > long local_cmpxchg(local_t *l, long old, long new)
> > {
> >         return cmpxchg_local(&l->a.counter, old, new);
> > }
> >
> > long local_try_cmpxchg(local_t *l, long *old, long new)
> > {
> >         return try_cmpxchg_local(&l->a.counter, old, new);
> > }
> 
> Please find attached the complete prototype patch that implements the
> above suggestion.
> 
> The patch includes:
> - implementation of instrumented try_cmpxchg{,64}_local definitions
> - corresponding arch_try_cmpxchg{,64}_local fallback definitions
> - generic local{,64}_try_cmpxchg (and local{,64}_cmpxchg) C wrappers
> 
> - x86 specific local_try_cmpxchg (and local_cmpxchg) C wrappers
> - x86 specific arch_try_cmpxchg_local definition
> 
> - kernel/events/ring_buffer.c change to test local_try_cmpxchg
> implementation and illustrate the transition
> - arch/x86/events/core.c change to test local64_try_cmpxchg
> implementation and illustrate the transition
> 
> The definition of atomic_long_t is different for 64-bit and 32-bit
> targets (s64 vs int), so target specific C wrappers have to use
> different casts to account for this difference.
> 
> Uros.

Thanks for this!

FWIW, the patch (inline below) looks good to me.

Mark.

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index d096b04bf80e..d9310e9363f1 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -129,13 +129,12 @@ u64 x86_perf_event_update(struct perf_event *event)
>  	 * exchange a new raw count - then add that new-prev delta
>  	 * count to the generic event atomically:
>  	 */
> -again:
>  	prev_raw_count = local64_read(&hwc->prev_count);
> -	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
>  
> -	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
> -					new_raw_count) != prev_raw_count)
> -		goto again;
> +	do {
> +		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev_raw_count,
> +				      new_raw_count));
>  
>  	/*
>  	 * Now we have the new raw value and have updated the prev
> diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
> index 94fbe6ae7431..540573f515b7 100644
> --- a/arch/x86/include/asm/cmpxchg.h
> +++ b/arch/x86/include/asm/cmpxchg.h
> @@ -221,9 +221,15 @@ extern void __add_wrong_size(void)
>  #define __try_cmpxchg(ptr, pold, new, size)				\
>  	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
>  
> +#define __try_cmpxchg_local(ptr, pold, new, size)			\
> +	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
> +
>  #define arch_try_cmpxchg(ptr, pold, new) 				\
>  	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
>  
> +#define arch_try_cmpxchg_local(ptr, pold, new)				\
> +	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
> +
>  /*
>   * xadd() adds "inc" to "*ptr" and atomically returns the previous
>   * value of "*ptr".
> diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
> index 349a47acaa4a..d286a6c7c0b7 100644
> --- a/arch/x86/include/asm/local.h
> +++ b/arch/x86/include/asm/local.h
> @@ -120,8 +120,20 @@ static inline long local_sub_return(long i, local_t *l)
>  #define local_inc_return(l)  (local_add_return(1, l))
>  #define local_dec_return(l)  (local_sub_return(1, l))
>  
> -#define local_cmpxchg(l, o, n) \
> -	(cmpxchg_local(&((l)->a.counter), (o), (n)))
> +static inline long local_cmpxchg(local_t *l, long old, long new)
> +{
> +	return cmpxchg_local(&l->a.counter, old, new);
> +}
> +
> +static inline bool local_try_cmpxchg(local_t *l, long *old, long new)
> +{
> +#ifdef CONFIG_64BIT
> +	return try_cmpxchg_local(&l->a.counter, (s64 *)old, new);
> +#else
> +	return try_cmpxchg_local(&l->a.counter, (int *)old, new);
> +#endif
> +}
> +
>  /* Always has a lock prefix */
>  #define local_xchg(l, n) (xchg(&((l)->a.counter), (n)))
>  
> diff --git a/include/asm-generic/local.h b/include/asm-generic/local.h
> index fca7f1d84818..7f97018df66f 100644
> --- a/include/asm-generic/local.h
> +++ b/include/asm-generic/local.h
> @@ -42,6 +42,7 @@ typedef struct
>  #define local_inc_return(l) atomic_long_inc_return(&(l)->a)
>  
>  #define local_cmpxchg(l, o, n) atomic_long_cmpxchg((&(l)->a), (o), (n))
> +#define local_try_cmpxchg(l, po, n) atomic_long_try_cmpxchg((&(l)->a), (po), (n))
>  #define local_xchg(l, n) atomic_long_xchg((&(l)->a), (n))
>  #define local_add_unless(l, _a, u) atomic_long_add_unless((&(l)->a), (_a), (u))
>  #define local_inc_not_zero(l) atomic_long_inc_not_zero(&(l)->a)
> diff --git a/include/asm-generic/local64.h b/include/asm-generic/local64.h
> index 765be0b7d883..14963a7a6253 100644
> --- a/include/asm-generic/local64.h
> +++ b/include/asm-generic/local64.h
> @@ -42,7 +42,16 @@ typedef struct {
>  #define local64_sub_return(i, l) local_sub_return((i), (&(l)->a))
>  #define local64_inc_return(l)	local_inc_return(&(l)->a)
>  
> -#define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
> +static inline s64 local64_cmpxchg(local64_t *l, s64 old, s64 new)
> +{
> +	return local_cmpxchg(&l->a, old, new);
> +}
> +
> +static inline bool local64_try_cmpxchg(local64_t *l, s64 *old, s64 new)
> +{
> +	return local_try_cmpxchg(&l->a, (long *)old, new);
> +}
> +
>  #define local64_xchg(l, n)	local_xchg((&(l)->a), (n))
>  #define local64_add_unless(l, _a, u) local_add_unless((&(l)->a), (_a), (u))
>  #define local64_inc_not_zero(l)	local_inc_not_zero(&(l)->a)
> @@ -81,6 +90,7 @@ typedef struct {
>  #define local64_inc_return(l)	atomic64_inc_return(&(l)->a)
>  
>  #define local64_cmpxchg(l, o, n) atomic64_cmpxchg((&(l)->a), (o), (n))
> +#define local64_try_cmpxchg(l, po, n) atomic64_try_cmpxchg((&(l)->a), (po), (n))
>  #define local64_xchg(l, n)	atomic64_xchg((&(l)->a), (n))
>  #define local64_add_unless(l, _a, u) atomic64_add_unless((&(l)->a), (_a), (u))
>  #define local64_inc_not_zero(l)	atomic64_inc_not_zero(&(l)->a)
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 77bc5522e61c..36c92851cdee 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -217,6 +217,28 @@
>  
>  #endif /* arch_try_cmpxchg64_relaxed */
>  
> +#ifndef arch_try_cmpxchg_local
> +#define arch_try_cmpxchg_local(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg_local((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg_local */
> +
> +#ifndef arch_try_cmpxchg64_local
> +#define arch_try_cmpxchg64_local(_ptr, _oldp, _new) \
> +({ \
> +	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> +	___r = arch_cmpxchg64_local((_ptr), ___o, (_new)); \
> +	if (unlikely(___r != ___o)) \
> +		*___op = ___r; \
> +	likely(___r == ___o); \
> +})
> +#endif /* arch_try_cmpxchg64_local */
> +
>  #ifndef arch_atomic_read_acquire
>  static __always_inline int
>  arch_atomic_read_acquire(const atomic_t *v)
> @@ -2456,4 +2478,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// b5e87bdd5ede61470c29f7a7e4de781af3770f09
> +// 1f49bd4895a4b7a5383906649027205c52ec80ab
> diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> index 7a139ec030b0..14a9212cc987 100644
> --- a/include/linux/atomic/atomic-instrumented.h
> +++ b/include/linux/atomic/atomic-instrumented.h
> @@ -2066,6 +2066,24 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__); \
>  })
>  
> +#define try_cmpxchg_local(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
> +#define try_cmpxchg64_local(ptr, oldp, ...) \
> +({ \
> +	typeof(ptr) __ai_ptr = (ptr); \
> +	typeof(oldp) __ai_oldp = (oldp); \
> +	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
> +	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
> +	arch_try_cmpxchg64_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> +})
> +
>  #define cmpxchg_double(ptr, ...) \
>  ({ \
>  	typeof(ptr) __ai_ptr = (ptr); \
> @@ -2083,4 +2101,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
>  })
>  
>  #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
> -// 764f741eb77a7ad565dc8d99ce2837d5542e8aee
> +// 456e206c7e4e681126c482e4edcc6f46921ac731
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 273a0fe7910a..111ab85ee97d 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -191,9 +191,10 @@ __perf_output_begin(struct perf_output_handle *handle,
>  
>  	perf_output_get_handle(handle);
>  
> +	offset = local_read(&rb->head);
>  	do {
>  		tail = READ_ONCE(rb->user_page->data_tail);
> -		offset = head = local_read(&rb->head);
> +		head = offset;
>  		if (!rb->overwrite) {
>  			if (unlikely(!ring_buffer_has_space(head, tail,
>  							    perf_data_size(rb),
> @@ -217,7 +218,7 @@ __perf_output_begin(struct perf_output_handle *handle,
>  			head += size;
>  		else
>  			head -= size;
> -	} while (local_cmpxchg(&rb->head, offset, head) != offset);
> +	} while (!local_try_cmpxchg(&rb->head, &offset, head));
>  
>  	if (backward) {
>  		offset = head;
> diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
> index 3a07695e3c89..6e853f0dad8d 100755
> --- a/scripts/atomic/gen-atomic-fallback.sh
> +++ b/scripts/atomic/gen-atomic-fallback.sh
> @@ -225,6 +225,10 @@ for cmpxchg in "cmpxchg" "cmpxchg64"; do
>  	gen_try_cmpxchg_fallbacks "${cmpxchg}"
>  done
>  
> +for cmpxchg in "cmpxchg_local" "cmpxchg64_local"; do
> +	gen_try_cmpxchg_fallback "${cmpxchg}" ""
> +done
> +
>  grep '^[a-z]' "$1" | while read name meta args; do
>  	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
>  done
> diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> index 77c06526a574..c8165e9431bf 100755
> --- a/scripts/atomic/gen-atomic-instrumented.sh
> +++ b/scripts/atomic/gen-atomic-instrumented.sh
> @@ -173,7 +173,7 @@ for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg" "try_cmpxchg64"; do
>  	done
>  done
>  
> -for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
> +for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg" "try_cmpxchg_local" "try_cmpxchg64_local" ; do
>  	gen_xchg "${xchg}" "" ""
>  	printf "\n"
>  done

