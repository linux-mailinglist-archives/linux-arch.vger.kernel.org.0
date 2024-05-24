Return-Path: <linux-arch+bounces-4526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88F68CE757
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBE028283E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 14:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631312C498;
	Fri, 24 May 2024 14:53:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0AA6586643
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562401; cv=none; b=O4yrZOUxNz29tauxIN7C7HyBO7n5d6nFXrSSIH2+DZWyPxd1hlYwIJrG+63hosMq2wdv6L6Mxf/PKGO60Q/F+nUGFPImjeW/wTULH9U/eIJHoM0ar0Ek25HLzZJrjpyWP7W9jcIRPZ6/5esNtouqpFAYluMbI1hPJdh+SopJ3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562401; c=relaxed/simple;
	bh=MU/9caFcN9+jAACsPQtrpOTtABdSUNmXeksHz2iZDGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gogWSBF8aJv4mEow6XQs1j93Pq7WivN5xxasXBiEHDwB+ig0DIoD9p/DkHeTjYrHZYy96AUOIzy2pgL0op1DkddthVo0D7Fqo8XuxQHA0QOWwgOGlVV3ePYnAAA8HYKjiHmjlt0Gs3NEQhuUDfIV3OsKaqI4QnEXF2PF9+q7TDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 576302 invoked by uid 1000); 24 May 2024 10:53:19 -0400
Date: Fri, 24 May 2024 10:53:19 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <a3c10533-1d86-4945-8bda-c0bdf4b14935@rowland.harvard.edu>
References: <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
 <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
 <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>

On Fri, May 24, 2024 at 07:34:06AM -0700, Boqun Feng wrote:
> On Fri, May 24, 2024 at 10:14:25AM -0400, Alan Stern wrote:
> [...]
> > > Not really, RMW events contains all events generated from
> > > read-modify-write primitives, if there is an R event without a rmw
> > > relation (i.e there is no corresponding write event), it's a failed RWM
> > > by definition: it cannot be anything else.
> > 
> > Not true.  An R event without an rmw relation could be a READ_ONCE().  
> 
> No, the R event is already in the RWM events, it has come from a rwm
> atomic.

Oh, right.  For some reason I was thinking that an instruction could 
belong to only one set, R or RMW.  But that doesn't make sense.

> > Or a plain read.  The memory model uses the tag to distinguish these 
> > cases.
> > 
> > > > that it would work is merely an artifact of herd7's internal actions.  I 
> > > > think it would be much cleaner if herd7 represented these events in some 
> > > > other way, particularly if we can tell it how.
> > > > 
> > > > After all, herd7 already does generate different sets of events for 
> > > > successful (both R and W) and failed (only R) RMWs.  It's not such a big 
> > > > stretch to make the R events it generates different in the two cases.
> > > > 
> > > 
> > > I thought we want to simplify the herd internal processing by avoid
> > > adding mb events in cmpxchg() cases, in the same spirit, if syntactic
> > > tagging is already good enough, why do we want to make herd complicate?
> > 
> > Herd7 already is complicated by the fact that it needs to handle 
> > cmpxchg() instructions in two ways: success and failure.  This 
> > complication is unavoidable.  Adding one extra layer (different tags for 
> > the different ways) is an insignificant increase in the complication, 
> > IMO. And it's a net reduction when you compare it to the amount of 
> > complication currently in the herd7 code.
> > 
> > Also what about cmpxchg_acquire()?  If it fails, it will generate an R 
> > event with an acquire tag not in the rmw relation.  There is no way to 
> > tell such events apart from a normal smp_load_acquire(), and so the .cat 
> > file would have no way to know that the event should not have acquire 
> > semantics.  I guess we would have to rename this tag, as well.
> 
> No,
> 
> 	let read_of_rmw = (RMW & R) 
> 	let fail_read_of_rmw = read_of_rmw / dom(rmw)
> 	let fail_cmpxchg_acquire = fail_read_of_rmw & [Acquire]
> 
> gives you all the failed cmpxchg_acquire() apart from a normal
> smp_load_acquire().

Yes, I see.  Using this approach, no further changes to herd7 or the 
.def file would be needed.  We would just have to add 'mb to the 
Accesses enumeration and to the list of tags allowed for an RMW 
instruction.

Question: Since R and RMW have different lists of allowable tags, how 
does herd7 decide which tags are allowed for an event that is in both 
the R and RMW sets?

Alan

