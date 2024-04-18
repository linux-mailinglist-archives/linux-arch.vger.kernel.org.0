Return-Path: <linux-arch+bounces-3815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B418AA5C0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 01:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A12A1F21ADB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B2495CB;
	Thu, 18 Apr 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce0ASPgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAA2E41C;
	Thu, 18 Apr 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482510; cv=none; b=CZH5B9O2KUg2VjuCNQFE6HX4Bb/CmIM0GMahhntimv+KdUf98MKMjMmsDti3NyWPc2enux/jgxZDHzkyc1tf66vaQm6AZgjGinCjN4NIuIAEuOjTPuSZq4xtjSz4r0GVNF6cE4njrYqIwTZEf2rPaqIXyIQoXpHG3y8W6FNN67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482510; c=relaxed/simple;
	bh=dzxvq6I5MOiA+x8U3pxHwdsyCxcbLN+w/BGN0JJSvvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOQ9I/PL7tE1A8Kvm/z/7GhWzESRrGEnpq/wDemwcE+xBYUGnb0htwLfcbjeNyilGHGdBCmfyShl8rNIMHgz/oNvLq5ujjRU7nqESdIKMPZHFWGUKjg8A/+v7oO2lgCAgIwsifFkpaoeQWDNvVY0YTiUMHrj9bgUxLBC1AnyuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce0ASPgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C585BC113CC;
	Thu, 18 Apr 2024 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713482510;
	bh=dzxvq6I5MOiA+x8U3pxHwdsyCxcbLN+w/BGN0JJSvvU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ce0ASPggVM3gvb5vctWsZjOCjy4IdytPqulNMC7utAYhDf0V/N3ZuYvMDTF2FcgKn
	 JJ84GJtk/DZuVVpAFEtn1ljT58BMCvumGpif5rW4j7qlU+6mLGdQaDU7SvkugtcFDj
	 YhdZYi7TADD8jCsy06WitTN/BBcpkKzhewLHzHtfl6/3KYo+8y9MgbLlJp1hmx6f9+
	 SPHwWOoy2/1eoppm5QyvqjmGlnAZuLqhIn6C+PmrnYUOZu7z+YMCnl3zOTfaxetNo3
	 Sczjd8qDH7ICY1LUcjv6ujvVorrdhi3YjOWLs73xF2nzijOg9fnc9Vf/JbmBYnuSeo
	 3U7z3MxSZCw3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7DCC4CE0444; Thu, 18 Apr 2024 16:21:46 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:21:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH cmpxchg 13/14] xtensa: Emulate one-byte cmpxchg
Message-ID: <620a10e8-f5c0-4e23-8403-492ab1c7f110@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-13-paulmck@kernel.org>
 <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXAB-9GPqNBJKF=JtWNfhBv168N6eko-9VcLmLSeQaS4Q@mail.gmail.com>

On Thu, Apr 18, 2024 at 10:06:21AM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Mon, Apr 8, 2024 at 7:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.
> >
> > [ paulmck: Apply kernel test robot feedback. ]
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks for your patch!
> 
> > --- a/arch/xtensa/include/asm/cmpxchg.h
> > +++ b/arch/xtensa/include/asm/cmpxchg.h
> > @@ -74,6 +75,7 @@ static __inline__ unsigned long
> >  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> >  {
> >         switch (size) {
> > +       case 1:  return cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
> 
> The cast is not needed.

In both cases, kernel test robot yelled at me when it was not present.

Happy to resubmit without it, though, if that is a yell that I should
have ignored.

							Thanx, Paul

> >         case 4:  return __cmpxchg_u32(ptr, old, new);
> >         default: __cmpxchg_called_with_bad_pointer();
> >                  return old;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

