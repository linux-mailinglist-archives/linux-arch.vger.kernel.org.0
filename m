Return-Path: <linux-arch+bounces-4480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9AC8CB17C
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E89A1F23302
	for <lists+linux-arch@lfdr.de>; Tue, 21 May 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF806146580;
	Tue, 21 May 2024 15:36:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E02EF144D0B
	for <linux-arch@vger.kernel.org>; Tue, 21 May 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305779; cv=none; b=E21vGkQrYb68uQKJgMEQjtfism1AXxqQrC3NvpgUCpWp9NC8w8pcG30j9Z+ggVF5Be/5m/i+QMxnvpLpZWmrXw90C0CW/v38x4o3m15uDA1ouNyF2hcQSYHM0lJGyBGVvKhPKGFSQPbHwlH2jgTiUwIt0CUJonW+MK/8GmrnGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305779; c=relaxed/simple;
	bh=fIDHjv/NCpoLSHsJ8mBwHvur7uwCdXS242ClZn3xmmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm5STf2dD9sDZQJiQhD7TAhkKdGJ45haHU+MiTKswWMZQe27DJ86Jx/BPY4bc8Qb6yzCqDvtqyVRF2XcedLQ3s/nwQkj+PW9K7Xmw9SGIuaw5aBAjGNvXJZoXBzMWaQtaAHwT15z2Wd/mXzOwFl1RsMbNcmFxzgud9c5tzWJfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 457861 invoked by uid 1000); 21 May 2024 11:36:10 -0400
Date: Tue, 21 May 2024 11:36:10 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>

On Tue, May 21, 2024 at 11:57:29AM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
> > On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
> > > On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
> > > > 
> > > > 
> > > > Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
> > > > > Hernan and Jonas:
> > > > > 
> > > > > Can you explain more fully the changes you want to make to herd7 and/or
> > > > > the LKMM?  The goal is to make the memory barriers currently implicit in
> > > > > RMW operations explicit, but I couldn't understand how you propose to do
> > > > > this.
> > > > > 
> > > > > Are you going to change herd7 somehow, and if so, how?  It seems like
> > > > > you should want to provide sufficient information so that the .bell
> > > > > and .cat files can implement the appropriate memory barriers associated
> > > > > with each RMW operation.  What additional information is needed?  And
> > > > > how (explained in English, not by quoting source code) will the .bell
> > > > > and .cat files make use of this information?
> > > > > 
> > > > > Alan
> > > > 
> > > > 
> > > > I don't know whether herd7 needs to be changed. Probably, herd7 does the
> > > > following:
> > > > - if a tag called Mb appears on an rmw instruction (by instruction I
> > > > mean things like xchg(), atomic_inc_return_relaxed()), replace it with
> > > > one of those things:
> > > >     * full mb ; once (the rmw) ; full mb, if a value returning
> > > > (successful) rmw
> > > >     * once (the rmw)   otherwise
> > > > - everything else gets translated 1:1 into some internal representation
> > > 
> > > This is my understanding from reading the source code of CSem.ml in herd7's
> > > repo.
> > > 
> > > Also, this is exactly what dartagnan is currently doing.
> > > 
> > > > 
> > > > What I'm proposing is:
> > > > 1. remove this transpilation step,
> > > > 2. and instead allow the Mb tag to actually appear on RMW instructions
> > > > 3. change the cat file to explicitly define the behavior of the Mb tag
> > > > on RMW instructions
> > > 
> > > These are the exact 3 things I changed in dartagnan for testing what Jonas
> > > proposed.
> > > 
> > > I am not sure if further changes are needed for herd7.

What about failed RMW instructions?  IIRC, herd7 generates just an R for 
these, not both R and W, but won't it still be annotated with an mb tag? 
And wasn't this matter of failed RMWs one of the issues that the two of 
you specifically wanted to make explicit in the memory model, rather 
than implicit in the operation of herd7?

And wasn't another one of these issues the difference between 
value-returning and non-value-returning RMWs?  As far as I can, nothing 
in the .def file specifically mentions this.  There's the noreturn tag 
in the .bell file, but nothing in the .def file says which instructions 
it applies to.  Or are we supposed to know that it automatically applies 
to all __atomic_op() instances?

> > Okay, good.  This answers the first part of what I asked.  What about
> > the second part?  That is, how will the changes to the .def, .bell, and
> > .cat files achieve your goals?
> > 
> > Alan
> 
> 
> Firstly, we'd allow 'mb as a barrier mode in events, e.g.

You mean as a mode in RMW events.  'mb already is a mode for F events.

> instructions RMW[{'once,'acquire,'release,'mb}]
> 
> then the Mb tags would appear in the graph. And then I'd define the ordering
> explicitly. One way is to say that an Mb tag orders all memory accesses
> before(or at) the tag with all memory accesses after(or at) the tag, except
> the accesses of the rmw with each other.

I don't think you need to add very much.  The .cat file already defines 
the mb relation as including the term:

	([M] ; fencerel(Mb) ; [M])

All that's needed is to replace the fencerel(Mb) with something more 
general...

> This is the same as the full fence before the read, which orders all memory
> accesses before the read with every access after(or at) the read,
> plus the full fence after the write, which orders all memory accesses
> before(or at) the write with all accesses after the write.
> 
> That would be done by adding
> 
>      [M] ; (po \ rmw) & (po^?; [RMW_MB] ; po^?) ; [M]

... like this.

> to ppo.

You need to update the definition of mb, not ppo.  And the RMW_MB above 
looks wrong; shouldn't it be just Mb?

Also, is the "\ rmw" part really necessary?  I don't think it makes any 
difference; the memory model already knows that the read part of an RMW 
has to happen before the write part.

> One could also split it into two rules to keep with the "two full fences"
> analogy. Maybe a good way would be like this:
> 
>      [M] ; po; [RMW_MB & R] ; po^? ; [M]
> 
>      [M] ; po^?; [RMW_MB & W] ; po ; [M]

My preference is for the first approach.

Alan

