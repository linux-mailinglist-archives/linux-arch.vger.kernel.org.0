Return-Path: <linux-arch+bounces-4489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F48CC31A
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14F01F21D53
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC111419A0;
	Wed, 22 May 2024 14:20:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6DE2A74BE0
	for <linux-arch@vger.kernel.org>; Wed, 22 May 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387656; cv=none; b=FbDu2Nxz0VcVavoal4UiYCEfBbPUOvX1yhWLtJVRewW5hnKCo1l+oWf6JJElXWUIm9cgmG3e7KvXhvbS6UZeJRwMqV3N7FE6JHUP9iz/stiLgLqPXGNBAXxAL6ZMK3H5Amztz3h99mY3WCtAQ3iVuYMjGVuIb62DSZhYGkvSYW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387656; c=relaxed/simple;
	bh=S5aeipgVT1iZXT29NiPJwGdjHb4sv5v6xJ7UTaP7fcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi1uRwyAMFzzfpOfQMLXaMJA2Z+vB303bs8LofVujzWN/1u0nxhMmWmJgaJlVzIWlwG03T07EEzwbHZOeeRzS7SjQH0WGk5r6af3QkLrp4IeBkJw9oFKL2aWEJFc7qpYoLqLRazUO5jtP0SPDHCVfdp0jW9BL3ff0EdiSrrL5yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 498954 invoked by uid 1000); 22 May 2024 10:20:53 -0400
Date: Wed, 22 May 2024 10:20:53 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>

On Wed, May 22, 2024 at 11:20:47AM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/21/2024 um 5:36 PM schrieb Alan Stern:
> > On Tue, May 21, 2024 at 11:57:29AM +0200, Jonas Oberhauser wrote:
> > > 
> > > 
> > > Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
> > > > On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
> > > > > On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
> > > > > > 
> > > > > > 
> > > > > > Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
> > > > > > > Hernan and Jonas:
> > > > > > > 
> > > > > > > Can you explain more fully the changes you want to make to herd7 and/or
> > > > > > > the LKMM?  The goal is to make the memory barriers currently implicit in
> > > > > > > RMW operations explicit, but I couldn't understand how you propose to do
> > > > > > > this.
> > > > > > > 
> > > > > > > Are you going to change herd7 somehow, and if so, how?  It seems like
> > > > > > > you should want to provide sufficient information so that the .bell
> > > > > > > and .cat files can implement the appropriate memory barriers associated
> > > > > > > with each RMW operation.  What additional information is needed?  And
> > > > > > > how (explained in English, not by quoting source code) will the .bell
> > > > > > > and .cat files make use of this information?
> > > > > > > 
> > > > > > > Alan
> > > > > > 
> > > > > > 
> > > > > > I don't know whether herd7 needs to be changed. Probably, herd7 does the
> > > > > > following:
> > > > > > - if a tag called Mb appears on an rmw instruction (by instruction I
> > > > > > mean things like xchg(), atomic_inc_return_relaxed()), replace it with
> > > > > > one of those things:
> > > > > >      * full mb ; once (the rmw) ; full mb, if a value returning
> > > > > > (successful) rmw
> > > > > >      * once (the rmw)   otherwise
> > > > > > - everything else gets translated 1:1 into some internal representation
> > > > > 
> > > > > This is my understanding from reading the source code of CSem.ml in herd7's
> > > > > repo.
> > > > > 
> > > > > Also, this is exactly what dartagnan is currently doing.
> > > > > 
> > > > > > 
> > > > > > What I'm proposing is:
> > > > > > 1. remove this transpilation step,
> > > > > > 2. and instead allow the Mb tag to actually appear on RMW instructions
> > > > > > 3. change the cat file to explicitly define the behavior of the Mb tag
> > > > > > on RMW instructions
> > > > > 
> > > > > These are the exact 3 things I changed in dartagnan for testing what Jonas
> > > > > proposed.
> > > > > 
> > > > > I am not sure if further changes are needed for herd7.
> > 
> > What about failed RMW instructions?  IIRC, herd7 generates just an R for
> > these, not both R and W, but won't it still be annotated with an mb tag?
> > And wasn't this matter of failed RMWs one of the issues that the two of
> > you specifically wanted to make explicit in the memory model, rather
> > than implicit in the operation of herd7?
> 
> That's why we use the RMW_MB tag. I should have copied that definition too:
> 
> 
> (* full barrier events that appear in non-failing RMW *)
> let RMW_MB = Mb & (dom(rmw) | range(rmw))
> 
> 
> This ensures that the only successful rmw instructions have an RMW_MB tag.

It would be better if there was a way to tell herd7 not to add the 'mb 
tag to failed instructions in the first place.  This approach is 
brittle; see below.

An alternative would be to have a way for the .cat file to remove the 
'mb tag from a failed RMW instruction.  But I don't know if this is 
feasible.

> > And wasn't another one of these issues the difference between
> > value-returning and non-value-returning RMWs?  As far as I can, nothing
> > in the .def file specifically mentions this.  There's the noreturn tag
> > in the .bell file, but nothing in the .def file says which instructions
> > it applies to.  Or are we supposed to know that it automatically applies
> > to all __atomic_op() instances?
> 
> Ah, now you're already forestalling my next suggestion :))
> 
> I would say let's fix one issue at a time (learned this from Andrea).
> 
> For the other issue, do noreturn rmws always have the same ordering as once?

If they aren't annotated with _acquire or _release then yes...  And I 
don't know whether there _are_ any annotated no-return RMWs.  If 
somebody wanted such a thing, they probably would just use a 
value-returning RMW instead.

> I suspect we need to extend herd slightly more to support the second one, I
> don't know if there's syntax for passing tags to __atomic_op.

This may not be be needed.  But still, it would nice to be explicit (in 
a comment in the .def file if nowhere else) that __atomic_op always adds 
a 'noreturn tag.

> > > instructions RMW[{'once,'acquire,'release,'mb}]
> > > 
> > > then the Mb tags would appear in the graph. And then I'd define the ordering
> > > explicitly. One way is to say that an Mb tag orders all memory accesses
> > > before(or at) the tag with all memory accesses after(or at) the tag, except
> > > the accesses of the rmw with each other.
> > 
> > I don't think you need to add very much.  The .cat file already defines
> > the mb relation as including the term:
> > 
> > 	([M] ; fencerel(Mb) ; [M])
> > 
> > All that's needed is to replace the fencerel(Mb) with something more
> > general...

And this is why I said the RMW_MB mechanism is brittle.  With the 'mb 
tag still added to failed RMW events, the term above will cause the 
memory model to think there is ordering even though the event isn't in 
the RMW_MB class.

> > Also, is the "\ rmw" part really necessary?  I don't think it makes any
> > difference; the memory model already knows that the read part of an RMW
> > has to happen before the write part.
> 
> It unfortunately does make a difference, because mb is a strong fence.
> This means that an Mb in an rmw sequence would create additional pb edges.
> 
>   prop;(rfe ; [Mb];rmw;[Mb])
> 
> I believe this is might give wrong results on powerpc, but I'd need to
> double check.

PowerPC uses a load-reserve/store-conditional approach for RMW, so it's 
tricky.  However, you're right that having a fictitious mb between the 
read and the write of an RMW would mean that the preceding (in coherence 
order) write would have to be visible to all CPUs before the RMW write 
could execute, and I don't believe we want to assert this.

> > > One could also split it into two rules to keep with the "two full fences"
> > > analogy. Maybe a good way would be like this:
> > > 
> > >       [M] ; po; [RMW_MB & R] ; po^? ; [M]
> > > 
> > >       [M] ; po^?; [RMW_MB & W] ; po ; [M]
> > 
> > My preference is for the first approach.
> 
> That was also my early preference, but to be honest I expected that you'd
> prefer the second approach.
> Actually, I also started warming up to it.

If you do want to use this approach, it should be simplified.  All you 
need is:

	[M] ; po ; [RMW_MB]

	[RMW_MB] ; po ; [M]

This is because events tagged with RMW_MB always are memory accesses, 
and accesses that aren't part of the RMW are already covered by the 
fencerel(Mb) thing above.

Alan

