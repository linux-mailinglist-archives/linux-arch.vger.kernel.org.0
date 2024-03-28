Return-Path: <linux-arch+bounces-3116-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B7E8875E9
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39A21C219E6
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D6682C96;
	Fri, 22 Mar 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u71BeYo8"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A482C71
	for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2024 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151873; cv=none; b=IV23EaSJiiEinKTfGw1gLJyxgx919WG2lQgiv+eJP5VcUFUpQeqEhZEduw9u5KXeWhdzIf2i6Cvombzi8Z6nwZsQd+vBrKh1j3dYhMaNRDORsqqq79YcqKm87R7xqZb4FcmHQYmQZbdxZdJkjNmTQHtZK6TX/zB9v08OFYqxI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151873; c=relaxed/simple;
	bh=gHKzUe8JzF89dHoFO0MdDMvtGmOiIhrk5YeCQO2D14Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7wAmKa0w8l6NohmeRtJld5Ny5IOuQfM/iVfcrb8VIPgwg0a9/GcJFYc6zSNnKV8298lPgyl/z8z+vZnCqzvRFNz3nHm6t4XFKvUzsGWlUbnxrWDnE667MYOhyr/BHO+mMdrV3zYqUr9ALsmkgiqXebVh4VPV8jBZ3sAEzmIlbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u71BeYo8; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 19:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711151869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzaOVOcWvV/nA21QW9YCB5ZLkXvzMsM78SbUFC/cEIU=;
	b=u71BeYo8ZPPBx6zr7bjzI7c8dcXHxeJlKAd5L/MOx7wYcQg4q0IZx9gmNGikve9VrVZYQy
	ZefMTKuAcyE0DNidFJO0phvDd/T3yRH/CZvA7jq3XM6XsFq1j7rnE9x1MC1/FN7Qktod1f
	QyjixmECOSwLtVmjm8Br0fFffn0ZVxk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322233838.868874-1-boqun.feng@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 04:38:35PM -0700, Boqun Feng wrote:
> Hi,
> 
> Since I see more and more Rust code is comming in, I feel like this
> should be sent sooner rather than later, so here is a WIP to open the
> discussion and get feedback.
> 
> One of the most important questions we need to answer is: which
> memory (ordering) model we should use when developing Rust in Linux
> kernel, given Rust has its own memory ordering model[1]. I had some
> discussion with Rust language community to understand their position
> on this:
> 
> 	https://github.com/rust-lang/unsafe-code-guidelines/issues/348#issuecomment-1218407557
> 	https://github.com/rust-lang/unsafe-code-guidelines/issues/476#issue-2001382992
> 
> My takeaway from these discussions, along with other offline discussion
> is that supporting two memory models is challenging for both correctness
> reasoning (some one needs to provide a model) and implementation (one
> model needs to be aware of the other model). So that's not wise to do
> (at least at the beginning). So the most reasonable option to me is:
> 
> 	we only use LKMM for Rust code in kernel (i.e. avoid using
> 	Rust's own atomic).
> 
> Because kernel developers are more familiar with LKMM and when Rust code
> interacts with C code, it has to use the model that C code uses.

I wonder about that. The disadvantage of only supporting LKMM atomics is
that we'll be incompatible with third party code, and we don't want to
be rolling all of our own data structures forever.

Do we see a path towards eventually supporting the standard Rust model?

Perhaps LKMM atomics could be reworked to be a layer on top of C/C++
atomics. When I last looked, they didn't look completely incompatible;
rather, there is a common subset that both support with the same
semantics, and either has some things that it supports and the other
doesn't (i.e., LKMLL atomics have smp_mb__after_atomic(); this is just a
straightforward optimization to avoid an unnecessary barrier on
architectures where the atomic already provided it).

