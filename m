Return-Path: <linux-arch+bounces-4501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361D38CD55A
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DA7280E8F
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3713D2BD;
	Thu, 23 May 2024 14:05:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 67F0C1DFF0
	for <linux-arch@vger.kernel.org>; Thu, 23 May 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473119; cv=none; b=EBGgCm6nexCF3FsBT6U8wDAA53XtnkcMXs7U9cIlCCPmddzVtqLBKdfYlpqzxVvVrJFUWoh5IMveSMmrxb6Vc8zviuRWDPItUl17GPZDbMueMZcoZM9lHXJ2ZkBhP1Ghl4F+OYp3JRSbTlVTEe3HypweedQm16aBYwBJw8N3lWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473119; c=relaxed/simple;
	bh=nPSkzDMhQidOoMXQKG6zY45AtQrck8vaGjz3ckPaPmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVFHl8lXVSPrh4RlhvdG/8HNWxTNvLyinpKHKJOIkjy114QgSxomMPCEUW50jyYBKFimddD7W93cOGJGTOBvEA9Rw7rOwWG27lrqmbhWptfOqihLOo2MCVGh0NpMRYiL0ETuqBui0xlAQYmFk3O+R7L8ufZUo8+YiEwkUJj/9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 539230 invoked by uid 1000); 23 May 2024 10:05:16 -0400
Date: Thu, 23 May 2024 10:05:16 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>

On Thu, May 23, 2024 at 02:54:05PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/22/2024 um 4:20 PM schrieb Alan Stern:
> > It would be better if there was a way to tell herd7 not to add the 'mb
> > tag to failed instructions in the first place.  This approach is
> > brittle; see below.
> 
> Hernan told me that in fact that is actually currently the case in herd7.
> Failing RMW get assigned the Once tag implicitly.
> Another thing that I'd suggest to change.

Indeed.

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

Overall, it seems better to have herd7 assign the right tag, but change 
the way the .def file works so that it can tell herd7 which tag to use 
in each of the success and failure cases.

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

Oops, that's right.  Silly oversight on my part.  But at least you 
understood what I meant.

> We could do (with the assumption that Mb applies only to successful rmw):
> 
>  	[M] ; po ; [Mb & R]
>  	[Mb & W] ; po ; [M]

That works.

Alan

