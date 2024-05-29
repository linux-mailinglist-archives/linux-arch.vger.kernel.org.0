Return-Path: <linux-arch+bounces-4602-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD68D38B6
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 16:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831411C21536
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1D1CAB9;
	Wed, 29 May 2024 14:07:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2DEA91CFBD
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991672; cv=none; b=W1UP/wPq4QxT2235xGR13OFSaC6OM1uoA3K6Kaqj9NqSlmbJhi8LvK7pz4GFOczK2a3aSneF3C8wvdEK9EKDDBGsvtW6aZ7hat+tpAbW1b6v1wYMWWbjUkkKvlw2SHBYJ1mndfruLFGjGEqBmYbr8enz9X3thEV8Od77TkByS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991672; c=relaxed/simple;
	bh=tDRMZ/xjppcv17Vv7I7IS1EiKe3ccUEx8QOpa9SHJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrqvq1Z/pmWYJ6ED12/QjkVZx2M2EbXPA/h0yWXBFbUVd2W5BM9icFqVAcnrpr14BoUz+e35oDxYXKgl/nT5f2/cw0LmghJmGzo6F4B0yGtqoo98MHuIJsoOeCIgWeXY9eZOSln1jssGTf2HYn2DrmQyCc4pOs8/xN6GvcMxrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 724132 invoked by uid 1000); 29 May 2024 10:07:44 -0400
Date: Wed, 29 May 2024 10:07:44 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andrea Parri <parri.andrea@gmail.com>,
  Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>, will@kernel.org,
  peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
  j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <b54575b9-ab29-4bcd-ae7a-6132d1e36195@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
 <ZlYbXZSLPmjTKtaE@boqun-archlinux>
 <7e2963a3-d471-4593-9170-7f59aa1ce038@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e2963a3-d471-4593-9170-7f59aa1ce038@huaweicloud.com>

On Wed, May 29, 2024 at 02:37:30PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/28/2024 um 7:58 PM schrieb Boqun Feng:
> > This may not be trivial. Note that cmpxchg() is an expression (it has a
> > value), so in .def, we want to define it as an expression. However, the
> > C-like multiple-statement expression is not supported by herd parser, in
> > other words we want:
> > 
> > 	{
> > 		__fence{mb-successful-rmw};
> > 		int tmp = __cmpxchg{once}(...);
> > 		__fence{mb-successful-rmw};
> > 		tmp;
> > 	}
> 
> Oh, you're right. Then probably the rule I was violating is that
> value-returning macros can not be defined with {} at all.
> 
> Given herd's other syntactic limitations, perhaps the best way would be to
> introduce these macros as
> 
> 	x = cmpxchg(...) {
> 		__fence{mb-successful-rmw};
>  		x = __cmpxchg{once}(...);
>  		__fence{mb-successful-rmw};
> 	}
> 
> since I think x = M(...) is the only way we are allowed to use these macros
> anyways.

If we did this, how would the .cat file know to ignore the fence events 
when the cmpxchg() fails?  It doesn't look like there's anything to 
connect the two of them.

Adding the MB tag to the cmpxchg itself seems like the only way forward.

Alan

