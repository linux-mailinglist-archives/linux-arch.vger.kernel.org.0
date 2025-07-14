Return-Path: <linux-arch+bounces-12734-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2B7B03B93
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 12:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3167116C36D
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jul 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974162417DE;
	Mon, 14 Jul 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVEDxYkD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BC239E69;
	Mon, 14 Jul 2025 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487398; cv=none; b=qac/Ly176DtSLjFPpXC3n75JVqd7KJDXON/5IZAAxz6Zg2THyUAL5eCOmaHMYKcYU0eh+sXNY7WvHn2vb9U8LKjXI6zoC2JTfRQ/M3AaxyYbdxORyncwsk+xFweJ0utmz9BmG2hRNQCGQ9SY3JVRpkSQ4KCeHQf7QUEU/D4KhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487398; c=relaxed/simple;
	bh=HNeMqdWKNrq8boA6qHmSu+sqnpTFb+5Ta06mGhvf3ME=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WXkGicA5fP6cnSSPqHDEfxAzuRnSfp/6JyrpNUar2872CWah2S7zdHSS6Sr/8PJ75UT0wF2NBG0nzATjqtEICDWcQ+v7SoeI43t+yYtMzyGCZ9X1ayiS9CBdfsSWWc4hexHKbZcy1X0JhEmMkBW0VP47a2H0vKbiSk2TNaGU+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVEDxYkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B444C4CEF4;
	Mon, 14 Jul 2025 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752487398;
	bh=HNeMqdWKNrq8boA6qHmSu+sqnpTFb+5Ta06mGhvf3ME=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aVEDxYkD1y1qhi699n0cRjmrQF+1SC+eaZWmdDV28WCMBjNFHO0vs0P9vIwlxHUv0
	 DkTRJERN0BvR/hgFa/iGKGfeKM7+VdDQhXaZXwJ3Q+Oao+xaumPQm2b7SqWfqJTuar
	 bQFYLjGCT/7s7ZbTlbEpEFbdisypu12He+8Eq/rQes08PWsQpry6c5X/DY6E8QpxZY
	 BUvyH5MMWvu4Xyul+AJj5cfeH2zJ9e2j8E8IlVp/nRH8kdNvZEbl/DrYgcynBgv6yq
	 Bq1WJyhzFFPCiqRwQXo+APimnJC83YP87o9y5+5eQTmZ3nfKm4WWs1tEVzlM6cOC5m
	 ESCsmJ8+uyXDA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 12:03:11 +0200
Message-Id: <DBBOXLF23VVA.2T3U6GBOZ3Y20@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 2/9] rust: sync: Add basic atomic operation mapping
 framework
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-3-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-3-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> Preparation for generic atomic implementation. To unify the
> implementation of a generic method over `i32` and `i64`, the C side
> atomic methods need to be grouped so that in a generic method, they can
> be referred as <type>::<method>, otherwise their parameters and return
> value are different between `i32` and `i64`, which would require using
> `transmute()` to unify the type into a `T`.
>
> Introduce `AtomicImpl` to represent a basic type in Rust that has the
> direct mapping to an atomic implementation from C. This trait is sealed,
> and currently only `i32` and `i64` impl this.
>
> Further, different methods are put into different `*Ops` trait groups,
> and this is for the future when smaller types like `i8`/`i16` are
> supported but only with a limited set of API (e.g. only set(), load(),
> xchg() and cmpxchg(), no add() or sub() etc).
>
> While the atomic mod is introduced, documentation is also added for
> memory models and data races.
>
> Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
> my responsiblity on the Rust atomic mod.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Benno, I actually followed your suggestion and put the safety
> requirement inline, and also I realized I don't need to mention about
> data race, because no data race is an implied safety requirement.

Thanks! I think it looks much better :)

> Note that macro-wise, I forced only #[doc] attributes can be put
> before `unsafe fn ..` because this is the only usage, and I don't
> think it's likely we want to support other attributes. We can always
> add them later.

Sounds good.

> +declare_and_impl_atomic_methods!(
> +    /// Basic atomic operations
> +    pub trait AtomicHasBasicOps {

I think we should drop the `Has` from the names. So this one can just be
`AtomicBasicOps`. Or how about `BasicAtomic`, or `AtomicBase`?

> +        /// Atomic read (load).
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> +        /// - `ptr` is valid for reads.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn read[acquire](ptr: *mut Self) -> Self {
> +            bindings::#call(ptr.cast())
> +        }
> +
> +        /// Atomic set (store).
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> +        /// - `ptr` is valid for writes.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn set[release](ptr: *mut Self, v: Self) {
> +            bindings::#call(ptr.cast(), v)
> +        }
> +    }
> +);
> +
> +declare_and_impl_atomic_methods!(
> +    /// Exchange and compare-and-exchange atomic operations
> +    pub trait AtomicHasXchgOps {

Same here `AtomicXchgOps` or `AtomicExchangeOps` or `AtomicExchange`?
(I would prefer to not abbreviate it to `Xchg`)

> +        /// Atomic exchange.
> +        ///
> +        /// Atomically updates `*ptr` to `v` and returns the old value.
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> +        /// - `ptr` is valid for reads and writes.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn xchg[acquire, release, relaxed](ptr: *mut Self, v: Sel=
f) -> Self {
> +            bindings::#call(ptr.cast(), v)
> +        }
> +
> +        /// Atomic compare and exchange.
> +        ///
> +        /// If `*ptr` =3D=3D `*old`, atomically updates `*ptr` to `new`.=
 Otherwise, `*ptr` is not
> +        /// modified, `*old` is updated to the current value of `*ptr`.
> +        ///
> +        /// Return `true` if the update of `*ptr` occured, `false` other=
wise.
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to [`align_of::<Self>()`].
> +        /// - `ptr` is valid for reads and writes.
> +        /// - `old` is aligned to [`align_of::<Self>()`].
> +        /// - `old` is valid for reads and writes.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn try_cmpxchg[acquire, release, relaxed](ptr: *mut Self,=
 old: *mut Self, new: Self) -> bool {
> +            bindings::#call(ptr.cast(), old, new)
> +        )}
> +    }
> +);
> +
> +declare_and_impl_atomic_methods!(
> +    /// Atomic arithmetic operations
> +    pub trait AtomicHasArithmeticOps {

Forgot to rename this one to `Add`? I think `AtomicAdd` sounds best for
this one.

---
Cheers,
Benno

> +        /// Atomic add (wrapping).
> +        ///
> +        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`.
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to `align_of::<Self>()`.
> +        /// - `ptr` is valid for reads and writes.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn add[](ptr: *mut Self, v: Self::Delta) {
> +            bindings::#call(v, ptr.cast())
> +        }
> +
> +        /// Atomic fetch and add (wrapping).
> +        ///
> +        /// Atomically updates `*ptr` to `(*ptr).wrapping_add(v)`, and r=
eturns the value of `*ptr`
> +        /// before the update.
> +        ///
> +        /// # Safety
> +        /// - `ptr` is aligned to `align_of::<Self>()`.
> +        /// - `ptr` is valid for reads and writes.
> +        ///
> +        /// [`align_of::<Self>()`]: core::mem::align_of
> +        unsafe fn fetch_add[acquire, release, relaxed](ptr: *mut Self, v=
: Self::Delta) -> Self {
> +            bindings::#call(v, ptr.cast())
> +        }
> +    }
> +);


