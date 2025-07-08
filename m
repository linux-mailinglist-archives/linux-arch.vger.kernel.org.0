Return-Path: <linux-arch+bounces-12594-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD2AFDB72
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDF45644B4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jul 2025 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D728220F5B;
	Tue,  8 Jul 2025 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoY7ft4S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A01B4257;
	Tue,  8 Jul 2025 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015561; cv=none; b=WOKi1uCHrxVKB8ZOql7mwhJsIKpt0PT1k+KvvqhbjtiMB9e1ifXhLf9blP6PIso4HEEu6Pe6jL8g0ovvwxu3TsG4aEZwRDrsKIdU9iK0cRHa5unPukgEJhyH/9NSby1FTw3k46rgIcfx9kDf1bMX+kiwToxvE5us0SVJ40k3eQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015561; c=relaxed/simple;
	bh=PWEloiXUotz1C51oWqbRdlrm+SKoJ+BU5dA2jDSl7Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxM8cinCdH8g+LRgLjFP+r4F63yjdQ56RIxyl8mwu6pc/gpPWToBPFeOtcbGCG+hMQxEd1Y5yIR0dSXJJwUIMuwPSTPMghZ1uAch7Ct131qGen9KbtF6GSmkIBYa51FTz1jmdXSQ2HY82w936eyKkrekWElfjo8k09CZupWFHK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoY7ft4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85114C4CEED;
	Tue,  8 Jul 2025 22:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752015560;
	bh=PWEloiXUotz1C51oWqbRdlrm+SKoJ+BU5dA2jDSl7Qo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZoY7ft4SzlfM8T6ehzjrAmCUoG6RPj0KaxAvmaRyhEy4e7hBrX2YSJ4g/LRdFLfFO
	 mZ+3xjJaGDiXky7CBHaYL9sP5kSNWSP5QSb6A2D1+mELOXYOtQ8viozTSBc83FYQ2L
	 QcLG7OvwL9pnGjgtnfRSM1hnnV8HrVSuUMKa90bce/SuoCHTtsBMRcBr/V92J9vaBM
	 n8qYWmCg7gl/laueUgucJwppcYNH7ui0SdiJAIuzBtvoD58m/uT2ndZ6zvfnEsBn7b
	 Ko1nQUkIgJYC3RJWbTH6UNHlyNZMGI8q6UyTKuz8p7Uwrl955PwYEpw3OA6OLfX5Si
	 Rsz7QOX+FgQDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31DD7CE08A1; Tue,  8 Jul 2025 15:59:20 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:59:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] docs/memory-barriers.txt: Add wait_event_cmd()
 and wait_event_exclusive_cmd()
Message-ID: <60e29735-7359-4ef8-841a-fd5714404cf0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250627105034.1612947-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250627105034.1612947-1-haakon.bugge@oracle.com>

On Fri, Jun 27, 2025 at 12:50:33PM +0200, Håkon Bugge wrote:
> Add said functions to Documentation/memory-barriers.txt.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

Seeing no objections, I have queued this, thank you!

							Thanx, Paul

> --
> 
> v1 -> v2:
>       * Changed the prosaic part to kernel-doc style and moved it to
>         include/linux/wait.h in another commit
> ---
>  Documentation/memory-barriers.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 93d58d9a428b8..1d164e0057769 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2192,6 +2192,8 @@ interpolate the memory barrier in the right place:
>  	wait_event_timeout();
>  	wait_on_bit();
>  	wait_on_bit_lock();
> +	wait_event_cmd();
> +	wait_event_exclusive_cmd();
>  
>  
>  Secondly, code that performs a wake up normally follows something like this:
> -- 
> 2.43.5
> 

