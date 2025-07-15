Return-Path: <linux-arch+bounces-12777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9CDB0589C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D30A3A293F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AF2D8788;
	Tue, 15 Jul 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geI67ajN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBADF26E6F1;
	Tue, 15 Jul 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578487; cv=none; b=anu6/SMuDRIkJGF9AY9gbD818vxfWmyvip0cr5JOqWwrlaoOICsJ+geBJQTNbLKIykrBHkbT4cyegOKXIqYdjYXUCCnsnTslbHka9H0sHIqu/o1hGonS6ROFzQaOefs/6NXm3tuxkuK0RyBEnZpb6xDHW07jCrHl6kk55q4Dj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578487; c=relaxed/simple;
	bh=/VY8qNuYt4dNinHnUlxo11M1DqWGCBPY/iGLGM4TX0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=D2IhTjX4hirzSDvpLYSDl1gsrlTp3RSsY47LOtd0qtBvVQkTSn+zOsLjUX9e5eAoqZ8Pb0fSF/RVzJlkc0GTK3e+gA4+IoBsBnVDGKcff2yrJu7cPT7GwHjugCU41dZzSfBM/bBmEaTQD7ppHrO1jGXlbeW7WQf4SKsHzZlRsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geI67ajN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7550EC4CEE3;
	Tue, 15 Jul 2025 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752578487;
	bh=/VY8qNuYt4dNinHnUlxo11M1DqWGCBPY/iGLGM4TX0k=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=geI67ajNzB1NnjNM/Kwwkcn9Ae6O+GY2Ul7aE+Z1d9tQ+l9tnkhCAsMo/SYmVNpyv
	 bjvx4daHrY606Gl/qiv/VxeAdZbayYx+2qLmgrVm9IHJXAziicrI805w0dtCrGYC1v
	 WYtJMEWL0suCEfbwYr2otZM0/gjJ4uCI9jtEW8+ipdw0Zyq+0EXYGa0k02xjJheR+M
	 oBWYLkz3bu0Q5UJR3UPsBuDZqRq4/HAF7+gPAH7iYv9W01G4yHLgW0vZLlQieu9CFp
	 10uKjM0nYVgHLQYJDqIle2bpXR67J21LBfmHaUYtQF45Kt86/YC15Y+fs2i1zKTY7c
	 elWpMfeCpOYWg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 13:21:20 +0200
Message-Id: <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
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
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
In-Reply-To: <20250714053656.66712-7-boqun.feng@gmail.com>

On Mon Jul 14, 2025 at 7:36 AM CEST, Boqun Feng wrote:
> +/// Types that support atomic add operations.
> +///
> +/// # Safety
> +///
> +/// Wrapping adding any value of type `Self::Repr::Delta` obtained by [`=
Self::rhs_into_delta()`] to

I don't like "wrapping adding", either we use "`wrapping_add`" or we use
some other phrasing.

> +/// any value of type `Self::Repr` obtained through transmuting a value =
of type `Self` to must
> +/// yield a value with a bit pattern also valid for `Self`.
> +pub unsafe trait AllowAtomicAdd<Rhs =3D Self>: AllowAtomic {

Why `Allow*`? I think `AtomicAdd` is better?

> +    /// Converts `Rhs` into the `Delta` type of the atomic implementatio=
n.
> +    fn rhs_into_delta(rhs: Rhs) -> <Self::Repr as AtomicImpl>::Delta;
> +}
> +
>  impl<T: AllowAtomic> Atomic<T> {
>      /// Creates a new atomic `T`.
>      pub const fn new(v: T) -> Self {
> @@ -462,3 +474,100 @@ fn try_cmpxchg<Ordering: ordering::Any>(&self, old:=
 &mut T, new: T, _: Ordering)
>          ret
>      }
>  }
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasArithmeticOps,
> +{
> +    /// Atomic add.
> +    ///
> +    /// Atomically updates `*self` to `(*self).wrapping_add(v)`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x =3D Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.add(12, Relaxed);
> +    ///
> +    /// assert_eq!(54, x.load(Relaxed));
> +    /// ```
> +    #[inline(always)]
> +    pub fn add<Rhs, Ordering: ordering::RelaxedOnly>(&self, v: Rhs, _: O=
rdering)
> +    where
> +        T: AllowAtomicAdd<Rhs>,
> +    {
> +        let v =3D T::rhs_into_delta(v);
> +        // CAST: Per the safety requirement of `AllowAtomic`, a valid po=
inter of `T` is a valid
> +        // pointer of `T::Repr` for reads and valid for writes of values=
 transmutable to `T`.
> +        let a =3D self.as_ptr().cast::<T::Repr>();
> +
> +        // `*self` remains valid after `atomic_add()` because of the saf=
ety requirement of
> +        // `AllowAtomicAdd`.

This part should be moved to the CAST comment above, since we're not
only writing a value transmuted from `T` into `*self`.

---
Cheers,
Benno

> +        //
> +        // SAFETY:
> +        // - `a` is aligned to `align_of::<T::Repr>()` because of the sa=
fety requirement of
> +        //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
> +        // - `a` is a valid pointer per the CAST justification above.
> +        unsafe {
> +            T::Repr::atomic_add(a, v);
> +        }
> +    }

