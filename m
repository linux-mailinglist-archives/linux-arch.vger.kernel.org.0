Return-Path: <linux-arch+bounces-4529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E36F8CE845
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0571F20FEB
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547312C55D;
	Fri, 24 May 2024 15:51:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3BFE12CD81
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565899; cv=none; b=sVX4mdFS7O88LyvqAqDcZoDkR+KGL2cM2EqxtF81dzym7p7BNdCMf17BUn7PmaXZCnluc8XU9TF9oKIgoK9ivMZYr1A/HPnMwwgPXCjJOZczuqeCp8npSAjCoUS+wSYWQbugO5nX4XpmPLMtelDqhlyxDBrSWy6qhPvdbTgLh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565899; c=relaxed/simple;
	bh=VxEqOwntj5lgS5ot2nI+0IGJ6LjiZDRiVYPxT+g+0rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN+EZADJiiavGVg3KiY3dYtJoZlv/Ixj2kkvBfarUJ9QvESmpBfJnv4Tg6MPSWzGWjdzPhqWLWrkuGVCHjLlbsp9Z+/06fJnuVTSQC6WQQ69e8RAjFfVEwduzoNV26cXnrY3rXVdhI03+VcyCLwvEAhy4PXPYeKMx2l53OEAhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 577964 invoked by uid 1000); 24 May 2024 11:51:36 -0400
Date: Fri, 24 May 2024 11:51:36 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <bd6426c0-f439-4b15-9ab4-12768aa8557a@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlC0IkzpQdeGj+a3@andrea>

On Fri, May 24, 2024 at 05:37:06PM +0200, Andrea Parri wrote:
> > - While checking the information below using herd7, I've observed some
> >   "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
> >   IAC, that's also excluded from this table/submission.
> 
> For completeness, the behavior in question:
> 
> $ cat T.litmus 
> C T
> 
> {}
> 
> P0(spinlock_t *x)
> {
> 	int r0;
> 
> 	spin_lock(x);
> 	spin_unlock(x);
> 	r0 = spin_is_locked(x);
> }

No "exists" clause?  Maybe that's your problem.

Alan

> 
> $ herd7 -conf linux-kernel.cfg T.litmus
> Test T Required
> States 0
> Ok
> Witnesses
> Positive: 0 Negative: 0
> Condition forall (true)
> Observation T Never 0 0
> Time T 0.00
> Hash=6fa204e139ddddf2cb6fa963bad117c0
> 
> Haven't been using spin_is_locked for a while...  perhaps I'm doing
> something wrong?  (IAC, will have a closer look next week...)
> 
>   Andrea

