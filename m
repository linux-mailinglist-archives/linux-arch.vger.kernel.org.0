Return-Path: <linux-arch+bounces-12789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269E1B06620
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CED501391
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 18:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED992BE047;
	Tue, 15 Jul 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG5X8JOh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37E34545;
	Tue, 15 Jul 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604752; cv=none; b=vElIYyush7rDR9Qwpibw1+RATQzPlNpcw2qsyKWK1FotSS8SU9wuytDRAwdD3BgvT8Ofo9eAxxQKG9luvk8D8SLb3j1r3FBYKai2ZMJceiUcAVop63kJD8nHSUeensGgEGE3Tk59QmD0UQ2gEyi9l1nSCgqjuNU0Bfzu5ux0gKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604752; c=relaxed/simple;
	bh=4Nwz1aScLl/kvJgNVXnmc4//qaF22EiPJK4z6ONTkWU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ICxVSN+JltF6+CltBk63mqDXo9kBbS6WootZzHLwSBbm4kWwJ/4IC0k+LHl7htGCyTRCrtpSAIhEZAAF2E2aEgyiEmzRKVD37gmwBWcAlHf6+NqDmOqkUuLVo4NCMO2N9wOX79taxxN7NmzKIOjAHkJEaNFAe0WFgW3fk7fCA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG5X8JOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFB9C4CEE3;
	Tue, 15 Jul 2025 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752604752;
	bh=4Nwz1aScLl/kvJgNVXnmc4//qaF22EiPJK4z6ONTkWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SG5X8JOhJ9xvFah+hGGXMfGS+d4sH7OitjpuPmBZ75b1AYxxVfKcmjMWjYdmCQOvo
	 Gc3yjyzg015VPgVvRBqHx+BgjmIUXoujITXnKNNl1oJRrG8AmxHeh9AEdplEsR6M/S
	 /WX5cz7yZMS+6YWQerYU5dqPe8VgNAfxq+g0nKE0XQ7YGziCOi1n0P5ltvUEx9nsaU
	 cXEIxCYpNamGB0xUy9E4q+58tF6i8EBDeLwJPNK8AuOr0nKfO0kK3zU1TO/9OhTRkT
	 q6RbNrAtG0mP5ZV32+4HqlX98tHbLiDSpDVB01u1XNmmPPo8N9WdkOjmYWnb0q8pC9
	 FfcyAxL+Dppcg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 20:39:04 +0200
Message-Id: <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org> <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org> <aHZ-HP1ErzlERfpI@Mac.home>
In-Reply-To: <aHZ-HP1ErzlERfpI@Mac.home>

On Tue Jul 15, 2025 at 6:13 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 05:45:34PM +0200, Benno Lossin wrote:
>> On Tue Jul 15, 2025 at 3:33 PM CEST, Boqun Feng wrote:
>> > On Tue, Jul 15, 2025 at 01:21:20PM +0200, Benno Lossin wrote:
>> >> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
>> >> > +/// Types that support atomic add operations.
>> >> > +///
>> >> > +/// # Safety
>> >> > +///
>> >> > +/// Wrapping adding any value of type `Self::Repr::Delta` obtained=
 by [`Self::rhs_into_delta()`] to
>> >>=20
>> >> I don't like "wrapping adding", either we use "`wrapping_add`" or we =
use
>> >> some other phrasing.
>> >>=20
>> >
>> > Let's use `wrapping_add` then.
>> >
>> >     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained =
by [`Self::rhs_into_delta()`] to
>> >     /// any value of type `Self::Repr` obtained through transmuting a =
value of type `Self` to must
>> >     /// yield a value with a bit pattern also valid for `Self`.
>> >
>> >> > +pub unsafe trait AllowAtomicAdd<Rhs =3D Self>: AllowAtomic {
>> >>=20
>> >> Why `Allow*`? I think `AtomicAdd` is better?
>> >>=20
>> >
>> > To be consistent with `AllowAtomic` (the super trait), if we use
>> > `AtomicAdd` here, should we change `AllowAtomic` to `AtomicBase`?
>>=20
>> Ideally, we would name that trait just `Atomic` :) But it then
>> conflicts with the `Atomic<T>` struct (this would be motivation to put
>> them in different modules :). I like `AtomicBase` better than
>
> Oh, if we move `Atomic<T>` to atomic.rs and keep atomic::generic, then
> we can name it atomic::generic::Atomic ;-)

That would be an argument for having the `generic` module :)

Well, I'm not so sure about having two types with the same name right
away, so maybe let's discuss this in our meeting.

>> `AllowAtomic`, but maybe there is a better name, how about `AtomicType`?
>>=20
>
> AtomicType may be better than AtomicBase to me.

Yeah I like it better too.

>> >> > +    /// Converts `Rhs` into the `Delta` type of the atomic impleme=
ntation.
>> >> > +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Del=
ta;
>> >> > +}
>> >> > +
>> >> >  impl<T: AllowAtomic> Atomic<T> {
>> >> >      /// Creates a new atomic `T`.
>> >> >      pub const fn new(v: T) -> Self {
>> >> > @@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self=
, old: &mut T, new: T, _: Ordering)
>> >> >          ret
>> >> >      }
>> >> >  }
>> >> > +
>> >> > +impl<T: AllowAtomic> Atomic<T>
>> >> > +where
>> >> > +    T::Repr: AtomicHasArithmeticOps,
>> >> > +{
>> >> > +    /// Atomic add.
>> >> > +    ///
>> >> > +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
>> >> > +    ///
>> >> > +    /// # Examples
>> >> > +    ///
>> >> > +    /// ```
>> >> > +    /// use kernel::sync::atomic::{Atomic, Relaxed};
>> >> > +    ///
>> >> > +    /// let x =3D Atomic::new(42);
>> >> > +    ///
>> >> > +    /// assert_eq!(42, x.load(Relaxed));
>> >> > +    ///
>> >> > +    /// x.add(12, Relaxed);
>> >> > +    ///
>> >> > +    /// assert_eq!(54, x.load(Relaxed));
>> >> > +    /// ```
>> >> > +    #[inline(always)]
>> >> > +    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs=
, _: Ordering)
>> >> > +    where
>> >> > +        T: AllowAtomicAdd<Rhs>,
>> >> > +    {
>> >> > +        let v =3D T::rhs_into_delta(v);
>> >> > +        // CAST: Per the safety requirement of `AllowAtomic`, a va=
lid pointer of `T` is a valid
>> >> > +        // pointer of `T::Repr` for reads and valid for writes of =
values transmutable to `T`.
>> >> > +        let a =3D self.as_ptr().cast::<T::Repr>();
>> >> > +
>> >> > +        // `*self` remains valid after `atomic_add()` because of t=
he safety requirement of
>> >> > +        // `AllowAtomicAdd`.
>> >>=20
>> >> This part should be moved to the CAST comment above, since we're not
>> >> only writing a value transmuted from `T` into `*self`.
>> >>=20
>> >
>> > Hmm.. the CAST comment should explain why a pointer of `T` can be a
>> > valid pointer of `T::Repr` because the atomic_add() below is going to
>> > read through the pointer and write value back. The comment starting wi=
th
>> > "`*self`" explains the value written is a valid `T`, therefore
>> > conceptually atomic_add() below writes a valid `T` in form of `T::Repr=
`
>> > into `a`.
>>=20
>> I see, my interpretation was that if we put it on the cast, then the
>> operation that `atomic_add` does also is valid.
>>=20
>> But I think this comment should either be part of the `CAST` or the
>> `SAFETY` comment. Going by your interpretation, it would make more sense
>> in the SAFETY one, since there you justify that you're actually writing
>> a value of type `T`.
>>=20
>
> Hmm.. you're probably right. There are two safety things about
> atomic_add():
>
> - Whether calling it is safe
> - Whether the operation on `a` (a pointer to `T` essentially) is safe.

Well part of calling `T::Repr::atomic_add` is that the pointer is valid.
But it actually isn't valid for all operations, only for the specific
one you have here. If we want to be 100% correct, we actually need to
change the safety comment of `atomic_add` to say that it only requires
the result of `*a + v` to be writable... But that is most likely very
annoying... (note that we also have this issue for `store`)

I'm not too sure on what the right way to do this is. The formal answer
is to "just do it right", but then safety comments really just devolve
into formally proving the correctness of the program. I think -- for now
at least :) -- that we shouldn't do this here & now (since we also have
a lot of other code that isn't using normal good safety comments, let
alone formally correct ones).

> How about the following:
>
>         let v =3D T::rhs_into_delta(v);
>         // CAST: Per the safety requirement of `AllowAtomic`, a valid poi=
nter of `T` is a valid
>         // pointer of `T::Repr` for reads and valid for writes of values =
transmutable to `T`.
>         let a =3D self.as_ptr().cast::<T::Repr>();
>
>         // `*self` remains valid after `atomic_add()` because of the safe=
ty requirement of
>         // `AllowAtomicAdd`.
>         //
>         // SAFETY:
>         // - For calling `atomic_add()`:
>         //   - `a` is aligned to `align_of::<T::Repr>()` because of the s=
afety requirement of
>         //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
>         //   - `a` is a valid pointer per the CAST justification above.
>         // - For accessing `*a`: the value written is transmutable to `T`
>         //   due to the safety requirement of `AllowAtomicAdd`.
>         unsafe { T::Repr::atomic_add(a, v) };

That looks fine for now. But isn't this duplicating the sentence
starting with `*self`?

---
Cheers,
Benno

