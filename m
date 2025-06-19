Return-Path: <linux-arch+bounces-12399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09C1AE08CC
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484653B04E5
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 14:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526831DB92C;
	Thu, 19 Jun 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ssaMiAxK"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277B2248AB;
	Thu, 19 Jun 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343544; cv=none; b=fI7Osx/DD0ITvlQsjrb0c4s+RoLw7kSvcDdya87doDSaL7tte4m74swEC8gLIbDyS/IbexxBZvhIT8Gl54aLTdXKie2lpNYn2H1Cj9RKgMmElrxH+uPyjYZw15pAIArx0SO+sd8ekeZMMdBf5orRfVBwy3KeKLoZ1KRRHQwR/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343544; c=relaxed/simple;
	bh=+lGGauceAgecoodgkOWaPseFJ5G5VSZiH3HBHzKffqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHKopyth0qd3VLoeU3n+n4Jlq+81/H6KWr8UY6YyhrYdRyjglG103QrRyL8rfBXpg3S5BHYXNpil8M/VM1XJ33lTSt4ib5cF2SXcRMwWZUqqrPXS5fSd0ne9pqMYRyk1VPkaoT0ubx/tdKJAhQvXlbA2MCm7fx6ZzW+ilntIw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ssaMiAxK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FxYqUBO/i9JK9DafKPTMkfssky1LNkMmgnzIrT+GOPc=; b=ssaMiAxKNfkamTbRQCOoy6KJpJ
	HG9kLWD8ejmLYMWlz8h3FSOED33y9V5p7RdZJdiggUEORapwHvJ6lnYZA+qnb74QMoAZKJQ/+xixW
	bvddgrrO+A8zgN7p/d/fkjNi8sYM0UrEVcq0DzvOx1f4BIaUBafYgzsdt7VO4Tt4B8PrKiMPgnYrU
	3fxE2eVsdC3VOCuacQGMIscIoSgS/571vW4MkdVLTg0/pOL4RJ/Pl3Gnp9TzxC115J8J0cvt/hGlU
	FH7TvAoWwwkOWvXduJ4OY889nriBJpvDe0uBR4EOKygrkr4SnC6DVsY3OVGaP+jIfJt6vqrpQKa14
	CB/YZQuQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSGJM-000000095gu-0evK;
	Thu, 19 Jun 2025 14:32:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0902D30890E; Thu, 19 Jun 2025 16:32:15 +0200 (CEST)
Date: Thu, 19 Jun 2025 16:32:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
 <aFQQuf44uovVNFCV@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQQuf44uovVNFCV@Mac.home>

On Thu, Jun 19, 2025 at 06:29:29AM -0700, Boqun Feng wrote:
> On Thu, Jun 19, 2025 at 12:31:55PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 18, 2025 at 09:49:27AM -0700, Boqun Feng wrote:
> > 
> > > +//! Memory orderings.
> > > +//!
> > > +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> > > +//!
> > > +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> > 
> > So I've no clue what the Rust memory model states, and I'm assuming
> > it is very similar to the C11 model. I have also forgotten what LKMM
> > states :/
> > 
> > Do they all agree on what RELEASE+ACQUIRE makes?
> > 
> 
> I think the question is irrelevant here, because we are implementing
> LKMM atomics in Rust using primitives from C, so no C11/Rust memory
> model in the picture for kernel Rust.

The question is relevant in so far that the comment refers to them; and
if their behaviour is different in any way, this is confusing.

> But I think they do. I assume you mostly ask whether RELEASE(a) +
> ACQUIRE(b) (i.e. release and acquire on different variables) makes a TSO
> barrier [1]? We don't make it a TSO barrier in LKMM either (only
> unlock(a)+lock(b) is a TSO barrier) and neither does C11/Rust memory
> model.
> 
> [1]: https://lore.kernel.org/lkml/20211202005053.3131071-1-paulmck@kernel.org/

Right, that!

So given we build locks from atomics, this has to come from somewhere.

The simplest lock -- TAS -- is: rmw.acquire + store.release.

So while plain store.release + load.acquire might not make TSO (although
IIRC ARM added variants that do just that in an effort to aid x86
emulation); store.release + rmw.acquire must, otherwise we cannot
satisfy that unlock+lock.


