Return-Path: <linux-arch+bounces-12576-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA603AF9EFC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 10:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49531189FFE3
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 08:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2357B27381B;
	Sat,  5 Jul 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo0fd4s5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493C26CE21;
	Sat,  5 Jul 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751702652; cv=none; b=KokvcGeid0vCuFpA0JnsE36NhigsJA6hawzCI1IGVReuo8bI4dvOxl7r+fh1KADtLqFquVj2eDdkKsQmKV87sBZVVADEfoJSlgtfTduI9HqejBtCoFJF/vNmRWm7n8HDGl7KtHO+ooqvmePwz2BVhsVK8kzpNHmUczDkdiYfh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751702652; c=relaxed/simple;
	bh=hjqxLW+6zaIDAMkFuFqYlRa/pAYfVX2EP7QP35RoaRk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=llqUStnKjbKP01HLlOdg46J67RpqYZ6RcMn26WzbxWapb3zOz9N6SMHRrSeMbZ96bcgYvDp+H9vvS6EfShVyfN7/V6K58qCBR3oi6pzt2gHC9Pv2BIe4XKbhqoMnL8H5FCbH5iiq8rtCLmhPjjSEEWTM8ZmlTohrUd04uBMkPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo0fd4s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBD2C4CEE7;
	Sat,  5 Jul 2025 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751702651;
	bh=hjqxLW+6zaIDAMkFuFqYlRa/pAYfVX2EP7QP35RoaRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bo0fd4s5G5LQ8U4f1mCg4SSfOz/umJz5KDpQoD40okSaurUC4WHv2qIL1U5ULhk2Q
	 TMhfHy1DsbYVZJI1h97cEbwajKrMkAhD/W9ZsqkWUq1aCY31wL7T37Y2RvRvVog7fg
	 9+tire7gfBEpj68z5f6gkNebkbZO90bHSg70mhTB2PbXwoc1cXo5pKFOfjMLS0mbVP
	 upkbV3HWrGGts2GQBfH+yW/15HVyjVMtavgoc1+KL2jfmKy3oBqXfGd4IDMW4wWI6z
	 Obv1pevn9CPwz40WL+4DoRpUMMylkWHpNw0/L0xJrCDm4MP0vyK6CWeKT9AnIc7vor
	 tTp0phV9ScfEQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 10:04:04 +0200
Message-Id: <DB3YRHR9RN8Z.29926G08T7KZ0@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Gary Guo" <gary@garyguo.net>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home> <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
 <aGhFAlpOZJaLNekS@Mac.home> <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org>
 <aGhiEZ4uNzEs4nah@Mac.home>
In-Reply-To: <aGhiEZ4uNzEs4nah@Mac.home>

On Sat Jul 5, 2025 at 1:21 AM CEST, Boqun Feng wrote:
> On Sat, Jul 05, 2025 at 12:38:05AM +0200, Benno Lossin wrote:
> [..]
>> >> >   (This is not a safety requirement)
>> >> >
>> >> >   from_repr() and into_repr(), if exist, should behave like transmu=
te()
>> >> >   on the bit pattern of the results, in other words, bit patterns o=
f `T`
>> >> >   or `T::Repr` should stay the same before and after these operatio=
ns.
>> >> >
>> >> >   Of course if we remove them and replace with transmute(), same re=
sult.
>> >> >
>> >> >   This reflects the fact that customized atomic types should store
>> >> >   unmodified bit patterns into atomic variables, and this make atom=
ic
>> >> >   operations don't have weird behavior [1] when combined with new()=
,
>> >> >   from_ptr() and get_mut().
>> >>=20
>> >> I remember that this was required to support types like `(u8, u16)`? =
If
>> >
>> > My bad, I forgot to put the link to [1]...
>> >
>> > [1]: https://lore.kernel.org/rust-for-linux/20250621123212.66fb016b.ga=
ry@garyguo.net/
>> >
>> > Basically, without requiring from_repr() and into_repr() to act as a
>> > transmute(), you can have weird types in Atomic<T>.
>>=20
>> Ah right, I forgot some context... Is this really a problem? I mean it's
>
> It's not a problem for safety, so it's not a safety requirement. But I
> really don't see a reason why we want to support this. Not supporting
> this makes the atomic implementation reasoning easier.

Yeah.

>> weird sure, but if someone needs this, then it's fine?
>>=20
>
> They can always play the !value game outside atomic, i.e. !value before
> store and !value after load, so I don't think it's reasonable request.

That's true, yeah let's forbid this :)

>> > `(u8, u16)` (in case it's not clear to other audience, it's tuple with=
 a
>> > `u8` and a `u16` in it, so there is a 8-bit hole) is not going to
>> > support until we have something like a `Atomic<MaybeUninit<i32>>`.
>>=20
>> Ahh right we also had this issue, could you also include that in your
>> writeup? :)
>>=20
>
> Sure, I will put it in a limitation section maybe.
>
>> >> yes, then it would be good to include a paragraph like the one above =
for
>> >> enums :)
>> >>=20
>> >> > * Provenance preservation.
>> >> >
>> >> >   (This is not a safety requirement for Atomic itself)
>> >> >
>> >> >   For a `Atomic<*mut T>`, it should preserve the provenance of the
>> >> >   pointer that has been stored into it, i.e. the load result from a
>> >> >   `Atomic<*mut T>` should have the same provenance.
>> >> >
>> >> >   Technically, without this, `Atomic<*mut T>` still work without an=
y
>> >> >   safety issue itself, but the user of it must maintain the provena=
nce
>> >> >   themselves before store or after load.
>> >> >
>> >> >   And it turns out it's not very hard to prove the current
>> >> >   implementation achieve this:
>> >> >
>> >> >   - For a non-atomic operation done on the atomic variable, they ar=
e
>> >> >     already using pointer operation, so the provenance has been
>> >> >     preserved.
>> >> >   - For an atomic operation, since they are done via inline asm cod=
e, in
>> >> >     Rust's abstract machine, they can be treated as pointer read an=
d
>> >> >     write:
>> >> >
>> >> >     a) A load of the atomic can be treated as a pointer read and th=
en
>> >> >        exposing the provenance.
>> >> >     b) A store of the atomic can be treated as a pointer write with=
 a
>> >> >        value created with the exposed provenance.
>> >> >
>> >> >     And our implementation, thanks to no arbitrary type coercion,
>> >> >     already guarantee that for each a) there is a from_repr() after=
 and
>> >> >     for each b) there is a into_repr() before. And from_repr() acts=
 as
>> >> >     a with_exposed_provenance() and into_repr() acts as a
>> >> >     expose_provenance(). Hence the provenance is preserved.
>> >>=20
>> >> I'm not sure this point is correct, but I'm an atomics noob, so maybe
>> >> Gary should take a look at this :)
>> >>=20
>> >
>> > Basically, what I'm trying to prove is that we can have a provenance-
>> > preserved Atomic<*mut T> implementation based on the C atomics. Either
>> > that is true, or we should write our own atomic pointer implementation=
.
>>=20
>> That much I remembered :) But since you were going into the specifics
>> above, I think we should try to be correct. But maybe natural language
>> is the wrong medium for that, just write the rust code and we'll see...
>>=20
>
> I don't thinking writing rust code can help us here other than duplicate
> my reasoning above, so like:
>
>     ipml *mut() {
>         pub fn xchg(ptr: *mut *mut (), new: *mut ()) -> *mut () {
> 	    // SAFTEY: ..
> 	    // `atomic_long_xchg()` is implemented as asm(), so it can
> 	    // be treated as a normal pointer swap() hence preserve the
> 	    // provenance.

Oh I think Gary was talking specifically about Rust's `asm!`. I don't
know if C asm is going to play the same way... (inside LLVM they
probably are the same thing, but in the abstract machine?)

> 	    unsafe { atomic_long_xchg(ptr.cast::<atomic_long_t>(), new as ffi:c_=
long) }
> 	}
>
>         pub fn cmpxchg(ptr: *mut *mut (), old: *mut (), new: *mut ()) -> =
*mut () {
> 	    // SAFTEY: ..
> 	    // `atomic_long_xchg()` is implemented as asm(), so it can
> 	    // be treated as a normal pointer compare_exchange() hence preserve =
the
> 	    // provenance.
> 	    unsafe { atomic_long_cmpxchg(ptr.cast::<atomic_long_t>(), old as ffi=
::c_long, new as ffi:c_long) }
> 	}
>
> 	<do it for a lot of functions>
>     }
>
> So I don't think that approach is worth doing. Again the provenance
> preserving is a global property, either we have it as whole or we don't
> have it, and adding precise comment of each function call won't change
> the result. I don't see much difference between reasoning about a set of
> functions vs. reasoning one function by one function with the same
> reasoning.
>
> If we have a reason to believe that C atomic doesn't support this we
> just need to move to our own implementation. I know you (and probably
> Gary) may feel the reasoning about provenance preserving a bit handwavy,

YES :)

> but this is probably the best we can get, and it's technically better

I think we can at improve the safety docs situation.

> than using Rust native atomics, because that's just UB and no one would
> help you.

I'm not arguing using those :)

> (I made a copy-pasta on purpose above, just to make another point why
> writing each function out is not worth)

Yeah that's true, but at the moment that safety comment is on the `impl`
block? I don't think that's the right place...

---
Cheers,
Benno

