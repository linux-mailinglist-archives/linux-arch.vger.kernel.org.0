Return-Path: <linux-arch+bounces-12635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35765B005EE
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 17:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CCC1CA1CA5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9892405E1;
	Thu, 10 Jul 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owrdGSQ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD4154BF5;
	Thu, 10 Jul 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159932; cv=none; b=lhMVpMzSp6FoDUtWKS5e9N5gU/vnC4767PzYFm2gP4iqVk2+3sSunCYZYRAGRmDFczPmSjEwXOKjsMsx7pWZH6AbgPW9BMuwahZEL5Prc4m574GnL+hJR/ak2s+xaH0SN65FOET6mKLeiarPkP6HAxKzo0632W4BoATMCsjt0OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159932; c=relaxed/simple;
	bh=o0tIfnXyZL6RSXxuYwIYRelHab7pZgA3+IwPqH/WlLU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KTdgnnhX98JuMyVXT1v7LR54RUU+68Ibb/UkTlF3Q7k1rx7orH++VjpXdw/BdQHw1RTybthQK5Ulqr+IOxPj2IHAThrVB8/AmbGfiRkdHiNaTV/ynebKZNJbpRLWvrrTfrL4TUOmTsXffoOE6VG1DSlGy0/ZdhqYk9gHnfP3Hww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owrdGSQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE6AC4CEF4;
	Thu, 10 Jul 2025 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752159931;
	bh=o0tIfnXyZL6RSXxuYwIYRelHab7pZgA3+IwPqH/WlLU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=owrdGSQ58+poQzM6eqQfPuEnjKYhBgNnydk+GPYkzH4aGJ4+GiX5OKam8pVQrP5Ma
	 oIMBX8SyQmYzV0PZKgBd18axGczzWeVrwJuiYj+DUewFAbJSARb307sEqQvCsP07Fl
	 OHtIuXtd/7OOGvfrpwLWVnWvTLehnta6bMoF/wbJyAk0LNBc1MHkO71yvn7jfSNVbY
	 TdTJbm4A8EJUM8ohlxdABvtcKGjEyVJp+It1hoHu1opwnJ9vJNvjfcFI8Q/M2oaRD9
	 h5HAkjdAC3VrbwpQajwWq8memyVMJInyuQYDgQ9rIMVhKtaEfdTU/L8APdtapyDAA+
	 R6dTSjA6Lj8iw==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 17:05:25 +0200
Message-Id: <DB8GUTJA9QU1.X112WTV7ABZN@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude
 Paul" <lyude@redhat.com>, "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 3/9] rust: sync: atomic: Add ordering annotation
 types
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-4-boqun.feng@gmail.com>
 <4Ql5DIvfmXBHoUA428q2PelaaLNBI5Mi0jE3y3YPObJLRgY73zNZzQ8Pdl2qq25VWsMQFKUpYRHHQ1e7wFaGUw==@protonmail.internalid> <DB8BTA477Z2V.1J7XFLDXHMN2S@kernel.org> <87v7o0i7b8.fsf@kernel.org> <aG_RcB0tcdnkE_v4@Mac.home>
In-Reply-To: <aG_RcB0tcdnkE_v4@Mac.home>

On Thu Jul 10, 2025 at 4:42 PM CEST, Boqun Feng wrote:
> On Thu, Jul 10, 2025 at 02:00:59PM +0200, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>> > On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
>> >> +/// The trait bound for annotating operations that support any order=
ing.
>> >> +pub trait Any: internal::Sealed {
>> >
>> > I don't like the name `Any`, how about `AnyOrdering`? Otherwise we
>> > should require people to write `ordering::Any` because otherwise it's
>> > pretty confusing.
>>=20
>> I agree with this observation.
>>=20
>
> I'm OK to do the change, but let me show my arguments ;-)
>
> * First, we are using a language that supports namespaces,
>   so I feel it's a bit unnecessary to use a different name just because
>   it conflicts with `core::any::Any`. Doing so kinda undermines the
>   namespace concepts. And we may have other `Any`s in the future, are we
>   sure at the moment we should keyword `Any`?

I don't think `Any` is a good name for something this specific anyways.
If it were something private, then sure use `Any`, but since this is
public, I don't think `Any` is a good name.

> * Another thing is that this trait won't be used very often outside
>   definition of functions that having ordering variants, currently the
>   only users are all inside atomic/generic.rs.

I don't think this is a good argument to keep a bad name.

> I probably choose the `ordering::Any` approach if you guys insist.

I don't think we have a lint for that, so I'd prefer if we avoid that...

Someone is going to just `use ...::ordering::Any` and then have a
function `fn<T: Any>(_: T)` in their code and that will be very
confusing.

---
Cheers,
Benno

