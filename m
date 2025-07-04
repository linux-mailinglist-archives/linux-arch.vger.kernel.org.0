Return-Path: <linux-arch+bounces-12570-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCEAF9C3E
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 00:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8269485993
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67B288525;
	Fri,  4 Jul 2025 22:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaObhdcg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF707285045;
	Fri,  4 Jul 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751666756; cv=none; b=fS2o7+5lrlz6q2RnrQHSfm5LvtXJQfv+46s8xfmui59/7Z87Y393pZJ+2BSVt6Y2teajlXs60osJzNFhOoxxDhOo7DL8OcIZtSnLwAjfRcmDxnvrKIBmdNIHKKE+s/No7/xUa2tS0LvSTNKDCr87AJEbPe8O0We33lC7GSMFKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751666756; c=relaxed/simple;
	bh=XLeXxdSCNAGO5NV6NYg14ixnzSnIeBzMBFkCaOw/yTg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KG5mIxB42oLrCdExcG783IoQLKGas4h4G+pFF3h+DQq5o5DRBbFC631S4hgKZHYFtkw7eOtT0wVh4/pyoe0AAQUHOuOGYjY1ij9HeXmZo76z25zMThDA4fs0JUSdCkiiDEOzqXEZRkNhF0sWKAHAl6FCB0VSdTK5hieNQtj3jto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaObhdcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C10C4CEE3;
	Fri,  4 Jul 2025 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751666755;
	bh=XLeXxdSCNAGO5NV6NYg14ixnzSnIeBzMBFkCaOw/yTg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=RaObhdcgZPd6pSpQ4SqB2VmgQ1BFy9M6LKrbBG5JDNxN8mtqA67t9eTdPBYVb+83q
	 3k39fL7Wai8dpPb5Ap2GVdwIIbUwBQbCEB+C7Yt+r6IxGgAMC57JHoOpv/tZobkIlG
	 apiYAYtAsgWi/KnkLkuEG8VCpcTa2TbwyXc4Lr66ac0iiCZJMoY2lyuZdGrXUAsUqt
	 LAMO6ScsIc5hpifZlgQwUJdYyLOsjRxXWOi67zLt4Ajt28tJzYUv9Esd/Ckj7zVka9
	 lzGFk03x2udcuVyMFGLN8PbU1xk36UcKuKblVRZz1aB4eFxbjAvPKhuEfAdhT2XBQx
	 5OENedr+rHnYQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 00:05:48 +0200
Message-Id: <DB3M1FEMKVLN.1BDAD6WHDR7HG@kernel.org>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
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
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org> <aFrTyXcFVOjWa2o-@Mac.home>
 <DAWIKTODZ3FT.2LGX1H8ZFDONN@kernel.org> <aGhGDJvUf7zFCmQt@Mac.home>
In-Reply-To: <aGhGDJvUf7zFCmQt@Mac.home>

On Fri Jul 4, 2025 at 11:22 PM CEST, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 03:54:24PM +0200, Benno Lossin wrote:
>> On Tue Jun 24, 2025 at 6:35 PM CEST, Boqun Feng wrote:
>> > On Tue, Jun 24, 2025 at 01:27:38AM +0200, Benno Lossin wrote:
>> >> On Mon Jun 23, 2025 at 9:09 PM CEST, Boqun Feng wrote:
>> >> > On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
>> >> >> cannot just transmute between from pointers to usize (which is its
>> >> >> Repr):
>> >> >> * Transmuting from pointer to usize discards provenance
>> >> >> * Transmuting from usize to pointer gives invalid provenance
>> >> >>=20
>> >> >> We want neither behaviour, so we must store `usize` directly and
>> >> >> always call into repr functions.
>> >> >>=20
>> >> >
>> >> > If we store `usize`, how can we support the `get_mut()` then? E.g.
>> >> >
>> >> >     static V: i32 =3D 32;
>> >> >
>> >> >     let mut x =3D Atomic::new(&V as *const i32 as *mut i32);
>> >> >     // ^ assume we expose_provenance() in new().
>> >> >
>> >> >     let ptr: &mut *mut i32 =3D x.get_mut(); // which is `&mut self.=
0.get()`.
>> >> >
>> >> >     let ptr_val =3D *ptr; // Does `ptr_val` have the proper provena=
nce?
>> >>=20
>> >> If `get_mut` transmutes the integer into a pointer, then it will have
>> >> the wrong provenance (it will just have plain invalid provenance).
>> >>=20
>> >
>> > The key topic Gary and I have been discussing is whether we should
>> > define Atomic<T> as:
>> >
>> > (my current implementation)
>> >
>> >     pub struct Atomic<T: AllowAtomic>(Opaque<T>);
>> >
>> > or
>> >
>> > (Gary's suggestion)
>> >
>> >     pub struct Atomic<T: AllowAtomic>(Opaque<T::Repr>);
>> >
>> > `T::Repr` is guaranteed to be the same size and alignment of `T`, and
>> > per our discussion, it makes sense to further require that `transmute<=
T,
>> > T::Repr>()` should also be safe (as the safety requirement of
>> > `AllowAtomic`), or we can say `T` bit validity can be preserved by
>> > `T::Repr`: a valid bit combination `T` can be transumated to `T::Repr`=
,
>> > and if transumated back, it's the same bit combination.
>> >
>> > Now as I pointed out, if we use `Opaque<T::Repr>`, then `.get_mut()`
>> > would be unsound for `Atomic<*mut T>`. And Gary's concern is that in
>> > the current implementation, we directly cast a `*mut T` (from
>> > `Opaque::get()`) into a `*mut T::Repr`, and pass it directly into C/as=
m
>> > atomic primitives. However, I think with the additional safety
>> > requirement above, this shouldn't be a problem: because the C/asm atom=
ic
>> > primitives would just pass the address to an asm block, and that'll be
>> > out of Rust abstract machine, and as long as the C/primitives atomic
>> > primitives are implemented correctly, the bit representation of `T`
>> > remains valid after asm blocks.
>> >
>> > So I think the current implementation still works and is better.
>>=20
>> I don't think there is a big difference between=C2=A0`Opaque<T>`=C2=A0an=
d
>> `Opaque<T::Repr>`=C2=A0if we have the transmute equivalence between the =
two.
>> From a safety perspective, you don't gain or lose anything by using the
>> first over the second one. They both require the invariant that they are
>> valid (as=C2=A0`Opaque`=C2=A0removes that... we should really be using
>> `UnsafeCell`=C2=A0here instead... why aren't we doing that?).
>>=20
>
> I need the `UnsafePinned`-like behavior of `Atomic<*mut T>` to support
> Rcu<T>, and I will replace it with `UnsafePinned`, once that's is
> available.

Can you expand on this? What do you mean by "`UnsafePinned`-like
behavior"? And what does `Rcu<T>` have to do with atomics?

> Maybe that also means `UnsafePinned<T>` make more sense? Because if `T`
> is a pointer, it's easy to prove the provenance is there. (Note a
> `&Atomic<*mut T>` may come from a `*mut *mut T`, may be a field in C
> struct)

Also don't understand this.

---
Cheers,
Benno

