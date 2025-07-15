Return-Path: <linux-arch+bounces-12785-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33EEB0635D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAFC1AA18A5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040462561D1;
	Tue, 15 Jul 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9tQs8nX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640E2561AE;
	Tue, 15 Jul 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594341; cv=none; b=ttDvt80r0YNWLOmjg5Q1HYdwd6eowFHorsocNSdWdawwvs5eYzvWGPXGAKMbj6/ql5L2NnlsBZJry1DuYMkO73YwbC4FvndhGwtfHxnHXGSYYgJS9o8ZDK+zEC5oyO2hmhPX/5jvT5tVlbdb1+fzdYFOoaSmeYuwlh9B4hGyNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594341; c=relaxed/simple;
	bh=SoTTWR6ZYPVzO+P1szw9alpdHsgJzaMP2zOCwQgnPoE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QFDkemJdLKz8/o/9rOtyJNr6OEjFjR+dXBCFl/iYL3vrmdQ/QZyYtX5CJSFl63nfzNPXLXi6FCXNt0H4Yc+2boOHZ0WtHmlnP/akhuQd0YS1UwcMirwsf4MGMKKF6ZtQrqWxPql+5Ysgdi71ovzTkgQ1qlD6rqr0GM9seN5Z818=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9tQs8nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E437C4CEF4;
	Tue, 15 Jul 2025 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752594341;
	bh=SoTTWR6ZYPVzO+P1szw9alpdHsgJzaMP2zOCwQgnPoE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=g9tQs8nXOZpSPTy6wTPYimiG85CQwvghEN6iP5B787Cu4JXppPymJre+V6+gVnuIa
	 r0pObQgssRddUBt+DxVjVMSc5ycgTu9hyTJhwvLEsA+0ixJ69bjGcfaFZEfc8yDkWa
	 PGars/6u9wVPBD2q6GrnWCjzrkAdQOl6re6/+2ydLYyJok543bDEQd7W+LuJmL0mrt
	 PhqpCw4SZ0sN/gLRr3TSli0Fj1OjM6TN8qSF5js7FOelHQ/425f35YaI6Yen/IWlm1
	 X9v7D8uA1sFJfozdtBZtuhN8WYeiL/7s8uF8wkbUMXjUz854NFdruXO9eBjKDpzXbR
	 /TSca0p65vqCw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 17:45:34 +0200
Message-Id: <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
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
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org> <aHZYt3Csy29GF2HM@Mac.home>
In-Reply-To: <aHZYt3Csy29GF2HM@Mac.home>

On Tue Jul 15, 2025 at 3:33 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 01:21:20PM +0200, Benno Lossin wrote:
>> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
>> > +/// Types that support atomic add operations.
>> > +///
>> > +/// # Safety
>> > +///
>> > +/// Wrapping adding any value of type `Self::Repr::Delta` obtained by=
 [`Self::rhs_into_delta()`] to
>>=20
>> I don't like "wrapping adding", either we use "`wrapping_add`" or we use
>> some other phrasing.
>>=20
>
> Let's use `wrapping_add` then.
>
>     /// `wrapping_add` any value of type `Self::Repr::Delta` obtained by =
[`Self::rhs_into_delta()`] to
>     /// any value of type `Self::Repr` obtained through transmuting a val=
ue of type `Self` to must
>     /// yield a value with a bit pattern also valid for `Self`.
>
>> > +pub unsafe trait AllowAtomicAdd<Rhs =3D Self>: AllowAtomic {
>>=20
>> Why `Allow*`? I think `AtomicAdd` is better?
>>=20
>
> To be consistent with `AllowAtomic` (the super trait), if we use
> `AtomicAdd` here, should we change `AllowAtomic` to `AtomicBase`?

Ideally, we would name that trait just `Atomic` :) But it then
conflicts with the `Atomic<T>` struct (this would be motivation to put
them in different modules :). I like `AtomicBase` better than
`AllowAtomic`, but maybe there is a better name, how about `AtomicType`?

>> > +    /// Converts `Rhs` into the `Delta` type of the atomic implementa=
tion.
>> > +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
>> > +}
>> > +
>> >  impl<T: AllowAtomic> Atomic<T> {
>> >      /// Creates a new atomic `T`.
>> >      pub const fn new(v: T) -> Self {
>> > @@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self, o=
ld: &mut T, new: T, _: Ordering)
>> >          ret
>> >      }
>> >  }
>> > +
>> > +impl<T: AllowAtomic> Atomic<T>
>> > +where
>> > +    T::Repr: AtomicHasArithmeticOps,
>> > +{
>> > +    /// Atomic add.
>> > +    ///
>> > +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
>> > +    ///
>> > +    /// # Examples
>> > +    ///
>> > +    /// ```
>> > +    /// use kernel::sync::atomic::{Atomic, Relaxed};
>> > +    ///
>> > +    /// let x =3D Atomic::new(42);
>> > +    ///
>> > +    /// assert_eq!(42, x.load(Relaxed));
>> > +    ///
>> > +    /// x.add(12, Relaxed);
>> > +    ///
>> > +    /// assert_eq!(54, x.load(Relaxed));
>> > +    /// ```
>> > +    #[inline(always)]
>> > +    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs, _=
: Ordering)
>> > +    where
>> > +        T: AllowAtomicAdd<Rhs>,
>> > +    {
>> > +        let v =3D T::rhs_into_delta(v);
>> > +        // CAST: Per the safety requirement of `AllowAtomic`, a valid=
 pointer of `T` is a valid
>> > +        // pointer of `T::Repr` for reads and valid for writes of val=
ues transmutable to `T`.
>> > +        let a =3D self.as_ptr().cast::<T::Repr>();
>> > +
>> > +        // `*self` remains valid after `atomic_add()` because of the =
safety requirement of
>> > +        // `AllowAtomicAdd`.
>>=20
>> This part should be moved to the CAST comment above, since we're not
>> only writing a value transmuted from `T` into `*self`.
>>=20
>
> Hmm.. the CAST comment should explain why a pointer of `T` can be a
> valid pointer of `T::Repr` because the atomic_add() below is going to
> read through the pointer and write value back. The comment starting with
> "`*self`" explains the value written is a valid `T`, therefore
> conceptually atomic_add() below writes a valid `T` in form of `T::Repr`
> into `a`.

I see, my interpretation was that if we put it on the cast, then the
operation that `atomic_add` does also is valid.

But I think this comment should either be part of the `CAST` or the
`SAFETY` comment. Going by your interpretation, it would make more sense
in the SAFETY one, since there you justify that you're actually writing
a value of type `T`.

---
Cheers,
Benno

> Basically
>
> // CAST
> let a =3D ..
>
> ^ explains what `a` is a valid for and why it's valid.
>
> // `*self` remains
>
> ^ explains that we write a valid value to `a`.
>
>
> So I don't think we need to move?

