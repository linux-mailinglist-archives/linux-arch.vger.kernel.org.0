Return-Path: <linux-arch+bounces-12632-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78513B0002A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC4E585D9E
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7692E54DF;
	Thu, 10 Jul 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THu2ivw0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE7245005;
	Thu, 10 Jul 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145706; cv=none; b=UkCqhItp32YIOzg9FyU/UFM2SM9OcMdU5ja+VsueZGEozmC9C7Z8sM4eBWbUsOvW6LRECZ0OBFvnOrCraGzU7rzyJskqJ0wZEROhw8V8PiANTFBQFGYlF1P3g/kqmF0VnuPN4Glqz/v+iRZD5lR4eXHZNjF0w9vypEHfDQ46T0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145706; c=relaxed/simple;
	bh=06vmJVYbLt+NdxRw+Ts2u7M9TMq+jFYPoVoc4jfx5DE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C6tToaH9RnaG6hGP5O4dh+QA7arGBiRaWBZVDeUEa1scwSFwfTkJHNuabxD4i9jcynCSkDn2V3RzMGBTxrqlgt2y7JurjOzXOJwBPr7vOeo7MPk/d7rpixeGI5hf8BmX0z3DZefwk44gQsh9WtPlyuXpwTzWrGGyXgijg2sSlVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THu2ivw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C9C4CEF5;
	Thu, 10 Jul 2025 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752145705;
	bh=06vmJVYbLt+NdxRw+Ts2u7M9TMq+jFYPoVoc4jfx5DE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=THu2ivw0Azp6h1Coq9LNqnWIQJt2eeAuvAMfMDk/1Pl949Jy6p4pagXuo50tkjfcb
	 MUxi3hvEJL+yzuyk5grkP1oOktMR/nXgOqEBvHCLDFdKoeEVra7ujiSmyYiUvrNrKI
	 c5lPmrB/dYkfX9Ghbvzn+4/JDX6i5bUyhefwKKw+GkSWJ3biK/MpFBBebKaPZliXyH
	 r8ZIiSl0c8ElnFWmxhGNCynTnWB3w7WyJ3c4Amkhp3FYoO6ZTYug0k4XA2r2OULrOQ
	 JVAVxWs1pz0isQ6AYUImqPWmQp6N/OD7XgxNTaFlj2BbEG0wfXfnkgkLkZjm3/z7n+
	 tqmrhcmMDsXDQ==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 13:08:19 +0200
Message-Id: <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org>
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
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <linux-arch@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-4-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-4-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
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
> 	let r =3D x.load(Acquire);
>
> relaxed users:
>
> 	let r =3D x.load(Relaxed);
>
> doing the following:
>
> 	let r =3D x.load(Release);
>
> will cause a compiler error.
>
> Compared to suffixes, it's easier to tell what ordering variants an
> operation has, and it also make it easier to unify the implementation of
> all ordering variants in one method via generic. The `TYPE` associate
> const is for generic function to pick up the particular implementation
> specified by an ordering annotation.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

One naming comment below, with that fixed:

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/sync/atomic.rs          |  3 +
>  rust/kernel/sync/atomic/ordering.rs | 97 +++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs

> +/// The trait bound for annotating operations that support any ordering.
> +pub trait Any: internal::Sealed {

I don't like the name `Any`, how about `AnyOrdering`? Otherwise we
should require people to write `ordering::Any` because otherwise it's
pretty confusing.

---
Cheers,
Benno

> +    /// Describes the exact memory ordering.
> +    const TYPE: OrderingType;
> +}

