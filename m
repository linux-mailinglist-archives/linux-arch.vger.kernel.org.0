Return-Path: <linux-arch+bounces-3181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4FD88B4EE
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02295302F77
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E391C82D67;
	Mon, 25 Mar 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wXtpZzz+"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9418120A
	for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407744; cv=none; b=LZBB0NJnhNqjUeIw8gQRFNHUIBMn7YU8t/NpZROARtvobFqffD9UU5sAUuf3P1gNDh3duyvqFjUcwo2skXMuX52AS6CuvzX8qY2f/n/U839pRjR8y+b8oUGi9HxLBkBYOhaMhc6Rw3BMePI2FfNw7asrsl3xHwbYz5xPmIgc6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407744; c=relaxed/simple;
	bh=dhq0wQ4bujebEG50JtGVBPe0IzvhPlIu9QTxgHCBYrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVABe76wEebfRcFEG6fri6W0hkgld3c6hM2oQ+/+G1KySR95G3afwXVB8JEOzRiUVTubGa8/qSdfYB99WBx1cYC2xltwbSYt6t7ZuZe/NZP+jS3q5xzE+ps7f/RUM+jtAXuoZn2tDW3ktgr8SzHIgC9uyWp5MyhbJuuDPXQjwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wXtpZzz+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 19:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711407740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxKin5CBbhEIAweuWYc8DioXtjMxoM71TwtnDHIUDg8=;
	b=wXtpZzz+EduHqpjv2yQJ/1+huRaSLUOj/BhnESIDJX+64BPTIqn4GfMWMG5DypUmOGGcCp
	Y3Hhw+9huSxrjpkwByZNRTCJ88Nf2FJAeBHqDrepgT/XhuDEAC8r8vfuuJfpajBzdp+kAP
	jJ01xhfozQfS/FE+Szl07wuyU1u8oNk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Philipp Stanner <pstanner@redhat.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <qo6z3j2h32rzwr6bcnkrrw7irdqwakgymcf2jodnq5nz3simwq@tqydlv4mctrv>
References: <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
 <ZgHuioMM1cAWNDiX@boqun-archlinux>
 <jyijwrrzzhlsrffj37xj4sskipxqbxfewydnb3yzgybjobj6tg@cbv5y7znhm3n>
 <ZgH86EUON30lUk6m@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgH86EUON30lUk6m@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 03:38:32PM -0700, Boqun Feng wrote:
> On Mon, Mar 25, 2024 at 06:09:19PM -0400, Kent Overstreet wrote:
> > On Mon, Mar 25, 2024 at 02:37:14PM -0700, Boqun Feng wrote:
> > > On Mon, Mar 25, 2024 at 05:14:41PM -0400, Kent Overstreet wrote:
> > > > On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> > > > > On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > > > >
> > > > > > To be fair, "volatile" dates from an era when we didn't have the haziest
> > > > > > understanding of what a working memory model for C would look like or
> > > > > > why we'd even want one.
> > > > > 
> > > > > I don't disagree, but I find it very depressing that now that we *do*
> > > > > know about memory models etc, the C++ memory model basically doubled
> > > > > down on the same "object" model.
> > > > > 
> > > > > > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > > > > > with modern thinking, just done with the tools available at the time. A
> > > > > > more modern version would be just
> > > > > >
> > > > > > __atomic_load_n(ptr, __ATOMIC_RELAXED)
> > > 
> > > Note that Rust does have something similiar:
> > > 
> > > 	https://doc.rust-lang.org/std/ptr/fn.read_volatile.html
> > > 
> > > 	pub unsafe fn read_volatile<T>(src: *const T) -> T
> > > 
> > > (and also write_volatile()). So they made a good design putting the
> > > volatile on the accesses rather than the type. However, per the current
> > > Rust memory model these two primitives will be UB when data races happen
> > > :-(
> > > 
> > > I mean, sure, if I use read_volatile() on an enum (whose valid values
> > > are only 0, 1, 2), and I get a value 3, and the compiler says "you have
> > > a logic bug and I refuse to compile the program correctly", I'm OK. But
> > > if I use read_volatile() to read something like a u32, and I know it's
> > > racy so my program actually handle that, I don't know any sane compiler
> > > would miss-compile, so I don't know why that has to be a UB.
> > 
> > Well, if T is too big to read/write atomically then you'll get torn
> > reads, including potentially a bit representation that is not a valid T.
> > 
> > Which is why the normal read_volatile<> or Volatile<> should disallow
> > that.
> > 
> 
> Well, why a racy read_volatile<> is UB on a T who is valid for all bit
> representations is what I was complaining about ;-)

yeah, that should not be considered UB; that should be an easy fix. Are
you talking to Rust compiler people about this stuff? I've been meaning
to make my own contacts there, but - sadly, busy as hell.

> > > > where T is any type that fits in a machine word, and the only operations
> > > > it supports are get(), set(), xchg() and cmpxchG().
> > > > 
> > > > You DO NOT want it to be possible to transparantly use Volatile<T> in
> > > > place of a regular T - in exactly the same way as an atomic_t can't be
> > > > used in place of a regular integer.
> > > 
> > > Yes, this is useful. But no it's not that useful, how could you use that
> > > to read another CPU's stack during some debug functions in a way you
> > > know it's racy?
> > 
> > That's a pretty difficult thing to do, because you don't know the
> > _layout_ of the other CPU's stack, and even if you do it's going to be
> > changing underneath you without locking.
> > 
> 
> It's a debug function, I don't care whether the data is accurate, I just
> want to get much information as possible.

yeah, if you just want the typical backtrace functionality where you're
just looking for instruction pointers - that's perfectly
straightforward.

> This kinda of usage, along
> with cases where the alorigthms are racy themselves are the primary
> reasons of volatile _accesses_ instead of volatile _types_. For example,
> you want to read ahead of a counter protected by a lock:
> 
> 	if (unlikely(READ_ONCE(cnt))) {
> 		spin_lock(lock);
> 		int c = cnt; // update of the cnt is protected by a lock.
> 		...
> 	}
> 
> because you want to skip the case where cnt == 0 in a hotpath, and you
> know someone is going to check this again in some slowpath, so
> inaccurate data doesn't matter.

That's an interesting one because in Rust cnt is "inside" the lock, you
can't access it at all without taking the lock - and usually that's
exactly right.

So to allow this we'd annotate in the type definition (with an
attribute) which fields we allow read access to without the lock, then
with some proc macro wizardry we'd get accessors that we can call without
the lock held.

So that probably wouldn't be a Volatile<T> thing, that'd be coupled with
the lock implementation because that's where the accessors would hang
off of and they'd internally probably just use mem::volatile_read().

> > So the races thare are equivalent to a bad mem::transmute(), and that is
> > very much UB.
> > 
> > For a more typical usage of volatile, consider a ringbuffer with one
> > thread producing and another thread consuming. Then you've got head and
> > tail pointers, each written by one thread and read by another.
> > 
> > You don't need any locking, just memory barriers and
> > READ_ONCE()/WRITE_ONCE() to update the head and tail pointers. If you
> > were writing this in Rust today the easy way would be an atomic integer,
> > but that's not really correct - you're not doing atomic operations
> > (locked arithmetic), just volatile reads and writes.
> > 
> 
> Confused, I don't see how Volatile<T> is better than just atomic in this
> case, since atomc_load() and atomic_store() are also not locked in any
> memory model if lockless implementation is available.

It certainly compiles to the same code, yeah. But Volatile<T> really is
the more primitive/generic concept, Atomic<T> is a specialization.

> > Volatile<T> would be Send and Sync, just like atomic integers. You don't
> > need locking if you're just working with single values that are small
> > enough for the machine to read/write atomically.
> 
> So to me Volatile<T> can help in the cases where we know some memory is
> "external", for example a MMIO address, or ringbuffer between guests and
> hypervisor. But it doesn't really fix the missing functionality here:
> allow generating a plain "mov" instruction on x86 for example on _any
> valid memory_, and programmers can take care of the result.

You're talking about going completely outside the type system, though.
There is a need for that, but it's very rare and something we really
want to discourage. Usually, even with volatile access, you do know the
type - and even if you don't, you have to treat it as _something_ so
Volatile<ulong> is probably as good as anything.

