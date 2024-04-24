Return-Path: <linux-arch+bounces-3944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6E8B1710
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 01:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FB4281E89
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2036816F0CF;
	Wed, 24 Apr 2024 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PuaOvteq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D9157467
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001454; cv=none; b=qZn77MHwv4XNxAeBlks9uU1Q6cuDFUgTzqp125prw3schYrSE7IvZ6ENtYZ4C6lH6zG8SxxzCHvCPelV0T+F5krPwe2N9yAWTxMmQYdYSbqjEaMKAyww3M/8rSV/uj87iiuiekVfgAOrmwDesxbYhBT1x0urzbbohlY+h1P1KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001454; c=relaxed/simple;
	bh=oH09D5zkFXRFNfU7QJiNFf+gIh+lrRtBdFHPc4eg0Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+rvZWCwCacAIqgZhT96gaWWmWvxxxlPptWkvCHiKCglTuUCtts2rNavcdVc0hZ/h55CY3g+KtKbAAAu2rRRDZqC/nDUIAkQTIwNscTEDKgaG3CJLYMkylPzrTlmM4fSY9SH8rnOwUz42+Qe15HxhB11aIiPVTiSi8SI2NjCdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PuaOvteq; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ad2da2196bso216518eaf.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 16:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714001452; x=1714606252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwtnqARf0+6Z9GG1dv72c6Df9XT02q1HeJoWwzmw6v8=;
        b=PuaOvteq0mMRgO3Jlb2dgmiCdAPFB3Btc8zIHX74LLL3fcOxKUNDdejxB4uqBY5JPG
         gzeSqc5Q6og7ag+mA85KLwOLD2cgygAFMqFSk4UJczXMpWloJJYfcMV9Dq0DpY7UpbE3
         IpKBWIDyFj1vZDAhupVMhZaYLMQxGDePYUc5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001452; x=1714606252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwtnqARf0+6Z9GG1dv72c6Df9XT02q1HeJoWwzmw6v8=;
        b=QRvgcBZG/eogg0PUopAID7SZ44o6p+xd48OHHhqzDgkS5+MQ9o7cG+TxhTBC/WrWnU
         8cG91GuUe3VM7XtZa8qi88uDYlakpthbbe1LFOuenYR/VbXZYMotrlGjqN/8KCXJ1l9e
         pKahFuZwDqOAUv4ELsBjlovfZC95zNj36lEUBEcyIZV0OhK2K/1m0G3WwFNIOKtquzdU
         N5fEfmrF7MUShiOx5lwqb9ZZ5bOWGnBT9MUAjSfxFCOyEi4H8O2KQIAVlTPDo0yI8MVg
         nfr2w5lHEZL8L6gpdbR9GaaArwtqlYLY4Ddi2xQJMVCtJisaJV7v66dxe7UQAUgY4FLF
         4PMA==
X-Forwarded-Encrypted: i=1; AJvYcCUxPI+OB6Fru/QUHyYJBYV5LyfVB9JSwoiJ6KdjSMfsKPkkKmQIDK1S7Gcqy+kTsmfpEfS9VGmK+CWBKr4WMtfXp1Qbjxgx9UjdPw==
X-Gm-Message-State: AOJu0Yy2ZS9z4PDq8+fWdcXxDxhbcMVz3YGc6zT9bthmTT7tTSV4Cqrf
	j6VKWgHsXHaEsE7f+Iro53Hh8b25/3Ri85PPm7MlXAc8t4fMf/f7turROwdl9w==
X-Google-Smtp-Source: AGHT+IG1ie+7N7gLAuYGp0jXBUvNN0VNl/qnLnqCCnwse0PJuc/S/QdeclEgnM1MgF3ysfsWuiww9g==
X-Received: by 2002:a05:6871:7410:b0:233:56e5:ff99 with SMTP id nw16-20020a056871741000b0023356e5ff99mr4180313oac.23.1714001451762;
        Wed, 24 Apr 2024 16:30:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k73-20020a636f4c000000b005df41b00ee9sm600140pgc.68.2024.04.24.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 16:30:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:30:50 -0700
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
Message-ID: <202404241621.8286B8A@keescook>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <20240424230500.GG12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424230500.GG12673@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 01:05:00AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 12:54:36AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 24, 2024 at 03:45:07PM -0700, Kees Cook wrote:
> > > On Thu, Apr 25, 2024 at 12:41:41AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Apr 24, 2024 at 12:17:34PM -0700, Kees Cook wrote:
> > > > 
> > > > > @@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> > > > >  
> > > > >  static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > > > >  {
> > > > > -	return i + xadd(&v->counter, i);
> > > > > +	return wrapping_add(int, i, xadd(&v->counter, i));
> > > > >  }
> > > > >  #define arch_atomic_add_return arch_atomic_add_return
> > > > 
> > > > this is going to get old *real* quick :-/
> > > > 
> > > > This must be the ugliest possible way to annotate all this, and then
> > > > litter the kernel with all this... urgh.
> > > 
> > > I'm expecting to have explicit wrapping type annotations soon[1], but for
> > > the atomics, it's kind of a wash on how intrusive the annotations get. I
> > > had originally wanted to mark the function (as I did in other cases)
> > > rather than using the helper, but Mark preferred it this way. I'm happy
> > > to do whatever! :)
> > > 
> > > -Kees
> > > 
> > > [1] https://github.com/llvm/llvm-project/pull/86618
> > 
> > This is arse-about-face. Signed stuff wraps per -fno-strict-overflow.
> > We've been writing code for years under that assumption.
> > 
> > You want to mark the non-wrapping case.
> 
> That is, anything that actively warns about signed overflow when build
> with -fno-strict-overflow is a bug. If you want this warning you have to
> explicitly mark things.

This is confusing UB with "overflow detection". We're doing the latter.

> Signed overflow is not UB, is not a bug.
> 
> Now, it might be unexpected in some places, but fundamentally we run on
> 2s complement and expect 2s complement. If you want more, mark it so.

Regular C never provided us with enough choice in types to be able to
select the overflow resolution strategy. :( So we're stuck mixing
expectations into our types. (One early defense you were involved in
touched on this too: refcount_t uses a saturating overflow strategy, as
that works best for how it gets used.)

Regardless, yes, someone intent on wrapping gets their expected 2s
complement results, but in the cases were a few values started collecting
in some dark corner of protocol handling, having a calculation wrap around
is at best a behavioral bug and at worst a total system compromise.
Wrapping is the uncommon case here, so we mark those.

-- 
Kees Cook

