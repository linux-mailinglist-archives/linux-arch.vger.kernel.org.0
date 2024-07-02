Return-Path: <linux-arch+bounces-5228-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC34924688
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5D21C2182B
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D31BD50C;
	Tue,  2 Jul 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itoahYdp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FD1BD00C;
	Tue,  2 Jul 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941744; cv=none; b=AIshit7u98MwOShx6g4XjWAUEz5B+oRKCmxdWPiZMxivoQd2OFVXpG3urFb83nglbY3yfW93x0drduvAFlTEbCkDj65VE/fo9s2tu22J5GFiwTEBkCjUY2x4U8HoAzdcjYEqKvmjUoM5ruTWVgrqBCbyoYTA2z5Amnw5eBO+vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941744; c=relaxed/simple;
	bh=Nu6GRxlGa0VoTzhJK1nsMc2JN3ykCCTFYre947Pc32w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov3LcFQ+ZZJMeiguWrS/MC9RWKopELMSPpbcichuBf/TBvy9jzOQR8HBXJCPhm32aLd8A32U7wWKSvBwVwuL5M5SEsK9CFjEeR9fQ/YuP8nCdVx70mBcxqRiEoSX4Po/5tjYvGKLoU6WVPIUWvI/okcHqMvCQW/m5sY+8hcv/yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itoahYdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78142C116B1;
	Tue,  2 Jul 2024 17:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719941743;
	bh=Nu6GRxlGa0VoTzhJK1nsMc2JN3ykCCTFYre947Pc32w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=itoahYdpeGGVFxUMajXuMGS59FhaIvhSAJ4kGznZauf3scSwAIHjvMpRmDidTFj5G
	 /JOL7EKeiiJ5vx4jgHlXXt1/Zmc2obeOWMlJPOYgaVEjtupRMLR+vzstBALxDGF+1h
	 hCu9D4PLodZEEzUAWKTBQJfLy+hWPC81rtbS4Prz3nx57iEDoNmsEMBdM3JfZH+Ir2
	 e4YTxLOTVNN7U1eW+vKzg82WNQNv+z8BCkMsjm9kFrzVALFYT5Rl8MM3cxLMuCm16C
	 YrV/zxi2uafAFxd5zpTKpwPpvuFZlVAnnB41cIyb/u/lxc11mSsb+UjAT9JSWUzcWw
	 Hq1NOuxh64Qpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36B05CE0414; Tue,  2 Jul 2024 10:35:43 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:35:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH lkmm] docs/memory-barriers.txt: Remove left-over
 references to "CACHE COHERENCY"
Message-ID: <00b12ab0-611c-4006-91a3-229062ba2139@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>
 <ZoQFMqkRMDEZdvpa@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoQFMqkRMDEZdvpa@andrea>

On Tue, Jul 02, 2024 at 03:48:34PM +0200, Andrea Parri wrote:
> On Tue, Jul 02, 2024 at 08:42:44PM +0900, Akira Yokosawa wrote:
> > Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
> > [smp_]read_barrier_depends()") removed the entire section of "CACHE
> > COHERENCY", without getting rid of its traces.
> > 
> > Remove them.
> > 
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Queued for the v6.12 merge window, thank you both!

							Thanx, Paul

