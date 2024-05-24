Return-Path: <linux-arch+bounces-4530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099D8CE849
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 17:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F91C22650
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48512E1CA;
	Fri, 24 May 2024 15:53:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A9BF312C52E
	for <linux-arch@vger.kernel.org>; Fri, 24 May 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565994; cv=none; b=UCTFP12OoHJWkF+uGCzfvO0pXsuQQgv1BRLIWAiC6C8UD5de16Vjae4btWaPr/qvJ7Re1J7K6XryoygHtQk65jW5wopbJlDLLD3G4XZ3vCyT6m8poxJ9RJUgH//JnMKuWVAd64TngpJr8XoAOBpvMB84eOPAUNLL6FYDo+IFIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565994; c=relaxed/simple;
	bh=1zS8ibP+hJWRzbynsQG0FATpqCiju5Hqqp7403hPuFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb7LnUdW53ymV6WCCRCasUfcmf2BYVTI8Cg0AjRQd1r+hTp8ZwmT8fuDLovO3MQdjV51pGO6A493dXmXBT1o1kMYvirP/5lzIOHVK/JjNVgtrx/ZFNdv+eD35OhhY+tJVp04Sg41QIXqIl2vMff7YB+k4Ffk2NiQXwIWBHs7Ruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 578024 invoked by uid 1000); 24 May 2024 11:53:11 -0400
Date: Fri, 24 May 2024 11:53:11 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524151356.236071-1-parri.andrea@gmail.com>

On Fri, May 24, 2024 at 05:13:56PM +0200, Andrea Parri wrote:
> tools/memory-model/ and herdtool7 are closely linked: the latter is
> responsible for (pre)processing each C-like macro of a litmus test,
> and for providing the LKMM with a set of events, or "representation",
> corresponding to the given macro.  Provide herd-representation.txt
> to document the representation of synchronization macros, following
> their "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---

> +    |             rcu_dereference | R[once]                                   |
> +    |          rcu_assign_pointer | W[release]                                |
> +    |              srcu_read_lock | R[srcu-lock]                              |
> +    |            srcu_read_unlock | W[srcu-unlock]                            |
> +    |            synchronize_srcu | SRCU[sync-srcu]                           |
> +    ---------------------------------------------------------------------------
> +    |    RMW ops w/o return value |                                           |
> +    ---------------------------------------------------------------------------
> +    |                  atomic_add | R*[noreturn] ->rmw W*[once]               |

What's the difference between R and R*, or between W and W*?

Alan

