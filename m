Return-Path: <linux-arch+bounces-5120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10850916D7C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C117328EEBA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8116F91B;
	Tue, 25 Jun 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXgl0tgF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9B16EC10;
	Tue, 25 Jun 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330651; cv=none; b=MIKfHyYLBwfIBnk6fxPSmrh1fmPctiuGWnsPqDkf7uuqAlpjGBQdYgzFfvlLx/lO8BCla9hZ8xtew0g+tz3FttPOk8XcJfzMEObmoz9sf5YlN4yuT2Lq0+Hh+wBOZiYNfqfHxLy4MNhjfnSrFp62xP0A8JRDPS4D/ST3UeDZIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330651; c=relaxed/simple;
	bh=ZaDeCopv0PJ1QwF2b0WCd5Id1ccH0b00NTXA6Ny1H0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4I7AH+0tvmYOMxe+9C32iWDJbudf4uPEBovQS5rEeZgfc9gPY59bWtucMkxPT1FVpN6PMgOq56VET0ElkS+GdZTz86DBsRtBwGZFfHoI5vFEQs4ttajLI5MRGsqIa5Q9+QguMAbhbkbp8oM934LudEwrfZ4gx/dtQHtK5jtFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXgl0tgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4F7C32781;
	Tue, 25 Jun 2024 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719330650;
	bh=ZaDeCopv0PJ1QwF2b0WCd5Id1ccH0b00NTXA6Ny1H0Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mXgl0tgF674ieLxrHGX9nw9jrSsq8mEVLOQBhUA69O1Oir11f0AiqcNg+PtLLiCkR
	 hIJkoY3nhi/1JXPgcoCoOO+p7O28KjUbSpizAu78UDIePT95th/DJgvEEKLX5wgo67
	 PNjAXOUJS9Qy3d9VzY75+nPbe+FbD4mox9lN+MtNMBoI57k+Ezhv1iTxeECfGDV8ku
	 ZjXabwx/hLSXwgIas452xONwVYd7z6FPpvGeI5Kdev5Bl/IW+UmiQt5w/xOkjJxvTH
	 22Gr0UZHcvx+ZSXc+SidA10pmrPz3KmZqIZmvM48w4nLRB0e8ArHaQ7dBA0u7VzF13
	 Ce3eo9gO54T2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C774CE0760; Tue, 25 Jun 2024 08:50:49 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:50:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Marco Elver <elver@google.com>, Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH lkmm v2 0/2] tools/memory-model: Add locking.txt and
 glossary.txt to README
Message-ID: <ab561ed0-51c9-4f17-a71a-5743735a2efa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07d41c9-5236-44ad-8e89-f3be5da90e98@gmail.com>

On Tue, Jun 25, 2024 at 05:56:49PM +0900, Akira Yokosawa wrote:
> Hi all,
> 
> Here is a v2 series with the trailing white space fixed and Acked-by's
> from Andrea applied.
> 
> Please find v1 at [1] if you need to.
> 
> [1]: https://lore.kernel.org/ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com/
> 
>         Thanks, Akira

Queued for further review, thank you all!

							Thanx, Paul

> --
> Akira Yokosawa (2):
>   tools/memory-model: Add locking.txt and glossary.txt to README
>   tools/memory-model: simple.txt: Fix stale reference to
>     recipes-pairs.txt
> 
>  tools/memory-model/Documentation/README     | 17 +++++++++++++++++
>  tools/memory-model/Documentation/simple.txt |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 5bdd17ab5a7259d2da562eab63abab3a6d95adcd
> -- 
> 2.34.1
> 

