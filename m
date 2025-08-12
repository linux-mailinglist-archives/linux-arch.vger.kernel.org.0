Return-Path: <linux-arch+bounces-13126-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C0B2202F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57A9C7A596A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC22DE6F7;
	Tue, 12 Aug 2025 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY8TMvAb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E8A182B4;
	Tue, 12 Aug 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985860; cv=none; b=qFDVzfsAjTHRnukfEnZw/Uw/ceNlbZw77dB3XmACHSqBRwEfpEIXb/93Of0DaZeSLKBq+Aza8xMUc3iupxMoRvym27oOhY+1W/7lFcHEncEi6EGGgCFnNeAnpRpfomTNTCRryZYRWV8/FFOyAXBOH2DwRDreSoCsCbD3S3kLfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985860; c=relaxed/simple;
	bh=CmsqAWCDgpYx/WtLNPYOAeyzDquaNc5otZlS8cdWDtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=DfTNfXwCj2I56iqz0zXDad3eC8k8uHlOD1wtITNk/MREmHSfjkPcqaLuT2OzdWgvJ8jbJXv4oBSGY7UL8GVCFmrCIvd+vSNMDp+BXa7pBFmOgtW/Qo8r6F9/tOUuCWeXfb+dCUH0VT2pp+KfePgYJIVpKXKsOebVgUoRRg4qnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY8TMvAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A69C4CEF0;
	Tue, 12 Aug 2025 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985858;
	bh=CmsqAWCDgpYx/WtLNPYOAeyzDquaNc5otZlS8cdWDtI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SY8TMvAbvChDBZi6AmEP32jwY8okHVwKfZXk1d4NqMlhvmgZO6MpTGRKhzsuzKpoH
	 Jm4p4JbZjnzRu4RdkDL15DrstzfmVzePw3hv9RjH0zAic/xiPKABAu8Y1jcW7GD65v
	 S5LVBQCDAgJxd88xB5QR9stlfm9GFLt+ZDdI3gUcrTJl1giQ4lo2R7fvptUieWjCS7
	 uUGJi8hJWqL57TfUe4V4WvvVy7gG+NsEanQzkesfWl27YeKXXwfC6ybZiZ7/29fdDK
	 VQvmdlBjg8d6WNXN5MAUpCuCe454wuYyyaawzUEstRcxu/A8rhJ9wpdMVTpkxUH/xp
	 ZpsALwl3cVr7w==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 10:04:12 +0200
Message-Id: <DC0AKAL1LW84.MR2RFTMX1H61@kernel.org>
Subject: Re: [PATCH v8 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
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
X-Mailer: aerc 0.20.1
References: <20250719030827.61357-1-boqun.feng@gmail.com>
 <20250719030827.61357-7-boqun.feng@gmail.com>
In-Reply-To: <20250719030827.61357-7-boqun.feng@gmail.com>

On Sat Jul 19, 2025 at 5:08 AM CEST, Boqun Feng wrote:
> One important set of atomic operations is the arithmetic operations,
> i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> make senses for all the types that `AtomicType` to have arithmetic
> operations, for example a `Foo(u32)` may not have a reasonable add() or
> sub(), plus subword types (`u8` and `u16`) currently don't have
> atomic arithmetic operations even on C side and might not have them in
> the future in Rust (because they are usually suboptimal on a few
> architecures). Therefore the plan is to add a few subtraits of
> `AtomicType` describing which types have and can do atomic arithemtic
> operations.
>
> One trait `AtomicAdd` is added, and only add() and fetch_add() are
> added. The rest will be added in the future.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/sync/atomic.rs           | 93 +++++++++++++++++++++++++++-
>  rust/kernel/sync/atomic/predefine.rs | 14 +++++
>  2 files changed, 105 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 793134aeaac1..e3a30b6aaee4 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -16,7 +16,6 @@
>  //!
>  //! [`LKMM`]: srctree/tools/memory-model/
> =20
> -#[allow(dead_code, unreachable_pub)]
>  mod internal;
>  pub mod ordering;
>  mod predefine;
> @@ -25,7 +24,7 @@
>  pub use ordering::{Acquire, Full, Relaxed, Release};
> =20
>  use crate::build_error;
> -use internal::{AtomicBasicOps, AtomicExchangeOps, AtomicRepr};
> +use internal::{AtomicArithmeticOps, AtomicBasicOps, AtomicExchangeOps, A=
tomicRepr};
>  use ordering::OrderingType;
> =20
>  /// A memory location which can be safely modified from multiple executi=
on contexts.
> @@ -115,6 +114,18 @@ pub unsafe trait AtomicType: Sized + Send + Copy {
>      type Repr: AtomicImpl;
>  }
> =20
> +/// Types that support atomic add operations.
> +///
> +/// # Safety
> +///
> +/// `wrapping_add` any value of type `Self::Repr::Delta` obtained by [`S=
elf::rhs_into_delta()`] to

Can you add a normal comment TODO here:

    // TODO: properly define `wrapping_add` in this context.

---
Cheers,
Benno

> +/// any value of type `Self::Repr` obtained through transmuting a value =
of type `Self` to must
> +/// yield a value with a bit pattern also valid for `Self`.
> +pub unsafe trait AtomicAdd<Rhs =3D Self>: AtomicType {
> +    /// Converts `Rhs` into the `Delta` type of the atomic implementatio=
n.
> +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> +}
> +

