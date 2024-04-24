Return-Path: <linux-arch+bounces-3942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E868B16D3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92881B270A9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 23:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDB16EC0F;
	Wed, 24 Apr 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gguesAFc"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56901157465;
	Wed, 24 Apr 2024 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999917; cv=none; b=t1YM76KR7MNw78iurpAbF1UjSrsPT2uf+DCQZqgQYMfzWndLGrw1cWZLQA0RDzDhCjXD5fylNMTjdF3pRvL04PDTuITH0mlA+56axv0md/oxhr59KO/UZOV0bbIR9kHVR2r+ytblqU2C+vRWsNbGnTNCSxbKgF1J1C67sB77xD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999917; c=relaxed/simple;
	bh=pKPm/zrzVvXlCmLdiEV2pW5uSOyfPaBjLWmKfuO257Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/cTNiXlOjEkvEv4fWGq/aQlO4ZW63mHzUr6cINeL8qH4obG6Y9TmWTj3BYucpUCzZWOA3w9TVkj7yfNSPei4Mh3DlqwTf17Mt91QNQrqwfQAVh7szCD6moFh5nhWHULOGVDuT6Ep/eAIpJptRqc9PjGXzzyFMN3mgII8n13Hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gguesAFc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZkT+6J58bxSG5zYwuGwSSUyrEmL9IGY39TrZq4eGklU=; b=gguesAFcokKJCJyv+QBKjsgZkg
	Fxm+aLJmRjFH3615INiPM5LIlxwiF4CsTlJ1OgKbQRjMejaxSaekr0J5Q9EcfUVpHeF7vZyiSzeS9
	p0OCpCAwDtAdvwws0QfVLDE2BS4eWwZljuMyX1OwIDrOMk+SLGSFTLRh/JDvLg/il3VcbmXD3ehLq
	kBCeD/cbRa/ECD0aoX2bXfVpS3VRV/N8ImQqlND9Jh3WnUW7qllGyGdHLcyhMeZBzNKtlC5Rq6fuj
	IhBplFbSM5K+cacg3KipHlduBx35xJl+lom25sOLDExia1u37DaBXudyimcXF0Sr9kTyQBN49TPBF
	qNo9oERg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlfg-0000000EdWW-2rpA;
	Wed, 24 Apr 2024 23:05:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5529830043E; Thu, 25 Apr 2024 01:05:00 +0200 (CEST)
Date: Thu, 25 Apr 2024 01:05:00 +0200
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
Message-ID: <20240424230500.GG12673@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424225436.GY40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:54:36AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 03:45:07PM -0700, Kees Cook wrote:
> > On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> > > On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> > > 
> > > > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> > > >  
> > > >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > > >  {
> > > > -	return i + xadd(&v->counter, i);
> > > > +	return wrapping_add(int, i, xadd(&v->counter, i));
> > > >  }
> > > >  #define arch_atomic_add_return arch_atomic_add_return
> > > 
> > > this is going to get old *real* quick :-/
> > > 
> > > This must be the ugliest possible way to annotate all this, and then
> > > litter the kernel with all this... urgh.
> > 
> > I'm expecting to have explicit wrapping type annotations soon[1], but for
> > the atomics, it's kind of a wash on how intrusive the annotations get. I
> > had originally wanted to mark the function (as I did in other cases)
> > rather than using the helper, but Mark preferred it this way. I'm happy
> > to do whatever! :)
> > 
> > -Kees
> > 
> > [1] https://github.com/llvm/llvm-project/pull/86618
> 
> This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
> We've been writing code for years under that assumption.
> 
> You want to mark the non-wrapping case.

That is, anything that actively warns about signed overflow when build
with -fno-strict-overflow is a bug. If you want this warning you have to
explicitly mark things.

Signed overflow is not UB, is not a bug.

Now, it might be unexpected in some places, but fundamentally we run on
2s complement and expect 2s complement. If you want more, mark it so.

