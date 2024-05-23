Return-Path: <linux-arch+bounces-4499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9898CD4D0
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F87B1C20C84
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18A14A4EC;
	Thu, 23 May 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf5EB+N+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574513C80E;
	Thu, 23 May 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471357; cv=none; b=aGMq/DMmBMQV6Mgg+XQkyIjVj9gIWm4YjOVTJfgQLeDX+7caGnTv5eiYyD0IdyZDhKLan2sJJ5SqN4THBVZqOluIPYjX2LhceVA49tqByTCPPn0I8j65fxz2oa9QNPYLihexcEG7Hji/IE510DPpN/9sh6QBtQN66y5/AAnDlSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471357; c=relaxed/simple;
	bh=DQf/PzXhE7xjrQyF17Hn3mDn2ItzYzk41r6ACSfGKm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdP98WZJrxVRIOMAYxynAlazr+iay9sRAf97fIR8teQBdGU0EqdzrEABK3ByrJqpeuq8oJBQ1awihKILKgnGRjafDwq0pj7mtQbv3WXpOzX4Kr9GneGdgKWtxMdyVOaP0mPO6rwtiLRe9yk1VVd1m8oqSyGN3otMqpm3FVaq/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf5EB+N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D38C2BD10;
	Thu, 23 May 2024 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716471356;
	bh=DQf/PzXhE7xjrQyF17Hn3mDn2ItzYzk41r6ACSfGKm8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gf5EB+N+5fKKREzM8n61Sz2VOAnrxVSSqDOn4GmoN+3flyaMsZKApWu8Vxwugymfy
	 X/gMCLllQ2tTKrzTEVUBNBHxiyvuj62bTYUKBWcI0pw8GPuIZXUCBOrcwxF6p0BLBQ
	 +evyRgDDbCMxbAAwbGaYtYQT76XwXOkVU5jzfq0cag2Oghs/MGVjAM1FcqS/sEN3fI
	 m00qwN0hMcf04WyEz0H3FK9IfzPss9R8L2AV/pbh6r18iFHzmeE42Bmc8gsQhWLrOQ
	 MY2PgyFyEa6xx4Q99/m7dCGnY/hANJjCnrRmfarWfqm8TQYrXMi+uZp556ZOdXpwAv
	 A4YHLSJhUFOCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5111ACE12E9; Thu, 23 May 2024 06:35:56 -0700 (PDT)
Date: Thu, 23 May 2024 06:35:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, parri.andrea@gmail.com, boqun.feng@gmail.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <93dc7c63-425d-4b89-8a36-48e0d5aa3674@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>

On Thu, May 23, 2024 at 02:54:05PM +0200, Jonas Oberhauser wrote:
> Am 5/22/2024 um 4:20 PM schrieb Alan Stern:
> > On Wed, May 22, 2024 at 11:20:47AM +0200, Jonas Oberhauser wrote:
> > > Am 5/21/2024 um 5:36 PM schrieb Alan Stern:
> > > > On Tue, May 21, 2024 at 11:57:29AM +0200, Jonas Oberhauser wrote:
> > > > > Am 5/18/2024 um 2:31 AM schrieb Alan Stern:
> > > > > > On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
> > > > > > > On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
> > > > > > > > Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
> > > > > > > > > Hernan and Jonas:
> > > > > > > > > 
> > > > > > > > > Can you explain more fully the changes you want to make to herd7 and/or
> > > > > > > > > the LKMM?  The goal is to make the memory barriers currently implicit in
> > > > > > > > > RMW operations explicit, but I couldn't understand how you propose to do
> > > > > > > > > this.
> > > > > > > > > 
> > > > > > > > > Are you going to change herd7 somehow, and if so, how?  It seems like
> > > > > > > > > you should want to provide sufficient information so that the .bell
> > > > > > > > > and .cat files can implement the appropriate memory barriers associated
> > > > > > > > > with each RMW operation.  What additional information is needed?  And
> > > > > > > > > how (explained in English, not by quoting source code) will the .bell
> > > > > > > > > and .cat files make use of this information?
> > > > > > > > > 
> > > > > > > > > Alan
> > > > > > > > 
> > > > > > > > 
> > > > > > > > I don't know whether herd7 needs to be changed. Probably, herd7 does the
> > > > > > > > following:
> > > > > > > > - if a tag called Mb appears on an rmw instruction (by instruction I
> > > > > > > > mean things like xchg(), atomic_inc_return_relaxed()), replace it with
> > > > > > > > one of those things:
> > > > > > > >       * full mb ; once (the rmw) ; full mb, if a value returning
> > > > > > > > (successful) rmw
> > > > > > > >       * once (the rmw)   otherwise
> > > > > > > > - everything else gets translated 1:1 into some internal representation
> > > > > > > 
> > > > > > > This is my understanding from reading the source code of CSem.ml in herd7's
> > > > > > > repo.
> > > > > > > 
> > > > > > > Also, this is exactly what dartagnan is currently doing.
> > > > > > > 
> > > > > > > > 
> > > > > > > > What I'm proposing is:
> > > > > > > > 1. remove this transpilation step,
> > > > > > > > 2. and instead allow the Mb tag to actually appear on RMW instructions
> > > > > > > > 3. change the cat file to explicitly define the behavior of the Mb tag
> > > > > > > > on RMW instructions
> > > > > > > 
> > > > > > > These are the exact 3 things I changed in dartagnan for testing what Jonas
> > > > > > > proposed.
> > > > > > > 
> > > > > > > I am not sure if further changes are needed for herd7.
> > > > 
> > > > What about failed RMW instructions?  IIRC, herd7 generates just an R for
> > > > these, not both R and W, but won't it still be annotated with an mb tag?
> > > > And wasn't this matter of failed RMWs one of the issues that the two of
> > > > you specifically wanted to make explicit in the memory model, rather
> > > > than implicit in the operation of herd7?
> > > 
> > > That's why we use the RMW_MB tag. I should have copied that definition too:
> > > 
> > > 
> > > (* full barrier events that appear in non-failing RMW *)
> > > let RMW_MB = Mb & (dom(rmw) | range(rmw))
> > > 
> > > 
> > > This ensures that the only successful rmw instructions have an RMW_MB tag.
> > 
> > It would be better if there was a way to tell herd7 not to add the 'mb
> > tag to failed instructions in the first place.  This approach is
> > brittle; see below.
> 
> Hernan told me that in fact that is actually currently the case in herd7.
> Failing RMW get assigned the Once tag implicitly.
> Another thing that I'd suggest to change.

Let's please be careful, though.  There is a lot out there that depends
on this semantic, odd though it might seem at first glance.  ;-)

							Thanx, Paul

> > An alternative would be to have a way for the .cat file to remove the
> > 'mb tag from a failed RMW instruction.  But I don't know if this is
> > feasible.
> 
> For Mb it's feasible, as there is no Mb read or Mb store.
> 
> Mb = Mb & (~M | dom(rmw) | range(rmw))
> 
> However one would want to do the same for Acq and Rel.
> 
> For that one would need to distinguish e.g. between a read that comes from a
> failed rmw instruction, and where the tag would disappear, or a normal
> standalone read.
> 
> For example, by using two different acquire tags, 'acquire and 'rmw-acquire,
> and defining
> 
> Acquire = Acquire | Rmw-acquire & (dom(rmw) | range(rmw))
> 
> Anyways we can do this change independently. So for now, we don't need
> RMW_MB.
> 
> 
> > 
> > > > And wasn't another one of these issues the difference between
> > > > value-returning and non-value-returning RMWs?  As far as I can, nothing
> > > > in the .def file specifically mentions this.  There's the noreturn tag
> > > > in the .bell file, but nothing in the .def file says which instructions
> > > > it applies to.  Or are we supposed to know that it automatically applies
> > > > to all __atomic_op() instances?
> > > 
> > > Ah, now you're already forestalling my next suggestion :))
> > > 
> > > I would say let's fix one issue at a time (learned this from Andrea).
> > > 
> > > For the other issue, do noreturn rmws always have the same ordering as once?
> > 
> > If they aren't annotated with _acquire or _release then yes...  And I
> > don't know whether there _are_ any annotated no-return RMWs.  If
> > somebody wanted such a thing, they probably would just use a
> > value-returning RMW instead.
> > 
> > > I suspect we need to extend herd slightly more to support the second one, I
> > > don't know if there's syntax for passing tags to __atomic_op.
> > 
> > This may not be be needed.  But still, it would nice to be explicit (in
> > a comment in the .def file if nowhere else) that __atomic_op always adds
> > a 'noreturn tag.
> > 
> > > > > instructions RMW[{'once,'acquire,'release,'mb}]
> > > > > 
> > > > > then the Mb tags would appear in the graph. And then I'd define the ordering
> > > > > explicitly. One way is to say that an Mb tag orders all memory accesses
> > > > > before(or at) the tag with all memory accesses after(or at) the tag, except
> > > > > the accesses of the rmw with each other.
> > > > 
> > > > I don't think you need to add very much.  The .cat file already defines
> > > > the mb relation as including the term:
> > > > 
> > > > 	([M] ; fencerel(Mb) ; [M])
> > > > 
> > > > All that's needed is to replace the fencerel(Mb) with something more
> > > > general...
> > 
> > And this is why I said the RMW_MB mechanism is brittle.  With the 'mb
> > tag still added to failed RMW events, the term above will cause the
> > memory model to think there is ordering even though the event isn't in
> > the RMW_MB class.
> > 
> 
> Huh, I thought that fencerel(Mb) is something like po ; [F & Mb] ; po (where
> F includes standalone fences). But looking into the stdlib.cat, you're
> right.
> 
> 
> > > > Also, is the "\ rmw" part really necessary?  I don't think it makes any
> > > > difference; the memory model already knows that the read part of an RMW
> > > > has to happen before the write part.
> > > 
> > > It unfortunately does make a difference, because mb is a strong fence.
> > > This means that an Mb in an rmw sequence would create additional pb edges.
> > > 
> > >    prop;(rfe ; [Mb];rmw;[Mb])
> > > 
> > > I believe this is might give wrong results on powerpc, but I'd need to
> > > double check.
> > 
> > PowerPC uses a load-reserve/store-conditional approach for RMW, so it's
> > tricky.  However, you're right that having a fictitious mb between the
> > read and the write of an RMW would mean that the preceding (in coherence
> > order) write would have to be visible to all CPUs before the RMW write
> > could execute, and I don't believe we want to assert this.
> > 
> > > > > One could also split it into two rules to keep with the "two full fences"
> > > > > analogy. Maybe a good way would be like this:
> > > > > 
> > > > >        [M] ; po; [RMW_MB & R] ; po^? ; [M]
> > > > > 
> > > > >        [M] ; po^?; [RMW_MB & W] ; po ; [M]
> > > > 
> > > > My preference is for the first approach.
> > > 
> > > That was also my early preference, but to be honest I expected that you'd
> > > prefer the second approach.
> > > Actually, I also started warming up to it.
> > 
> > If you do want to use this approach, it should be simplified.  All you
> > need is:
> > 
> > 	[M] ; po ; [RMW_MB]
> > 
> > 	[RMW_MB] ; po ; [M]
> > 
> > This is because events tagged with RMW_MB always are memory accesses,
> > and accesses that aren't part of the RMW are already covered by the
> > fencerel(Mb) thing above.
> 
> This has exactly the issue mentioned above - it will cause the rmw to have
> an internal strong fence that on powerpc probably isn't there.
> 
> We could do (with the assumption that Mb applies only to successful rmw):
> 
>  	[M] ; po ; [Mb & R]
>  	[Mb & W] ; po ; [M]
> 
> 
> Kind regards, jonas
> 

