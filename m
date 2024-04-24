Return-Path: <linux-arch+bounces-3943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBED8B16FE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 01:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9595C2869A5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 23:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB3516EC1A;
	Wed, 24 Apr 2024 23:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjOkppfY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FECC16F0C6
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714000823; cv=none; b=kbSQ6O4R6B4QPnKFmprzoMucH/9aFldqJa0ikYd7cWMbLmRrjFMq6sCwDRC3ilkfXprWaxmmZhV16DIuf/CCgQ43s/RnCQaRmHbepiAKzwd7PBBAHvePSkXdgn61GUqT3cZsLVMrOl6fg7QU10m1clJhtjzs9o4eLMCL5cIVq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714000823; c=relaxed/simple;
	bh=xMdC6gPfhPx0eqt9pE8Cf6dx1C6F38ZaVJBhnbPRa2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWvKYD6ADgCg7mCbbWZav7g8rHPdcITM52L3I9W1vjHS1YJwjx7AICUDY5cynaP1bu70UiIMqdX9EU5zfVdgLzRUBDv+UJKDjQVNCDVAyAgAo77lzc7xjRMzFd8+22jCf8aWJkNLloacr6OJHJwxJygFL84+aUSAHozg2OUbAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YjOkppfY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1eab16dcfd8so1388855ad.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714000821; x=1714605621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53galFO5b9NlY6rYFvZBx1xxKB41abzyybNlJJlu7mM=;
        b=YjOkppfYENLsgSowL4ZSX3/HwEPO/rWaGdecpkQt5gyw/H5ZATAG+gW+W2tC+ojKok
         MDqG3tof6H/HtrbSwsMYkIbwjtGjzCmmqvw2O5Sw6eFYjDC33lZoOHsxxzCcHM0elPT6
         YEf1+Ieh2UUWDqca+ScK4hNpsq1jjUD6IVZak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714000821; x=1714605621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53galFO5b9NlY6rYFvZBx1xxKB41abzyybNlJJlu7mM=;
        b=L5k1XACzyM2tAjDFBHHawDklqvufTX+eil/4/nXFCmbq/uOh5rJPGXCFwF3j9P7pCN
         uP6gIOHoQ9UJk43X0Hm+LeJFj8YSsaZWwVSflkVwj2GAJu3STsrxcTlBCNedXIvUOe1b
         tP+IAalWfNl3plY8GXpEUfGg5p6NvJTqAhyJNxtVnjAyArm/wne5n0Jzso96O+vCfIp8
         FFgB8IfRbQY6tsxhy8gn/+VobXEk5wURtnmV9A3tEma3EH3gBTHC5NiSHPU5Pw0RvBaT
         vFO7rAWJNPiOYO00p9phTUIam8o2493+Fh8vEEALDppSrRXHaLJNHBikSnMZBRkBcJoY
         pGgw==
X-Forwarded-Encrypted: i=1; AJvYcCULXq4E8mwWWXW44pvP+Vt14tfuYhJVh/Oqq3WyAqxYni7ltj+rnqqhdlyYDlvZ5BQUYDCFaPOozxrmoa2ufi5cfTRqecA/K5rwsQ==
X-Gm-Message-State: AOJu0Yzt3PZiYG8phAZ4FO1U+umOfAaEyRyUs4lgOAG+yF7PIATS92rO
	FCxQ7hpF1MiWn6xKhVNMB8jRUr1vqqyyF8bzfEGhUjcWOgWlCxV0zN3AkuH23Q==
X-Google-Smtp-Source: AGHT+IFMkYJNAfNLSmk4oPnPeYVule+RDiUbFbapsmqTHjfPM7QXarEC91Pvng6lRM//0u2jQSClHg==
X-Received: by 2002:a17:902:868f:b0:1dd:2eed:52a5 with SMTP id g15-20020a170902868f00b001dd2eed52a5mr3803324plo.37.1714000821414;
        Wed, 24 Apr 2024 16:20:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b001dd0c5d5227sm12448914plg.193.2024.04.24.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:20:20 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:20:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <202404241602.276D4ADA@keescook>
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

Right, which is why this is going to take time to roll out. :) What we
were really doing with -fno-strict-overflow was getting rid of undefined
behavior. That was really really horrible; we don't need the compiler
hallucinating.

> You want to mark the non-wrapping case.

What we want is lack of ambiguity. Having done these kinds of things in
the kernel for a while now, I have strong evidence that we get much better
results with the "fail safe" approach, but start by making it non-fatal.
That way we get full coverage, but we don't melt the world for anyone
that doesn't want it, and we can shake things out over a few years. For
example, it has worked well for CONFIG_FORTIFY, CONFIG_UBSAN_BOUNDS,
KCFI, etc.

The riskier condition is having something wrap when it wasn't expected
(e.g. allocations, pointer offsets, etc), so we start by defining our
regular types as non-wrapping, and annotate the wrapping types (or
specific calculations or functions).

For signed types in particular, wrapping is overwhelmingly the
uncommon case, so from a purely "how much annotations is needed"
perspective, marking wrapping is also easiest. Yes, there are cases of
expected wrapping, but we'll track them all down and get them marked
unambiguously. One thing on the short list is atomics, so here we are. :)

-Kees

-- 
Kees Cook

