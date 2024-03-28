Return-Path: <linux-arch+bounces-3120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF39887608
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AA81F228D6
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C42107;
	Sat, 23 Mar 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J5hqVNg1"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E67385
	for <linux-arch@vger.kernel.org>; Sat, 23 Mar 2024 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153296; cv=none; b=jgVxg0zYg8AzDtwPgyBOJ69mJNkd6ozda5jY9xiQtnVUOV8sU3bUwlRvqeX83AJjJn+rEHlyyibggdo4MTLwf+BbBuPEUvch9ZVuoBqRlyr2+hohV/GVWUPO3owRpRjgVuNLdR6Hl+f30itr6ZAMH2S9r9RzIDCr1bbzaTmyLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153296; c=relaxed/simple;
	bh=3oVdTJIWwBdIc+TKQQRMm1GvKnrkgkGxIRm7Lek5enI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajioqqfv4tXKBAeOU+zbZ4s0c3QOADvU5Ig/+h0k/PBhlA9C2w2SMZtRlF2BUHbjjXWFy4//G8O7NY0SGb91iqIKwL0SjuVo7dYYiVF5PAZrA9WRZATK5eMlSRe6ZpvAHji92GkIQ8RW+mhaF1rhVPJcGShD3mctEv8tH2Emoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J5hqVNg1; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 20:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711153290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdNz/STIRdapZrDiaLvH7XN2qY1HG1kHxZd/Wx1Un8Y=;
	b=J5hqVNg1ovC1cbzfglT1Aem53QApQiVgxGvj1QDflZlBhq5mrj7tPfnyEQpgE2h10cg3/9
	iRsZTFnNWZV/re8Qg/Q5rC5Kx+tv0Q0j1AXf9fr6v6KVn0TMsvEebKi9uxB9gZHRpvMlyO
	TPZkam0JSNG3vbeP00+HbzXJYh36TUE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
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
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 05:12:29PM -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 16:57, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > I wonder about that. The disadvantage of only supporting LKMM atomics is
> > that we'll be incompatible with third party code, and we don't want to
> > be rolling all of our own data structures forever.
> 
> Honestly, having seen the shit-show that is language standards bodies
> and incomplete compiler support, I do not understand why people think
> that we wouldn't want to roll our own.
> 
> The C++ memory model may be reliable in another decade. And then a
> decade after *that*, we can drop support for the pre-reliable
> compilers.
> 
> People who think that compilers do things right just because they are
> automated simply don't know what they are talking about.
> 
> It was just a couple of days ago that I was pointed at
> 
>     https://github.com/llvm/llvm-project/issues/64188

Besides that there's cross arch support to think about - it's hard to
imagine us ever ditching our own atomics.

I was thinking about something more incremental - just an optional mode
where our atomics were C atomics underneath. It'd probably give the
compiler people a much more effective way to test their stuff than
anything they have now.

