Return-Path: <linux-arch+bounces-12507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D18AED98D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AC5175879
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jun 2025 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C424EA90;
	Mon, 30 Jun 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK+Qs1me"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40824466E;
	Mon, 30 Jun 2025 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278616; cv=none; b=gKygM2+pGDNqVtBR2lUtw48PawZ/i9fkNfhW6ETQpo0157RsqU0bGqFHPpLRSN3CNfRL9JMJkJBP+0zOVqFmA55mPRlFmJrqzaPuKqWtbFr5eY/gfrEncuiGuAK/kyeg0xfLj8nBjcvXhPivEInOCKiOdcsFdxCzRID1ilGy12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278616; c=relaxed/simple;
	bh=jyY7VefVj/pRCib4aQ/EAxfV4IOvZHmPLQGlbEVLfrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fE12EDwfR9btKMuGhIXwrvkgmoIa6bq4qBorYFlX0mQJN3IkrxVCx5IwAXkRs6/RwMIrvySF8qEOc6E8veCBLMRdx++pzRS8deqiKEvdUtLxmJZ5JBak4BX3GPPikvucbme0vA6sOXbzMPqKAuD/4ZGH6wymDsoYS95biHY/clU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK+Qs1me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B8FC4CEEF;
	Mon, 30 Jun 2025 10:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751278616;
	bh=jyY7VefVj/pRCib4aQ/EAxfV4IOvZHmPLQGlbEVLfrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lK+Qs1meId433F4nC7m2zLarI/XsKLyZs/NfXqSW08FevT7XSPlMrHPvkMzFEU5ej
	 IvT3UDjLnfVoSZvhzu0eM6dvMa/FoFOAlrrF7fEdu9o2SbHuaSWfPYm4iTy0Jyg9aD
	 kNrflsFLt+mvouLIkVjJC+naTdwm3VHchi/gBnA1RYic2R5CotM73QSCLyWi2FVxoe
	 bn0BMrrfefesjQ6M29xvJfOTvoWm9LinFL8DjMKems0c5OgqtCn6XgDqvUkzlZSmoF
	 eJ3AI5Pj/RokTFGvBmOAoSN7T5q8gN8uPKsV2On28I21lzlyfwsM1qFDRln/r7+KTZ
	 OOjVIlzPoI+tg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <lkmm@lists.linux.dev>,  <linux-arch@vger.kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
In-Reply-To: <aF9bmpX-i6HVMlaj@Mac.home> (Boqun Feng's message of "Fri, 27 Jun
	2025 20:03:54 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<jBAtISwM9LKkR7KuCHEnym75NfGOM4z408pMuDfk4U8VzN8PQuk9JJfBc33Usre3YSjbgtFRj8c0ZNeeQMpZsA==@protonmail.internalid>
	<20250618164934.19817-6-boqun.feng@gmail.com> <87a55uzlxv.fsf@kernel.org>
	<_pLa3zqu-AHBOnxkEz7l13l9W-OsKBtuXIkjRsIJJy6EnYTrM99E8Yr24pzjqwCAj1_qs_PI-cVxRsBsbgiFdA==@protonmail.internalid>
	<aF9bmpX-i6HVMlaj@Mac.home>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 30 Jun 2025 12:16:27 +0200
Message-ID: <878ql9zg90.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Thu, Jun 26, 2025 at 03:12:12PM +0200, Andreas Hindborg wrote:
>> "Boqun Feng" <boqun.feng@gmail.com> writes:
>>
>> > xchg() and cmpxchg() are basic operations on atomic. Provide these based
>> > on C APIs.
>> >
>> > Note that cmpxchg() use the similar function signature as
>> > compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
>> > the operation succeeds and `Err(old)` means the operation fails.
>> >
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> > ---
>> >  rust/kernel/sync/atomic/generic.rs | 154 +++++++++++++++++++++++++++++
>> >  1 file changed, 154 insertions(+)
>> >
>> > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
>> > index 73c26f9cf6b8..bcdbeea45dd8 100644
>> > --- a/rust/kernel/sync/atomic/generic.rs
>> > +++ b/rust/kernel/sync/atomic/generic.rs
>> > @@ -256,3 +256,157 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
>> >          };
>> >      }
>> >  }
>> > +
>> > +impl<T: AllowAtomic> Atomic<T>
>> > +where
>> > +    T::Repr: AtomicHasXchgOps,
>> > +{
>> > +    /// Atomic exchange.
>> > +    ///
>> > +    /// # Examples
>> > +    ///
>> > +    /// ```rust
>> > +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
>> > +    ///
>> > +    /// let x = Atomic::new(42);
>> > +    ///
>> > +    /// assert_eq!(42, x.xchg(52, Acquire));
>> > +    /// assert_eq!(52, x.load(Relaxed));
>> > +    /// ```
>> > +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
>> > +    #[inline(always)]
>> > +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
>> > +        let v = T::into_repr(v);
>> > +        let a = self.as_ptr().cast::<T::Repr>();
>> > +
>> > +        // SAFETY:
>> > +        // - For calling the atomic_xchg*() function:
>> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
>>
>> Typo: `AllowAtomic`.
>>
>
> Fixed.
>
>> > +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
>> > +        //   - per the type invariants, the following atomic operation won't cause data races.
>> > +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
>> > +        //   - atomic operations are used here.
>> > +        let ret = unsafe {
>> > +            match Ordering::TYPE {
>> > +                OrderingType::Full => T::Repr::atomic_xchg(a, v),
>> > +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
>> > +                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
>> > +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
>> > +            }
>> > +        };
>> > +
>> > +        T::from_repr(ret)
>> > +    }
>> > +
>> > +    /// Atomic compare and exchange.
>> > +    ///
>> > +    /// Compare: The comparison is done via the byte level comparison between the atomic variables
>> > +    /// with the `old` value.
>> > +    ///
>> > +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
>> > +    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
>> > +    /// failed cmpxchg should be treated as a relaxed read.
>>
>> Rust `core::ptr` functions have this sentence on success ordering for
>> compare_exchange:
>>
>>   Using Acquire as success ordering makes the store part of this
>>   operation Relaxed, and using Release makes the successful load
>>   Relaxed.
>>
>> Does this translate to LKMM cmpxchg operations? If so, I think we should
>> include this sentence. This also applies to `Atomic::xchg`.
>>
>
> I see this as a different style of documenting, so in my next version,
> I have the following:
>
> //! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
> //!   following memory accesses.
> //! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
> //!   the annotated operation.
>
> in atomic/ordering.rs, I think I can extend it to:
>
> //! - [`Acquire`] provides ordering between the load part of the annotated operation and all the
> //!   following memory accesses, and if there is a store part, it has Relaxed ordering.
> //! - [`Release`] provides ordering between all the preceding memory accesses and the store part of
> //!   the annotated operation, and if there is load part, it has Relaxed ordering
>
> This aligns with what we usually describe things in tool/memory-model/.

Cool. When you start to go into details of ordering concepts, I feel
like something is missing though. For example for this sentence:

  [`Release`] provides ordering between all the preceding memory
  accesses and the store part of the annotated operation.

I guess this provided ordering is only guaranteed to be observable for
threads that read the same location with `Acquire` or stronger ordering?

If we start expanding on the orderings, rather than deferring to LKMM,
we should include this info.


Best regards,
Andreas Hindborg




