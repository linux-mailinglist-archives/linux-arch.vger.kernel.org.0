Return-Path: <linux-arch+bounces-12818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E43B07A13
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ABD1886B31
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 15:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7472356BD;
	Wed, 16 Jul 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2a5CYWK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7C19F40A;
	Wed, 16 Jul 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680173; cv=none; b=POBfXiYjc5I5o7J/ECZmkFiv6yoAUCDHswHGCtI6gSQlyPJKCgEL1bySF4a9s1skoQY0eYax2g38gH6H00Ic9LdhhsFQYnM+dULUAwHuD4C6Nb0C9oHtp5Zee5Ks7NxPht1m4yknw+I4ykYpSMHO0xLe01vuXX0cLXAf8hI0Vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680173; c=relaxed/simple;
	bh=iDuNDBH8DmskIjB6QZW3VDr54ybRnZOA1Zod2ETR3ho=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=roVHTfmOFGxkZuqVSECWzc7jZFKc4PXq3KMIA9VOPSvu7xIgxTKUbzZP20P5PDdQO9mttsYuBoS2nS0FAhCEqAyvvuetTlabEhtDkKE4F1urStn8QdroatH9AtQB2td52za86exHpwZlbVdavDE/D5yCBspv9gQTKhXFb/gfJWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2a5CYWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63C3C4CEE7;
	Wed, 16 Jul 2025 15:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752680173;
	bh=iDuNDBH8DmskIjB6QZW3VDr54ybRnZOA1Zod2ETR3ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2a5CYWKcye/Sn1lYE0QXO2n7hgxKixDFWFGjhQljZo7FnGaoXZW7GwVAa3fGJCV/
	 4d9TgSa2xoW0ZmGPMQFNrhmOfQ601+e1x7zvMRAVKzXMJNZvwougubW/Mjb7wFwnNo
	 9zUTCiG2g02zVP0V6RH0CV7m2CVB/Q+1xciIyCJ4Ydf6PS/OscH3sajHOaxZeSU+dP
	 kBqG61AHMxGMXQ295JYtO65+jSqrg9J7nT0fXiMbA1HoMytimyLhgmrfFRfJktdXVV
	 myZjKcQQLI+3XPq0dbiwoCTtN6pAMnQ3OJIP0qRnaljgAyfbUzSVklJwmEG/jQJ6gz
	 IgvyHzW0R7eEw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 17:36:05 +0200
Message-Id: <DBDL9KI7VNO2.1QZBWS222KQGP@kernel.org>
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
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org> <aHa2he81nBDgvA5u@tardis-2.local>
 <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org> <aHezbbzk0FyBW9jS@Mac.home>
In-Reply-To: <aHezbbzk0FyBW9jS@Mac.home>

On Wed Jul 16, 2025 at 4:13 PM CEST, Boqun Feng wrote:
> On Wed, Jul 16, 2025 at 12:25:30PM +0200, Benno Lossin wrote:
>> On Tue Jul 15, 2025 at 10:13 PM CEST, Boqun Feng wrote:
>> > On Tue, Jul 15, 2025 at 08:39:04PM +0200, Benno Lossin wrote:
>> > [...]
>> >> >> > Hmm.. the CAST comment should explain why a pointer of `T` can b=
e a
>> >> >> > valid pointer of `T::Repr` because the atomic_add() below is goi=
ng to
>> >> >> > read through the pointer and write value back. The comment start=
ing with
>> >> >> > "`*self`" explains the value written is a valid `T`, therefore
>> >> >> > conceptually atomic_add() below writes a valid `T` in form of `T=
::Repr`
>> >> >> > into `a`.
>> >> >>=20
>> >> >> I see, my interpretation was that if we put it on the cast, then t=
he
>> >> >> operation that `atomic_add` does also is valid.
>> >> >>=20
>> >> >> But I think this comment should either be part of the `CAST` or th=
e
>> >> >> `SAFETY` comment. Going by your interpretation, it would make more=
 sense
>> >> >> in the SAFETY one, since there you justify that you're actually wr=
iting
>> >> >> a value of type `T`.
>> >> >>=20
>> >> >
>> >> > Hmm.. you're probably right. There are two safety things about
>> >> > atomic_add():
>> >> >
>> >> > - Whether calling it is safe
>> >> > - Whether the operation on `a` (a pointer to `T` essentially) is sa=
fe.
>> >>=20
>> >> Well part of calling `T::Repr::atomic_add` is that the pointer is val=
id.
>> >
>> > Here by saying "calling `T::Repr::atomic_add`", I think you mean the
>> > whole operation, so yeah, we have to consider the validy for `T` of th=
e
>> > result.
>>=20
>> I meant just the call to `atomic_add`.
>>=20
>> > But what I'm trying to do is reasoning this in 2 steps:
>> >
>> > First, let's treat it as an `atomic_add(*mut i32, i32)`, then as long =
as
>> > we provide a valid `*mut i32`, it's safe to call.=20
>>=20
>> But the thing is, we're not supplying a valid `*mut i32`. Because the
>> pointer points to a value that is not actually an `i32`. You're only
>> allowed to write certain values and so you basically have to treat it as
>> a transmute + write. And so you need to include a justification for this
>> transmute in the write itself.=20
>>=20
>> For example, if we had `bool: AllowAtomic`, then writing a `2` in store
>> would be insta-UB, since we then have a `&UnsafeCell<bool>` pointing at
>> `2`.
>>=20
>> This is part of library vs language UB, writing `2` into a bool and
>> having a reference is language-UB (ie instant UB) and writing a `2` into
>> a variable of type `i32` that is somewhere cast to `bool` is library-UB
>> (since it will lead to language-UB later).=20
>>=20
>
> But we are not writing `2` in this case, right?=20
>
> A) we have a pointer `*mut i32`, and the memory location is valid for
>    writing an `i32`, so we can pass it to a function that may write
>    an `i32` to it.
>
> B) and at the same time, we prove that the value written was a valid
>    `bool`.
>
> There is no `2` written in the whole process, the proof contains two
> parts, that is it. There is no language-UB or library-UB in the whole
> process, and you're missing it.

There is no UB here and the public API surface is sound.

The problem is the internal safe <-> unsafe code interaction & the
safety documentation.

> It's like if you want to prove 3 < x < 5, you first prove that x > 3
> and then x < 5. It's just that you don't prove it in one go.

That's true, but not analogous to this case. This is a better analogy:

You have a lemma that proves P given that x =3D=3D 10. Now you want to use
this lemma, but you are only able to prove that x >=3D 10. You argue that
this is fine, because the proof of the lemma only uses the fact that
x >=3D 10.
    But in this situation you're not following the exact rules of the
formal system. To do that you would have to reformulate the lemma to
only ask for x >=3D 10.

The last part is what relaxing the safety requirements would be
(approach (2) given below).

>> The safety comments become simpler when you use `UnsafeCell<T::Repr>`
>> instead :) since that changes this language-UB into library-UB. (the
>> only safety comment that is more complex then is `get_mut`, but that's
>> only a single one)
>>=20
>> If you don't want that, then we can solve this in two ways:
>>=20
>> (1) add a guarantee on `atomic_add` (and all other operations) that it
>>     will write `*a + v` to `a` and nothing else.
>> (2) make the safety requirement only require writes of the addition to
>>     be valid.
>>=20
>> My preference precedence is: use `T::Repr`, (2) and finally (1). (2)
>> will be very wordy on all operations & the safety comments in this file,
>> but it's clean from a formal perspective. (1) works by saying "what
>> we're supplying is actually not a valid `*mut i32`, but since the
>> guarantee of the function ensures that only specific things are written,
>> it's fine" which isn't very clean. And the `T::Repr` approach avoids all
>> this by just storing value of `T::Repr` circumventing the whole issue.
>> Then we only need to justify why we can point a `&mut T` at it and that
>> we can do by having an invariant that should be simple to keep.
>>=20
>> We probably should talk about this in our meeting :)
>>=20
>
> I have a better solution:
>
> in ops.rs
>
>     pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>)
>
>     impl AtomicArithmeticOps for i32 {
>         // a *safe* function
>         fn atomic_add(a: &AtomicRepr, v: i32) {
> 	    ...
> 	}
>     }
>
> in generic.rs
>
>     pub struct Atomic<T>(AtoimcRepr<T::Repr>);
>
>     impl<T: AtomicAdd> Atomic<T> {
>         fn add(&self, v: .., ...) {
> 	    T::Repr::atomic_add(&self.0, ...);
> 	}
>     }
>
> see:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=
=3Drust-atomic-impl

Hmm what does the additional indirection give you?

Otherwise this looks like the `T::Repr` approach that I detailed above,
so I like it :)

---
Cheers,
Benno

