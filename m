Return-Path: <linux-arch+bounces-3145-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC673887D71
	for <lists+linux-arch@lfdr.de>; Sun, 24 Mar 2024 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F2F1F21264
	for <lists+linux-arch@lfdr.de>; Sun, 24 Mar 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097FA18641;
	Sun, 24 Mar 2024 15:22:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BFA0518638
	for <linux-arch@vger.kernel.org>; Sun, 24 Mar 2024 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711293764; cv=none; b=EhmoeCxNugq/GAGzzZw/4fwkGTrdjNonELM+hv36/zBkpvbNjuIeKR0ui36eNXSARGUSqxiDf6xmoKvp3wGEygMi2EaZvKLSsmqR31RWk09yeXN9LfmEH3q01Nf7sgInMN8YFZbKH+xbKM6TmH7VoBit05woKySQwfkiW5EKBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711293764; c=relaxed/simple;
	bh=SuH1hMVA2o74FCs6AvGI7dXDMoRLsBXOu5zkwoZfD8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paZMTEiA6+s/fwFzF4qP2nOmUsZTs7NyAreV2doy+2D64sZRYgSZhoZWJRkrp1D3lUgSUkJ5rrRL7vxwSqk2mDCZGptJsJkZgsOXfi1C0nBlMJww8vioO2prYY9kkgTEV7eFR3pl8vOckKWAi17a1gs+T7G44mJDYirci6o2Jm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 820911 invoked by uid 1000); 24 Mar 2024 11:22:41 -0400
Date: Sun, 24 Mar 2024 11:22:41 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: comex <comexk@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
  Kent Overstreet <kent.overstreet@linux.dev>,
  Boqun Feng <boqun.feng@gmail.com>,
  rust-for-linux <rust-for-linux@vger.kernel.org>,
  linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
  llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
  =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@samsung.com>,
  Alice Ryhl <aliceryhl@google.com>, Andrea Parri <parri.andrea@gmail.com>,
  Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
  Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>,
  Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
  "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
  Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>,
  Nathan Chancellor <nathan@kernel.org>,
  Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
  Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
  Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
  "H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>,
  linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <174272a1-e21f-4d85-94ab-f0457bd1c93b@rowland.harvard.edu>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <C85BE4F4-5847-45B4-A973-76B184B35EDE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C85BE4F4-5847-45B4-A973-76B184B35EDE@gmail.com>

On Sat, Mar 23, 2024 at 05:40:23PM -0400, comex wrote:
> That may be true, but the LLVM issue you cited isn’t a good example.  
> In that issue, the function being miscompiled doesn’t actually use any 
> barriers or atomics itself; only the scaffolding around it does.  The 
> same issue would happen even if the scaffolding used LKMM atomics.
> 
> For anyone curious: The problematic optimization involves an 
> allocation (‘p’) that is initially private to the function, but is 
> returned at the end of the function.  LLVM moves a non-atomic store to 
> that allocation across an external function call (to ‘foo’).  This 
> reordering would be blatantly invalid if any other code could observe 
> the contents of the allocation, but is valid if the allocation is 
> private to the function.  LLVM assumes the latter: after all, the 
> pointer to it hasn’t escaped.  Yet.  Except that in a weak memory 
> model, the escape can ‘time travel’...

It's hard to understand exactly what you mean, but consider the 
following example:

int *globalptr;
int x;

int *f() {
	int *p = kzalloc(sizeof(int));

	L1: *p = 1;
	L2: foo();
	return p;
}

void foo() {
	smp_store_release(&x, 2);
}

void thread0() {
	WRITE_ONCE(globalptr, f());
}

void thread1() {
	int m, n;
	int *q;

	m = smp_load_acquire(&x);
	q = READ_ONCE(globalptr);
	if (m && q)
		n = *q;
}

(If you like, pretend each of these function definitions lives in a 
different source file -- it doesn't matter.)

With no optimization, whenever thread1() reads *q it will always obtain 
1, thanks to the store-release in foo() and the load-acquire() in 
thread1().  But if the compiler swaps L1 and L2 in f() then this is not 
guaranteed.  On a weakly ordered architecture, thread1() could then get 
0 from *q.

I don't know if this is what you meant by "in a weak memory model, the 
escape can ‘time travel'".  Regardless, it seems very clear that any 
compiler which swaps L1 and L2 in f() has a genuine bug.

Alan Stern

