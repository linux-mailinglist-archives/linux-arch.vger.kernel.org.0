Return-Path: <linux-arch+bounces-3954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218408B1EEA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9171F24B08
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563C86AE2;
	Thu, 25 Apr 2024 10:15:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583B8595B;
	Thu, 25 Apr 2024 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040126; cv=none; b=O/RRX0aJXoNXQ+goVKvX4KMAl+3FHo05UUJv3TGbYEQdbbeIvnOHuB1nBl8VKG5vvsWBL1T5ESkeLMM9nGg9Qd+zywtS7S74sIaeEY+5T/Od0n0U/vuSl1eJEsTU0NSvqLDfcKhC++b5S/DczaNP8gjfNUiKdcOaVZAy51oNsvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040126; c=relaxed/simple;
	bh=Qq1AnccoHrm0GNohxKCpb5x/v0HAT6PjJOBCntlXYtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6WST0OEfYvhV5RFeizsnFeOU9uCi7iYeCR0dQH7n5XUsLWncDTeL4gorLF0GJ+LqmetWc6sSPML1yZmZXrKkgqt9Md2hT8Ktpi9A1PupTg/3zc9mtQPfAQNPaFes4HkNkaodG8sinFDf7oj2/nFY+ymo11ia0ngvG/oVe8UYRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52511063;
	Thu, 25 Apr 2024 03:15:52 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B875E3F64C;
	Thu, 25 Apr 2024 03:15:20 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:15:17 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
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
Message-ID: <ZiotNVLD3ek-9Lwj@FVFF77S0Q05N>
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

To be clear, I dislike the function annotation because then it applies to
*everything* within the function, which is overly broad and the intent becomes
unclear. That makes it painful to refactor the code (since e.g. if we want to
add another operation to the function which *should not* wrap, that gets
silenced too).

I'm happy with something that applies to specific types/variables or specific
operations (which is what these patches do).

As to whether or not we do this at all I'll have to defer to Peter.

Mark.

