Return-Path: <linux-arch+bounces-3955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB28B1F01
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F045B2A85C
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860938614D;
	Thu, 25 Apr 2024 10:19:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8515D477;
	Thu, 25 Apr 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040364; cv=none; b=U9en/363kDOcA31yCesWJJU/10bZttUTdw3kk0lgb4iP9mVU/9LT76toAddPqMx57o324gvQ5yBZ4ufQnt32AwQMgrXyHaVt37YW5xomgbui5y2KonIJrK3V45Yuvz8fMaLNd8I2F77zkyzHfjSrXNg7+zy3kEM7adS7TfvLjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040364; c=relaxed/simple;
	bh=CO0oG3tcPoAXzns4+gVCxaDMq9og+CQjT5fProCOaYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1PhFs5Omqf+39P6V+RRp+e68aLle5ILFkZNrKy/ZxIB31XjtZgEHNEKJHsv1HHaBeGg8a5ElOIDqce5Xuj6x9RRaCvaRFEnftKANYbkDL7BphXnPa39sQhybfsB31KIRQNk46ofe6R8ND4IRGorx7aLsfuxhXS+WjHHsasIQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7F6F2F;
	Thu, 25 Apr 2024 03:19:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E2B3F64C;
	Thu, 25 Apr 2024 03:19:18 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:19:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
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
Message-ID: <ZiouI6rM8x83nXUF@FVFF77S0Q05N>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <20240424230500.GG12673@noisy.programming.kicks-ass.net>
 <202404241621.8286B8A@keescook>
 <20240425092812.GB21980@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425092812.GB21980@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 11:28:12AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 04:30:50PM -0700, Kees Cook wrote:
> 
> > > That is, anything that actively warns about signed overflow when build
> > > with -fno-strict-overflow is a bug. If you want this warning you have to
> > > explicitly mark things.
> > 
> > This is confusing UB with "overflow detection". We're doing the latter.
> 
> Well, all of this is confusing to me because it is not presented
> coherently.
> 
> The traditional 'must not let signed overflow' is because of the UB
> nonsense, which we fixed.
> 
> > > Signed overflow is not UB, is not a bug.
> > > 
> > > Now, it might be unexpected in some places, but fundamentally we run on
> > > 2s complement and expect 2s complement. If you want more, mark it so.
> > 
> > Regular C never provided us with enough choice in types to be able to
> > select the overflow resolution strategy. :( So we're stuck mixing
> > expectations into our types.
> 
> Traditionally C has explicit wrapping for unsigned and UB on signed. We
> fixed the UB, so now expect wrapping for everything.
> 
> You want to add overflow, so you should make that a special and preserve
> semantics for existing code.
> 
> Also I would very strongly suggest you add an overflow qualifier to the
> type system and please provide sane means of qualifier manipulation --
> stripping qualifiers is painful :/

I agree that having an overflow/nooverflow qualifier that's separate from
signed/unsigned would make more sense than inferring that from signed vs
unsigned.

Mark.

