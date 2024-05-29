Return-Path: <linux-arch+bounces-4604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B148D390E
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E6D282751
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2024 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E964157E9B;
	Wed, 29 May 2024 14:24:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id C5398157E94
	for <linux-arch@vger.kernel.org>; Wed, 29 May 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992669; cv=none; b=ZiXFsbe5XneaAyFm8Frt8+tGrbO9fsSebk7SdBCEhzVLPEys8EEDHcNcUzfrRbnBoHA6Gk5dNWU2IuPMi+k2dGGaqRbNY8xg3B1iNUfRoraDviTfIHDWuEOT97oyG86MKCXx827crl0FGwTVrOpedBF8EG+gEBod4+p5mCV84I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992669; c=relaxed/simple;
	bh=gehAJrBCj0tUPfdTW7IgQRwjU9msG11mfhKKvOrwlj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obAXXEjtu9OQspCe4Ym4UBLhwUYXTfolR6+/X4MJqSRtT6yd0y6EdHocHZrHnbHYDUWFAA43u+5MXR2FdmCW7VDi7TVJzHT2z5BjdXl9QUVlO6cZXRfnpZiWMIigfn8iTkeueebchf40TSeDmHgeqqkAFS5DOXe4ZAV5jwqxYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 724843 invoked by uid 1000); 29 May 2024 10:24:26 -0400
Date: Wed, 29 May 2024 10:24:26 -0400
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
Message-ID: <2e34674c-2443-4345-8bc7-8c950a47f621@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
 <ZlSKYA/Y/daiXzfy@andrea>
 <41bc01fa-ce02-4005-a3c2-abfabe1c6927@huaweicloud.com>
 <ZlYbXZSLPmjTKtaE@boqun-archlinux>
 <7e2963a3-d471-4593-9170-7f59aa1ce038@huaweicloud.com>
 <b54575b9-ab29-4bcd-ae7a-6132d1e36195@rowland.harvard.edu>
 <8c6174c7-a26c-416e-b9b1-2aff2d43dea1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6174c7-a26c-416e-b9b1-2aff2d43dea1@huaweicloud.com>

On Wed, May 29, 2024 at 04:17:36PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 5/29/2024 um 4:07 PM schrieb Alan Stern:
> > On Wed, May 29, 2024 at 02:37:30PM +0200, Jonas Oberhauser wrote:
> > > Given herd's other syntactic limitations, perhaps the best way would be to
> > > introduce these macros as
> > > 
> > > 	x = cmpxchg(...) {
> > > 		__fence{mb-successful-rmw};
> > >   		x = __cmpxchg{once}(...);
> > >   		__fence{mb-successful-rmw};
> > > 	}
> > > 
> > > since I think x = M(...) is the only way we are allowed to use these macros
> > > anyways.
> > 
> > If we did this, how would the .cat file know to ignore the fence events
> > when the cmpxchg() fails?  It doesn't look like there's anything to
> > connect the two of them.
> > 
> > Adding the MB tag to the cmpxchg itself seems like the only way forward.
> > 
> > Alan
> 
> Something along these lines:
> 
>   Mb = Mb | Mb-successful-rmw & (domain((po\(po;po));rmw) |
> range(rmw;(po\(po;po)))
> 
> i.e., using the fact that these mb-successful-rmw fences must appear
> directly next to a possibly failing rmw, and looking for successful rmw
> directly around them.
> 
> I suppose we have to distinguish between the before- and after- fences
> though to make it work for cases like
> 
> xchg_release();
> cmpxchg(); // fails
> 
> 
>                 __xchg_release(...); // is an rmw
>  		__fence{mb-successful-rmw}; // wrong takes mb semantics
>    		x = __cmpxchg{once}(...); // fails
>    		__fence{mb-successful-rmw};
> 
> 
> So that would leave us with
> 
>  	x = cmpxchg(...) {
>  		__fence{mb-before-successful-rmw};
>    		x = __cmpxchg{once}(...);
>    		__fence{mb-after-successful-rmw};
>  	}
> 
> and in .cat/.bell:
> 
>   Mb = Mb | Mb-before-successful-rmw & domain((po\(po;po));rmw) |
> Mb-after-successful-rmw & range(rmw;(po\(po;po)))

It's messy.  Associating the fences directly with the RMW event(s) by 
adding the MB tags is much cleaner, IMO.

Also, does the syntax you are proposing require changes to herd7?  I'm 
not aware that it is currently able to parse that kind of definition.

Alan

