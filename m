Return-Path: <linux-arch+bounces-4275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020F8C0338
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C6C1F20ACB
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 17:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B1129A9E;
	Wed,  8 May 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB5RMCHf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E1128829;
	Wed,  8 May 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189654; cv=none; b=JC/mfW75gzpAhh3AkRnYT8AmLZrxKaz/KXHs1I5RqYmIdBgumf8Leijmar6zBJwk3TW7L/k+xESO8w72juHth8BPo3W9uEYcDqT7VT14Lj0V3fNIoiSaqvXjF8fnvYYdZt3KhgL0+oH1k8RjdmQspmJv0pXvH0WxI1+Gh+XP/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189654; c=relaxed/simple;
	bh=RO+OX4OnuX/UqQFFPw0QJr4nwO4KwxnWWktJWf7Ariw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry16IXrFB+ljcdtSVi/0OZBMAUi7FLvHSZtkSCKLsHGIIjzXWSNd4NZpTsNxartz77gGL7V/lYE53cHvga0oy9o/vF2VOulGhUm4TsBOW+oTTPKrUXs3T4QgP1ih5IDP/rEsmHoOaakLHImQg68X+nOnMauYzUAW0BLLEqGEFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB5RMCHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A4C2BD11;
	Wed,  8 May 2024 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715189654;
	bh=RO+OX4OnuX/UqQFFPw0QJr4nwO4KwxnWWktJWf7Ariw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uB5RMCHf6dt8ZTnS4XNzG8fPZ6xjEtoj4wXKNZWDBJOUoLM12mvC2MPyW96PaJ/o2
	 u63561FB81vJC749FLbD2cpZv4Ttt8HIAheGsw2StAgOL4vcVIvpMJgAX7ivmA0zOj
	 Ni4wEwwA3c/Y5iuQMKqmkoyJguzjPHmcejJvxVQT/HVvymZwzM1hUYaggD8U05PzDX
	 +CYDeT1eEW3pmOlAi1nKyWB1SSQMjqIZmZUcF7eTf7oywsHAVFA6h9SYs3kHDHFlXI
	 EOxLhJ4UpfrxmIUE9t4Zue94j0HxA2B+tjKt5X6n9hjNDyrHlK0BcPn/hviFBEhOUq
	 09ajS+d+CCwSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0FFF0CE0448; Wed,  8 May 2024 10:34:14 -0700 (PDT)
Date: Wed, 8 May 2024 10:34:14 -0700
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
Subject: Re: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and
 add_negative
Message-ID: <ca00b80e-3770-48e1-ba27-29da55949c82@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240508143400.36256-1-puranjay@kernel.org>
 <ZjuaFmFMloYqq1PS@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjuaFmFMloYqq1PS@andrea>

On Wed, May 08, 2024 at 05:28:22PM +0200, Andrea Parri wrote:
> On Wed, May 08, 2024 at 02:34:00PM +0000, Puranjay Mohan wrote:
> > Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> > atomics operations.
> > 
> > Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> > all their ordering variants.
> > 
> > atomic_add_negative() is already available so add its acquire, release,
> > and relaxed ordering variants.
> > 
> > [1] https://github.com/herd/herdtools7/pull/849
> > 
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Queued for review and testing, and thank you both!

							Thanx, Paul

