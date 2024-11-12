Return-Path: <linux-arch+bounces-9044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1138A9C63CF
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 22:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D95D285FDF
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54A218D6B;
	Tue, 12 Nov 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L96mEZur"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5592170DF;
	Tue, 12 Nov 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731448385; cv=none; b=rLCTtUtu9uxpZY0ATJnLGivAbeObbCExK+a5QRHQy3mjWRenjhmooIVu/Seatw+X2zLAbYlrhEhaSRsyTl5Wv9W31bq1Auju6P1Xl/MJGDohgbSolWKZxz5Yc47nlxz7S4mFtDGyVwDuNWZa7XuenSzFOvmRIL51cD98vQUGqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731448385; c=relaxed/simple;
	bh=Cpq6m42ZBOwGk09BWFODZ3n4FLE2EVPtB3Tnhvqv+7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFD4F0EFxFSv/78SQOSOiCdN4OE40snZdVwjzY+8M6Dv8hIs/OzVm2gBXiazAoHjf9QC+k9ZeVj5yDCKdJieQqBO04GIvVF3gIkXJQ3BuDfva+37KA+tWen5Y6vcwYzeOqNAzwshHe1nZnD9LJcjl3kitKn10e692f9xTdK3Wz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L96mEZur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F91C4CECD;
	Tue, 12 Nov 2024 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731448385;
	bh=Cpq6m42ZBOwGk09BWFODZ3n4FLE2EVPtB3Tnhvqv+7E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=L96mEZurnQMIAYAhAd4kXZCMvLVCYQA/qGVdk9Us6r1OBtniUkUi1QntDPcuxWpfS
	 gN5cOf+UQSojoMcAWMcl1wyasAgRZCETsFaR/PvuWij3+luwAZD3hbSkDSZHkvdPUx
	 FKfbeeDopISYavdT0aLeiO6XIdcYtSZlx0xPZegSicARxzhjOI2TYApjGecgQHnMEa
	 7f9vnHLGj5Y9+Pn2ZNL3gqy7LSj+LaJvQiDS5E8SBbnRAAtynwRsEGQYOWMamkFqcz
	 el0GW1jBRQVdo7NUXOdCKrcZedoZdCtbKzdPqjrbynHUnX7k8d6BLyC1cDb6+qJgiq
	 Qym4QidTn0mxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84E8ECE0FA5; Tue, 12 Nov 2024 13:53:04 -0800 (PST)
Date: Tue, 12 Nov 2024 13:53:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <e3a5aa0a-2c8b-4679-9344-64135df63fe1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
 <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>
 <75a5a694-1313-44b1-baff-d72559ac9039@rowland.harvard.edu>
 <de5485b8-6d88-46f6-b982-cdfb3cf80a13@paulmck-laptop>
 <25cee4ed-1115-42d4-8422-ed7f7f4ff389@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25cee4ed-1115-42d4-8422-ed7f7f4ff389@rowland.harvard.edu>

On Tue, Nov 12, 2024 at 03:20:00PM -0500, Alan Stern wrote:
> On Tue, Nov 12, 2024 at 10:26:37AM -0800, Paul E. McKenney wrote:
> > We do have a rule for the filenames in that directory that most of
> > them follow (I am looking at *you*, "dep+plain.litmus"!).  So we have
> > a few options:
> > 
> > 1.	Status quo.  (How boring!!!)
> > 
> > 2.	Come up with a better rule mapping the litmus-test file
> > 	contents to the filename, and rename things to follow that rule.
> > 	(Holy bikeshedding, Batman!)
> > 
> > 3.	Keep it simple and keep the current rule, but make the
> > 	combination of spin_lock() and smp_mb__after_spinlock()
> > 	have a greater Hamming distance from "lock".  Szőke's
> > 	patch changed only one of the filenames containing "Lock".
> > 	(Bikeshedding, but narrower scope.)
> > 
> > 4.	One of the above, but bring the litmus tests not following
> > 	the rule into compliance.
> > 
> > 5.	Give up on the idea of the name reflecting the contents of the
> > 	file, and just number them or something.  (More bikeshedding
> > 	and a different form of confusion.)
> > 
> > 6.	#5, but accompanied by some tool or script that allows easy
> > 	searching of the litmus tests by pattern of interaction.
> > 	(Easy for *me* to say!)
> > 
> > 7.	Something else entirely.
> > 
> > Thoughts?
> 
> Thumbs up for 3.

Very good!  Any nominations for the lucky replacement for "Lock"?

							Thanx, Paul

