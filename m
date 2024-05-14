Return-Path: <linux-arch+bounces-4400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BDC8C5B71
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4DA41C215D9
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA68180A8E;
	Tue, 14 May 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu0sGo/S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF61E504;
	Tue, 14 May 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715713361; cv=none; b=XnPsZRIJJjY2SMBYT4u/TgKyZN14TC9Y893LO2ZGMiBU6qeCmmPcmTPbV3rf9hATtqX0IDxbN0RitjlBQXwtasA/cFPHm+lAhXAu06oOe0ycFw4vQo/gqRQznBzFOgbo9I9CULd9tNO/aF3d/iPWQAS3GYf41coZhskkmX7xdbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715713361; c=relaxed/simple;
	bh=jxhYiv+J0iyFeK8LIFwYs1oTdF393tkXterG44SitaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOfrYmY8oHkezzdqQAiBP46NT7Barqf5Ie9WfJM25Ry+9kH5GXdhLDyRaKQ4HMLpeBWBuJddkPsuWZN1hCsN/gDYh5YOQX360hTZOYZQGSF7jUiinbOlcJJiqbnKJZDwWtJj2FUT7KqVWt/pH3X6YvpR+uTKgA9PpffejO36mEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu0sGo/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334ECC2BD10;
	Tue, 14 May 2024 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715713361;
	bh=jxhYiv+J0iyFeK8LIFwYs1oTdF393tkXterG44SitaY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qu0sGo/SOXkdmYDDFLiu/c4BkLi7e/hwMKaAJssv5GtJxVfoRdhQpXei2KHLDbWb0
	 Ws7MEHdL6nziU6pdhumvzCxbb6BKHDfytpV/bMGe/II60T5U30mI9gGiRZbXVxigv2
	 9klutUeql7Y5CZB6jtLHa2T95mSmbcuWc8MZbePGYh1H3WZ5AxBnnUbxPo7rZSLFu4
	 d+6qIDewPuOuJE/3WDWDUFv7N9TfVJmfK9UzqyXPfYSkB1gcTKZ3WTOIpXoM/ez8W8
	 nYB6tcLHRWPJXSBG+nsxq6DigVOKp92sE3nRb71LuV0gvL4CjeqgYJgKsCaBXSDvdc
	 xolQYn0AprKUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 81A4ACE098A; Tue, 14 May 2024 12:02:40 -0700 (PDT)
Date: Tue, 14 May 2024 12:02:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] tools/memory-model: Add atomic_andnot() with its variants
Message-ID: <aeba034f-142b-4d8f-9ea8-475f4dbaaf1c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240514094633.48067-1-puranjay@kernel.org>
 <ZkNG2uZEiF1S6M7z@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkNG2uZEiF1S6M7z@andrea>

On Tue, May 14, 2024 at 01:11:22PM +0200, Andrea Parri wrote:
> > C andnot
> > 
> > {
> > atomic_t u = ATOMIC_INIT(7);
> > }
> > 
> > P0(atomic_t *u)
> > {
> > 
> >         r0 = atomic_fetch_andnot(3, u);
> >         r1 = READ_ONCE(*u);
> > }
> > 
> > exists (0:r0=7 /\ 0:r1=4)
> 
> Fair enough for the changelog.  If/when submitting proper tests, please
> check their format using klitmus7 (besides herd7); say,
> 
>   $ mkdir mymodule
>   $ klitmus7 -o mymodule <.litmus file>
>   $ cd mymodule ; make
>   $ sudo sh run.sh
> 
> Documentation/litmus-tests/ provides some examples litmus tests.
> 
> 
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Queued and pushed, thank you both!

Again, I will hold off pushing this until herd7 releases a version
supporting this.

							Thanx, Paul

