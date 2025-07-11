Return-Path: <linux-arch+bounces-12713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C502DB02616
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 23:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6794A6817
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2F1DE3CB;
	Fri, 11 Jul 2025 21:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itdAQMro"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3A1B414E;
	Fri, 11 Jul 2025 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267811; cv=none; b=ZjSk9w27Etrdnz78hRFJwS4VhdXRKhZQ8bQwrhbKQVAmMYf2ZLMD1AzNNyUdujXCtWEPwfSBIQ3TLRF9ROQzBXjlKxngURh7q5tXbVp9/sPlZeRhhjgDHVzbrXt4vg4DzU/7utPHX61qsmPEWsb+482gud8Vdt7buuJEWFar+QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267811; c=relaxed/simple;
	bh=prI0zZuePLEepZXdZDCkqpsQHiKrXP2PCHAIHJP99RU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pxlpeWYM6IQTdO7CeHRvuqiPlNyMGCoCyIa6IRc4c9KLHqmQX4Fwq8NyItPVmyIy6HrMKI81GwHvUQW0HCLb6jZvoZTZB/Iay/LB9RqHdNk2Zraq0ZR+4Qn1rkRfNguDjSXUlncM/xqVNx3hJqhX4FProPhmy/ExAxcxhAzRv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itdAQMro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC55C4CEED;
	Fri, 11 Jul 2025 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752267810;
	bh=prI0zZuePLEepZXdZDCkqpsQHiKrXP2PCHAIHJP99RU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=itdAQMroJjVZr6E8zOxBvILp6TxFoGyXJZstge/MW3qjOZb4C6dEpFMG6xrqw37NP
	 cGT8YM9BnryAIK4iOsmNUcQkECbBY1xVgJNmrdgaQ0bUEamGTJLZK3clQh6F+eFnlt
	 3j/s10dXS00ojyMn7NadfaAGsEYzQG6/2h0Ao0vvJ8rtlLxXt7CKGmN6daSCH6NVDX
	 FZPkiOZ1RofG8qypQPsODNYBjUioIYYHDZUwJ1bmvIL2r70dWzOl2hDozD8OEDN41U
	 FUm2TJBg8i9YUO5FbdbanCHvs3za4VLCPUBbyoOIAteuE/sRJnKVlU/BoEPT3pVgAw
	 sj0s5kpNRLLhA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 23:03:24 +0200
Message-Id: <DB9J3GBDB2UK.2OHWT5AI5DXFD@kernel.org>
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
Subject: Re: [PATCH v6 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org> <aHEiE0OoA3w1FmCp@Mac.home>
 <DB9GDOR3AY9B.21YFXYHE4F0MP@kernel.org> <aHFrUa3VWaKTe0xr@tardis-2.local>
In-Reply-To: <aHFrUa3VWaKTe0xr@tardis-2.local>

On Fri Jul 11, 2025 at 9:51 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 08:55:42PM +0200, Benno Lossin wrote:
> [...]
>> >> The generic allows you to implement it multiple times with different
>> >> meanings, for example:
>> >>=20
>> >>     pub struct Nanos(u64);
>> >>     pub struct Micros(u64);
>> >>     pub struct Millis(u64);
>> >>=20
>> >>     impl AllowAtomic for Nanos {
>> >>         type Repr =3D i64;
>>=20
>> By the way, I find this a bit unfortunate... I think it would be nice to
>> be able to use `u64` and `u32` as reprs too.
>>=20
>
> I don't think that's necessary, because actually a MaybeUninit<i32> and=
=20
> MaybeUninit<i64> would cover all the cases, and even with `u64` and
> `u32` being reprs, you still need to trasmute somewhere for non integer
> types. But I'm also open to support them, let's discuss this later
> separately ;-)

I think it just looks weird for me to build a type that contains a `u64`
and then not being able to choose that as the repr...

>> Maybe we can add an additional trait `AtomicRepr` that gets implemented
>> by all integer types and then we can use that in the `Repr` instead.
>>=20
>> This should definitely be a future patch series though.
>>=20
>> >>     }
>> >>=20
>> >>     impl AtomicAdd<Millis> for Nanos {
>> >>         fn rhs_into_repr(rhs: Millis) -> i64 {
>> >>             transmute(rhs.0 * 1000_000)
>> >
>> > We probably want to use `as` in real code?
>>=20
>> I thought that `as` would panic on over/underflow... But it doesn't and
>> indeed just converts between the two same-sized types.
>>=20
>> By the way, should we ask for `Repr` to always be of the same size as
>> `Self` when implementing `AllowAtomic`?
>>=20
>> That might already be implied from the round-trip transmutability:
>> * `Self` can't have a smaller size, because transmuting `Self` into
>>   `Repr` would result in uninit bytes.
>> * `Repr` can't have a smaller size, because then transmuting a `Repr`
>>   (that was once a `Self`) back into `Self` will result in uninit bytes
>>=20
>> We probably should mention this in the docs somewhere?
>>=20
>
> We have it already as the first safety requirement of `AllowAtomic`:
>
> /// # Safety
> ///
> /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
>
> Actually at the beginning, I missed the round-trip transmutablity
> (thanks to you and Gary for bring that up), that's only safe requirement
> I thought I needed ;-)

So technically we only need round-trip transmutablity & same alignment
(as size is implied as shown above), but I think it's much more
understandable if we keep it.

>> >>         }
>> >>     }
>> >>=20
>> >>     impl AtomicAdd<Micros> for Nanos {
>> >>         fn rhs_into_repr(rhs: Micros) -> i64 {
>> >>             transmute(rhs.0 * 1000)
>> >>         }
>> >>     }
>> >>=20
>> >>     impl AtomicAdd<Nanos> for Nanos {
>> >>         fn rhs_into_repr(rhs: Nanos) -> i64 {
>> >>             transmute(rhs.0)
>> >>         }
>> >>     }
>> >>=20
>> >> For the safety requirement on the `AtomicAdd` trait, we might just
>> >> require bi-directional transmutability... Or can you imagine a case
>> >> where that is not guaranteed, but a weaker form is?
>> >
>> > I have a case that I don't think it's that useful, but it's similar to
>> > the `Micros` and `Millis` above, an `Even<T>` where `Even<i32>` is a
>> > `i32` but it's always an even number ;-) So transmute<i32, Even<i32>>(=
)
>> > is not always sound. Maybe we could add a "TODO" in the safety section
>> > of `AtomicAdd`, and revisit this later? Like:
>> >
>> > /// (in # Safety)
>> > /// TODO: The safety requirement may be tightened to bi-directional
>> > /// transmutability.=20
>> >
>> > And maybe also add the `Even` example there?
>>=20
>> Ahh that's interesting... I don't think the comment in the tightening
>> direction makes sense, either we start out with bi-directional
>> transmutability, or we don't do it at all.
>>=20
>> I think an `Even` example is motivation enough to have it. So let's not
>> tighten it. But I think we should improve the safety requirement:
>>=20
>>     /// The valid bit patterns of `Self` must be a superset of the bit p=
atterns reachable through
>>     /// addition on any values of type [`Self::Repr`] obtained by transm=
uting values of type `Self`.
>>=20
>> or
>>    =20
>>     /// Adding any two values of type [`Self::Repr`] obtained through tr=
ansmuting values of type `Self`
>>     /// must yield a value with a bit pattern also valid for `Self`.
>>=20
>> I feel like the second one sounds better.
>>=20
>
> Me too! Let's use it then. Combining with your `AtomicAdd<Rhs>`
> proposal:
>
>     /// # Safety
>     ///
>     /// Adding any:
>     /// - one being the value of [`Self::Repr`] obtained through transmut=
ing value of type `Self`,
>     /// - the other being the value of [`Self::Delta`] obtained through c=
onversion of `rhs_into_delta()`,
>     /// must yield a value with a bit pattern also valid for `Self`.

I think this will render wrongly in markdown & we shouldn't use a list,
so how about:

    /// Adding any value of type [`Self::Delta`] obtained by [`Self::rhs_in=
to_delta`] to any value of
    /// type [`Self::Repr`] obtained through transmuting a value of type `S=
elf` to must yield a value
    /// with a bit pattern also valid for `Self`.

My only gripe with this is that "Adding" isn't really well-defined...

>     pub unsafe trait AtomicAdd<Rhs>: AllowAtomic {
>         type Delta =3D Self::Repr;
>         fn rhs_into_delta(rhs: Rhs) -> Delta;
>     }
>
> Note that I have to provide a `Delta` (or better named as `ReprDelta`?)
> because of when pointer support is added, atomic addition is between
> a `*mut ()` and a `isize`, not two `*mut()`.

Makes sense, but we don't have default associated types yet :(

>> Also is overflowing an atomic variable UB in LKMM? Because if it is,
>
> No, all atomic arithmetic operations are wrapping, I did add a comment
> in Atomic::add() and Atomic::fetch_add() saying that. This also aligns
> with Rust std atomic behaviors.

Apparently I didn't read your docs very well :)

>> then `struct MultipleOf<const M: u64>(u64)` is also something that would
>> be supported. Otherwise only powers of two would be supported.
>
> Yeah, seems we can only support PowerOfTwo<integer>.
>
> (but technically you can detect overflow for those value-returning
> atomics, but let's think about that later if there is a user)

Yeah, I doubt that a real use-case will pop up soon.

---
Cheers,
Benno

