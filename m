Return-Path: <linux-arch+bounces-12681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346DB02440
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 21:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A38216A055
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 19:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627A2ED152;
	Fri, 11 Jul 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djdm+9iE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5579A5FDA7;
	Fri, 11 Jul 2025 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752260893; cv=none; b=CN0fx/9hCbuZzjlUSO1/MJAW4c81uki4uDaAUFq0LzpqaZ/GD6rPIrptrYRR5k94aEnbk/RKuEJgxWp8R7jCmrqlP0iKoOmJZ3Td7K24OkWCa0Oj30dZ1KHnFMSI8+yvV5YGTVQcmBRt2MHawu//OyJelkFyS24NLxeXdIC3IFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752260893; c=relaxed/simple;
	bh=0s7VJf+TVitAdyUjPCU9a8WPEAfAzRJf511iXXIdi68=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dZGslIZhP6gq2UTrgbcBGgSgRrnDUkWRBsU9PCgKmRBdXN4+6M/ka7xLZZLZD2r1lWpx1GVr4yy5rdnSI1wQq6cgfg+twfhOpRMh+CCtQJKGSykx+IQ+r2NGmNt9u+HRILByI8V/xxRCVHrq4ZeSDtqX07PBRDyxLXUDgDqdsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djdm+9iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F74C4CEED;
	Fri, 11 Jul 2025 19:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752260892;
	bh=0s7VJf+TVitAdyUjPCU9a8WPEAfAzRJf511iXXIdi68=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=djdm+9iEBCik9vSS3i4x0wplQTA4YslSO977pHx6rIZELGqrsysQ2LDqah8Q3DMCj
	 tVyhfcqCiZn1jwtd4Gr7GHVEzR1Ce2r/7EOXIZTBWyTNH+03t8dpMnUeBpOPylrUJx
	 421xwnO0GeCGx/aCLWX8TQhF49Y6UHbdUBrF7hWTFw5F4bjLHE3d8DSgOfm1Up7Ml2
	 H/G6YE5DJJoFuVIf+tI+8eGptgJgCczH33o273Tmz+pXvCeLUmVxu/jE2vbG0eqY7B
	 jiqXp0GORVFW+rIOlGsZP2S/0Hponi+fN/kQP529BkZXYGlK3ae37y3X7F1Vtb3aCw
	 rLy6Bzm/Pplig==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 21:07:57 +0200
Message-Id: <DB9GN29XXLPS.3L31JLBDSSDXS@kernel.org>
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
 <aHFMwB-aL7Lj_twN@tardis-2.local>
In-Reply-To: <aHFMwB-aL7Lj_twN@tardis-2.local>

On Fri Jul 11, 2025 at 7:41 PM CEST, Boqun Feng wrote:
> On Fri, Jul 11, 2025 at 07:39:15AM -0700, Boqun Feng wrote:
> [...]
>> > > ---
>> > >  rust/kernel/sync/atomic.rs         |  18 +++++
>> > >  rust/kernel/sync/atomic/generic.rs | 108 ++++++++++++++++++++++++++=
+++
>> > >  2 files changed, 126 insertions(+)
>> >=20
>> > I think it's better to name this trait `AtomicAdd` and make it generic=
:
>> >=20
>> >     pub unsafe trait AtomicAdd<Rhs =3D Self>: AllowAtomic {
>> >         fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
>> >     }
>> >=20
>> > `sub` and `fetch_sub` can be added using a similar trait.
>> >=20
>>=20
>> Seems a good idea, I will see what I can do. Thanks!
>>=20
>> > The generic allows you to implement it multiple times with different
>> > meanings, for example:
>> >=20
>> >     pub struct Nanos(u64);
>> >     pub struct Micros(u64);
>> >     pub struct Millis(u64);
>> >=20
>> >     impl AllowAtomic for Nanos {
>> >         type Repr =3D i64;
>> >     }
>> >=20
>> >     impl AtomicAdd<Millis> for Nanos {
>> >         fn rhs_into_repr(rhs: Millis) -> i64 {
>> >             transmute(rhs.0 * 1000_000)
>>=20
>> We probably want to use `as` in real code?
>>=20
>> >         }
>> >     }
>> >=20
>> >     impl AtomicAdd<Micros> for Nanos {
>> >         fn rhs_into_repr(rhs: Micros) -> i64 {
>> >             transmute(rhs.0 * 1000)
>> >         }
>> >     }
>> >=20
>> >     impl AtomicAdd<Nanos> for Nanos {
>> >         fn rhs_into_repr(rhs: Nanos) -> i64 {
>> >             transmute(rhs.0)
>> >         }
>> >     }
>> >=20
>> > For the safety requirement on the `AtomicAdd` trait, we might just
>> > require bi-directional transmutability... Or can you imagine a case
>> > where that is not guaranteed, but a weaker form is?
>>=20
>> I have a case that I don't think it's that useful, but it's similar to
>> the `Micros` and `Millis` above, an `Even<T>` where `Even<i32>` is a
>
> Oh I mis-read, it's not similar to `Micros` or `Millis`, but still,
> `Even<i32>` itself should have the point.
>
>> `i32` but it's always an even number ;-) So transmute<i32, Even<i32>>()
>> is not always sound. Maybe we could add a "TODO" in the safety section
>> of `AtomicAdd`, and revisit this later? Like:
>>=20
>> /// (in # Safety)
>> /// TODO: The safety requirement may be tightened to bi-directional
>> /// transmutability.=20
>>=20
>> And maybe also add the `Even` example there?
>>=20
>> Thoughts?
>>=20
>
> Or since we are going to use fine-grained traits, it's actually easy to
> define the safety requirement of `AtomicAdd` (instead of
> `AllowAtomicArithmetic) now:
>
>     /// # Safety
>     ///
>     /// For a `T: AtomicAdd<Rhs>`, the addition result of a valid bit
>     /// pattern of `T` and a `T::Repr` convert from `rhs_into_repr()` sho=
uld
>     /// be a valid bit pattern of `T`.

Let's combine our two safety requirement ideas (I forgot about my Rhs
change).

---
Cheers,
Benno

>     pub unsafe trait AtomicAdd<Rhs =3D Self>: AllowAtomic {
>        fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
>     }
>
> Thoughts?
>
> Regards,
> Boqun


