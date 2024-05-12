Return-Path: <linux-arch+bounces-4333-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2CD8C34D2
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 03:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D17281B3B
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6933FD;
	Sun, 12 May 2024 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiYStP+o"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B22CAB;
	Sun, 12 May 2024 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715477173; cv=none; b=CN5nrkHXn+NCYXzXnx8czOP7vUusyT0L5Xynf83XuGjQPDENvXRBuaT8Xkk9drySHHImtNBzEhcaQiKbgtPwOev3LilQZitJYoaIxuCbvPhbzzBNjVulzeMeTNoACMvsVd5Gyzqp8HJp1k2vAzdM4SDeCzSt6avSNn5BC0+PnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715477173; c=relaxed/simple;
	bh=I1NyLOkKTzftYmKJ0ZaRdKXLyP9+Hj3V8ORnavLb564=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNjwCN/hu7RRxNLAsBhVBFcAu6XnYronQB+/QIKtNcP+dsI18/HZkbCvG6pLSyXOApjkOGKqfa8u4c7Yi4qnL+zTl5dldy1Ot0h47dX1nZEm4xcuj056nNZ3fXtUwSHJacfj9vL9iYWMo0VEaB4wgRTWZ7Mg6Ed2raFF1Iu3T30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiYStP+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99493C2BBFC;
	Sun, 12 May 2024 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715477172;
	bh=I1NyLOkKTzftYmKJ0ZaRdKXLyP9+Hj3V8ORnavLb564=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JiYStP+oK4lSfaCUaV2fC0UOXtQoFGzg0MeK2TWieM0LGEelSDKe4p7Jipd2sTgc8
	 E9PfzpV+OKKsxE8EvgMd3mEAF26X9//I2jXZxj9Z4ABn/k7xlTlUhq5bq2XvCO3Zvo
	 TeGYbal5db8ECKD/uRJsP5QaMAzyuuthK75kWSY9qVZ5RX0JyQVh3AzO8CEYMVUMH4
	 W0vNGsKOsITup7MV49YfA26654tnw86Tr3zbdgt3yv6NYiqlKQFXulYNZLJaIyrWA0
	 so2+j3ioEofXqfYPcZnNgKciejbVfFb31YWK8E5nPZ3TwyJ+fFJjDRuilVgYCAZAij
	 CrKAKf6mox+4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2378CE094C; Sat, 11 May 2024 18:26:10 -0700 (PDT)
Date: Sat, 11 May 2024 18:26:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-alpha@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] alpha: cleanups and build fixes for 6.10
Message-ID: <f01d9eb2-9ab8-4e82-99d2-467385ebce2b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <71feb004-82ef-4c7b-9e21-0264607e4b20@app.fastmail.com>
 <e383dfe5-814a-4a87-befc-4831a7788f42@app.fastmail.com>
 <6e6dae45ffbf7a6ab54175695a3e21207c6f5126.camel@physik.fu-berlin.de>
 <46543a98-4767-471a-91be-20fb60ab138b@paulmck-laptop>
 <7432d241b538819b603194bfb3a306faf360d4b1.camel@physik.fu-berlin.de>
 <a1331c86-dc07-4635-b169-623fcdd11824@paulmck-laptop>
 <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd1c466-54e3-45c1-a19f-f81dd9dbf243@app.fastmail.com>

On Sat, May 11, 2024 at 10:08:50PM +0200, Arnd Bergmann wrote:
> On Sat, May 11, 2024, at 21:37, Paul E. McKenney wrote:
> > On Sat, May 11, 2024 at 08:49:08PM +0200, John Paul Adrian Glaubitz wrote:
> >
> > The pre-EV56 Alphas have no byte store instruction, correct?
> >
> > If that is in fact correct, what code is generated for a volatile store
> > to a single byte for those CPUs?  For example, for this example?
> >
> > 	char c;
> >
> > 	...
> >
> > 	WRITE_ONCE(c, 3);
> >
> > The rumor I heard is that the compilers will generate a non-atomic
> > read-modify-write instruction sequence in this case, first reading the
> > 32-bit word containing that byte into a register, then substituting the
> > value to be stored into corresponding byte of that register, and finally
> > doing a 32-bit store from that register.
> >
> > Is that the case, or am I confused?
> 
> I think it's slightly worse: gcc will actually do a 64-bit
> read-modify-write rather than a 32-bit one, and it doesn't
> use atomic ll/sc when storing into an _Atomic struct member:
> 
> echo '#include <stdatomic.h>^M struct s { _Atomic char c; _Atomic char s[7]; long l; }; void f(struct s *s) { atomic_store(&s->c, 3); }' | alpha-linux-gcc-14  -xc - -S -o- -O2 -mcpu=ev5
> 
> f:
> 	.frame $30,0,$26,0
> $LFB0:
> 	.cfi_startproc
> 	.prologue 0
> 	mb
> 	lda $1,3($31)
> 	insbl $1,$16,$1
> 	ldq_u $2,0($16)
> 	mskbl $2,$16,$2
> 	bis $1,$2,$1
> 	stq_u $1,0($16)
> 	bis $31,$31,$31
> 	mb
> 	ret $31,($26),1
> 	.cfi_endproc
> $LFE0:
> 	.end f
> 
> compared to -mcpu=ev56:
> 
> f:
> 	.frame $30,0,$26,0
> $LFB0:
> 	.cfi_startproc
> 	.prologue 0
> 	mb
> 	lda $1,3($31)
> 	stb $1,0($16)
> 	bis $31,$31,$31
> 	mb
> 	ret $31,($26),1
> 	.cfi_endproc
> $LFE0:
> 	.end f

Thank you, Arnd!

And that breaks things because it can clobber concurrent stores to
other bytes in that enclosing machine word.

							Thanx, Paul

