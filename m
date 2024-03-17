Return-Path: <linux-arch+bounces-3016-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A187E117
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 00:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FDA1F20FB2
	for <lists+linux-arch@lfdr.de>; Sun, 17 Mar 2024 23:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9482135A;
	Sun, 17 Mar 2024 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdrrpH9R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C5210E7;
	Sun, 17 Mar 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710718025; cv=none; b=UhzqEqbds6KZ57MLKSJXz8lmTyYrBIJ8WKhwUqmn2tmHGoA4FWJX1eLLHgLs/C/GCy1IsBAEoVrwU466q6FKxZabI82pg8CtMW95pRn2To3kaz+M6BG+dKv0OjkwskYzfzrMX4atbxi7TKzapJt3SPggLXKxwF9ZRtKAku5A1WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710718025; c=relaxed/simple;
	bh=J3mH4Lz+h6JdZbI06BLdCCwKx2xsG2E17TgdAzhbbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btJFOn9QEv83ans4bU3Rcqmc9g2LwViSHus1rIFsaDuv5lhCDusGI5IozldBItuN7uBovHZtVw/ZKlQvO8bmioufcg0MkR8DIy6DA0IAmsQfHXsihX5H+DI9rii0Tv5FfCVHPLMbjUMmVBttvPJWqvJs8t+VNHgDORE5kS/qasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdrrpH9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63422C433C7;
	Sun, 17 Mar 2024 23:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710718024;
	bh=J3mH4Lz+h6JdZbI06BLdCCwKx2xsG2E17TgdAzhbbZs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TdrrpH9R5ddZPd3pLMl20GBDUGKcavhTcY/z3s1mBmsFgERaBEoJcVlFQ1VYU52CI
	 ljPJdNYPCOt2S499Of5DHqXABFAEO8BTeSmn9meXzISylaLVzdeMd7GviPSi1YESvx
	 qfG2ug+Gco9PLmYC2kwWOKui2rJ458RBcLHvb9FLmYuumOvmNXhPrWwJgdcw3qS4eD
	 b5X7FwocaeGvEeeEqQyi4N8HCzXEpAM6y6CgMj1zTwuDLgMvTHW+xbZ3jjqG01xhT5
	 Ef7Pek4XgfEB0W89KhIrhfu4WjugSGR4OmC03hwOSK6AhJ7bqPxEmq/SNLtESgkLzK
	 uDZ2JzIiqyATg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38D74CE0D83; Sun, 17 Mar 2024 16:02:27 -0700 (PDT)
Date: Sun, 17 Mar 2024 16:02:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Huang <mmpgouride@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: Question about ISA2+pooncelock+pooncelock+pombonce litmus
Message-ID: <17ddc858-a926-4f12-beda-3f54cb91bfbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <12E5C279-ADB1-463E-83E2-0A4F5D193754@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12E5C279-ADB1-463E-83E2-0A4F5D193754@gmail.com>

On Mon, Mar 18, 2024 at 01:47:43AM +0800, Alan Huang wrote:
> Hi,
> 
> I’m playing with the LKMM, then I saw the ISA2+pooncelock+pooncelock+pombonce.
> 
> The original litmus is as follows:
> ------------------------------------------------------
> P0(int *x, int *y, spinlock_t *mylock)
> {
> 	spin_lock(mylock);
> 	WRITE_ONCE(*x, 1);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(mylock);
> }
> 
> P1(int *y, int *z, spinlock_t *mylock)
> {
> 	int r0;
> 
> 	spin_lock(mylock);
> 	r0 = READ_ONCE(*y);
> 	WRITE_ONCE(*z, 1);
> 	spin_unlock(mylock);
> }
> 
> P2(int *x, int *z)
> {
> 	int r1;
> 	int r2;
> 
> 	r2 = READ_ONCE(*z);
> 	smp_mb();
> 	r1 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
> ------------------------------------------------------
> Of course, the result is Never. 
> 
> But when I delete P0’s spin_lock and P1’s spin_unlock:
> -------------------------------------------------------
> P0(int *x, int *y, spinlock_t *mylock)
> {
> 	WRITE_ONCE(*x, 1);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(mylock);
> }
> 
> P1(int *y, int *z, spinlock_t *mylock)
> {
> 	int r0;
> 
> 	spin_lock(mylock);
> 	r0 = READ_ONCE(*y);
> 	WRITE_ONCE(*z, 1);
> }
> 
> P2(int *x, int *z)
> {
> 	int r1;
> 	int r2;
> 
> 	r2 = READ_ONCE(*z);
> 	smp_mb();
> 	r1 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
> ------------------------------------------------------
> Then herd told me the result is Sometimes.

You mean like this?

Test ISA2+pooncelock+pooncelock+pombonce Allowed
States 8
1:r0=0; 2:r1=0; 2:r2=0;
1:r0=0; 2:r1=0; 2:r2=1;
1:r0=0; 2:r1=1; 2:r2=0;
1:r0=0; 2:r1=1; 2:r2=1;
1:r0=1; 2:r1=0; 2:r2=0;
1:r0=1; 2:r1=0; 2:r2=1;
1:r0=1; 2:r1=1; 2:r2=0;
1:r0=1; 2:r1=1; 2:r2=1;
Ok
Witnesses
Positive: 1 Negative: 7
Flag unmatched-unlock
Condition exists (1:r0=1 /\ 2:r2=1 /\ 2:r1=0)
Observation ISA2+pooncelock+pooncelock+pombonce Sometimes 1 7
Time ISA2+pooncelock+pooncelock+pombonce 0.01
Hash=f55b8515e48310f812aa676084f2cc88

> Is this expected? 

There are no locks held initially, so why can't the following
sequence of events unfold:

o	P1() acquires the lock.

o	P0() does WRITE_ONCE(*y, 1). (Yes, out of order)

o	P1() does READ_ONCE(*y), and gets 1.

o	P1() does WRITE_ONCE(*z, 1).

o	P2() does READ_ONCE(*z) and gets 1.

o	P2() does smp_mb(), but there is nothing to order with.

o	P2() does READ_ONCE(*x) and gets 0.

o	P0() does WRITE_ONCE(*x, 1), but too late to affect P2().

o	P0() releases the lock that is does not hold, which is why you see
	the "Flag unmatched-unlock" in the output.  LKMM is complaining
	that the litmus test is not legitimate, and rightly so!

Or am I missing your point?

							Thanx, Paul

