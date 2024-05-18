Return-Path: <linux-arch+bounces-4463-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7658C8EE8
	for <lists+linux-arch@lfdr.de>; Sat, 18 May 2024 02:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EBC1F21EDD
	for <lists+linux-arch@lfdr.de>; Sat, 18 May 2024 00:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A8063B;
	Sat, 18 May 2024 00:31:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D12BB161
	for <linux-arch@vger.kernel.org>; Sat, 18 May 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715992298; cv=none; b=CflL4DaFeMk19Wc+ogtYvwTWrHzFCyUb35QXAENHWFGf8A1w9gwowPpXLUNrXaObIuYO9QJMmA4lmJuzd/8nsJ0kM3k73s1+gF2glABugjjLwCBhuAeGzWnWgcfMg0iYZ/DB9FpmIeerf6awZzvGSUl7W/G/qPpG7qWdHc6HAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715992298; c=relaxed/simple;
	bh=g3RkVv+t4bcwiCbgF99DVpzGzO44nWwU895QumCSBRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK2VFUEFpp9jRppIRikXmtjie8b0iXiqDrb1qFMUcoGZhqQHbcLwfYBdSUjV9MRTX83A09dgyW42JAVkyBc3R50JDu3hFyOMpvTlZQTH0UwUCwLARISV+q3ukrxgmoHcy5vb6nanB3Y4UKoXUNItES/FfZwNEd7X39NO2SQMq+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 327208 invoked by uid 1000); 17 May 2024 20:31:35 -0400
Date: Fri, 17 May 2024 20:31:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>

On Thu, May 16, 2024 at 10:44:05AM +0200, Hernan Ponce de Leon wrote:
> On 5/16/2024 10:31 AM, Jonas Oberhauser wrote:
> > 
> > 
> > Am 5/16/2024 um 3:43 AM schrieb Alan Stern:
> > > Hernan and Jonas:
> > > 
> > > Can you explain more fully the changes you want to make to herd7 and/or
> > > the LKMM?  The goal is to make the memory barriers currently implicit in
> > > RMW operations explicit, but I couldn't understand how you propose to do
> > > this.
> > > 
> > > Are you going to change herd7 somehow, and if so, how?  It seems like
> > > you should want to provide sufficient information so that the .bell
> > > and .cat files can implement the appropriate memory barriers associated
> > > with each RMW operation.  What additional information is needed?  And
> > > how (explained in English, not by quoting source code) will the .bell
> > > and .cat files make use of this information?
> > > 
> > > Alan
> > 
> > 
> > I don't know whether herd7 needs to be changed. Probably, herd7 does the
> > following:
> > - if a tag called Mb appears on an rmw instruction (by instruction I
> > mean things like xchg(), atomic_inc_return_relaxed()), replace it with
> > one of those things:
> >    * full mb ; once (the rmw) ; full mb, if a value returning
> > (successful) rmw
> >    * once (the rmw)   otherwise
> > - everything else gets translated 1:1 into some internal representation
> 
> This is my understanding from reading the source code of CSem.ml in herd7's
> repo.
> 
> Also, this is exactly what dartagnan is currently doing.
> 
> > 
> > What I'm proposing is:
> > 1. remove this transpilation step,
> > 2. and instead allow the Mb tag to actually appear on RMW instructions
> > 3. change the cat file to explicitly define the behavior of the Mb tag
> > on RMW instructions
> 
> These are the exact 3 things I changed in dartagnan for testing what Jonas
> proposed.
> 
> I am not sure if further changes are needed for herd7.

Okay, good.  This answers the first part of what I asked.  What about 
the second part?  That is, how will the changes to the .def, .bell, and 
.cat files achieve your goals?

Alan

