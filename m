Return-Path: <linux-arch+bounces-3962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337398B27AD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B30B20D7B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ECB14EC48;
	Thu, 25 Apr 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="daInXeQu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B14D6F5
	for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2024 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714066763; cv=none; b=oUKON1AKr6ILvpXO0Rcub+xvx02YUZ0xp31gfOAOM81c2aRZoMt7Mt7Bdn0yfzLyo4QrZOabfmky1Du6sRyFAwsW9E7keURjmjC0CyJ56zBmExCxGPO/poVkl9wdNVysJOa6OMfkeOHyKQ0szLDQ7t6ecgRzwmV/ExNOl3BmWQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714066763; c=relaxed/simple;
	bh=kB9KMA3DcvNtLyh0bj0IRDkpYiWpOT4msDbmbXW4p7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYSFlxkAxRHXD/ILMsmVmBI3KkE79GDtL+EDnaKuwdkvWkUnb3FR3whMH0sEgQEOub5HqqiiQemQx5cR/Hi6aCGrF3/lSsozF3K5OLoLaeLs/zRNXucciARQ/i01Tr2Rn9oyn4IlHQ8VdcXJHD56Mmbt2gqeEVyXnCni+CUedP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=daInXeQu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed01c63657so1270138b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Apr 2024 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714066762; x=1714671562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGRp4J8KaAZoR1Iq7v17JFw6BNoCDdtd2vscqG11gNs=;
        b=daInXeQuKW7uLwE9YPmL2yzFp19SkUFqvF4AsQMUS7hgBUtAKgAe5ExqLSbb6Ih3V6
         05WwXwd0OAJzAKtJ1J7iYMQVqQMnYvaCbzqEyRMLaZoeCJ5/QppEjegzasyVYmGkPxWQ
         R6iiHgLLuxtsP53/QLHAmxttdefaZe0SYKuo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714066762; x=1714671562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGRp4J8KaAZoR1Iq7v17JFw6BNoCDdtd2vscqG11gNs=;
        b=Ej3Aa7DilFBLrJcpWxD0OraMzPu1n1wjZuwnRaJ0nrJI75m/3hTMiX6XBZ5KWdLZTI
         7UnHR2dlNyfbrgEgAUeh8MOesTF2QepIofkQXAxH3KOoFKCxLug7bzn0Xmxvqoy+oflF
         Sp2Av3aq7E/gClNBufW/cBZjj6TNfXVFvS7tyTWpvAuOn0cFzufB/9LH851RXySlzFng
         R4hBACVlB7lHXZHI0MCILkFgL7UMM6EymwR64acqr6z4WBAw7QidJK56yKIJZgjJh5co
         3PsHSUwgecy3wDMeNuKLdmBUG6qah2/uqSQA+5Vk0mqRIM/N7dduL8fQxkJvD1jj7H+h
         EQXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqjc/TWifzqgUo6ZPErxx7dF5+bhWmo8dLVmZ8mxujkTlBzG9exaZk0nwkl/ioYMTRwR1i22yT9qUoKDUW34wFOAfIZ0yBdTYXOA==
X-Gm-Message-State: AOJu0YxA47Gi7uJn6dgBto9mQGk0tJcqIdyW6KcsXEOJW1I+wuz1sv3n
	Bv+AJD/JZd5MHh5Ui7e52VgCuhF9q1GnWbU4CjqduyhhpJixpY+VnZ7QfPi/yw==
X-Google-Smtp-Source: AGHT+IHo6ruBh+6PnC5lx4dAR90eGtu9va6/DL9++gNNA1zkeY3/L32beujc9vp0VhFbPkSwUX9WUg==
X-Received: by 2002:a05:6a20:5b12:b0:1ad:3d93:b71e with SMTP id kl18-20020a056a205b1200b001ad3d93b71emr347251pzb.59.1714066761597;
        Thu, 25 Apr 2024 10:39:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ck16-20020a17090afe1000b002a2f6da006csm13262979pjb.52.2024.04.25.10.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:39:21 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:39:20 -0700
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
Message-ID: <202404251019.2DF0A48@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <202404241602.276D4ADA@keescook>
 <20240425091752.GA21980@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425091752.GA21980@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 11:17:52AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 04:20:20PM -0700, Kees Cook wrote:
> 
> > > This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
> > > We've been writing code for years under that assumption.
> > 
> > Right, which is why this is going to take time to roll out. :) What we
> > were really doing with -fno-strict-overflow was getting rid of undefined
> > behavior. That was really really horrible; we don't need the compiler
> > hallucinating.
> 
> Right, but that then got us well defined semantics for signed overflow.

Yes, and this gets us to the next step: disambiguation for general
users. It's good that we have a well-defined overflow resolution strategy,
but our decades of persistent wrap-around flaws in the kernel show
that many devs (even experienced ones) produce code with unexpected and
unwanted (to the logic of the code) wrap-around. So we have to find a
way to distinguish wrapping and non-wrapping operations or types up
front and in a clear way.

> 
> > > You want to mark the non-wrapping case.
> > 
> > What we want is lack of ambiguity. Having done these kinds of things in
> > the kernel for a while now, I have strong evidence that we get much better
> > results with the "fail safe" approach, but start by making it non-fatal.
> > That way we get full coverage, but we don't melt the world for anyone
> > that doesn't want it, and we can shake things out over a few years. For
> > example, it has worked well for CONFIG_FORTIFY, CONFIG_UBSAN_BOUNDS,
> > KCFI, etc.
> 
> The non-fatal argument doesn't have bearing on the mark warp or mark
> non-wrap argument though.

This gets at the strategy of refactoring our code to gain our unambiguous
coverage. Since we can't sanely have a flag-day, we have to go piecemeal,
and there will continue to be places where the coverage was missed, and
so we want to progress through marking wrapping cases without BUGing the
kernel. (We don't care about catching non-wrapping -- the exceptional
condition is hitting an overflow.)

> > The riskier condition is having something wrap when it wasn't expected
> > (e.g. allocations, pointer offsets, etc), so we start by defining our
> > regular types as non-wrapping, and annotate the wrapping types (or
> > specific calculations or functions).
> 
> But but most of those you mention are unsigned. Are you saying you're
> making all unsigned variables non-wrap by default too? That's bloody
> insane.

We have a mix (and a regular confusion even in core code) where "int"
gets passed around even though at one end or another of a call chain
it's actually u32 or u16 or whatever. Regardless, yes, the next step
after signed overflow mitigation would be unsigned overflow mitigation,
and as you suggest, it's much more tricky.

> > For signed types in particular, wrapping is overwhelmingly the
> > uncommon case, so from a purely "how much annotations is needed"
> > perspective, marking wrapping is also easiest. Yes, there are cases of
> > expected wrapping, but we'll track them all down and get them marked
> > unambiguously. 
> 
> But I am confused now, because above you seem to imply you're making
> unsigned non-wrap too, and there wrapping is *far* more common, and I
> must say I hate this wrapping_add() thing with a passion.

Yes, most people are not a fan of the wrapping_*() helpers, which is why
I'm trying to get a typedef attribute created. But again, to gain the
"fail safe by default" coverage, we have to start with the assumption
that the default is non-wrapping, and mark those that aren't. (Otherwise
we're not actually catching unexpected cases.) And no, it's not going
to be over-night. It's taken almost 5 years to disambiguate array bounds
and we're still not done. :)

> > One thing on the short list is atomics, so here we are. :)
> 
> Well, there are wrapping and non-wrapping users of atomic. If only C had
> generics etc.. (and yeah, _Generic doesn't really count).

Non-wrapping users of atomics should be using refcount_t, which is
our non-wrapping atomic type. But regardless, atomics are internally
wrapping, yes?

Anyway, I suspect this whole plan needs wider discussion. I will write
up a more complete RFC that covers my plans, including the rationale for
why we should adopt this in a certain way. (These kinds of strategic RFCs
don't usually get much traction since our development style is much more
"show the patches", so that's why I have been just sending patches. But
since it's a pretty big topic, I'll give it a shot...)

-- 
Kees Cook

