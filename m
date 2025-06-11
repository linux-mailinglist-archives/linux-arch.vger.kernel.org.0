Return-Path: <linux-arch+bounces-12328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8AAD4BED
	for <lists+linux-arch@lfdr.de>; Wed, 11 Jun 2025 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E3E189CF27
	for <lists+linux-arch@lfdr.de>; Wed, 11 Jun 2025 06:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9BE22A7E1;
	Wed, 11 Jun 2025 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILRmI8cM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED582576;
	Wed, 11 Jun 2025 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749624025; cv=none; b=eQ+QP8sQ8Jy/Gcbw2VQY9LwMWscs5B67wFjxVxsw/bKN6HsOYQYIlw+I1OxiQVtxv7EwMHH7iMXxtZckRoh+JD+W/Bdm6/+IcN44+mBolv27gt07RSv3jG/l7gTuPACXwNx+RSmcATDW5vI9wjS+1TtL9r1vtuFNoom1bSCwy1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749624025; c=relaxed/simple;
	bh=hTZ4O1f+yyRThvIWYmjjaVb+T8UQ4NQFi4XinDUzJbE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hM+oI00exH6WFJY0wl/mjiv5P04/U2Sdqjp+Qxp0DlulIj3Ah26GM7vBbv+S4xsKsBxRp6mIWCHFlHdXbuE8zXRJ5BxiMKJDILNRcXCZLFLLQ7b+QYXo2i0nAbDTC+L7TeNvnq73ZqpBGVPUHoX66l1ZjmMblPc4zR1O95sojms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILRmI8cM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223ADC4CEEE;
	Wed, 11 Jun 2025 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749624024;
	bh=hTZ4O1f+yyRThvIWYmjjaVb+T8UQ4NQFi4XinDUzJbE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ILRmI8cMjGf65AqQkb3cOeaQJ7RKZL/N58pNF2ZLJJX+3Ax3r4awDigxs0hghD5r3
	 uhkNhoF2vij4mRRPvmBqo0thNPUCRenZoMxm81rUCWX5xbYAPU7o61mfX1m/hsbiaz
	 x1AMORfgUJhPeIKMhjnOaKDS790UZbgpyZLkzKHGQJ4Qqi7d7IDNOjQ3saC3l8tluf
	 M1+kfWW2fYl57d/dl5uuYjLCSmLa0YZ07XuDbV1AD4YCNCkUUFT81R/bT8O29u6TSc
	 GDiw69DmrR00OA0VdCZWDPWR2s6uswoRoI+b361lmsObuyKBBwyExO5BPOsa9CyBHk
	 TB1mD0UZs2OfA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 08:40:12 +0200
Message-Id: <DAJHY74JP27K.3VV3U3W0A9PCN@kernel.org>
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
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v4 03/10] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250609224615.27061-1-boqun.feng@gmail.com>
 <20250609224615.27061-4-boqun.feng@gmail.com>
 <DAIQG9ALK4QC.2P2C2MC4U9YVX@kernel.org> <aEhrzxltkdnub_bR@tardis.local>
 <aEhyRhb71dIXzqSu@tardis.local> <aEh_HEwSh2w0Ajkq@tardis.local>
In-Reply-To: <aEh_HEwSh2w0Ajkq@tardis.local>

On Tue Jun 10, 2025 at 8:53 PM CEST, Boqun Feng wrote:
> On Tue, Jun 10, 2025 at 10:58:30AM -0700, Boqun Feng wrote:
>> On Tue, Jun 10, 2025 at 10:30:55AM -0700, Boqun Feng wrote:
>> [...]
>> > > > +/// Describes the exact memory ordering of an `impl` [`All`].
>> > > > +pub enum OrderingDesc {
>> > >=20
>> > > Why not name this `Ordering`?
>> > >=20
>> >=20
>> > I was trying to avoid having an `Ordering` enum in a `ordering` mod.
>> > Also I want to save the name "Ordering" for the generic type parameter
>> > of an atomic operation, e.g.
>> >=20
>> >     pub fn xchg<Ordering: ALL>(..)
>> >=20
>> > this enum is more of an internal implementation detail, and users shou=
ld
>> > not use this enum directly, so I would like to avoid potential
>> > confusion.
>> >=20
>> > I have played a few sealed trait tricks on my end, but seems I cannot
>> > achieve:
>> >=20
>> > 1) `OrderingDesc` is only accessible in the atomic mod.
>> > 2) `All` is only impl-able in the atomic mod, while it can be used as =
a
>> > trait bound outside kernel crate.
>> >=20
>> > Maybe there is a trick I'm missing?
>> >=20
>>=20
>> Something like this seems to work:
>>=20
>>     pub(super) mod private {
>>         /// Describes the exact memory ordering of an `impl` [`All`].
>>         pub enum Ordering {
>>             /// Relaxed ordering.
>>             Relaxed,
>>             /// Acquire ordering.
>>             Acquire,
>>             /// Release ordering.
>>             Release,
>>             /// Fully-ordered.
>>             Full,
>>         }
>>    =20
>>         pub trait HasOrderingDesc {
>>             /// Describes the exact memory ordering.
>>             const ORDERING: Ordering;
>>         }
>>     }
>>=20
>>     /// The trait bound for annotating operations that should support al=
l orderings.
>>     pub trait All: private::HasOrderingDesc { }
>>=20
>>     impl private::HasOrderingDesc for Relaxed {
>>         const ORDERING: private::Ordering =3D private::Ordering::Relaxed=
;
>>     }
>>=20
>> the trick is to seal the enum and the trait together.
>>=20
>> Regards,
>> Boqun
>>=20
>> > > > +    /// Relaxed ordering.
>> > > > +    Relaxed,
>> > > > +    /// Acquire ordering.
>> > > > +    Acquire,
>> > > > +    /// Release ordering.
>> > > > +    Release,
>> > > > +    /// Fully-ordered.
>> > > > +    Full,
>> > > > +}
>> > > > +
>> > > > +/// The trait bound for annotating operations that should support=
 all orderings.
>> > > > +pub trait All {
>> > > > +    /// Describes the exact memory ordering.
>> > > > +    const ORDER: OrderingDesc;
>> > >=20
>> > > And then here: `ORDERING`.
>> >=20
>
> After a second thought, the following is probably what I will go for:
>
>     /// The annotation type for relaxed memory ordering.
>     pub struct Relaxed;
>    =20
>     /// The annotation type for acquire memory ordering.
>     pub struct Acquire;
>    =20
>     /// The annotation type for release memory ordering.
>     pub struct Release;
>    =20
>     /// The annotation type for fully-order memory ordering.
>     pub struct Full;
>
>     /// Describes the exact memory ordering.
>     pub enum OrderingType {
>         /// Relaxed ordering.
>         Relaxed,
>         /// Acquire ordering.
>         Acquire,
>         /// Release ordering.
>         Release,
>         /// Fully-ordered.
>         Full,
>     }
>    =20
>     mod internal {
>         /// Unit types for ordering annotation.
>         ///
>         /// Sealed trait, can be only implemented inside atomic mod.
>         pub trait OrderingUnit {
>             /// Describes the exact memory ordering.
>             const TYPE: super::OrderingType;
>         }
>     }
>    =20
>     impl internal::OrderingUnit for Relaxed {
>         const TYPE: OrderingType =3D OrderingType::Relaxed;
>     }
>    =20
>     impl internal::OrderingUnit for Acquire {
>         const TYPE: OrderingType =3D OrderingType::Acquire;
>     }
>    =20
>     impl internal::OrderingUnit for Release {
>         const TYPE: OrderingType =3D OrderingType::Release;
>     }
>    =20
>     impl internal::OrderingUnit for Full {
>         const TYPE: OrderingType =3D OrderingType::Full;
>     }
>
> That is:
>
> 1) Rename "OrderingDesc" into "OrderingType", and make it public.
> 2) Provide a sealed trait (`OrderingUnit`) for all the unit types
>    that describe ordering.
> 3) Instead of "ORDER" or "ORDERING", name the enum constant "TYPE".
>
>
> An example shows why is probably an xchg() implementation, if I was to
> follow the previous naming suggestion, it will be:
>
>     match Ordering::ORDERING {
>         <some mode path>::Ordering::Relaxed =3D> atomic_xchg_relaxed(...)=
,
> 	...
>     }
>
> with the current one, it will be:
>
>     match Ordering::TYPE {
>         // assume we "use ordering::OrderingType"
>         OrderingType::Relaxed =3D> atomic_xchg_relaxed(...),
> 	...
>     }
>
> I think this version is much better.

Agreed :)

---
Cheers,
Benno

