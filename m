Return-Path: <linux-arch+bounces-12658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C77CB0170F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB0916971C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 09:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A491EFF8D;
	Fri, 11 Jul 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsbwaKpV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B771B87F2;
	Fri, 11 Jul 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224440; cv=none; b=YeuhV8HXinhax+NxwpI0cHXG8BiNNrp9kVd4qLFohkLiqVW/jJIsjJ1sVsjq2MJstwLWVn/IVJihUMjLu/ukbRmhOfnrzlAT207QasPvqij6yne3o8cqBl40As0Q/0X3r5fYv4eTvwRNb+fxpb4gUCdEBU+1gIdjaEuf4Hij5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224440; c=relaxed/simple;
	bh=dZfg0K4iovcFVfeIPvcgClAGWqliniueLQcE59/G35g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KQzFAV/EU08GMGpSe3ivHjLk2ysV3pDjvvhqoKLajX2ZoQXSqLt1N1ZsGNYSZcGu9JbOA3aifkvnQzSRfFDMfOJ/uSDFgg2RdZpDBPjY9VNm1EA/IisEl96CRicUBLAOXwpfnbX2ozpO4zYntBn1Wa/ipY4fPYb3Pjfsk8z8X7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsbwaKpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E263C4CEED;
	Fri, 11 Jul 2025 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224440;
	bh=dZfg0K4iovcFVfeIPvcgClAGWqliniueLQcE59/G35g=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=BsbwaKpV6FqFvm6VGDfTMgmM+VU30FFrmR4oU04m2OLHR2tB8U9ScYaln/ERbjzZy
	 tvU6kXAGLnfvL459h12aIugZk2B62waXXgLV4B55s3kW9Z/kWv7vArXVHPT913XZp0
	 JdTyLyCHW+GFmbW3WFsJgrCH80ZWKbqEg4X6gJPRi490KQ5smDCl2YdLkFxkHZPf4A
	 fzLRdKsibI1WyDH+EYzIZ4jl5Ebb9p0m88/jr686lC4fhwJVe5qeyPrQM+mUJ1y28T
	 eLTAmzHtFHH1hKwsCfVQHBJRxFfddDKxw9D6Fn2GbsmdhpXZzaAHgOfnYCjbRQBG0l
	 6WdGptTyy6LZg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 11:00:33 +0200
Message-Id: <DB93Q0CXTA0G.37LQP5VCP9IGP@kernel.org>
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
Subject: Re: [PATCH v6 9/9] rust: sync: atomic: Add Atomic<{usize,isize}>
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-10-boqun.feng@gmail.com>
In-Reply-To: <20250710060052.11955-10-boqun.feng@gmail.com>

On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> Add generic atomic support for `usize` and `isize`. Note that instead of
> mapping directly to `atomic_long_t`, the represention type
> (`AllowAtomic::Repr`) is selected based on CONFIG_64BIT. This reduces
> the necessity of creating `atomic_long_*` helpers, which could save
> the binary size of kernel if inline helpers are not available.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/sync/atomic.rs | 48 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index e676bc7d9275..e1e40757d7b5 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -53,6 +53,26 @@ fn delta_into_repr(d: Self::Delta) -> Self::Repr {
>      }
>  }
> =20
> +// SAFETY: For 32bit kernel, `isize` has the same size and alignment wit=
h `i32` and is round-trip
> +// transmutable to it, for 64bit kernel `isize` has the same size and al=
ignment with `i64` and is
> +// round-trip transmutable to it.
> +unsafe impl generic::AllowAtomic for isize {
> +    #[cfg(not(CONFIG_64BIT))]
> +    type Repr =3D i32;
> +    #[cfg(CONFIG_64BIT)]
> +    type Repr =3D i64;

Do we have a static assert with these cfgs that `isize` has the same
size as these?

If not, then it would probably make sense to add them now.

---
Cheers,
Benno

> +}

