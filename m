Return-Path: <linux-arch+bounces-7024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CF96C43C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D811C22930
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25FF1E0B61;
	Wed,  4 Sep 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OVf3aPck"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA31E00B7
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467878; cv=none; b=T6ccYsUppXIRCQX65PBgNdLBlZWArDuO2DUWXqBGS+gne7zJdVTefY6oxA1LHz5syNfjyT2aNnUCCXqUumzgh5BXG3wjruayfSoOfl/3kDmvkyrbzyCmvk07c0ruDYgwGno9/Bt1cYWO71cYWxYGVm2lEHc0TlQjiSPfq1kerjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467878; c=relaxed/simple;
	bh=Kai+oXgyYqx51OC9L3hBXB9yZXTbTfdql5NHmBr+XLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOYNxIkFmC4BFsn/GWGkX80Y9VWELUzmRC+gNYq2wf699EPVHTatkkDUjhm6qIp3MsKKaUWTnGHW/fx0WqfrWwB3+LI+KakiysN5SJdtP5y9AGola0elT4K1lGwOBx+mf8GKiYyT6ic4eUUUejuJfva2jUTzfh6T5rgAvKZfya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OVf3aPck; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 12:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725467874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJRjlFiLzX37Eyl/RAVDP2lOWHI5udCI3PpG5m3qNKk=;
	b=OVf3aPckmjLImnybBd3QJgZuv7Miwlfaa94VmAQuQD04yHk60dretbmCqlve+1G/hsasxU
	Y8H25oJcGNPfl1I9RdYkCpGecTN27Pjka5vkEHBD+xfaUftddGMVYu7nSzVLOPA9DDdoiG
	cP1SfjL7lUi09m9XTGkEI6mdw0YL+Ls=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Subject: Re: [PATCH v2 6/6] alloc_tag: config to store page allocation tag
 refs in page flags
Message-ID: <keaqrfkkoswtpbtvr3l5oetd4d3ncbpaxsay7dckn74qdob2u2@lohq26fuccib>
References: <20240902044128.664075-1-surenb@google.com>
 <20240902044128.664075-7-surenb@google.com>
 <20240901221636.5b0af3694510482e9d9e67df@linux-foundation.org>
 <CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HDqxXA@mail.gmail.com>
 <47c4ef47-3948-4e46-8ea5-6af747293b18@nvidia.com>
 <ZtfDiH3lZ9ozxm0v@casper.infradead.org>
 <CAJuCfpHJ9PwNOqmFOH373gn6Uqa-orG6zP3rqk-_x=GkpUo2+Q@mail.gmail.com>
 <ZtiMZWqht_8Bse-5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtiMZWqht_8Bse-5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 04, 2024 at 05:35:49PM GMT, Matthew Wilcox wrote:
> On Wed, Sep 04, 2024 at 09:18:01AM -0700, Suren Baghdasaryan wrote:
> > I'm not sure I understand your suggestion, Matthew. We allocate a
> > folio and need to store a reference to the tag associated with the
> > code that allocated that folio. We are not operating with ranges here.
> > Are you suggesting to use a maple tree instead of page_ext to store
> > this reference?
> 
> I'm saying that a folio has a physical address.  So you can use a physical
> address as an index into a maple tree to store additional information
> instead of using page_ext or trying to hammer the additional information
> into struct page somewhere.

Ah, thanks, that makes more sense.

But it would add a lot of overhead to the page alloc/free paths...

