Return-Path: <linux-arch+bounces-12748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E999B04369
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 17:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52111164CD6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59FF25CC6C;
	Mon, 14 Jul 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD4R/XRb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73725C82E;
	Mon, 14 Jul 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506181; cv=none; b=Xdga1xbJoMvwbQDfDqpn1cLIT09D+xshkUusFK7RleaVJqXzfkcjMJicP3rZMZng1MQxewUaeEGc6IHtjE0JX5KPi5LzfCFu3ok0WX6yPzF9A1PbrS1rrIBEfj5JJGBeSjYyjQLAs2Lsm73rYqFwhPjsvlJdTJfCD3/OqxhiM1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506181; c=relaxed/simple;
	bh=DYIpBX8VnAuNwWjILAB9UIK/+bNLzgpqHG3tl9P8+1k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dpc4ONBzzZIvyvxq4TBIjZhemLsxKVbqaxS8Ibv8S2VmPjCYwCBCeWY7eCmm8bcbyW1CNPGib6xCLly3OB4iiOBrH/e+6U//4eTKvBotHH0YJIGFYoVW7cjZ56ZzeRYwi+C8b63wasFfL12EWecBEnA1+TLTeqyH4pZmDf/Bjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD4R/XRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2706AC4CEED;
	Mon, 14 Jul 2025 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506181;
	bh=DYIpBX8VnAuNwWjILAB9UIK/+bNLzgpqHG3tl9P8+1k=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VD4R/XRbF/rTA1yEsFj7eJ3McbSzO0rpmbVdXcnktjIk23plNXE4IRcKcsdxbLhqg
	 lfM6DZeKHJYRu31zdvKN8X4ISOZbaYKNmRnkNcjRMbOYcFXXtfaEqyWDIRqRuKsr6C
	 sOe7kaJvui72ctvHkdGV/v7n4NQLmBCs8oYXfbJtmQEGWxbKsgFzE4n5U4nRGlNG6h
	 UXrNpQOuQB3nQ/kGMQJS1+ORO5N/NRH72uq3pBV8O2YsPQH/7xCOiTSpxBpaXK3EAV
	 rHC9EmOKIuhy5wuPZB3j6BtsYVza0LmKA09nXRbOpL8ZlmQYvUEGIz67Qj2pOm917i
	 8l03mb/6wBJQA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 17:16:14 +0200
Message-Id: <DBBVL9ZPDU9P.3M2L8OB6SHBUE@kernel.org>
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
Subject: Re: [PATCH v7 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-4-boqun.feng@gmail.com>
 <DBBP3E8PZ81U.2O0QHK1GQXKX2@kernel.org> <aHUbUZZ-8Z9kspds@Mac.home>
In-Reply-To: <aHUbUZZ-8Z9kspds@Mac.home>

On Mon Jul 14, 2025 at 4:59 PM CEST, Boqun Feng wrote:
> On Mon, Jul 14, 2025 at 12:10:46PM +0200, Benno Lossin wrote:
>> On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
>> > Preparation for atomic primitives. Instead of a suffix like _acquire, =
a
>> > method parameter along with the corresponding generic parameter will b=
e
>> > used to specify the ordering of an atomic operations. For example,
>> > atomic load() can be defined as:
>> >
>> > 	impl<T: ...> Atomic<T> {
>> > 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
>> > 	}
>> >
>> > and acquire users would do:
>> >
>> > 	let r =3D x.load(Acquire);
>> >
>> > relaxed users:
>> >
>> > 	let r =3D x.load(Relaxed);
>> >
>> > doing the following:
>> >
>> > 	let r =3D x.load(Release);
>> >
>> > will cause a compiler error.
>> >
>> > Compared to suffixes, it's easier to tell what ordering variants an
>> > operation has, and it also make it easier to unify the implementation =
of
>> > all ordering variants in one method via generic. The `TYPE` associate
>> > const is for generic function to pick up the particular implementation
>> > specified by an ordering annotation.
>> >
>> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> > ---
>> > Benno, please take a good and if you want to provide your Reviewed-by
>> > for this one. I didn't apply your Reviewed-by because I used
>> > `ordering::Any` instead of `AnyOrdering`, I think you're Ok with it [1=
],
>> > but I could be wrong. Thanks!
>> >
>> > [1]: https://lore.kernel.org/rust-for-linux/DB8M91D7KIT4.14W69YK7108ND=
@kernel.org/
>>=20
>> > +/// The trait bound for annotating operations that support any orderi=
ng.
>> > +pub trait Any: internal::Sealed {
>>=20
>> How about we just name this `Ordering`? Because that's what it is :)
>>=20
>
> Seems OK to me, I then also followed Gary's suggestion:
>
> 	https://lore.kernel.org/rust-for-linux/20250621121842.0c3ca452.gary@gary=
guo.net/
>
> and dropped `RelaxedOnly` trait.

Sounds good.

>> That sadly means you can't do
>>=20
>>     fn foo<Ordering: Ordering>() {}
>>            --------  ^^^^^^^^ not a trait
>>            |
>>            found this type parameter
>>=20
>> But you can still do
>>=20
>>     fn foo<O: Ordering>(_: O) {}
>>=20
>> If we don't have the ordering module public and instead re-export from
>
> Keeping ordering mod public helps rustdoc readers to find the module and
> read the module documentation (where is the best place to explain each
> ordering), and also I made `Relaxed`, `Acquire`, `Release` and `Full`
> refer to the module documentation in their doc, making `ordering` mod
> private would cause rustdoc issues.

You could move those docs to the `Ordering` trait :) But I think having
an ordering module is fine.

---
Cheers,
Benno

