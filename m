Return-Path: <linux-arch+bounces-3940-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D958E8B1679
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 00:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F331C23E67
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B2616E88D;
	Wed, 24 Apr 2024 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IILmx88m"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D716E885;
	Wed, 24 Apr 2024 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999096; cv=none; b=eWKc2W+gcoStE0SRov9o29++CFxnCfo8reTOvT4BVb9xm7oQ7pBKxUrnevwrAjLKEe7DZ8KRt/DLbdsbVZIxjTE/qwf5jEjuBZ3hdcmy2pBXfesmRdfl7wjStOEIc/yxDZqG2m0u1yyO2FPasZUj5TLJCL3i8DHvycfzyCwO6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999096; c=relaxed/simple;
	bh=0RsNjdeYSfUc0k8oq/Nv37S+nYzUNW+CoiEKuah2oCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8ki4G3h1GwgLTAphsfSuIdQ303yBzkk9Ft0LvZaKEF3KaJP9qss4tVU0B9OI8+XefzoTfE85KzKRi8Jm7Ug8AQqVihhtfZONDRKpvv+oTVleylnVNpG1UStiulg6a7/JErYViwyMoxODFE3LLr/dAyzM4IjcMNu0svMdOmwmNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IILmx88m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDrKK9MVu5GzHed4YiXOORHenuiRjCroUzkRtpq7Xr8=; b=IILmx88mD8vjiMwqrMmrre+9AR
	zlcY2kqPjYZncZiBJFj6pnDAU0ZhhuV4rlxSZ7HcxKqBCjBa6OOs5ocvCCax/S8NxxWj84EAxqbEL
	MFaNqZ2luw6imVBZuIGe/aG75GB7MYXZ5lbY0rcrAoNUxUNRBMpXuO1Am0ZJdsHYjENsjxw6Ycf9d
	99F8TBD+1jTtbHGf1q71XtM4hbBSu5Sgx4e9bcidXHlwPBNvG5kZMloqH84s7AtrC9VybE9Mi1Ref
	bJ1tegqi+pDWrgGvKx5eWVrDjQV3HCkjx2HtVZHUWlmRO6p1QgZOtIk+xYyIuM3ifm9ITathoorRw
	g3AhKNoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlSU-00000001qPk-444P;
	Wed, 24 Apr 2024 22:51:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F02930040C; Thu, 25 Apr 2024 00:51:22 +0200 (CEST)
Date: Thu, 25 Apr 2024 00:51:22 +0200
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
Message-ID: <20240424225122.GF12673@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224141.GX40213@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> 
> > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  
> >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> > -	return i + xadd(&v->counter, i);
> > +	return wrapping_add(int, i, xadd(&v->counter, i));
> >  }
> >  #define arch_atomic_add_return arch_atomic_add_return
> 
> this is going to get old *real* quick :-/
> 
> This must be the ugliest possible way to annotate all this, and then
> litter the kernel with all this... urgh.

Also, what drugs is involved with __builtin_add_overflow() ? Per
-fno-strict-overflow everything is 2s complement and you can just do the
unsigned add.

Over the years we've been writing code with the express knowledge that
everything wraps properly, this annotation is going to be utter pain.

As I've said before, add an explicit non-wrapping type and use that for
the cases you care about actually not wrapping.

NAK

