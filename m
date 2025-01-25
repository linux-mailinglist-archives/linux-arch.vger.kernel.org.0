Return-Path: <linux-arch+bounces-9907-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F2CA1C53A
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 22:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC78B3A4622
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C572201278;
	Sat, 25 Jan 2025 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VXYm1J23"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101C201261;
	Sat, 25 Jan 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737839483; cv=none; b=tIhjJGFAWBeiXet082fATvnrt+jSW42kmRh5eUCsv8n9ch4h0I4v1xX0kafMzoBUuztQIrtUkNjCB0/iW6ZTiOeRYIuhZDcu3Fi3fTP5tBIT5n3I7Vwps+R9o+LxHgwqvN+3c1pXUCutK1eg9pR3YqY2aMEiD62+roEfMtRx1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737839483; c=relaxed/simple;
	bh=WwBHBjXL9Tl0sCV996E+xmN/tqzCflQlGBIkEMaATss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8MG1RpugxxXxocZnYGtWhY//1uiIcZGKAFjspB+gdAWlTnZaP67z2NKeSUR84g9t0MlArhFRyPT/sHjxfc12faITb9EUyWBX9qfeFoa3VZfgApmIhoLLRxsrZHcC/eiLlx291mhYhD1U/3h4j7oGIi92nN7GraQk1zyHBp+EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VXYm1J23; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hTC7xZP00vZwuqeUX/Qi4a89pRjLh3//dnH8lrPL87c=; b=VXYm1J23cWK45LRtI+ytieiEkS
	kYr7WD+LswZg9KHQeHDLMp44H9Pbmeqpe/m1UoGnB27DO2opHk6Q7R5zpdfVyrwV7HJVm9YkaN/BT
	W4oDcyBj9smeuWkbQ8ScD7kz4zlDIqdz7vTfLricLnyOS1KZ5yOCkkoemN5lL1jF4BCrEZJDH5RSS
	DQJ7N94YGHRWCQvCrE95SZLGJQc4Rjs6YUUbo6KOOkH3vR3nGueuigahxwLD0V9NwiQkIhsCtSvim
	5aXdyV+yA2ZnJ2/JMkxQ3CDi6Kd8NmApfkXhib4bMAWwLLypl1KJLVAgbH8Y5QnbsV6AEQ8XzAsFN
	hCminmZg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tbnQc-000000071OE-2pbA;
	Sat, 25 Jan 2025 21:10:54 +0000
Date: Sat, 25 Jan 2025 21:10:54 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
	markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
	khalid@kernel.org, jthoughton@google.com, corbet@lwn.net,
	dave.hansen@intel.com, kirill@shutemov.name, luto@kernel.org,
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
	catalin.marinas@arm.com, mingo@redhat.com, peterz@infradead.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tglx@linutronix.de, cgroups@vger.kernel.org,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
	vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
	neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
Message-ID: <Z5VTXhszpk3_zfV1@casper.infradead.org>
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
 <879e64a0-f097-4bde-ae31-25a1adc30d5f@infradead.org>
 <f515279e-235e-4396-9c91-cbf67083001f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f515279e-235e-4396-9c91-cbf67083001f@oracle.com>

On Sat, Jan 25, 2025 at 12:05:47PM -0800, Anthony Yznaga wrote:
> 
> On 1/24/25 7:13 PM, Randy Dunlap wrote:
> > Just nits:
> > 
> > 
> > On 1/24/25 3:54 PM, Anthony Yznaga wrote:
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 1b501db06417..ba3dbe31f86a 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -1358,6 +1358,15 @@ config PT_RECLAIM
> > >   	  Note: now only empty user PTE page table pages will be reclaimed.
> > > +config MSHARE
> > > +	bool "Mshare"
> > > +	depends on MMU
> > > +	help
> > > +	  Enable msharefs: A ram-based filesystem that allows multiple
> > 	                     RAM-based

But it's not a ram-based filesystem.  It's a pseudo-filesystem like
procfs.  It doesn't have any memory of its own.

