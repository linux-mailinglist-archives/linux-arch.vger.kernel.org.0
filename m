Return-Path: <linux-arch+bounces-12567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F93AF9BC4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02DB5A34C0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5C2CA6;
	Fri,  4 Jul 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLciuCj0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162912E36EE;
	Fri,  4 Jul 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661956; cv=none; b=C5cSQmct218P2DbwsDjOU6Gu6yTYnFnhGHjhgqITJjd0ZSOksJcDy+EW78E84rZd4oGWmV2eomZTREEybTnU1hKEZNe9jPuwdMEFJRSL4gb5ZD5GTgupDtRxEtIaMiMfd5AgMtlfkhrlOMW3sVAWdZesvBCd9xJTaDe6etHg4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661956; c=relaxed/simple;
	bh=4xYB//ni5ywKO3/5qJ9H8xJDtm5Tpvw8yytmicWjmdQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HZ7G4KnZZQ0RV1GMo/aPkQ7ubZEQ4j+F5cnXFixX2vuT8HjIYwZXY756RDXEunz7JIQTLyxiXI9dp+Q6HOQberXG1M1BqWJ/i/obZTg4IEG4Xnnm+0l697zxR2ETAC2jdKK14F1JTKc2AhHSdXXvimdskvaojbUzZaUqYASlew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLciuCj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2362C4CEE3;
	Fri,  4 Jul 2025 20:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751661955;
	bh=4xYB//ni5ywKO3/5qJ9H8xJDtm5Tpvw8yytmicWjmdQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PLciuCj0+j1fEScnAAeIbYC6x4uSeVBW8PIQ3zGFyZaSDSDGIJrq0rC9yG0GoeRMF
	 pLS8PZC1sP+ts9IBEU5OQRHSSGzR6JWp676TI/FBrOutWpaEMsQ5ub2M7+pn4F0h20
	 i7ZpaM5HuixNdXQKpOntl4OOxSzYooBRgv7yQwW8ZLsrCZBpAb8ppwevYZ/GHzKRRm
	 PBaQX/IyJbeKOliZlVLPmhSC6gjEosCZksEB/rp0Ufk2lEyK+VZmJu/qFC2gQS4t76
	 C8Ul39Zh++0koO7Ey5heEZIwjsYNIG2ic0wJ8q0A1t82aXKmT4epKFsfocAfqCeQWR
	 1Pd541SGDJ67Q==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Jul 2025 22:45:48 +0200
Message-Id: <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.20.1
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net> <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net> <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home>
In-Reply-To: <aGg4sIORQiG02IoD@Mac.home>

On Fri Jul 4, 2025 at 10:25 PM CEST, Boqun Feng wrote:
> There are a few off-list discussions, and I've been trying some
> experiment myself, here are a few points/concepts that will help future
> discussion or documentation, so I put it down here:
>
> * Round-trip transmutability (thank Benno for the name!).
>
>   We realize this should be a safety requirement of `AllowAtomic` type
>   (i.e. the type that can be put in a Atomic<T>). What it means is:
>
>   - If `T: AllowAtomic`, transmute() from `T` to `T::Repr` is always
>     safe and

s/safe/sound/

>   - if a value of `T::Repr` is a result of transmute() from `T` to
>     `T::Repr`, then `transmute()` for that value to `T` is also safe.

s/safe/sound/

:)

>
>   This essentially means a valid bit pattern of `T: AllowAtomic` has to
>   be a valid bit pattern of `T::Repr`.
>
>   This is needed because the atomic framework operates on `T::Repr` to
>   implement atomic operations on `T`.
>
>   Note that this is more relaxed than bi-direct transmutability (i.e.
>   transmute() between `T` and `T::Repr`) because we want to support
>   atomic type over unit-only enums:
>
>     #[repr(i32)]
>     pub enum State {
>         Init =3D 0,
> 	Working =3D 1,
> 	Done =3D 2,
>     }
>
>   This should be really helpful to support atomics as states, for
>   example:
>
>     https://lore.kernel.org/rust-for-linux/20250702-module-params-v3-v14-=
1-5b1cc32311af@kernel.org/
>
> * transmute()-equivalent from_repr() and into_repr().

Hmm I don't think this name fits the description below, how about
"bit-equivalency of from_repr() and into_repr()"? We don't need to
transmute, we only want to ensure that `{from,into}_repr` are just
transmutes.

>   (This is not a safety requirement)
>
>   from_repr() and into_repr(), if exist, should behave like transmute()
>   on the bit pattern of the results, in other words, bit patterns of `T`
>   or `T::Repr` should stay the same before and after these operations.
>
>   Of course if we remove them and replace with transmute(), same result.
>
>   This reflects the fact that customized atomic types should store
>   unmodified bit patterns into atomic variables, and this make atomic
>   operations don't have weird behavior [1] when combined with new(),
>   from_ptr() and get_mut().

I remember that this was required to support types like `(u8, u16)`? If
yes, then it would be good to include a paragraph like the one above for
enums :)

> * Provenance preservation.
>
>   (This is not a safety requirement for Atomic itself)
>
>   For a `Atomic<*mut T>`, it should preserve the provenance of the
>   pointer that has been stored into it, i.e. the load result from a
>   `Atomic<*mut T>` should have the same provenance.
>
>   Technically, without this, `Atomic<*mut T>` still work without any
>   safety issue itself, but the user of it must maintain the provenance
>   themselves before store or after load.
>
>   And it turns out it's not very hard to prove the current
>   implementation achieve this:
>
>   - For a non-atomic operation done on the atomic variable, they are
>     already using pointer operation, so the provenance has been
>     preserved.
>   - For an atomic operation, since they are done via inline asm code, in
>     Rust's abstract machine, they can be treated as pointer read and
>     write:
>
>     a) A load of the atomic can be treated as a pointer read and then
>        exposing the provenance.
>     b) A store of the atomic can be treated as a pointer write with a
>        value created with the exposed provenance.
>
>     And our implementation, thanks to no arbitrary type coercion,
>     already guarantee that for each a) there is a from_repr() after and
>     for each b) there is a into_repr() before. And from_repr() acts as
>     a with_exposed_provenance() and into_repr() acts as a
>     expose_provenance(). Hence the provenance is preserved.

I'm not sure this point is correct, but I'm an atomics noob, so maybe
Gary should take a look at this :)

>   Note this is a global property and it has to proven at `Atomic<T>`
>   level.

Thanks for he awesome writeup, do you want to put this in some comment
or at least the commit log?

---
Cheers,
Benno

