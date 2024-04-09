Return-Path: <linux-arch+bounces-3527-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2289E22E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AC11C21FA2
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904C156892;
	Tue,  9 Apr 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWFfObJa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51837156870;
	Tue,  9 Apr 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686126; cv=none; b=OrMQZ6XFtoHtWx1/sYUZcruQozG4xYpuPggGaRQ+cjtWeIJLOIPAxPvQcbEPr8UO4AJ0LzZl+pslJ7U5GtcwyNDPtmueRqK9gUtMeH97y6qcG+9S5cYz3ToCg8jX+TPh3BOGJ4QBPBOazMyq/LoopSKwGoDI9d18d3dXMlFAhak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686126; c=relaxed/simple;
	bh=85j4q3S1t04tNE6JB8FUGp/zM0rF5jeGqXukKGZIwB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSv31NlaFkPY4wwnT1sa63MNVoKICfaTPcYiCyST6ZHovu0o8dGw9HlJsbUdLmsgNQn/qBsdCl/DRyEU8Lk+p/Ju6ctkbAlq7tWhxUHWl6YGy06Fh2Ky/NiICrCiaMU5mbsDbn9pNQspKaBhBeOvXT7EhHoTuvODbFwmuZq2/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWFfObJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE7C433F1;
	Tue,  9 Apr 2024 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712686125;
	bh=85j4q3S1t04tNE6JB8FUGp/zM0rF5jeGqXukKGZIwB8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XWFfObJahR4l3e3uA+Um8HE6AygMEhnv4bCi5uqEYCNZZTVj1BkO+ics7yp5isjRu
	 XTl9VJ1Heemw0EVSXQkbkn1uRpKtweJ5JFUrs0RXOJFWHGdpX3tZYHsKdYNSB3kTGv
	 ZMHv+9y9VRcVLo0XE7iXYmKnajbPaEPNDBEtixTqVk4jV/sMenodN9fpWaHLkJ/gQq
	 UC3KtaGxT0XvrIo2fZtkYmYqG5SkjGo9JbpT907wczYKK7ZTOArqIclMG8/2riLh38
	 WLfS1Ccke+e/PTlNnhm5K+mCbKyqLcefYmbnqk3v+mVa3j1K7IZNlMReiHqywDZ8Px
	 hNfJbVuwqV9qg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8815FCE2D22; Tue,  9 Apr 2024 11:08:45 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:08:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	torvalds@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH cmpxchg 14/14] riscv: Emulate one-byte cmpxchg
Message-ID: <bb4e43b1-21dc-4e82-87c9-0ce4c5791d7d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
 <20240408174944.907695-14-paulmck@kernel.org>
 <ZhV8a+pWAnJQ3Ljp@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhV8a+pWAnJQ3Ljp@andrea>

On Tue, Apr 09, 2024 at 07:35:39PM +0200, Andrea Parri wrote:
> Hi Paul,
> 
> > @@ -170,6 +171,9 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +		break;							\
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -214,6 +218,9 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> > @@ -260,6 +267,9 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			RISCV_RELEASE_BARRIER				\
> > @@ -306,6 +316,9 @@
> >  	__typeof__(*(ptr)) __ret;					\
> >  	register unsigned int __rc;					\
> >  	switch (size) {							\
> > +	case 1:								\
> > +		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
> > +		break;							\
> >  	case 4:								\
> >  		__asm__ __volatile__ (					\
> >  			"0:	lr.w %0, %2\n"				\
> 
> Seems the last three are missing uintptr_t casts?

Indeed they are, and good eyes!

However, Liu, Yujie beat you to it, and this commit contains the fix:

4d5c72a34948 ("riscv: Emulate one-byte cmpxchg")

							Thanx, Paul

