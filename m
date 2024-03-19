Return-Path: <linux-arch+bounces-3044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892178804FA
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA266B23D85
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341DB3838F;
	Tue, 19 Mar 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IOf0HdNd"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7EA3A1D8;
	Tue, 19 Mar 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873511; cv=none; b=CNSCrTFp/KCo62aS0hGd0Iu2bAiu4EBq9d3Meo/rpjRntyJTeprSYCYyrzB+6Ilnad1HFgXMx2cueNO35L6AjmISA5FnBJRWsSQx1N5z47v6skSTgO2pdpx7SKR232QgXRtyJJJnVaEEUIgNbbW8jWJleFpplThBrv320t7QhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873511; c=relaxed/simple;
	bh=GXwswoYv9U8DBj4pX6EMIE6f8CmqCoXFdq9sUHFNXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohle9ZofCXkwjot+1REHo9sAYj/v+c2EwdUVsF4EmAP3J8+Sr5Q/E9LoeUwgJW1dgNHho9lGgnBTfBgvENvziYf4MADvatuegZdAQd1MSzbRJi2JfHqECuBGCa2NZeYlug2e8R+61asNsd0JxRg+3gJf1SROhd2OdcLLZm9e2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IOf0HdNd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZnTbSyQ+3b0Xe1n8vMeKEDDL3zu+pgv6P5ioGToOLWc=; b=IOf0HdNdfe2DRHA61K6l5rZVg2
	bdPnLbBdeu7eicia0t7lJUpSvZj0snFu1o2hiqWFmclJVRbor6nLsw4Jr7kw6XNBLAPuXew+qB7aH
	ZdqTOsNZSRiAIKuH8958G7nz6Zs1aPO0AGUQJZcqAO700H3GCaCIR7U2MklhSN8Taws10z+zB6c3t
	0Eh26oPqUam4oZR7oLPxcj/N3CA1+YCHB8REn0R0eXpLDMEC/EYNBsIECTb1XICSKXix0XxMunAQv
	E1mV9DVakUrE/Z93KPA4beNtqaWgCDHLC7WzVNsv49LbNAHZrP4FJ+Wl3JnTUUEz2qnSRYOiP19UC
	cYPFIjuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmeLv-00000002W4q-1oCi;
	Tue, 19 Mar 2024 18:38:23 +0000
Date: Tue, 19 Mar 2024 18:38:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <Zfnbn8H4O9neZhcm@casper.infradead.org>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnWCRwcZJ4KBmSH@memverge.com>
 <ZfnXcbd3h3Rj4IIS@casper.infradead.org>
 <ZfnaMa6x/O68ENsP@memverge.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnaMa6x/O68ENsP@memverge.com>

On Tue, Mar 19, 2024 at 02:32:17PM -0400, Gregory Price wrote:
> On Tue, Mar 19, 2024 at 06:20:33PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 19, 2024 at 02:14:33PM -0400, Gregory Price wrote:
> > > On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> > > > On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > > > > Implement simple ktest that looks up the physical address via
> > > > > /proc/self/pagemap and migrates the page based on that information.
> > > > 
> > > > What?  LOL.  No.
> > > > 
> > > 
> > > Certainly the test is stupid and requires admin, but I could not
> > > come up an easier test to demonstrate the concept - and the docs
> > > say to include a test with all syscall proposals.
> > > 
> > > Am I missing something else important?
> > > (stupid question: of course I am, but alas I must ask it)
> > 
> > It's not that the test is stupid.  It's the concept that's stupid.
> 
> Ok i'll bite.
> 
> The 2 major ways page-hotness is detected right now is page-faults
> (induced or otherwise) and things like IBS/PEBS.
> 
> page-faults cause overhead, and IBS/PEBS actually miss upwards of ~66%
> of all traffic (if you want the details i can dig up the presentation,
> but TL;DR: prefetcher traffic is missed entirely).
> 
> so OCP folks have been proposing hotness-tracking offloaded to the
> memory devices themselves:
> 
> https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1
> 
> (it's come along further than this white paper, but i need to dig up
> the new information).
> 
> These devices are incapable of providing virtual addressing information,
> and doing reverse lookups of addresses is inordinately expensive from
> user space.  This leaves: Do it all in a kernel task, or give user space
> an an interface to operate on data provided by the device.
> 
> The syscall design is mostly being posted right now to collaborate via
> public channels, but if the idea is so fundamentally offensive then i'll
> drop it and relay the opinion accordingly.

The syscall design is wrong.  Exposing physical addresses to userspace
is never the right answer.  Think rowhammer.

I'm vehemently opposed to all of the bullshit around CXL.  However, if you
are going to propose something, it should be based around an abstraction.
Say "We have 8 pools of memory.  This VMA is backed by memory from pools
3 & 6.  The relative hotness of the 8 pools are <vector>.  The quantities
of memory in the 8 ppols are <vector>".  And then you can say "migrate
this range of memory to pool 2".

That's just an initial response to the idea.  I refuse to invest a
serious amount of time in a dead-end idea like CXL memory pooling.

