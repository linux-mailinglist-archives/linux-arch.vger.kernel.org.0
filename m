Return-Path: <linux-arch+bounces-5946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7899E9462B9
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 19:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BD61F2234E
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD311537C0;
	Fri,  2 Aug 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX15cDUL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1856136350;
	Fri,  2 Aug 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620848; cv=none; b=iTTNeWwySiZ29nWS+KeZVgM8XNwcQoANhWKZsFGT5MOPh9GMELOo5HMl8BcTm2HClh47IRBbwsmCujX4rK5CsD4YRqYyAdJqyLZNmtB/yG4EuuJRjQwBWTIYN89alxtZVl1kc6BMQp3042Nr/00FWa+X/lh/M7DdMGL5By2OCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620848; c=relaxed/simple;
	bh=59TiDqi3kg1UeIqPxlvhBXIwC01i6kboGdvd/Sllv5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kg1u3vsxUYR8kI96TcJvOBsIlYtD4WqbLolEE8TcLUaIOFtqK7D4YIqC/mvzX6LZ0Vf1Bh6vIpAlkifYdikaGRdMjcVe6v+aqoZkoYYIdgzqDdy1T0Rb1CIl+OI/bH3uokazbHGCdPAcZcH5oeOd+pH9NssqWdaHTnN7vopvYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX15cDUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825F6C32782;
	Fri,  2 Aug 2024 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722620847;
	bh=59TiDqi3kg1UeIqPxlvhBXIwC01i6kboGdvd/Sllv5M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=HX15cDULsbXp5AtvYHDvfrWo1epZQOr6dYesNDUxkx5+VkyFNsB3sT4EvQXNg5prj
	 pPCG4ogikyzioKp2XoXg5xzx+jwMNkOcBw6ndyKY7WUnTP0S6doUVa6Pw7utj+xo/5
	 ZFOpwQoQw4Kb73uNms+Yg7OHlX1xE4qVGmaTwJvqIYSOikbdECzUakbGSdet2NQHNI
	 lxSksTsJjhFny92R4p+DBci9RRuQ3fEf9tcKqz2OHZn1li898Gj6ufawnvAsHNpmPG
	 0WtI5NoCAsePN5ke0sCrqvlaeRXsHuyLKcS1MigBfzySu6nq/TrHRX/t6d6I+i8Uvo
	 9uBAObNb71XtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 25D47CE09DE; Fri,  2 Aug 2024 10:47:27 -0700 (PDT)
Date: Fri, 2 Aug 2024 10:47:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org,
	stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 7/7] MAINTAINERS: Add the dedicated maillist
 info for LKMM
Message-ID: <d877a2a8-8040-42b1-bd2f-cd60b2a9f4c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
 <20240802002215.4133695-7-paulmck@kernel.org>
 <Zqyq7DjIrHAOqf0k@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqyq7DjIrHAOqf0k@andrea>

On Fri, Aug 02, 2024 at 11:46:20AM +0200, Andrea Parri wrote:
> On Thu, Aug 01, 2024 at 05:22:15PM -0700, Paul E. McKenney wrote:
> > From: Boqun Feng <boqun.feng@gmail.com>
> > 
> > A dedicated mail list has been created for Linux kernel memory model
> > discussion, which could help people more easily track memory model
> > related discussions.  This could also help bring memory model discussions
> > to a broader audience.  Therefore, add the list information to the LKMM
> > maintainers entry.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul

