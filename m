Return-Path: <linux-arch+bounces-4493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C517A8CC636
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 20:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18271C20E0E
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD85762FF;
	Wed, 22 May 2024 18:20:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 86C4F339A8
	for <linux-arch@vger.kernel.org>; Wed, 22 May 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402051; cv=none; b=pt51zA3NEfYs/Xr8cuhk+a5CHB4n71PSYHkKJC47FRNVsjplOCMpkeQoAyZ4bjOoqrRtLlbw13Vkkg0jzAjnC2lAb9qWelpc+jrxDOMOfHkLdR59bG1Im7BNcAJaPTqpb5MByu7Yk4sbTle38Ko4kdcDck9zHClCo36zCiq1rBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402051; c=relaxed/simple;
	bh=uxu8FI2vtIphGSI3l0Rvcfu2ul4LYPisCRq5cmLblag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akJuHr1d6RCNSLaI1cLTsSXmU499D0YpSYNiEOOf9/zENswYTEgFaOxPTu0uqf6d5XDLqNcplEBFw5aNua37c3VMSo8Cu3m1cZJEIKBkj8yHm8VsCkwulD4INnM4wBl3mRgMjEyDq8wEG4MRD4rxRTr/GhhXL0G9r18Bk4YjnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 508150 invoked by uid 1000); 22 May 2024 14:20:42 -0400
Date: Wed, 22 May 2024 14:20:42 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, boqun.feng@gmail.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <ba7120a5-9208-4506-bf99-2bfa165180c5@rowland.harvard.edu>
References: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
 <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <Zk4jQe7Vq3N2Vip0@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4jQe7Vq3N2Vip0@andrea>

On Wed, May 22, 2024 at 06:54:25PM +0200, Andrea Parri wrote:
> Alan, all,
> 
> ("randomly" picking a recent post in the thread, after having observed
> this discussion for a while...)
> 
> > It would be better if there was a way to tell herd7 not to add the 'mb 
> > tag to failed instructions in the first place.  This approach is 
> > brittle; see below.
> 
> AFAIU, changing the herd representation to generate mb-accesses in place
> of certain mb-fences...

I believe herd7 already generates mb accesses (not fences) for certain 
RMW operations.  But then it does some post-processing on them, and that 
post-processing is what we are thinking of changing.

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
> ... and updating the .cat file to the effects of something like
> 
>   -let mb = ([M] ; fencerel(Mb) ; [M]) |
>   +let mb = (([M] ; po? ; [Mb] ; po? ; [M]) \ id) |
> 
> ... can hardly be called "making RMW barriers explicit".  (So much so
> that the first commit in PR #865 was titled "Remove explicit barriers
> from RMWs".  :-))

There is another point, something we didn't spell out explicitly in the 
email discussion.  Namely, in linux-kernel.def there is a long list of 
instructions along with corresponding herd7 implementation instructions, 
and those instructions explicitly contain either {once}, {acquire}, 
{release}, or {mb} tags.  So to a large extent, these barriers already 
are explicit in the memory model.  Not in the .cat file, but in the .def 
file.

What is not so explicit is how the {mb} tag works.  Its operation isn't 
as simple as the operation of the {acquire} and {release} tags; those 
just modify the R or W access in the RMW pair as you would expect.  
Instead, an {mb} tag says to insert strong memory barriers before the R 
access and after the W access.  This is more or less what the 
post-processing mentioned earlier does, and Jonas and Hernan want to 
move this out of herd7 and into the memory model.

> Overall, this discussion rather seems to confirm the close link between
> tools/memory-model/ and herdtools7.  (After all, to what extent could
> any putative RMW_MB be considered "explicit" without _knowing the under-
> lying representation of the RMW operations...)  My understanding is that
> this discussion was at least in part motivated by a desire to experiment
> and familiarize with the current herd representation (that does indeed
> require some getting-used-to...); this suggests, as some of you already
> mentioned, to add some comments or a .txt in tools/memory-model/ in order
> to document such representation and ameliorate that experience.  OTOH, I
> must admit, I'm unable to see here sufficient motivation(tm) for changing
> the current representation (and model): not the how, but the why...

Well, it's not a big change.  And in my opinion, if something can be 
moved out of herd7's innards and into the memory model files, then doing 
so is generally a good idea.

However, I do agree that there will still be a close link between 
tools/memory-model/ and herdtools7.  This may be unavoidable, at least 
to some extent, but any way to reduce it is worth considering.

Alan

