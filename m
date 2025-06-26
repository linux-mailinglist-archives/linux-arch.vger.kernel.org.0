Return-Path: <linux-arch+bounces-12465-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1661BAE9DAB
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 14:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD791C28BE6
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3961E2E336A;
	Thu, 26 Jun 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcvqtYXC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AF2E1729;
	Thu, 26 Jun 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941422; cv=none; b=qdKLYD5EhBSymR+iQoVkmJPwxV+LwcrIuFqEwHghjZ3AL8hjyo9S0BaCmST7nrlpbOFy4elzUg7XI6TlXjy8TktBAuiICDu6U4ldQLrlnSyYL9bzcTnTqnHbmW6s7oQsqq5CVZWq7sgVbYL5HfI20AHbTF7tHsIVWsgPAyz5r+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941422; c=relaxed/simple;
	bh=xW15kcP4yyg5AdrMKmaXCrTg/yym1rGPvlnjvNS8aQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZ3RQ2VlRq7MfLihp9yVb187Vyhha0x3D6EJwbXVePKyEhUJO/1vLEKjiTywzF1Ga0WLWS7TWqOw33pmTHiDlAMK7XANaGoB7e7+5wbNxiVhtHhJlYxsweFa/s1fNd2zzspGd7C4bjhXjR41/bS5KE8xwX7iBfSpMzIz03fPrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcvqtYXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47849C4CEED;
	Thu, 26 Jun 2025 12:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750941421;
	bh=xW15kcP4yyg5AdrMKmaXCrTg/yym1rGPvlnjvNS8aQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DcvqtYXCj7wYyfm4lc1WtNlnSAMHX7pypAcyq0vNJeAYE2gfsy7DLFDOfnRjuspIl
	 H6WJD9KzuzFzqWtKVudouagM3jOQwlSSOJIw8FV5rzYLY4f7RCTw/cFHIK7FiKTD+M
	 Fv8vtbh6V7aIKoPNF9bQ6fZ7CZ9oQfBZeczUj20JXKcuXQU1pwAWr5CyATsW2hVF7w
	 Rj0aaE6k4Pu7S0cJJWKeGlv/nKFD9EKPt165RQe+XizHsjaqS1blusPT5kIj5Relbp
	 gehxNAviN9xflCvOZ5j1sIHSqyvZoJSxX+if1c9tIJRIw/wkUuFtDAfUsmMxfCQ5/J
	 oNTo0sF2OaAKw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <lkmm@lists.linux.dev>,  <linux-arch@vger.kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <lossin@kernel.org>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Will Deacon" <will@kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Mark Rutland" <mark.rutland@arm.com>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  "Lyude Paul" <lyude@redhat.com>,  "Ingo
 Molnar" <mingo@kernel.org>,  "Mitchell Levy" <levymitchell0@gmail.com>,
  "Paul E. McKenney" <paulmck@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Linus Torvalds"
 <torvalds@linux-foundation.org>,  "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation types
In-Reply-To: <20250618164934.19817-4-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:27 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<W3facY85E7FjV5y6_67OMqPUz1-Vubr8TpYgFCgXNl8GMh1oM6_bF9V94Kl_oZsdyCQSrxm5WExUmztE3pJ_BQ==@protonmail.internalid>
	<20250618164934.19817-4-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 14:36:50 +0200
Message-ID: <87wm8yznkt.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> Preparation for atomic primitives. Instead of a suffix like _acquire, a
> method parameter along with the corresponding generic parameter will be
> used to specify the ordering of an atomic operations. For example,
> atomic load() can be defined as:
>
> 	impl<T: ...> Atomic<T> {
> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> 	}
>
> and acquire users would do:
>
> 	let r = x.load(Acquire);
>
> relaxed users:
>
> 	let r = x.load(Relaxed);
>
> doing the following:
>
> 	let r = x.load(Release);
>
> will cause a compiler error.
>
> Compared to suffixes, it's easier to tell what ordering variants an
> operation has, and it also make it easier to unify the implementation of
> all ordering variants in one method via generic. The `IS_RELAXED` and
> `TYPE` associate consts are for generic function to pick up the
> particular implementation specified by an ordering annotation.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs          |   3 +
>  rust/kernel/sync/atomic/ordering.rs | 106 ++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 65e41dba97b7..9fe5d81fc2a9 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -17,3 +17,6 @@
>  //! [`LKMM`]: srctree/tools/memory-mode/
>
>  pub mod ops;
> +pub mod ordering;
> +
> +pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
> new file mode 100644
> index 000000000000..96757574ed7d
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ordering.rs
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory orderings.
> +//!
> +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> +//!
> +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> +//! - [`Full`] means "fully-ordered", that is:
> +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> +//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
> +//!     accesses.
> +//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
> +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
> +//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
> +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
> +
> +/// The annotation type for relaxed memory ordering.
> +pub struct Relaxed;
> +
> +/// The annotation type for acquire memory ordering.
> +pub struct Acquire;
> +
> +/// The annotation type for release memory ordering.
> +pub struct Release;
> +
> +/// The annotation type for fully-order memory ordering.
> +pub struct Full;
> +
> +/// Describes the exact memory ordering.
> +pub enum OrderingType {
> +    /// Relaxed ordering.
> +    Relaxed,
> +    /// Acquire ordering.
> +    Acquire,
> +    /// Release ordering.
> +    Release,
> +    /// Fully-ordered.
> +    Full,
> +}
> +
> +mod internal {
> +    /// Unit types for ordering annotation.
> +    ///
> +    /// Sealed trait, can be only implemented inside atomic mod.
> +    pub trait OrderingUnit {
> +        /// Describes the exact memory ordering.
> +        const TYPE: super::OrderingType;
> +    }
> +}
> +
> +impl internal::OrderingUnit for Relaxed {
> +    const TYPE: OrderingType = OrderingType::Relaxed;
> +}
> +
> +impl internal::OrderingUnit for Acquire {
> +    const TYPE: OrderingType = OrderingType::Acquire;
> +}
> +
> +impl internal::OrderingUnit for Release {
> +    const TYPE: OrderingType = OrderingType::Release;
> +}
> +
> +impl internal::OrderingUnit for Full {
> +    const TYPE: OrderingType = OrderingType::Full;
> +}
> +
> +/// The trait bound for annotating operations that should support all orderings.
> +pub trait All: internal::OrderingUnit {}

I think I would prefer `Any` rather than `All` here. Because it is "any
of", not "all of them at once".


Best regards,
Andreas Hindborg



