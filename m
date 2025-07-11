Return-Path: <linux-arch+bounces-12655-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19EDB016E3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16454584D86
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FA20D500;
	Fri, 11 Jul 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX5no2qW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEB205E3B;
	Fri, 11 Jul 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224033; cv=none; b=QRGWhRH8SHJElo1weraXEiF/sFtfMzyeJ1Vw1JEg23EIicZ6z0zpgcYVWAsi0iGVSQb/KrmK40/65iFbh8DeGF77Mj8b7WLXNfo43iJQMadg0EZ8wlltOroztoob7+3JR57l/AC+RSbBXr5jJymHcuceUfKEbZxuq0YM+6G+J+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224033; c=relaxed/simple;
	bh=2YeFLlg3dTrJf6vN7+4tbGaGhGJwbz1PMJpCW+4YicQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NunpVu8ygz+OA6YaPAVgrEG14P5lLw+DYjcKSicgwnH4zRXW2tTOHdpz+oR0w0+vU1jxSxTv+7E87hVLxVKkrz9wbRsVfk2csTj/pS6Kcu+LMdCwwt46ilINTYPwI8l0+XX22jdgg6QV3EKItRkVfRQImzDNA4a2xiwzrqDQcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX5no2qW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D1C4CEF7;
	Fri, 11 Jul 2025 08:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224032;
	bh=2YeFLlg3dTrJf6vN7+4tbGaGhGJwbz1PMJpCW+4YicQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WX5no2qW3nwGGDe1NwWBIHlYf70MPGOToeP3ismzzbxfT5uiMIQzlq+xxKQjiE6S8
	 gDRogjPtvOoKwjCJlxzs4XJ9S5Dxp5RSozEoH72nqOB7kgx+/gGrCPX/UvVVaftSOT
	 DxhpwZGwF+vkInZuSUIX1X+RqDD6DrlbYZHROZK7F1z7ZQ07J6hMnul+LWmE7kEX6R
	 PjzcQzRwYuSr//PqzHlNSpbm6nGTpYINKXM1nWeakIJGlMR3MKVU+k2FbCEpC6XxIH
	 7ujH60RCYfRteVXbpY1WDFyhpxSWqr9i1LZjf8+u/ZAMFKfmyNom0sswHND09ax2Bf
	 ZU7tuDXDTIjFg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:53:45 +0200
Message-Id: <DB93KSS3F3AK.3R9RFOHJ4FSAQ@kernel.org>
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
Subject: Re: [PATCH v6 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-7-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-7-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> One important set of atomic operations is the arithmetic operations,
> i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> make senses for all the types that `AllowAtomic` to have arithmetic
> operations, for example a `Foo(u32)` may not have a reasonable add() or
> sub(), plus subword types (`u8` and `u16`) currently don't have
> atomic arithmetic operations even on C side and might not have them in
> the future in Rust (because they are usually suboptimal on a few
> architecures). Therefore add a subtrait of `AllowAtomic` describing
> which types have and can do atomic arithemtic operations.
>
> Trait `AllowAtomicArithmetic` has an associate type `Delta` instead of
> using `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is
> `i32`) may not wants an `add(&self, i32)`, but an `add(&self, u32)`.
>
> Only add() and fetch_add() are added. The rest will be added in the
> future.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs         |  18 +++++
>  rust/kernel/sync/atomic/generic.rs | 108 +++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+)

I think it's better to name this trait `AtomicAdd` and make it generic:

    pub unsafe trait AtomicAdd<Rhs =3D Self>: AllowAtomic {
        fn rhs_into_repr(rhs: Rhs) -> Self::Repr;
    }

`sub` and `fetch_sub` can be added using a similar trait.

The generic allows you to implement it multiple times with different
meanings, for example:

    pub struct Nanos(u64);
    pub struct Micros(u64);
    pub struct Millis(u64);

    impl AllowAtomic for Nanos {
        type Repr =3D i64;
    }

    impl AtomicAdd<Millis> for Nanos {
        fn rhs_into_repr(rhs: Millis) -> i64 {
            transmute(rhs.0 * 1000_000)
        }
    }

    impl AtomicAdd<Micros> for Nanos {
        fn rhs_into_repr(rhs: Micros) -> i64 {
            transmute(rhs.0 * 1000)
        }
    }

    impl AtomicAdd<Nanos> for Nanos {
        fn rhs_into_repr(rhs: Nanos) -> i64 {
            transmute(rhs.0)
        }
    }

For the safety requirement on the `AtomicAdd` trait, we might just
require bi-directional transmutability... Or can you imagine a case
where that is not guaranteed, but a weaker form is?

---
Cheers,
Benno

