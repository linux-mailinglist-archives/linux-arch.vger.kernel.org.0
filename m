Return-Path: <linux-arch+bounces-3941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325808B1695
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 00:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641801C24383
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 22:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4616EBE7;
	Wed, 24 Apr 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V23yVE2f"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D316192C;
	Wed, 24 Apr 2024 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999301; cv=none; b=Woh9lmbPQ78BZw6FEFfKiUKRNKnItZZ1PmyQfsS1OZ6g7SBLHzTsNtzJfTS5u8SPRp89ptiSq/mhpoVm2yhZv1ZzwuEkxksGbHQzKdWhWMcSrpOiCuDH/oJlWDdUsmZAdW27Wxg86ece9TzveMwuT9HkzZliDRQCKFhIHd0ISzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999301; c=relaxed/simple;
	bh=z9pMGRLrLzKVrELAWdWdsuiieAGr6M7d01DM3NJ5UWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClzlV5GM1w+vhVT2jQFHE6jsr/HPxEL8GO/28yCDBay//sZ45Td0LrIBj0Fpt5Khp9uSe1XwN3HPBRbEA7NJF2cyjtpxt/ndD8CuOoEc2NsAlexziQ9V8JlyxUAJBMRX+O1pPWlxj/Bi0SeTDb28uQGsN24a22VePiL5QK059JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V23yVE2f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0/eQjSTv8D6eZQAQWbqT2LJmg+Blfc0mgxAHCYd1hAM=; b=V23yVE2fnmFqMNMneHrFe2nxSM
	zIWX162MuXqByjLfKBbVwbcp0AzY6fOr+0zfvw3ceFos1ccHbkuaHaEJFbPDycFIj7r7MKcF3AoF9
	Ud6OrWWxfWsmc/D/+WPeVi1hgsxDm+xxuEvPjvu6V9rqYd4gytTsn/nUr0lGOIgRmdOThR/yErVzY
	Mp0SW0j3wOVIs5oVCS2IWT6ty3aWNKwgTx+o7gyzjjIXeUcvMSvHWtx/LYxCM2uEFyk5JbJnKhQqI
	ksWgC3vKtJidBTEq1tb37xRzuRV/Cv8knq5a8vixM6EfUhAnYGC4lr+jvFKN79uqdv+0symsrN1UX
	sZ19Qvcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlVc-0000000EdKy-3Czb;
	Wed, 24 Apr 2024 22:54:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6ACAD30043E; Thu, 25 Apr 2024 00:54:36 +0200 (CEST)
Date: Thu, 25 Apr 2024 00:54:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <20240424225436.GY40213@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404241542.6AFC3042C1@keescook>

On Wed, Apr 24, 2024 at 03:45:07PM -0700, Kees Cook wrote:
> On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> > 
> > > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> > >  
> > >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > >  {
> > > -	return i + xadd(&v->counter, i);
> > > +	return wrapping_add(int, i, xadd(&v->counter, i));
> > >  }
> > >  #define arch_atomic_add_return arch_atomic_add_return
> > 
> > this is going to get old *real* quick :-/
> > 
> > This must be the ugliest possible way to annotate all this, and then
> > litter the kernel with all this... urgh.
> 
> I'm expecting to have explicit wrapping type annotations soon[1], but for
> the atomics, it's kind of a wash on how intrusive the annotations get. I
> had originally wanted to mark the function (as I did in other cases)
> rather than using the helper, but Mark preferred it this way. I'm happy
> to do whatever! :)
> 
> -Kees
> 
> [1] https://github.com/llvm/llvm-project/pull/86618

This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
We've been writing code for years under that assumption.

You want to mark the non-wrapping case.




