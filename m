Return-Path: <linux-arch+bounces-12320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CDCAD3ECC
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 18:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75661189E6D3
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88E23A987;
	Tue, 10 Jun 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjqq1Sfu"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1A235BE5;
	Tue, 10 Jun 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572802; cv=none; b=eLzo/tw/WpJuYgkOUuIQ012H/Vn12U/7KJmZ+ZKqe3bt8fhn9XrndQ72HnsE3Bqq89QMsQ6uIsacz67yd8G/WVabi7cmuMrwMmNKLEFPnqF+7PWaDk3IQXaUUywFprUQfIiwv5bquJGNShpoDVbPP3A+kSxIB0AtIEhNy/8n0pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572802; c=relaxed/simple;
	bh=AfFdkGVaf25Yp8u5asLPt3erUUDF3wGXqaZaCp3COnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcCemeFegGi/1/wA+b7U+Ed+l3zvtzyZ0JT7z62h/snB4YPqpZAHTOAugzq6VQI9ML+WcXvBCvLGcbzWDAZtfG05vTdSBGCnTh+9ot9Xyue30cr0UH+bYGaz+wBmVlB7GR6mP5iaqwNs2blibW7WQfPUMTwkUBjuAzHXZKUbf60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hjqq1Sfu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aZS0PHXMGrZsbS++29v/OH/QUiFXlNb84S4FGKau4VY=; b=hjqq1SfuKB3WqCGlM2fdFVECKO
	uew6eTYGRKiuBhCJt4oP8uy0sq5H68Fg88CU0zip740GuXzpJCl+MKpV+qQw2q+ENpByLzn91O4Pu
	RUMmtAL/TVQJBX/MOo+qVKgac5BR30SJFN0KnnJ7LvSTJWVVrURX6ZYZ8RLJnYekuLOblk9S81GmQ
	rNnY8Iwu4lLy6VugEIIyUyc8rWhgUzLzw+VPL0bP8sePIBkfUUlGoWpYztP7B9epR+I6IFdGKK/oh
	TPpR58IqzFzU2a6JW+0AgHIZcNZY9wcnLjaX6F9pkTcFI9dxLqjjWQlvLMthSOKgud7fAX2wQoWRP
	pmMukF7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1nz-00000009cfG-2gFU;
	Tue, 10 Jun 2025 16:26:31 +0000
Date: Tue, 10 Jun 2025 17:26:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	SeongJae Park <sj@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <aEhct_dQxGAazoiY@casper.infradead.org>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
 <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
 <2fd7f80c-2b13-4478-900a-d65547586db3@gmail.com>
 <aEhTYkzsTsaBua40@casper.infradead.org>
 <8c762435-f5d8-4366-84de-308c8280ff3d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c762435-f5d8-4366-84de-308c8280ff3d@gmail.com>

On Tue, Jun 10, 2025 at 05:00:47PM +0100, Usama Arif wrote:
> On 10/06/2025 16:46, Matthew Wilcox wrote:
> > On Tue, Jun 10, 2025 at 04:30:43PM +0100, Usama Arif wrote:
> >> If we have 2 workloads on the same server, For e.g. one is database where THPs 
> >> just dont do well, but the other one is AI where THPs do really well. How
> >> will the kernel monitor that the database workload is performing worse
> >> and the AI one isnt?
> > 
> > It can monitor the allocation/access patterns and see who's getting
> > the benefit.  The two workloads are in competition for memory, and
> > we can tell which pages are hot and which cold.
> > 
> > And I don't believe it's a binary anyway.  I bet there are some
> > allocations where the database benefits from having THPs (I mean, I know
> > a database which invented the entire hugetlbfs subsystem so it could
> > use PMD entries and avoid one layer of TLB misses!)
> > 
> 
> Sure, but this is just an example. Workload owners are not going to spend time
> trying to see how each allocation works and if its hot, they put it in hugetlbfs.

No, they're not.  It should be automatic.  There are many deficiencies
in the kernel; this is one of them.

> Ofcourse hugetlbfs has its own drawbacks of reserving pages.

Drawback or advantage?  It's a feature.  You're being very strange about
this.  First you want to reserve THPs for some workloads only, then when
given a way to do that you complain that ... you have to reserve hugetlb
pages.  You can't possibly mean both of these things sincerely.


