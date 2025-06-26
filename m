Return-Path: <linux-arch+bounces-12469-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE2AE9E52
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0C1C42907
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jun 2025 13:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5C2E5415;
	Thu, 26 Jun 2025 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnDhrNTI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEA2E5412;
	Thu, 26 Jun 2025 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943544; cv=none; b=eEY1QzUkrw1XF7pzX0FGP/LrFiTLQepnP7E5J6p0ic0beeGth8dQKqCcZx+lSOZMErEMSrCydynUMMU1RJtc0pqWCB4DShj7JUy/dXSVq52BvVhOuMtuVW+/7DqdesV8yVoyfqZcQMezQlfFh9ZgLjOLH2/n2BTB0IXGLzlmaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943544; c=relaxed/simple;
	bh=6WoBhCawDr2/q9QTjDOrhN78tjcCQb59Az1jMjyMNes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JrBO3Aw39DZ7YWd7cBNPzVE93aqiAAa+i1Pgy5y670rVt/6PGt/zUxNDqhsP7sfssTbUa/q4zPuq95uDUWQtKxJTjCIZ9Iy0As0Gen96TJCDMBcFrjnzKZVsxbNvNXxhj7W27IhuG5Ps4petr2tuo8lmWH02U1N9aqt8IO4ul3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnDhrNTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F250DC4CEF0;
	Thu, 26 Jun 2025 13:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750943543;
	bh=6WoBhCawDr2/q9QTjDOrhN78tjcCQb59Az1jMjyMNes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qnDhrNTIfp+SM3B2zLBk3qIttbKsKa1Us2ef4HbgVXoTiUJo7vwKEpRkZ1NuXpbpF
	 fvtOin+klWJKLTggpH9eYM8j6EoUU03CnCltZvhP6y4So0eF8sqPZwyi4sJzlBcQQa
	 PObACkruEeL57kJ6+ksbaD1e4BIpcHa0q1sT6bLKqVtvGlZSBnyvnAL1n6Q/Le0OM1
	 0NhK3NF809MNz4nS7W/iHOcK8Zb9SF+DfJTye47fVm9DnxvK7JAMFTwLVak20Jr1EJ
	 dWGYBHlR/xCew3+wzio4X0N8o2+p7PfqZqJP/4qq2W6PwuVv0ZgRbTC2BJCpvr0Sts
	 eBZjGnRnP7n2Q==
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
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
In-Reply-To: <20250618164934.19817-6-boqun.feng@gmail.com> (Boqun Feng's
	message of "Wed, 18 Jun 2025 09:49:29 -0700")
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<jBAtISwM9LKkR7KuCHEnym75NfGOM4z408pMuDfk4U8VzN8PQuk9JJfBc33Usre3YSjbgtFRj8c0ZNeeQMpZsA==@protonmail.internalid>
	<20250618164934.19817-6-boqun.feng@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 26 Jun 2025 15:12:12 +0200
Message-ID: <87a55uzlxv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> xchg() and cmpxchg() are basic operations on atomic. Provide these based
> on C APIs.
>
> Note that cmpxchg() use the similar function signature as
> compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> the operation succeeds and `Err(old)` means the operation fails.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic/generic.rs | 154 +++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> index 73c26f9cf6b8..bcdbeea45dd8 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -256,3 +256,157 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
>          };
>      }
>  }
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasXchgOps,
> +{
> +    /// Atomic exchange.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.xchg(52, Acquire));
> +    /// assert_eq!(52, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> +    #[inline(always)]
> +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
> +        let v = T::into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_xchg*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,

Typo: `AllowAtomic`.

> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let ret = unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_xchg(a, v),
> +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
> +                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
> +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
> +            }
> +        };
> +
> +        T::from_repr(ret)
> +    }
> +
> +    /// Atomic compare and exchange.
> +    ///
> +    /// Compare: The comparison is done via the byte level comparison between the atomic variables
> +    /// with the `old` value.
> +    ///
> +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
> +    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
> +    /// failed cmpxchg should be treated as a relaxed read.

Rust `core::ptr` functions have this sentence on success ordering for
compare_exchange:

  Using Acquire as success ordering makes the store part of this
  operation Relaxed, and using Release makes the successful load
  Relaxed.

Does this translate to LKMM cmpxchg operations? If so, I think we should
include this sentence. This also applies to `Atomic::xchg`.


Best regards,
Andreas Hindborg



