Return-Path: <linux-arch+bounces-4548-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A18D01C2
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 15:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07301F22B69
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252615F318;
	Mon, 27 May 2024 13:33:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D2D95160781
	for <linux-arch@vger.kernel.org>; Mon, 27 May 2024 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816825; cv=none; b=Nfb88o7HX2tqckPds6S8KhKyq0GB+4nvI7Lz9fa1BE5hSmuJUK1FWZqEBtov7JeBygoORT8zznw4MldLLvoBsArc8PeIdxSa800NCWfDviDYHWcjQov22psDPSaQ1BfEf9JbF03sUDK+UbjlWgZ5EXldKj4BnK+W2b4swTWyGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816825; c=relaxed/simple;
	bh=HLaKj1OSX8J0+4JnLklX1GmIqpZ/oWIWx0x5KuNhncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbskFbh2BMpsWEKCDQNXodHm69sjGb3I5W/4Kq1UyKrDggHpQD6vSBsbkMkonyeYDufMEu7VWyk/Mq6+jHLgBUujL8Uep3cv4sXOGXI8+DITaZVA8DqH5rKKSLAU4q67lH0/PszDn+tBQjKpDaOYfaFcWlOnEdGOj2u9m6z21Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 659937 invoked by uid 1000); 27 May 2024 09:33:37 -0400
Date: Mon, 27 May 2024 09:33:37 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
  joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <bbf1a4ee-977c-4e74-ac57-69124c37337a@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <1c6d4146-86f8-4fd5-a23e-a95ba2464c9e@rowland.harvard.edu>
 <ZlC5q7bcdCAe7xPp@andrea>
 <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7365700-a983-b787-e22a-7526621d4c18@huaweicloud.com>

On Mon, May 27, 2024 at 02:25:01PM +0200, Hernan Ponce de Leon wrote:
> On 5/24/2024 6:00 PM, Andrea Parri wrote:
> > > What's the difference between R and R*, or between W and W*?
> > 
> > AFAIU, herd7 uses such notation, "*", to denote a load or a store which
> > is also in RMW.
> 
> I also got confused with this. What about the following notation?
> 
> 	R[once,RMW] ->rmw W[once,RMW]

Either way, it would be a good idea to add an explanation at the start 
of the file.

Likewise, add an explanation that blank entries mean the same as the 
preceding row.

Overall the table looks very good.

Alan

