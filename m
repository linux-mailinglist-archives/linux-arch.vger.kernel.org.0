Return-Path: <linux-arch+bounces-3951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728E8B1E02
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB5C285FD4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Apr 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1385624;
	Thu, 25 Apr 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ld0ONV5H"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76D284FC8;
	Thu, 25 Apr 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714037306; cv=none; b=lXoNPrbHykCA8xlEeJ+6lyRiWfWoLSaeiLRdaXNlPB0kJX/0BIAkmOSIOOMDuH+hcNc9cVBoREx+S1EqvX6plIh1CTsXqdI5KeaFxeUD1ksMB/wIwVcFXvPw5+YJfeHtUZbnsXjj0PZdzuX1m4e/fjuQreLhPH/mgACviGvjHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714037306; c=relaxed/simple;
	bh=dNnb/1qJ74rZ11oCWnJ46aTq5rkrxAFUBf2wVkykw+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMlqYZnD1xR1CZQYC/2GJsQ/ogQjFXZDzLYYmUMTj5/kd8D7rAOjbexT2Jb9URTITr07Y+z+37jH/OK7v3FcSgtAxe+2cinkjs67aRMtu70aVIe2kcgrHSNUUYxisKKj0NPY1nSTvzzFnAqIlITpcW84D7/xN4yUgSZimRWNcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ld0ONV5H; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2Zgzdc8bVIwFztt65g+xgtay+uCO2f+ZzLbfkYk6v1c=; b=Ld0ONV5HzIehLPpXBpxGFTUgf/
	Io2uQvl1my1KVYMM0jZLYVXTwiarZKNNfirjlNMPaMGXaylE46iZ1j/hQ+gG4jIyNPC25cGVPPoV3
	Cb4F9kAQubErw+1DLHSftowhQyYxk+pSTtPuxgzebeuOwXGrylBQBjF96uAd0nlti7jSrHErSb/4V
	oWQF0bp0TMhGFHLtbOOsGPO7j9GiBbQU2Iu3ysNICNY2+7LyiUG/tnSXU9Db4h2pC6T7tvwXtoycT
	s7eU5zr9eXNVU5RvMf2fgEZmUbR6cOzZV2BjAJx1Eru+g7U4/5dKNWDh8T6M1PXBIOGWiAM2O2CG4
	4Ze0hkfg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvOm-0000000EoZi-3Xul;
	Thu, 25 Apr 2024 09:28:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74649300439; Thu, 25 Apr 2024 11:28:12 +0200 (CEST)
Date: Thu, 25 Apr 2024 11:28:12 +0200
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
Message-ID: <20240425092812.GB21980@noisy.programming.kicks-ass.net>
References: <20240424191225.work.780-kees@kernel.org>
 <20240424191740.3088894-1-keescook@chromium.org>
 <20240424224141.GX40213@noisy.programming.kicks-ass.net>
 <202404241542.6AFC3042C1@keescook>
 <20240424225436.GY40213@noisy.programming.kicks-ass.net>
 <20240424230500.GG12673@noisy.programming.kicks-ass.net>
 <202404241621.8286B8A@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404241621.8286B8A@keescook>

On Wed, Apr 24, 2024 at 04:30:50PM -0700, Kees Cook wrote:

> > That is, anything that actively warns about signed overflow when build
> > with -fno-strict-overflow is a bug. If you want this warning you have to
> > explicitly mark things.
> 
> This is confusing UB with "overflow detection". We're doing the latter.

Well, all of this is confusing to me because it is not presented
coherently.

The traditional 'must not let signed overflow' is because of the UB
nonsense, which we fixed.

> > Signed overflow is not UB, is not a bug.
> > 
> > Now, it might be unexpected in some places, but fundamentally we run on
> > 2s complement and expect 2s complement. If you want more, mark it so.
> 
> Regular C never provided us with enough choice in types to be able to
> select the overflow resolution strategy. :( So we're stuck mixing
> expectations into our types.

Traditionally C has explicit wrapping for unsigned and UB on signed. We
fixed the UB, so now expect wrapping for everything.

You want to add overflow, so you should make that a special and preserve
semantics for existing code.

Also I would very strongly suggest you add an overflow qualifier to the
type system and please provide sane means of qualifier manipulation --
stripping qualifiers is painful :/

> Regardless, yes, someone intent on wrapping gets their expected 2s
> complement results, but in the cases were a few values started collecting
> in some dark corner of protocol handling, having a calculation wrap around
> is at best a behavioral bug and at worst a total system compromise.
> Wrapping is the uncommon case here, so we mark those.

Then feel free to sprinkle copious amounts of 'overflow' qualifiers in
the protocol handling code.

