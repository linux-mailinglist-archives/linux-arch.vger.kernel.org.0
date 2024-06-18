Return-Path: <linux-arch+bounces-4965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7B90DC18
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 20:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B941C20EF3
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23915ECED;
	Tue, 18 Jun 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0sX5nQv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683014BF92;
	Tue, 18 Jun 2024 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737185; cv=none; b=oXmmI6qKxoChF4aWV70VsAU/1/fqakPvy3Fi8keh76OGWXuKZQ3KOBZSCwMKHLScMqsOwyJfKOwwiAUvU4B4ebqpCLCulHRfiM3mhSSOLRPDWSq6O//hfmlFasP1whYZnJZAM6xHK+6bMuS3VoKEgPf97Wvq9900pe/AhWBACmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737185; c=relaxed/simple;
	bh=JihJOfkxteB+4RLbBZLnMbLiNw+sT2pn9x4JdCAsd6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvyHOl14xb2YqJS/y9HLKohtUleYuEhjFDOOG3VPAx39XENJcS0t9TsR8G7W8u/7B4m4PvYL+Efl5UPc5VpxWty+mLWNBZbcV6iQ3sJSPC66VkwG61oZwGWJYY4cgDnBU/8B8g5soYTSOGPEAq8P6nlJMZNVBIzSWP1s2hLz8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0sX5nQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3EFC3277B;
	Tue, 18 Jun 2024 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718737184;
	bh=JihJOfkxteB+4RLbBZLnMbLiNw+sT2pn9x4JdCAsd6Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T0sX5nQv9qpDirmfS6q/v3cPL+5/jnhWe+mSyjCnXLxFF3HIsz9S3UOhN3nxTeWqu
	 XKNmXZRN2fKAo32bOv9RPGErK81l+sr6ulxA9YMBLi7G2E6FTTYo193xipCUduvknK
	 5M+muja6ur+BLNodrB1Ce1HDEGFbf7i9PDxdhhF0uKN77XKZIyAAetbL8ts+2woyEQ
	 yDD3gR1Df0iNl7Gu5btZnI3bXLsYc2Tvzyj9fhSBfJNrawova1sgYi4saYK2qqTIc8
	 T8AALiN1K6Exqt5m0YhZW5fkvBsfRVV5+/j3EZHYZYqnmLKMPx21kQptg5fR5LS7wR
	 H5CR2gfWtd/aA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E8259CE05B6; Tue, 18 Jun 2024 11:59:43 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:59:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ded02789-6a8b-42cc-81b2-6e9a42fab673@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <6a7235ae-047d-484f-9180-1bd90e935468@paulmck-laptop>
 <ZnHUy2saXOgJr1Db@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHUy2saXOgJr1Db@andrea>

On Tue, Jun 18, 2024 at 08:41:15PM +0200, Andrea Parri wrote:
> > Queued, thank you!
> > 
> > I added Boqun's and Hernan's Reviewed-by tags and did the usual
> > wordsmithing.  Please check below to make sure that I did not mess
> > anything up.
> 
> Thanks!  That does look good to me.
> 
> It is missing the small addition to the rmw description discussed
> earlier in the thread [1]: feel free to squash it in your commit if
> that works for you (alternatively, I can respin the entire thing
> with that, JLMK what you prefer).

Please respin and I will replace the one that I have.

I clearly should have read the chain more carefully.  ;-)

> > Also, Puranjay added atomic_and()/or()/xor() and add_negative, which
> > is slated to go in to the next merge window:
> > 
> > be98107ab8a5 ("tools/memory-model: Add atomic_and()/or()/xor() and add_negative")
> > 
> > Would you like to add the corresponding lines to this table?
> 
> atomic_and() and atomic_add_negative() (together with its variants)
> should be listed in the table.
> 
> I did promise myself that I would have not done "or", "xor", "andnot"
> as well as "sub", "inc", "dec", but never say never!  :-) Alternatively,
> we could perhaps add a note along the lines of
> 
>   The table includes "add" and "and" operations; analogous/identical
>   representations for "sub", "inc", "dec", "or", "xor" and "andnot"
>   operations are omitted.

I am OK either way.  The second approach could be used to shrink
the "RMW ops w/ return value" section, if desired.

							Thanx, Paul

>   Andrea
> 
> [1] https://lore.kernel.org/ZnFZPJlILp5B9scN@andrea

