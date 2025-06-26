Return-Path: <linux-arch+bounces-12471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7238AE9F71
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCDD166E02
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341C72E1C7E;
	Thu, 26 Jun 2025 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZVtjbxY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036611922F6;
	Thu, 26 Jun 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946073; cv=none; b=VmssgL4lRIj04Jfo8UB2Do2TAPnx4vQeLeON838heUZxpqTQRscCmvym9eiiKhKdYuTFY87wfrFTNUP/1fZ0MScjPcoRdFgpyfM4VHFCRSlTbYJqKXCFymsqWMfgThKI/eUa1/1X3lx1F7jiMsBXtE4YrkYJTI//D+pFKtKdH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946073; c=relaxed/simple;
	bh=vGdG2KgJYgg71pcFHeAXtJsfxhvB+yb6bY/1UFHNcP0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=up1QpF//ceIvJRmv5CQHBdGQFmUkujMLCsLih9aplS0rERV+iP6Mqni625YfTKSahzZCBPJaHIJUsyP95k4jW3fHi1Izp93T9AkvE+MCsc8+6tArM4jyPsF3Bt8fICkxpjuxxzyagKUqE+cTqSHSS/ol0SwbyvRMP6pzea2A4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZVtjbxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A5DC4CEEB;
	Thu, 26 Jun 2025 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750946071;
	bh=vGdG2KgJYgg71pcFHeAXtJsfxhvB+yb6bY/1UFHNcP0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aZVtjbxYUppazWi1Kl594qJXtIKAnKuxBWJ2ttOrO9rnEChu7QJl6OOOn8JbpISGD
	 Pe4wkh6UlZLXWeXcgC7EaUdmZR5JMcWiUqCS9gjqPn6QhqD0uRcH3IjKXuZvu68rUx
	 EF3gyLORB9Guw5UGEBBymx/sOZ7IAYOTgncWrNey7SLvhGSxFalRWdfukConx1xeva
	 Slnhow1Tq5YGBV7Mj3Q6GyL2c8T0Za1V6wvifA3V9yx+v4fAWHR1+luRN3LRosukVx
	 YX5q/7xRK2LWSbnmNbl947p94BnyPxEtPWm17y11aQIPHWKDaA/TDthtD4LjlXLhf6
	 MMWENojMgUqhg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:54:24 +0200
Message-Id: <DAWIKTODZ3FT.2LGX1H8ZFDONN@kernel.org>
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
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org> <aFrTyXcFVOjWa2o-@Mac.home>
In-Reply-To: <aFrTyXcFVOjWa2o-@Mac.home>

On Tue Jun 24, 2025 at 6:35 PM CEST, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 01:27:38AM +0200, Benno Lossin wrote:
>> On Mon Jun 23, 2025 at 9:09 PM CEST, Boqun Feng wrote:
>> > On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
>> >> cannot just transmute between from pointers to usize (which is its
>> >> Repr):
>> >> * Transmuting from pointer to usize discards provenance
>> >> * Transmuting from usize to pointer gives invalid provenance
>> >>=20
>> >> We want neither behaviour, so we must store `usize` directly and
>> >> always call into repr functions.
>> >>=20
>> >
>> > If we store `usize`, how can we support the `get_mut()` then? E.g.
>> >
>> >     static V: i32 =3D 32;
>> >
>> >     let mut x =3D Atomic::new(&V as *const i32 as *mut i32);
>> >     // ^ assume we expose_provenance() in new().
>> >
>> >     let ptr: &mut *mut i32 =3D x.get_mut(); // which is `&mut self.0.g=
et()`.
>> >
>> >     let ptr_val =3D *ptr; // Does `ptr_val` have the proper provenance=
?
>>=20
>> If `get_mut` transmutes the integer into a pointer, then it will have
>> the wrong provenance (it will just have plain invalid provenance).
>>=20
>
> The key topic Gary and I have been discussing is whether we should
> define Atomic<T> as:
>
> (my current implementation)
>
>     pub struct Atomic<T: AllowAtomic>(Opaque<T>);
>
> or
>
> (Gary's suggestion)
>
>     pub struct Atomic<T: AllowAtomic>(Opaque<T::Repr>);
>
> `T::Repr` is guaranteed to be the same size and alignment of `T`, and
> per our discussion, it makes sense to further require that `transmute<T,
> T::Repr>()` should also be safe (as the safety requirement of
> `AllowAtomic`), or we can say `T` bit validity can be preserved by
> `T::Repr`: a valid bit combination `T` can be transumated to `T::Repr`,
> and if transumated back, it's the same bit combination.
>
> Now as I pointed out, if we use `Opaque<T::Repr>`, then `.get_mut()`
> would be unsound for `Atomic<*mut T>`. And Gary's concern is that in
> the current implementation, we directly cast a `*mut T` (from
> `Opaque::get()`) into a `*mut T::Repr`, and pass it directly into C/asm
> atomic primitives. However, I think with the additional safety
> requirement above, this shouldn't be a problem: because the C/asm atomic
> primitives would just pass the address to an asm block, and that'll be
> out of Rust abstract machine, and as long as the C/primitives atomic
> primitives are implemented correctly, the bit representation of `T`
> remains valid after asm blocks.
>
> So I think the current implementation still works and is better.

I don't think there is a big difference between=C2=A0`Opaque<T>`=C2=A0and
`Opaque<T::Repr>`=C2=A0if we have the transmute equivalence between the two=
.
From a safety perspective, you don't gain or lose anything by using the
first over the second one. They both require the invariant that they are
valid (as=C2=A0`Opaque`=C2=A0removes that... we should really be using
`UnsafeCell`=C2=A0here instead... why aren't we doing that?).

Where their differences do play a role is in the implementation of the
various operations on the atomic. If you need to pass=C2=A0`*mut T::Repr`=
=C2=A0to
the C side, it's better if you store=C2=A0`Opaque<T::Repr>`=C2=A0and if you=
 want
to give=C2=A0`&mut T`=C2=A0back to the user, then it's better to
store=C2=A0`Opaque<T>`.

I would choose the one that results in overall less code. It's probably
going to be=C2=A0`Opaque<T::Repr>`, since we will have more operations that
need=C2=A0`*mut T::Repr`=C2=A0than=C2=A0`*mut T`.

Now I don't understand why you value=C2=A0`Opaque<T>`=C2=A0over=C2=A0`Opaqu=
e<T::Repr>`,
they are (up to transmute-equivalence) the same.

I think that you said at one point that=C2=A0`Opaque<T>`=C2=A0makes more se=
nse
from a conceptual view, since we're building=C2=A0`Atomic<T>`. I think that
doesn't really matter, since it's implementation detail. The same
argument could be made about casing=C2=A0`u64`=C2=A0to=C2=A0`i64`=C2=A0for =
implementing the
atomics: just implement atomics in C also for=C2=A0`u64`=C2=A0and then use =
that
instead...

---
Cheers,
Benno

