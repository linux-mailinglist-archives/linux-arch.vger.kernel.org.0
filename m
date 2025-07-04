Return-Path: <linux-arch+bounces-12573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC7AF9C9F
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 00:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512585860FA
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF363217F56;
	Fri,  4 Jul 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxT62+UR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F166262A6;
	Fri,  4 Jul 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751669356; cv=none; b=hnvxaf9roeAAyMBuef3tkK0xDmGR4eUIhO0IFQkHwQ31mg+2gVEKzZKJqWYQVL89fEZX1/rTCIyO4v8px5yPpp/i4SfyEg/nLoiFRvedbW5YQ68ROPEtxsZSHJr/SAniZGgeV5Lk7xjZTzIIOA0YBmiS+oGZyIR6uTWuHo1BQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751669356; c=relaxed/simple;
	bh=kPlkbtpdeAKller+eP0lsjwYSwOWFj+yVROQguMI7CE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EyVcAEccMImSD4N9TDLisNf9TL9j5BF1Y0JSIL7nNu5wffKZxTd6GsSzphtj9wCyf6qEHXCx8us0sa1QMzi25FIeAImBPpmvacLR1gXElUE3pP1KDijuzywYOIHTFFIRnPaTyg7tzu2YPEFaZNXaFZPaZApfXrofff6hvGQXPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxT62+UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90003C4CEE3;
	Fri,  4 Jul 2025 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751669356;
	bh=kPlkbtpdeAKller+eP0lsjwYSwOWFj+yVROQguMI7CE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sxT62+URuBu+b9goE6vgNpl5nAvrr1+Uo3a2wsMD0m+Hog64hPwdIWrUVYyIQxu7S
	 oaLD6LQnjBwYJl6gleWn9YWrbSGPZrp3XVE3NVhBLWG0Xnn8P3K/R67aiEsKXo4TyZ
	 /sbbQa7ptoEzlNUrWwui1OoJHV48AIBI4mQQ4Oy8EgnT28qjYHuQCeHMo4IB0HDQRX
	 Iz3kHTGX0wzzo03sBLFRHb3DWg4FDgjDZMB56He+HipkrtG7kFcUMCN6EThit5KNSl
	 U7TZuM7bPa13yNfIFVJR9rxlU81hmQqiJuyKq7xISZKHZmPJTrdzwXSf+mphtuK+DO
	 1GoOmhYl5A57A==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Jul 2025 00:49:09 +0200
Message-Id: <DB3MYM27XOVT.2TNXQP9K1KK9I@kernel.org>
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
References: <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <DAUAW2Y0HYLY.3CDC9ZW0BUKI4@kernel.org> <aFrTyXcFVOjWa2o-@Mac.home>
 <DAWIKTODZ3FT.2LGX1H8ZFDONN@kernel.org> <aGhGDJvUf7zFCmQt@Mac.home>
 <DB3M1FEMKVLN.1BDAD6WHDR7HG@kernel.org> <aGhWBp3IhfJDhPOs@Mac.home>
In-Reply-To: <aGhWBp3IhfJDhPOs@Mac.home>

On Sat Jul 5, 2025 at 12:30 AM CEST, Boqun Feng wrote:
> On Sat, Jul 05, 2025 at 12:05:48AM +0200, Benno Lossin wrote:
> [..]
>> >>=20
>> >> I don't think there is a big difference between=C2=A0`Opaque<T>`=C2=
=A0and
>> >> `Opaque<T::Repr>`=C2=A0if we have the transmute equivalence between t=
he two.
>> >> From a safety perspective, you don't gain or lose anything by using t=
he
>> >> first over the second one. They both require the invariant that they =
are
>> >> valid (as=C2=A0`Opaque`=C2=A0removes that... we should really be usin=
g
>> >> `UnsafeCell`=C2=A0here instead... why aren't we doing that?).
>> >>=20
>> >
>> > I need the `UnsafePinned`-like behavior of `Atomic<*mut T>` to support
>> > Rcu<T>, and I will replace it with `UnsafePinned`, once that's is
>> > available.
>>=20
>> Can you expand on this? What do you mean by "`UnsafePinned`-like
>> behavior"? And what does `Rcu<T>` have to do with atomics?
>>=20
>
> `Rcu<T>` is an RCU protected (atomic) pointer, the its definition is
>
>     pub struct Rcu<T>(Atomic<*mut T>);
>
> I need Pin<&mut Rcu<T>> and &Rcu<T> able to co-exist: an updater will
> have the access to Pin<&mut Rcu<T>>, and all the readers will have the
> access to &Rcu<T>, for that I need `Atomic<*mut T>` to be
> `UnsafePinned`, because `Pin<&mut Rcu<T>>` cannot imply noalias.

Then `Rcu` should be
   =20
    pub struct Rcu<T>(UnsafePinned<Atomic<*mut T>>);

And `Atomic` shouldn't wrap `UnsafePinned<T>`. Because that prevents
`&mut Atomic<i32>` to be tagged with `noalias` and that should be fine.
You should only pay for what you need :)

>> > Maybe that also means `UnsafePinned<T>` make more sense? Because if `T=
`
>> > is a pointer, it's easy to prove the provenance is there. (Note a
>> > `&Atomic<*mut T>` may come from a `*mut *mut T`, may be a field in C
>> > struct)
>>=20
>> Also don't understand this.
>>=20
>
> One of the usage of the atomic is being able to communicate with C side,
> for example, if we have a struct foo:
>
>     struct foo {
>         struct bar *b;
>     }
>
> and writer can do this at C side:
>
>    struct foo *f =3D ...;
>    struct bar *b =3D kcalloc(*b, ...);
>
>    // init b;
>
>    smp_store_release(&f->b, b);
>
> and a reader at Rust side can do:
>
>     #[repr(transparent)]
>     struct Bar(binding::bar);
>     struct Foo(Opaque<bindings::foo>);
>
>     fn get_bar(foo: &Foo) {
>         let foo_ptr =3D foo.0.get();
>
>         let b: *mut *mut Bar =3D unsafe { &raw mut (*foo_ptr).b }.cast();
>         // SAFETY: C side accessing this pointer with atomics.
>         let b =3D unsafe { Atomic::<*mut Bar>::from_ptr(b) };
>
>         // Acquire pairs with the Release from C side;
>         let bar_ptr =3D b.load(Acquire);
>
>         // accessing bar.
>     }

This is a nice example, might be a good idea to put this on
`Atomic::from_ptr`.

> This is the case we must support if we want to write any non-trivial
> synchronization code communicate with C side.
>
> And in this case, it's generally easier to reason why we can convert a
> *mut *mut Bar to &UnsafePinned<*mut Bar>.

What does that have to do with `UnsafePinned`? `UnsafeCell` should
suffice.

Also where does the provenance interact with `UnsafePinned`?

---
Cheers,
Benno

