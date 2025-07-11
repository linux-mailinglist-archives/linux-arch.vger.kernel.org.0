Return-Path: <linux-arch+bounces-12678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD7B02430
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 20:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68DAEB433D9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E1A1DE3C8;
	Fri, 11 Jul 2025 18:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHhW8EFc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150201D8E07;
	Fri, 11 Jul 2025 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260150; cv=none; b=jjNnY0HazfPlD4Jjhn4sdKMnsWVNrqPcgwLOtfWSmLg/cBbyI41em6U+n20BOSgHhPPZnXP20of6d5z1FJzRP/KuybX9HRsaGi6vRhlkeHjp8cFtmclwiPKB6LnOMuPfnMrSy7r2u6oTHHopk5OotcNA1RDsa7+4vZjO/1bq8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260150; c=relaxed/simple;
	bh=+KzJx4j1V3cBO9GPt2SmbpMIiEUgVTKh/CkUNorxaeA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oCApQIjOKeBW8T9cPfIdGe6gK3jMnk1upNYkn2Hp1He8DpAhKC4ixbwkkCqJbggcLAYkHfqmC4az4gyQVCV9/X+TC/ZMnjuNUq9LohabHxMtqSoekc8DHXpyfpoHfUnc0s8xYVN0pTqlhO/fyNU+moxuiVbeaN6EY4rSpHJvIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHhW8EFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5FFC4CEED;
	Fri, 11 Jul 2025 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752260149;
	bh=+KzJx4j1V3cBO9GPt2SmbpMIiEUgVTKh/CkUNorxaeA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=GHhW8EFcIRKlJ9X8hASWH0/481dodVNzsra9/1z8p777j7JCwkoXoYLWq3WHGZJEA
	 P4uI4lJAdNve1IimuTUGrmFCvuHJH8/nioZaTBnmKt5hzzVbXHueXTO5uq+N0MGYmk
	 9+84lIS+yiCcv2YB+Rk90ltB1OtCcEyJ049+Bj5n9RzCrvUnrNm+8zbOnBQqLDgh4T
	 M044HjwOW7KOSbKGBNlyJDZFypiEwaHa4eEtCJNtlc9/iMrxWVxh9JmOLgKgkyEoIU
	 +MTMsWRXBDhSG5w8gzHFcNF6zx9jtKV+HZTRgbFmrpzIGckQJVK52CH4UeoQ8ZI1CG
	 fXh9ICrUsErHA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 20:55:42 +0200
Message-Id: <DB9GDOR3AY9B.21YFXYHE4F0MP@kernel.org>
Subject: Re: [PATCH v6 6/9] rust: sync: atomic: Add the framework of
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
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
 <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org> <aHEiE0OoA3w1FmCp@Mac.home>
In-Reply-To: <aHEiE0OoA3w1FmCp@Mac.home>

On Fri Jul 11, 2025 at 4:39 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 10:53:45AM +0200, Benno Lossin wrote:
>> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>> > One important set of atomic operations is the arithmetic operations,
>> > i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
>> > make senses for all the types that `AllowAtomic` to have arithmetic
>> > operations, for example a `Foo(u32)` may not have a reasonable add() o=
r
>> > sub(), plus subword types (`u8` and `u16`) currently don't have
>> > atomic arithmetic operations even on C side and might not have them in
>> > the future in Rust (because they are usually suboptimal on a few
>> > architecures). Therefore add a subtrait of `AllowAtomic` describing
>> > which types have and can do atomic arithemtic operations.
>> >
>> > Trait `AllowAtomicArithmetic` has an associate type `Delta` instead of
>> > using `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is
>> > `i32`) may not wants an `add(&self, i32)`, but an `add(&self, u32)`.
>> >
>> > Only add() and fetch_add() are added. The rest will be added in the
>> > future.
>> >
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> > ---
>> >  rust/kernel/sync/atomic.rs         |  18 +++++
>> >  rust/kernel/sync/atomic/generic.rs | 108 ++++++++++++++++++++++++++++=
+
>> >  2 files changed, 126 insertions(+)
>>=20
>> I think it's better to name this trait `AtomicAdd` and make it generic:
>>=20
>>     pub unsafe trait AtomicAdd<Rhs =3D Self>: AllowAtomic {
>>         fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
>>     }
>>=20
>> `sub` and `fetch_sub` can be added using a similar trait.
>>=20
>
> Seems a good idea, I will see what I can do. Thanks!
>
>> The generic allows you to implement it multiple times with different
>> meanings, for example:
>>=20
>>     pub struct Nanos(u64);
>>     pub struct Micros(u64);
>>     pub struct Millis(u64);
>>=20
>>     impl AllowAtomic for Nanos {
>>         type Repr =3D i64;

By the way, I find this a bit unfortunate... I think it would be nice to
be able to use `u64` and `u32` as reprs too.

Maybe we can add an additional trait `AtomicRepr` that gets implemented
by all integer types and then we can use that in the `Repr` instead.

This should definitely be a future patch series though.

>>     }
>>=20
>>     impl AtomicAdd<Millis> for Nanos {
>>         fn rhs_into_repr(rhs: Millis) -> i64 {
>>             transmute(rhs.0 * 1000_000)
>
> We probably want to use `as` in real code?

I thought that `as` would panic on over/underflow... But it doesn't and
indeed just converts between the two same-sized types.

By the way, should we ask for `Repr` to always be of the same size as
`Self` when implementing `AllowAtomic`?

That might already be implied from the round-trip transmutability:
* `Self` can't have a smaller size, because transmuting `Self` into
  `Repr` would result in uninit bytes.
* `Repr` can't have a smaller size, because then transmuting a `Repr`
  (that was once a `Self`) back into `Self` will result in uninit bytes

We probably should mention this in the docs somewhere?

>>         }
>>     }
>>=20
>>     impl AtomicAdd<Micros> for Nanos {
>>         fn rhs_into_repr(rhs: Micros) -> i64 {
>>             transmute(rhs.0 * 1000)
>>         }
>>     }
>>=20
>>     impl AtomicAdd<Nanos> for Nanos {
>>         fn rhs_into_repr(rhs: Nanos) -> i64 {
>>             transmute(rhs.0)
>>         }
>>     }
>>=20
>> For the safety requirement on the `AtomicAdd` trait, we might just
>> require bi-directional transmutability... Or can you imagine a case
>> where that is not guaranteed, but a weaker form is?
>
> I have a case that I don't think it's that useful, but it's similar to
> the `Micros` and `Millis` above, an `Even<T>` where `Even<i32>` is a
> `i32` but it's always an even number ;-) So transmute<i32, Even<i32>>()
> is not always sound. Maybe we could add a "TODO" in the safety section
> of `AtomicAdd`, and revisit this later? Like:
>
> /// (in # Safety)
> /// TODO: The safety requirement may be tightened to bi-directional
> /// transmutability.=20
>
> And maybe also add the `Even` example there?

Ahh that's interesting... I don't think the comment in the tightening
direction makes sense, either we start out with bi-directional
transmutability, or we don't do it at all.

I think an `Even` example is motivation enough to have it. So let's not
tighten it. But I think we should improve the safety requirement:

    /// The valid bit patterns of `Self` must be a superset of the bit patt=
erns reachable through
    /// addition on any values of type [`Self::Repr`] obtained by transmuti=
ng values of type `Self`.

or
   =20
    /// Adding any two values of type [`Self::Repr`] obtained through trans=
muting values of type `Self`
    /// must yield a value with a bit pattern also valid for `Self`.

I feel like the second one sounds better.

Also is overflowing an atomic variable UB in LKMM? Because if it is,
then `struct MultipleOf<const M: u64>(u64)` is also something that would
be supported. Otherwise only powers of two would be supported.

---
Cheers,
Benno

