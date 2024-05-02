Return-Path: <linux-arch+bounces-4153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D88BA3D9
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2024 01:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EEC1F24E58
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFC42077;
	Thu,  2 May 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETNdkf05"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADF42056;
	Thu,  2 May 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691565; cv=none; b=rNmjdacY1BDMfANrBxG35sPprSnVlCK6aBTO9b4AAvy2ug3vbfCFeM5OHt4yUpuETI2jtP00tuNZwKV292RvYG4R9CQpIe2WU3sgYMV8LP0MLF6mBrGMZ6dPxaubl+JXmDq24p9nZ3l0HirMyVwfsdBy5O4htgKAgMw2ZMvK3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691565; c=relaxed/simple;
	bh=TtQvW0/ZSCONrgzyA1qdsSq+lg8LR2BWPI/SrrOPqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IacIV/QifQf9cVV0qYZm7LvwvxikM2bQ0xx03TU/kgShrSiLvsI6hIlqPonxh0dy1iSNUhCXb8LfgOS8EwFXNYLEBRW2bf+Gg835mznMaNgy/ytkrZHeF/VnDoIS+/6Gv2YlodJp5qvR6rp6ubpf6ITZzmS7WkRtpryOVTbJdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETNdkf05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236F0C113CC;
	Thu,  2 May 2024 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714691565;
	bh=TtQvW0/ZSCONrgzyA1qdsSq+lg8LR2BWPI/SrrOPqTA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ETNdkf05c90wLRFtuo3itrE3t33QU2QVWuu5jYT48FmyzfrkNcO7kOVGonsQUSCbY
	 f2sOBPJBmFuj0D/OtHLAc2WxtGhAWObLauu9sV+0Ahx8kTqrcjtCiVFfhouj1aww5c
	 3A8K5ZXOn+ukFgZ7lu46UXPV1wUKaeEmSZn/rXCqK8DFMVDUVhlS7zG4T5UOLYWEcN
	 xKiO0eZ51H6Tc/DW8tM1BeY07nxAuLbqI0ZuiQ8kMMassJwXQzQgAHyqjQy9HMpjAY
	 UEJ+GeqML7Wn7ZLrYQf7yicsOooQgJbRWAFkVIIvpqerR6uRcAMo7y7XCb32lmQ49V
	 Yan4bS1qgAFaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C644DCE0991; Thu,  2 May 2024 16:12:44 -0700 (PDT)
Date: Thu, 2 May 2024 16:12:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <3dac400c-d18f-4f4e-b598-cad6948362d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
 <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
 <20240502220757.GL2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502220757.GL2118490@ZenIV>

On Thu, May 02, 2024 at 11:07:57PM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 02:18:48PM -0700, Paul E. McKenney wrote:
> 
> > If you are only ever doing atomic read-modify-write operations on the
> > byte in question, then agreed, you don't care about byte loads and stores.
> > 
> > But there are use cases that do mix smp_store_release() with cmpxchg(),
> > and those use cases won't work unless at least byte store is implemented.
> > Or I suppose that we could use cmpxchg() instead of smp_store_release(),
> > but that is wasteful for architectures that do support byte stores.
> > 
> > So EV56 adds the byte loads and stores needed for those use cases.
> > 
> > Or am I missing your point?
> 
> arch/alpha/include/cmpxchg.h:
> #define arch_cmpxchg(ptr, o, n)                                         \
> ({                                                                      \
>         __typeof__(*(ptr)) __ret;                                       \
>         __typeof__(*(ptr)) _o_ = (o);                                   \
>         __typeof__(*(ptr)) _n_ = (n);                                   \
>         smp_mb();                                                       \
>         __ret = (__typeof__(*(ptr))) __cmpxchg((ptr),                   \
>                 (unsigned long)_o_, (unsigned long)_n_, sizeof(*(ptr)));\
>         smp_mb();                                                       \
>         __ret;                                                          \
> })
> 
> Are those smp_mb() in there enough?
> 
> I'm probably missing your point, though - what mix of cmpxchg and
> smp_store_release on 8bit values?

One of RCU's state machines uses smp_store_release() to start the
state machine (only one task gets to do this) and cmpxchg() to update
state beyond that point.  And the state is 8 bits so that it and other
state fits into 32 bits to allow a single check for multiple conditions
elsewhere.

							Thanx, Paul

