Return-Path: <linux-arch+bounces-4684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C387C8FBAEA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E4F1F21568
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BF14A0AE;
	Tue,  4 Jun 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPCjPD6W"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC418635;
	Tue,  4 Jun 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523437; cv=none; b=iWoImuAk9WRtylTHD0rZxE3AdzIxwGrNQ07wckzTV2nSWceLnpk0hSRZJEP/DbAhBSXjoBh0Kg/w6ObgIOItsmL7WZgREKl2yXjyzoCd9On5YoOl8ELgrsdZ5uoaTPd8RqoGocxRB2iAgTdU2mQQcVtRMkhAt21Q3LsCmiZdDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523437; c=relaxed/simple;
	bh=4F6vgrbahpKxMp5okPGxh+uimyVwC2GU53G2uKd2VSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMZ2I2QXwAOqtohHOEOkNp+iwRatvsob45Xj+5CjsbEsAMc5nvvm6T+nh4bOgnh0nbl8k1OJaUH/U5UWqevLTHN0JOaVGgYN/NtiRa8Kf4PWUOvfRKl6WOJJuyN61nAfF88xPR4y335lWS2gj5WlnZSmxgg3CDX0IZYK6BlSDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPCjPD6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93364C2BBFC;
	Tue,  4 Jun 2024 17:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523436;
	bh=4F6vgrbahpKxMp5okPGxh+uimyVwC2GU53G2uKd2VSQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DPCjPD6W1Z4YtpEVniUUymu550RPaoTM8IJo0f5QcqN6KyBmaJhpftlbl9DQuhT5C
	 EKi2iON4CITLK8LYkfRo9cheDXZzbjj7aFVtk0NOzKJ+SDOQEFV6Jc7vRMCe+XyJ8F
	 nvQndTSefWkXtiVwvGkHU0NTlkz3pQAxXPGpnWqNZ9Azdq3ix6psWdWbRaBOeQzFm+
	 QmTbkXauVM272lqHIHKDvkbgQX9SZ/e1Jww8Xl17NkFjkWcSeJDMQ42M60gDEFkjzF
	 4OqCQB+kPy3VcASSWYgqFrLPdZEDsy4vD2mQnWNNLdPjwEiwYVLujnGCb+gQ6ZfZoA
	 CPbhsZlMAq7Gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 34390CE3F09; Tue,  4 Jun 2024 10:50:36 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:50:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, elver@google.com, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, dianders@chromium.org,
	pmladek@suse.com, torvalds@linux-foundation.org, arnd@arndb.de,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v3 cmpxchg 2/4] sh: Emulate one-byte cmpxchg
Message-ID: <fcfa4d17-ea05-46f2-840d-9486923fd01d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1dee481f-d584-41d6-a5f1-d84375be5fe8@paulmck-laptop>
 <20240604170437.2362545-2-paulmck@kernel.org>
 <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44890de1c3d54d93fbde09ada558e7cb4a7177c.camel@physik.fu-berlin.de>

On Tue, Jun 04, 2024 at 07:09:11PM +0200, John Paul Adrian Glaubitz wrote:
> Hello,
> 
> On Tue, 2024-06-04 at 10:04 -0700, Paul E. McKenney wrote:
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.
> > 
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > [ paulmck: Apply feedback from Naresh Kamboju. ]
> > [ Apply Geert Uytterhoeven feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-sh@vger.kernel.org>
> > ---
> >  arch/sh/Kconfig               | 1 +
> >  arch/sh/include/asm/cmpxchg.h | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 5e6a3ead51fb1..f723e2256c9c1 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -16,6 +16,7 @@ config SUPERH
> >  	select ARCH_HIBERNATION_POSSIBLE if MMU
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> > +	select ARCH_NEED_CMPXCHG_1_EMU
> >  	select CPU_NO_EFFICIENT_FFS
> >  	select DMA_DECLARE_COHERENT
> >  	select GENERIC_ATOMIC64
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > index 5d617b3ef78f7..1e5dc5ccf7bf5 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > +#include <linux/cmpxchg-emu.h>
> >  
> >  #if defined(CONFIG_GUSA_RB)
> >  #include <asm/cmpxchg-grb.h>
> > @@ -56,6 +57,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> >  		unsigned long new, int size)
> >  {
> >  	switch (size) {
> > +	case 1:
> > +		return cmpxchg_emu_u8(ptr, old, new);
> >  	case 4:
> >  		return __cmpxchg_u32(ptr, old, new);
> >  	}
> 
> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> I can pick this up through my SH tree unless someone insists this to
> go through some other tree.

Please do take it, and thank you!  When I see it in -next, I will drop
it from my tree.

> Adrian
> 
> PS: I'm a bit stumped that I'm not CC'ed as the SH maintainer.

Me too, now that you mention it.  I did generate the list some time
back, but "git blame" shows you being maintainer for more than a year.
Yet I do have the linux-sh email list, so it is unlikely that I pasted
the get_maintainer.pl output from the wrong commit.

I am forced to hypothesize that I fat-fingered the output of
get_maintainer.pl when adding the Cc lines to that commit.

Please accept my apologies for having left you out!

							Thanx, Paul

