Return-Path: <linux-arch+bounces-4926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E570909E20
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jun 2024 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466401C20329
	for <lists+linux-arch@lfdr.de>; Sun, 16 Jun 2024 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3108B171BB;
	Sun, 16 Jun 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="feWXWjPK"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4114F90
	for <linux-arch@vger.kernel.org>; Sun, 16 Jun 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718551414; cv=none; b=FnZkMJz3IsJ0f7RE00EbYfzxa6cR/ms7nEjZEX3/Gk6imW+mD/P3qJ08qAmc8ifceO8N20/cHUz4vhj+cUMvPUbZ2hpmoGHB9pU379Mwt0vq999cGIvUFt84IavA51K3pXfPyUfSf6szGMS4P8aheuP/wULdAMCo5/veCb6LLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718551414; c=relaxed/simple;
	bh=No/yQzvhSQo5eA4MVA3Ontr93OnajiTCJcU9VnBHmPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqPfzIyZQ/CA17o1vs+/Nnj19gw9ggejaiKxkMJfIUsjoHpmBG9m6tHDS2fOGXCLTgyxMG6BPUBQpLHXVbn0dluYM4PFmbZyKT9p9zsrU3GEMpCibc84cctnawW8hkEbhc0G9FeF5Bqc6dyMvV5JW90HTBPui0qkyDbBEVDeeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=feWXWjPK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: boqun.feng@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718551409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y0ywigxrcxoZLMnkkInJwDOVqW5TO6Aw/Ls7GsS5vA=;
	b=feWXWjPKXXY7VhKtIp2DrasCgMafipVFZJqsNNTR46i50F7JtgPaTyHGZrVzvKgTPXfIop
	WWU8jryipa3fHFey+xiAVr+eIxX5lyPSUIT/Q0P7ZxQlWEfNatfhz+vepE0+dVYnnvuUCE
	RgLLOMq/CTSyPIrdJhB58exbhTZzXR8=
X-Envelope-To: benno.lossin@proton.me
X-Envelope-To: miguel.ojeda.sandonis@gmail.com
X-Envelope-To: gary@garyguo.net
X-Envelope-To: rust-for-linux@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: alex.gaynor@gmail.com
X-Envelope-To: wedsonaf@gmail.com
X-Envelope-To: bjorn3_gh@protonmail.com
X-Envelope-To: a.hindborg@samsung.com
X-Envelope-To: aliceryhl@google.com
X-Envelope-To: stern@rowland.harvard.edu
X-Envelope-To: parri.andrea@gmail.com
X-Envelope-To: will@kernel.org
X-Envelope-To: peterz@infradead.org
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: dhowells@redhat.com
X-Envelope-To: j.alglave@ucl.ac.uk
X-Envelope-To: luc.maranget@inria.fr
X-Envelope-To: paulmck@kernel.org
X-Envelope-To: akiyks@gmail.com
X-Envelope-To: dlustig@nvidia.com
X-Envelope-To: joel@joelfernandes.org
X-Envelope-To: nathan@kernel.org
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: kent.overstreet@gmail.com
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: elver@google.com
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: hpa@zytor.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: tmgross@umich.edu
X-Envelope-To: dakr@redhat.com
Date: Sun, 16 Jun 2024 11:23:20 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <zq5p4o6j4avgncfacqrz6naaw7yqk4e5fbmwz547ge7xi52vmq@zjk3ncmsdrkk>
References: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 16, 2024 at 07:16:30AM -0700, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 05:51:07AM -0400, Kent Overstreet wrote:
> > On Sat, Jun 15, 2024 at 03:12:33PM -0700, Boqun Feng wrote:
> > > What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> > > need to do 1 or 2 until the real users show up.
> > > 
> > > And I'd like also to point out that there are a few more trait bound
> > > designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> > > have different sets of API (no inc_unless_negative() for u32).
> > > 
> > > Don't make me wrong, I have no doubt we can handle this in the type
> > > system, but given the design work need, won't it make sense that we take
> > > baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> > > already have real users, and then if there are some values of generic
> > > atomics, we introduce them and have proper discussion on design.
> > > 
> > > To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> > > What's the downside? A bit specific example would help me understand
> > > the real concern here.
> > 
> > Err, what?
> > 
> > Of course we want generic atomics, and we need that for properly
> > supporting cmpxchg.
> > 
> 
> Nope. Note this series only introduces the atomic types (atomic_ C
> APIs), but cmpxchg C APIs (no atomic_ prefix) are probably presented via
> a different API, where we need to make it easier to interact with normal
> types, and we may use generic there.
> 
> > Bogun, you've got all the rust guys pushing for doing this with
> > generics, I'm not sure why you're being stubborn here?
> 
> Hmm? Have you seen the email I replied to John, a broader Rust community
> seems doesn't appreciate the idea of generic atomics.

Apologies, I appear to have gotten things backwards in my pre-coffee
reading, I'll have to catch up on the whole thread :)

