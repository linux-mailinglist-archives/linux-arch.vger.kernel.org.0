Return-Path: <linux-arch+bounces-4716-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250058FD467
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 19:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13E42897D7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2264194AEC;
	Wed,  5 Jun 2024 17:55:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E4357194AEA
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610111; cv=none; b=skIzvEcvp0GPHS0UFz6ZPHGnzpdI0iFTHfD4Tkv5Ibt/EeBUReXrBCvX2IFZ84fws5gv+N0f+3G8aqUJEejuGgKzzm51+hROVjtGc3tJqfiECWkCVLrtmUEQYilwqC3g5p7P864BW6osC1LBFBrfIYNLN749zcXorA4YWp/GL0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610111; c=relaxed/simple;
	bh=H48mGkc8+WH0pYSHPbA6ngIUjU6HxfjtscVbuGhTGRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+BBpDGpUlYWZMGB6ySPBF2YQmxdwZkE0s97l9OF55QSLV69hcNX+iH2lU9nqb3vpkLOiRNqSkNFeGbF1r3uE1CsclmP4eyXxHKgtvZRzygH+lNXbhPtbQPHpRQdwWr4OqZTqw0SzZCRtPQweLV5Sy5pJo7HutQDIkHbqxbeMvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 203982 invoked by uid 1000); 5 Jun 2024 13:55:08 -0400
Date: Wed, 5 Jun 2024 13:55:08 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v2] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <010bd7e9-de81-4ff7-8532-18c41318123e@rowland.harvard.edu>
References: <20240605134918.365579-1-parri.andrea@gmail.com>
 <037bc316-3e8c-4748-bade-ffdad4239646@rowland.harvard.edu>
 <ZmCXwjX/Rx7zKWpj@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmCXwjX/Rx7zKWpj@andrea>

On Wed, Jun 05, 2024 at 06:52:18PM +0200, Andrea Parri wrote:
> > I wonder if we really need a special notation for lk-rmw.  Is anything 
> > wrong with using the normal rmw notation for these links?
> 
> I don't think we need the special notation: in fact, herd7 doesn't know
> anything about these lk-rmw or rmw links between lock events until after
> tools/memory-model/ (the .cat file) has established such links cf.
> 
>   (* Link Lock-Reads to their RMW-partner Lock-Writes *)
>   let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)
>   let rmw = rmw | lk-rmw
> 
> I was trying to be informative (since that says "lk-rmw is a subrelation
> of rmw) but, in order to be faithful to the scope of this document (herd
> representation), the doc should really just indicate LKR ->po LKW.
> 
> Thoughts?

I agree; be faithful to the document's scope and just say LKR ->po LKW.

Were there other things like this in the table?  I didn't notice any.

Alan

