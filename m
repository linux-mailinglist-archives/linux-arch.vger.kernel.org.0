Return-Path: <linux-arch+bounces-12804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8AB07347
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114833B976F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A492EE985;
	Wed, 16 Jul 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXJ7kO7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E599E219311;
	Wed, 16 Jul 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661538; cv=none; b=cy8XsXJszyOdCo02/ZOG7Q/zzsBfVMametUMgaoazJEPUPhpk2O1r7w2SxNrfmhNAO3tFWb1hE/SVkPoxFOxn+w2f3jaHSwQpLdB4QtDjsKz6Q/hThWPcLTO+uvbQbzBcVGmbYFgXmYsx4yDlaE+WlRsJ1ZffXc+rcdG+Kklg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661538; c=relaxed/simple;
	bh=473mc3MZXvs9Act5kTmKwMLGqXiBcGDDVJRhHEO7Ys4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=huEFQcEeULFEcY8PpscfujIdxoM8/9rvgoJuAtg4nr1Wqch0AhoNaEc38MeJ2ZfBXnXiC5SQnOQjcRCp3axUB3RkPRVmUfXjhOsk0k/ecHR4ZALbR835bmqbeXjAixZ8BlEhsmxX7goTa1WO/II7e3XRAjm4Xz0ZWytlkECmb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXJ7kO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9961BC4CEF0;
	Wed, 16 Jul 2025 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661537;
	bh=473mc3MZXvs9Act5kTmKwMLGqXiBcGDDVJRhHEO7Ys4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=KNXJ7kO7LGJI1r9yNP4C5/mN2N+02+5CVPLcdykvfjopwfG0v26zIpWZgD6yxB38w
	 3uAd4qsc82nWkq5rEtBRzuxJ+3m5e35smpBgakpVJxFIlNNM+GlFCo5EfPGNxS2VOR
	 WsfBneItZkNxuOxeAJz2ttBhQCx/EiXORxXd5H7Dx3u1D9kNirD91xvJUo2EvZn7sh
	 dWimR4iEevzYjNY3yQWrtGLlTG+s6fU7aAQI4IC6XrN3l4T5+fIuhLXfJlngHHuaHe
	 eNxS5i9z6tvuEPAz2qTqZe2LEZ7PAtjRQFUFc0BgZfsciquRhhyS1KwKMkVH/T89XH
	 L/BZb7Ar9O+Yg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 12:25:30 +0200
Message-Id: <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org>
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
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
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org> <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org> <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org> <aHa2he81nBDgvA5u@tardis-2.local>
In-Reply-To: <aHa2he81nBDgvA5u@tardis-2.local>

On Tue Jul 15, 2025 at 10:13 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 08:39:04PM +0200, Benno Lossin wrote:
> [...]
>> >> > Hmm.. the CAST comment should explain why a pointer of `T` can be a
>> >> > valid pointer of `T::Repr` because the atomic_add() below is going =
to
>> >> > read through the pointer and write value back. The comment starting=
 with
>> >> > "`*self`" explains the value written is a valid `T`, therefore
>> >> > conceptually atomic_add() below writes a valid `T` in form of `T::R=
epr`
>> >> > into `a`.
>> >>=20
>> >> I see, my interpretation was that if we put it on the cast, then the
>> >> operation that `atomic_add` does also is valid.
>> >>=20
>> >> But I think this comment should either be part of the `CAST` or the
>> >> `SAFETY` comment. Going by your interpretation, it would make more se=
nse
>> >> in the SAFETY one, since there you justify that you're actually writi=
ng
>> >> a value of type `T`.
>> >>=20
>> >
>> > Hmm.. you're probably right. There are two safety things about
>> > atomic_add():
>> >
>> > - Whether calling it is safe
>> > - Whether the operation on `a` (a pointer to `T` essentially) is safe.
>>=20
>> Well part of calling `T::Repr::atomic_add` is that the pointer is valid.
>
> Here by saying "calling `T::Repr::atomic_add`", I think you mean the
> whole operation, so yeah, we have to consider the validy for `T` of the
> result.

I meant just the call to `atomic_add`.

> But what I'm trying to do is reasoning this in 2 steps:
>
> First, let's treat it as an `atomic_add(*mut i32, i32)`, then as long as
> we provide a valid `*mut i32`, it's safe to call.=20

But the thing is, we're not supplying a valid `*mut i32`. Because the
pointer points to a value that is not actually an `i32`. You're only
allowed to write certain values and so you basically have to treat it as
a transmute + write. And so you need to include a justification for this
transmute in the write itself.=20

For example, if we had `bool: AllowAtomic`, then writing a `2` in store
would be insta-UB, since we then have a `&UnsafeCell<bool>` pointing at
`2`.

This is part of library vs language UB, writing `2` into a bool and
having a reference is language-UB (ie instant UB) and writing a `2` into
a variable of type `i32` that is somewhere cast to `bool` is library-UB
(since it will lead to language-UB later).=20

The safety comments become simpler when you use `UnsafeCell<T::Repr>`
instead :) since that changes this language-UB into library-UB. (the
only safety comment that is more complex then is `get_mut`, but that's
only a single one)

If you don't want that, then we can solve this in two ways:

(1) add a guarantee on `atomic_add` (and all other operations) that it
    will write `*a + v` to `a` and nothing else.
(2) make the safety requirement only require writes of the addition to
    be valid.

My preference precedence is: use `T::Repr`, (2) and finally (1). (2)
will be very wordy on all operations & the safety comments in this file,
but it's clean from a formal perspective. (1) works by saying "what
we're supplying is actually not a valid `*mut i32`, but since the
guarantee of the function ensures that only specific things are written,
it's fine" which isn't very clean. And the `T::Repr` approach avoids all
this by just storing value of `T::Repr` circumventing the whole issue.
Then we only need to justify why we can point a `&mut T` at it and that
we can do by having an invariant that should be simple to keep.

We probably should talk about this in our meeting :)

---
Cheers,
Benno

> And second assume we call it with a valid pointer to `T::Repr`, and a
> delta from `rhs_into_delta()`, then per the safety guarantee of
> `AllowAtomicAdd`, the value written at the pointer is a valid `T`.
>
> Based on these, we can prove the whole operation is safe for the given
> input.
>
>> But it actually isn't valid for all operations, only for the specific
>> one you have here. If we want to be 100% correct, we actually need to
>> change the safety comment of `atomic_add` to say that it only requires
>> the result of `*a + v` to be writable... But that is most likely very
>> annoying... (note that we also have this issue for `store`)
>>=20
>> I'm not too sure on what the right way to do this is. The formal answer
>> is to "just do it right", but then safety comments really just devolve
>> into formally proving the correctness of the program. I think -- for now
>> at least :) -- that we shouldn't do this here & now (since we also have
>> a lot of other code that isn't using normal good safety comments, let
>> alone formally correct ones).
>>=20
>> > How about the following:
>> >
>> >         let v =3D T::rhs_into_delta(v);
>> >         // CAST: Per the safety requirement of `AllowAtomic`, a valid =
pointer of `T` is a valid
>> >         // pointer of `T::Repr` for reads and valid for writes of valu=
es transmutable to `T`.
>> >         let a =3D self.as_ptr().cast::<T::Repr>();
>> >
>> >         // `*self` remains valid after `atomic_add()` because of the s=
afety requirement of
>> >         // `AllowAtomicAdd`.
>> >         //
>> >         // SAFETY:
>> >         // - For calling `atomic_add()`:
>> >         //   - `a` is aligned to `align_of::<T::Repr>()` because of th=
e safety requirement of
>> >         //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
>> >         //   - `a` is a valid pointer per the CAST justification above=
.
>> >         // - For accessing `*a`: the value written is transmutable to =
`T`
>> >         //   due to the safety requirement of `AllowAtomicAdd`.
>> >         unsafe { T::Repr::atomic_add(a, v) };

