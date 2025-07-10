Return-Path: <linux-arch+bounces-12631-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B3B00014
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 13:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D10A7A5E4F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95680245005;
	Thu, 10 Jul 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vbw/df0f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB220F4B;
	Thu, 10 Jul 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145485; cv=none; b=ZgTjUn1g/eooyAq9kv/hAdkHrmODYU3EKDCzk2P0Gq1coDfmTsIpNhBJD/dE9VfScGJ2E/ZtppZLgYjdzKt6jsH7ShPYYKrMwSS9XxiFwhpdHld1uRp5IzfOrhefF0h4VlZbkotJrJy+g+mtrNr6Kip9hdwA7DxUWVXxgdKDWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145485; c=relaxed/simple;
	bh=EqMlGjw32PRSX4jyVN+RJ865K9fKrDXxyRtztbrs/Nk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jERAm4xHGlC+iDOLa839s+cgJmYIqdi8VSXVKr3Zge0E7SCdFH7gtHoCXu2GHWwwZvvMF/cINqGDdVrSjedO5coSyJZW/FavueTXfdtB356uVl3ArEVZxRi13LPDTRbyAKfqqH6pLtKsXqMBRLnI4zqKsmiqqNC/4jno9NxgHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vbw/df0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC57C4CEF5;
	Thu, 10 Jul 2025 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145484;
	bh=EqMlGjw32PRSX4jyVN+RJ865K9fKrDXxyRtztbrs/Nk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Vbw/df0fiCOHSbUGzRRAagI6NG8tgY366UhhDQZQaqx0Bo+faCeqYeFWoyQer74ey
	 20ducUxQAdYm2nrj3d6zoWxsACE9F0HU2ubJS6SW+lEYid2/AbVB31LUYCd/vK6DnB
	 19UR5ZY+/QpwPl9ouLBtPSYhvBJ6odQZDgHDJstxlTbrDLX6h792oPwxZuv4LvmZcO
	 zWg9YvjdE/IBlxAvTD4p/HGjXp+3Crxz6muJqkrJX3lcYuypFPlWD81vbLcY85Nkgv
	 8J/zIG1athdCQ0aJEtm3qJGbtMmGJnw5tc9fnU5n24mOvQt2WiHVylGvejZWzqUosy
	 p7mCJnih29X1g==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 13:04:38 +0200
Message-Id: <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
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
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-3-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
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
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Overall this looks good from a functionality view. I have some cosmetic
comments for the macros below and a possibly bigger concern regarding
safety comments. But I think this is good enough for now, so:

Reviewed-by: Benno Lossin <lossin@kernel.org>

> diff --git a/rust/kernel/sync/atomic/ops.rs b/rust/kernel/sync/atomic/ops=
.rs
> new file mode 100644
> index 000000000000..da04dd383962
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ops.rs
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic implementations.
> +//!
> +//! Provides 1:1 mapping of atomic implementations.
> +
> +use crate::bindings::*;

We shouldn't import all bindings, just use `bindings::` below.

> +// This macro generates the function signature with given argument list =
and return type.
> +macro_rules! declare_atomic_method {
> +    (
> +        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
> +    ) =3D> {
> +        paste!(
> +            #[doc =3D concat!("Atomic ", stringify!($func))]
> +            #[doc =3D "# Safety"]
> +            #[doc =3D "- Any pointer passed to the function has to be a =
valid pointer"]
> +            #[doc =3D "- Accesses must not cause data races per LKMM:"]
> +            #[doc =3D "  - Atomic read racing with normal read, normal w=
rite or atomic write is not data race."]

s/not/not a/

> +            #[doc =3D "  - Atomic write racing with normal read or norma=
l write is data-race, unless the"]

s/data-race/a data race/

> +            #[doc =3D "    normal accesses are done at C side and consid=
ered as immune to data"]

    #[doc =3D "    normal access is done from the C side and considered imm=
une to data"]

> +            #[doc =3D "    races, e.g. CONFIG_KCSAN_ASSUME_PLAIN_WRITES_=
ATOMIC."]

Missing '`'.


Also why aren't you using `///` instead of `#[doc =3D`? The only part
where you need interpolation is the first one.

> +            unsafe fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $re=
t)?;
> +        );
> +    };

> +declare_and_impl_atomic_methods!(
> +    AtomicHasBasicOps ("Basic atomic operations") {
> +        read[acquire](ptr: *mut Self) -> Self {
> +            call(ptr.cast())
> +        }
> +
> +        set[release](ptr: *mut Self, v: Self) {
> +            call(ptr.cast(), v)
> +        }
> +    }

I think this would look a bit better:

    /// Basic atomic operations.
    pub trait AtomicHasBasicOps {
        unsafe fn read[acquire](ptr: *mut Self) -> Self {
            bindings::#call(ptr.cast())
        }

        unsafe fn set[release](ptr: *mut Self, v: Self) {
            bindings::#call(ptr.cast(), v)
        }
    }

And then we could also put the safety comments inline:

    /// Basic atomic operations.
    pub trait AtomicHasBasicOps {
        /// Atomic read
        ///
        /// # Safety
        /// - Any pointer passed to the function has to be a valid pointer
        /// - Accesses must not cause data races per LKMM:
        ///   - Atomic read racing with normal read, normal write or atomic=
 write is not a data race.
        ///   - Atomic write racing with normal read or normal write is a d=
ata race, unless the
        ///     normal access is done from the C side and considered immune=
 to data races, e.g.
        ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
        unsafe fn read[acquire](ptr: *mut Self) -> Self {
            // SAFETY: Per function safety requirement, all pointers are va=
lid, and accesses won't
            // cause data race per LKMM.
            unsafe { bindings::#call(ptr.cast()) }
        }

        /// Atomic read
        ///
        /// # Safety
        /// - Any pointer passed to the function has to be a valid pointer
        /// - Accesses must not cause data races per LKMM:
        ///   - Atomic read racing with normal read, normal write or atomic=
 write is not a data race.
        ///   - Atomic write racing with normal read or normal write is a d=
ata race, unless the
        ///     normal access is done from the C side and considered immune=
 to data races, e.g.
        ///     `CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC`.
        unsafe fn set[release](ptr: *mut Self, v: Self) {
            // SAFETY: Per function safety requirement, all pointers are va=
lid, and accesses won't
            // cause data race per LKMM.
            unsafe { bindings::#call(ptr.cast(), v) }
        }
    }

I'm not sure if this is worth it, but for reading the definitions of
these operations directly in the code this is going to be a lot more
readable. I don't think it's too bad to duplicate it.

I'm also not fully satisfied with the safety comment on
`bindings::#call`...

---
Cheers,
Benno

> +);
> +
> +declare_and_impl_atomic_methods!(
> +    AtomicHasXchgOps ("Exchange and compare-and-exchange atomic operatio=
ns") {
> +        xchg[acquire, release, relaxed](ptr: *mut Self, v: Self) -> Self=
 {
> +            call(ptr.cast(), v)
> +        }
> +
> +        try_cmpxchg[acquire, release, relaxed](ptr: *mut Self, old: *mut=
 Self, new: Self) -> bool {
> +            call(ptr.cast(), old, new)
> +        }
> +    }
> +);
> +
> +declare_and_impl_atomic_methods!(
> +    AtomicHasArithmeticOps ("Atomic arithmetic operations") {
> +        add[](ptr: *mut Self, v: Self) {
> +            call(v, ptr.cast())
> +        }
> +
> +        fetch_add[acquire, release, relaxed](ptr: *mut Self, v: Self) ->=
 Self {
> +            call(v, ptr.cast())
> +        }
> +    }
> +);

