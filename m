Return-Path: <linux-arch+bounces-3949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EF8B1DB1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 11:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2117B23B3E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423783CBE;
	Thu, 25 Apr 2024 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cUfaqNiQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89B839E5;
	Thu, 25 Apr 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036712; cv=none; b=GMJVU3AzpUVH/WZPbyC91g6WvoTcaGOmWLXU1yHy03mlCZSUez9EG++vKg18CP+N+nAL9R4CIzSg3gjIEj0YNAUJH1egpww8t58JO50oFFYmiWtSTG8ZmRxDOURsUcPVQPgrhuP3Dv/sh9ZXm2pz81JMO5gEU3hWHAzi07pVz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036712; c=relaxed/simple;
	bh=WJcbJq6LPOWVruhsjLEhcR+OLsCXSYTfrE6Km6Lfsek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKRpwcyPCcB/VqnttHK9kKbVaaAQ0iQp2PaAlPgtnM5FnAOwtEC86eBTPMYRWBO6FDPjiP+AVtdu7I6RQjmCEaFxvz29azQIEo9J8ywj3imD4UUyaZW6oxmkXIfWglf+LgZuruFZQMmSvZsePjys+szr3TMtnNdrGFw816jnW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cUfaqNiQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jlPcJXkfaMmGAq8OZN68om84KUfyIjul/ITuXAN1MVw=; b=cUfaqNiQ1wHARDkNj7QYMhforS
	oUBl99r29hGkUAx0ATQXOmidPsrbimAcpWld3NxErjYM+LG1bGal2QMllDh8Qo+YJh/byUx73lQcx
	T9U064kALKGeNkvlWmHEYXJpp0/TnSoJiZl0lE6JLfitzsmNHVmkedxIJEUCzwBI+K0Wyc1mc/xAn
	NkmIaqNeXf1zjcqNHbHl5q1iGmBz96CD9vvn0D3Pekz7DQtrKCIpBuDOYUfGyRfIstn3+qHMPdGDQ
	wCLTiSQMnlvCroykbX41A+4lHANWK6RwM43Itb3tjEngRxTVWe47uz4Y6AlwWgnrjM92HpeWPK6Dc
	TiTAk90Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvEn-0000000EoTr-1G9l;
	Thu, 25 Apr 2024 09:17:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 623D4300439; Thu, 25 Apr 2024 11:17:52 +0200 (CEST)
Date: Thu, 25 Apr 2024 11:17:52 +0200
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
Message-ID: <20240425091752.GA21980@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <202404241602.276D4ADA@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404241602.276D4ADA@keescook>

On Wed, Apr 24, 2024 at 04:20:20PM -0700, Kees Cook wrote:

> > This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
> > We've been writing code for years under that assumption.
> 
> Right, which is why this is going to take time to roll out. :) What we
> were really doing with -fno-strict-overflow was getting rid of undefined
> behavior. That was really really horrible; we don't need the compiler
> hallucinating.

Right, but that then got us well defined semantics for signed overflow.

> > You want to mark the non-wrapping case.
> 
> What we want is lack of ambiguity. Having done these kinds of things in
> the kernel for a while now, I have strong evidence that we get much better
> results with the "fail safe" approach, but start by making it non-fatal.
> That way we get full coverage, but we don't melt the world for anyone
> that doesn't want it, and we can shake things out over a few years. For
> example, it has worked well for CONFIG_FORTIFY, CONFIG_UBSAN_BOUNDS,
> KCFI, etc.

The non-fatal argument doesn't have bearing on the mark warp or mark
non-wrap argument though.

> The riskier condition is having something wrap when it wasn't expected
> (e.g. allocations, pointer offsets, etc), so we start by defining our
> regular types as non-wrapping, and annotate the wrapping types (or
> specific calculations or functions).

But but most of those you mention are unsigned. Are you saying you're
making all unsigned variables non-wrap by default too? That's bloody
insane.

> For signed types in particular, wrapping is overwhelmingly the
> uncommon case, so from a purely "how much annotations is needed"
> perspective, marking wrapping is also easiest. Yes, there are cases of
> expected wrapping, but we'll track them all down and get them marked
> unambiguously. 

But I am confused now, because above you seem to imply you're making
unsigned non-wrap too, and there wrapping is *far* more common, and I
must say I hate this wrapping_add() thing with a passion.

> One thing on the short list is atomics, so here we are. :)

Well, there are wrapping and non-wrapping users of atomic. If only C had
generics etc.. (and yeah, _Generic doesn't really count).

