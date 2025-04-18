Return-Path: <linux-arch+bounces-11459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6DA93EF2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4450219E240C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D91DFD8F;
	Fri, 18 Apr 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb6LSmgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284115442A;
	Fri, 18 Apr 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745008288; cv=none; b=Z6qME4fExJqgbfZ/gNCepjdqssdyDJinGuM+F4NJT1VooSUQ9x7EmFDYOCtzghIP+haKub+9YAxS9NxbLEuf4GXOCY7GURawyrprH5k5YIlLeo0i19r1kU2I1CVRMT7A34/C7VPRYRPObuKvQFLPh8q6DTCdXlqTxBXtp1xUhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745008288; c=relaxed/simple;
	bh=wELnVyTVL2FqP9LKt5SM0oQf4e2o1QQDJ0QFtTDfFUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9rH0lNOfsQvuO43AAyhTFIufjxn03vr97qHEJ0Np08loiuNRPmezjdAAUy86mUllYb5E1pX+J1GyTWWaEHeVRDLDu33oJk85Wxz0nQjWbXxdGiYSCUlq8XT3oto3ANUwGdsaYdvrh/pTVEx3G1Wi36PM3tdzCpkU2PD37NB8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb6LSmgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AEBC4CEE2;
	Fri, 18 Apr 2025 20:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745008288;
	bh=wELnVyTVL2FqP9LKt5SM0oQf4e2o1QQDJ0QFtTDfFUM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qb6LSmgguHO/yOqGONGIYCqvLAJN22BVVDDQbytDIaDtPyqrfqN40kKwTEORR88Or
	 hxqiQBkO9t4mC+ylYRe6m7ndbtqdv9TYhYcmM8deJCCUGRjqx7XrSnFFiwepFziX8p
	 4eDHbMa81YyKJajBQP0UT/ip0b9VMUAX7RuDNnQVNXxs5klU2E55p07m0IyIQFRZwc
	 0if3Lm4sSBMqlTEZEssnr9YapbEn6p6Y4Tt2N+/ZelRXdcfyFTqr1GxI83NlXNxxtY
	 UI3I1JFVbfKs2/DKBnexXrbODbM0iGU4eq7b1byILi6fdLKTOXGlcHs9XSyVySvE7W
	 8w9urmYEE2/Ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 19EE5CE077B; Fri, 18 Apr 2025 13:31:28 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:31:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org,
	stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH 0/4] LKMM documentation updates for v6.16
Message-ID: <67aebf50-68a7-459d-819b-13b9721ec051@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cd7fb2c4-1895-455c-84f8-8ed7252b93ff@paulmck-laptop>
 <aAKaAXQApP8JoQkL@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAKaAXQApP8JoQkL@andrea>

On Fri, Apr 18, 2025 at 08:30:42PM +0200, Andrea Parri wrote:
> On Fri, Apr 18, 2025 at 10:29:53AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series provides the following documentation updates, all courtesy
> > of Akira Yokosawa:
> > 
> > 1.	docs/README: Update introduction of locking.txt.
> > 
> > 2.	docs/simple.txt: Fix trivial typos.
> > 
> > 3.	docs/ordering: Fix trivial typos.
> > 
> > 4.	docs/references: Remove broken link to imgtec.com.
> 
> Thanks for the updates; for this series,
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

