Return-Path: <linux-arch+bounces-4536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DB8CEA07
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 20:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9535D1C2101B
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 18:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357103FB1B;
	Fri, 24 May 2024 18:48:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 631033FB2C
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576484; cv=none; b=PIAOZtC20ufALXhCuvJ2WH8m6b3n6ymyVJuctXWTim2v3OH6FDfp6GlWDGxqNExlc1eNWRnhidchldSy3Uf3R0d2hj5V/JJiuBoLSlwVy8qvhw28haIcQ9ChZuhuAnSNUxr/ZVIEzVw4+bkuGuRQdsgjxK4gt8sNUq1jCKJn1BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576484; c=relaxed/simple;
	bh=T3bqoD+DKGqwHMYwFCPwoGhYqgSzz1PCMdsTyZGlShk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AshGDibvcZTr9Pmt1xNQhsmADhlifQhgvBQSF03HtJHogTgSC2XCG8+KWMxKPI7il9ef7xSouYzEbLxBaRfJS4XK6OU5OMY9gwyRklrnsTiGwwPXIJLEeiSP8/amut4501D5TIDFe7Y4afNj2jFXf8ITMeUKtiM+7+kD5dn7dVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 582685 invoked by uid 1000); 24 May 2024 14:48:01 -0400
Date: Fri, 24 May 2024 14:48:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
  Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <09d0d4cf-6260-451b-a509-a3252b4cc423@rowland.harvard.edu>
References: <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
 <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
 <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>
 <a3c10533-1d86-4945-8bda-c0bdf4b14935@rowland.harvard.edu>
 <99cc68a9-477a-4ebe-b769-465a4016bdf6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cc68a9-477a-4ebe-b769-465a4016bdf6@huaweicloud.com>

On Fri, May 24, 2024 at 08:09:28PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/24/2024 um 4:53 PM schrieb Alan Stern:
> > Question: Since R and RMW have different lists of allowable tags, how
> > does herd7 decide which tags are allowed for an event that is in both
> > the R and RMW sets?
> 
> After looking over the patch draft for herd7 written by Hernan [1], my best
> guess is: it doen't. It seems that after herd7 detects you are using LKMM it
> simply drops all tags except 'acquire on read and 'release on store.
> Everything else becomes 'once (and 'mb adds some F[mb] sometimes).

Okay, yes, this is the sort of thing we would like to move away from.

> That means that if one were to go through with the earlier suggestion to
> distinguish between the smp_mb() Mb and the cmpxchg() Mb, e.g. by calling
> the latter RmwMb, current herd7 would always erase the RmwMb tag because it
> is not called "acquire" or "release".
> The same would happen of course if you introduced an RmwAcquire tag.
> 
> So there are several options:
> 
> - treat the tags as a syntactic thing which is always present, and
>  specify their meaning purely in the cat file, analogous to what you
>  have defined above. This is personally my favorite solution. To
>  implement this in herd7 we would simply remove all the current special
>  cases for the LKMM barriers, which I like.
> 
>  However then we need to actually define the behavior of herd if
>  an inappropriate tag (like release on a load) is provided. Since the
>  restriction is actually mostly enforced by the .def file - by simply
>  not  providing a smp_store_acquire() etc. -, that only concerns RMWs,
>  where xchg_acquire() would apply the Acquire tag to the write also.
> 
>  The easiest solution is to simply remove the syntax for specifying
>  restrictions - it seems it is not doing much right now anyways - and
>  do the filtering inside .bell, with things like
> 
>     (* only writes can have Release tags *)
>     let Release = Release & W \ (RMW \ rng(rmw))
> 
>  One good thing about this way is that it would work even without
>  modifying herd, since it is in a sense idempotent with the
>  transformations done by herd.

This seems like a good approach.

>  FWIW, in our internal weak memory model in Dresden we did exactly this,
>  and use REL for the syntax and Rel for the semantic release ordering to
>  make the distinction more clear, with things like:
> 
>     let Acq = (ACQ | SC) & (R | F)
>     let Rel = (REL | SC) & (W | F)
> 
>  (SC is our equivalent to LKMM's Mb)

Definitely, the syntactic markers should be easily distinguished (by 
case would be a good way) from the semantic classes used in the model.

> - treat the tags as semantic markers that are only present or not under
>  some circumstances, and define the semantics fully based on the present
>  tags. The circumstances are currently hardcoded in herd7, but we should
>  move them out with some syntax like __cmpxchg{acquire}{once}.
> 
>  This requires touching the parser and of course still has the issue
>  with the acquire tag appearing on the store as well.
> 
> - provide a full syntax for defining the event sequence that is
>  expected. For example, for a cmpxchg we could do
> 
>     cmpxchg = { F[success-cmpxchg]; c = R&RMW[once]; if (c==v) {
> W&RMW[once]; } F[success-cmpxchg] }
> 
>  and then define in .bell that a success-cmpxchg is an mb if it is
>  directly next to a cmpxchg that succeeds.
> 
>  The advantage is that you can customize the representation to whatever
>  kernel devs thing is the most intuitive. The downside is that it
>  requires major rewrites to herd7, someone to think about a reasonable
>  language for specifying this etc.

Let's avoid major rewrites to herd7.

Alan

