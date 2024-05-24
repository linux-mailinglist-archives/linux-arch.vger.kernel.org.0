Return-Path: <linux-arch+bounces-4538-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913F8CEAAE
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46B11F220BA
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C33F9D2;
	Fri, 24 May 2024 20:04:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 595FD3C47C
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581053; cv=none; b=u4CxeK72OdGpBqVfFyPsIQ69M/tvOOnGOqjtaEBjft5RZX1Q9WNdC+p6HYtj+avhkiDb7JX9LC/c4QJSbQ/ZY0Pebh+w2fdp9XZMw5CAuHJFcgYwwnxAeDjgiFP0VsSoOMPoMjYyjolVAf5AiDCmzoH0rvP4uitv7i8UnQvfVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581053; c=relaxed/simple;
	bh=BuCYfK/p22E1t/CTAd3Dvp5JyIR5mqEHmLiTTS+jrtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7rYIvEG7CyupfeGwhG0p96y42ZKF+q1O2XR8Pzz39uC9kQctOaiv6pOr53xkt0MMGU9+WxXCojEsm1ZXwUWQntybgHz9/1f5iveQS8O1Z3JCaaJI2Po7tIC9kIGouAvuW0p/zKD3wxM+9QNq96gsL+FryFwfuQsThrcsy3NSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 585212 invoked by uid 1000); 24 May 2024 16:04:09 -0400
Date: Fri, 24 May 2024 16:04:09 -0400
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
Message-ID: <37bbf3c3-8951-41f8-b900-e81a885b949e@rowland.harvard.edu>
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

I get the same empty result.  There's definitely something going wrong 
in the "with ... from cross(...)" lines in lock.cat.  I need to do some 
checking and testing.

Also, lock.cat doesn't check for R events that don't actually read from 
anything (which will happen when the spin_is_locked() call above 
generates an RL event).  This is a separate bug, easily fixed.

Alan

